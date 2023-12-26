#!/bin/bash
# Connexion à la console CouchDB
echo 'Connexion to CouchDB'
COUCHDB_URL=http://localhost:5984
COUCHDB_USERNAME=admin
COUCHDB_PASSWORD=password
COUCHDB_IDENTIFIANT=$COUCHDB_USERNAME:$COUCHDB_PASSWORD
DATABASE_NAME=tpa

# Vérifier si la base de données existe
EXISTING_DATABASE=$(curl -s -o /dev/null -w '%{http_code}' $COUCHDB_URL/$DATABASE_NAME -u $COUCHDB_IDENTIFIANT)

if [ $EXISTING_DATABASE -eq 200 ]; then
    # La base de données existe, la supprimer
    curl -X DELETE $COUCHDB_URL/$DATABASE_NAME -u $COUCHDB_IDENTIFIANT
    echo 'Database tpa deleted'
else
    echo 'Database tpa does not exist'
fi

# Créer la base de données
curl -X PUT $COUCHDB_URL/$DATABASE_NAME -u $COUCHDB_IDENTIFIANT
echo 'Database tpa created'