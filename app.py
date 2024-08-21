from flask import Flask, render_template, request, redirect, url_for
import mysql.connector
import os
from dotenv import load_dotenv

# Charger les variables d'environnement depuis le fichier .env
load_dotenv()

app = Flask(__name__)

def get_db_connection():
    conn = mysql.connector.connect(
        host=os.getenv('DB_HOST'),
        user=os.getenv('DB_USER'),
        password=os.getenv('DB_PASSWORD'),
        database=os.getenv('DB_NAME')
    )
    return conn

@app.route('/')
def voir_fonds():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Récupérer les fonds
    cursor.execute('SELECT * FROM referentiel_fonds')
    fonds = cursor.fetchall()

    fonds_data = []
    for fond in fonds:
        # Récupérer les positions pour chaque fond
        cursor.execute('''
            SELECT r.nom_instrument, p.quantite
            FROM positions p
            JOIN referentiel_instruments r ON p.id_instrument = r.id
            WHERE p.id_fond = %s
        ''', (fond['id'],))
        positions = cursor.fetchall()
        fonds_data.append({'fond': fond, 'positions': positions})

    conn.close()
    return render_template('fonds.html', fonds_data=fonds_data)

@app.route('/instruments')
def voir_instruments():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('SELECT * FROM referentiel_instruments')
    instruments = cursor.fetchall()
    conn.close()
    return render_template('instruments.html', instruments=instruments)

@app.route('/positions/<int:id_fond>', methods=['GET', 'POST'])
def voir_positions(id_fond):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute('SELECT nom_fond FROM referentiel_fonds WHERE id = %s', (id_fond,))
    fond = cursor.fetchone()

    cursor.execute('''
        SELECT p.id, r.nom_instrument, p.quantite, p.prix_achat, p.date_achat
        FROM positions p
        JOIN referentiel_instruments r ON p.id_instrument = r.id
        WHERE p.id_fond = %s
    ''', (id_fond,))
    positions = cursor.fetchall()

    cursor.execute('SELECT * FROM referentiel_instruments')
    instruments = cursor.fetchall()

    conn.close()
    return render_template('positions.html', positions=positions, instruments=instruments, id_fond=id_fond,
                           nom_fond=fond['nom_fond'])

@app.route('/ajouter_position/<int:id_fond>', methods=['POST'])
def ajouter_position(id_fond):
    id_instrument = request.form['id_instrument']
    quantite = request.form['quantite']
    prix_achat = request.form['prix_achat']
    date_achat = request.form['date_achat']

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('''
        INSERT INTO positions (id_fond, id_instrument, quantite, prix_achat, date_achat)
        VALUES (%s, %s, %s, %s, %s)
    ''', (id_fond, id_instrument, quantite, prix_achat, date_achat))
    conn.commit()
    conn.close()

    return redirect(url_for('voir_positions', id_fond=id_fond))

@app.route('/ajouter_fond', methods=['GET', 'POST'])
def ajouter_fond():
    if request.method == 'POST':
        nom_fond = request.form['nom_fond']
        description = request.form['description']
        date_creation = request.form['date_creation']

        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute('''
            INSERT INTO referentiel_fonds (nom_fond, description, date_creation)
            VALUES (%s, %s, %s)
        ''', (nom_fond, description, date_creation))
        conn.commit()
        conn.close()
        return redirect(url_for('voir_fonds'))

    return render_template('ajouter_fond.html')

@app.route('/ajouter_instrument', methods=['GET', 'POST'])
def ajouter_instrument():
    if request.method == 'POST':
        nom_instrument = request.form['nom_instrument']
        type_instrument = request.form['type_instrument']
        date_introduction = request.form['date_introduction']

        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute('''
            INSERT INTO referentiel_instruments (nom_instrument, type_instrument, date_introduction)
            VALUES (%s, %s, %s)
        ''', (nom_instrument, type_instrument, date_introduction))
        conn.commit()
        conn.close()
        return redirect(url_for('voir_instruments'))

    return render_template('ajouter_instrument.html')

@app.route('/api/fonds')
def api_fonds():
    query = request.args.get('q', '')
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('''
        SELECT * FROM referentiel_fonds
        WHERE nom_fond LIKE %s
    ''', ('%' + query + '%',))
    fonds = cursor.fetchall()
    conn.close()
    return render_template('fonds_partial.html', fonds=fonds)

@app.route('/api/instruments')
def api_instruments():
    query = request.args.get('q', '')
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('''
        SELECT * FROM referentiel_instruments
        WHERE nom_instrument LIKE %s
    ''', ('%' + query + '%',))
    instruments = cursor.fetchall()
    conn.close()
    return render_template('instruments_partial.html', instruments=instruments)

if __name__ == '__main__':
    app.run(debug=True)
