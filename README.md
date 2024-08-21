
# Application web de suivi des portefeuilles

## Guide d'installation

1. **Cloner le repository**
   
   ```bash
   git clone https://github.com/kangmartin/walletmanager.git
   ```

2. **Installer les dépendances**

   ```bash
   pip install -r requirements.txt
   ```

## Configuration de la base de données

Initialiser la base de donnée en important le fichier `db.sql`

## Configuration des variables d'environnement

Dans le dossier du projet, ajoutez un fichier `.env` avec les lignes ci-dessous:
```bash
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=YOUR_PASSWORD
DB_NAME=portefeuille_db
```

## Démarrer l'application

Pour démarrer l'application, lancez le fichier app.py (à la racine du projet)

  ```bash
  python3 app.py
  ```


## Captures d'écrans



---
