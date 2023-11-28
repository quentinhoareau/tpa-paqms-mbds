# Connexion à la console CouchDB
echo 'Connexion to CouchDB'
COUCHDB_URL=http://localhost:5984
COUCHDB_USERNAME=admin
COUCHDB_PASSWORD=password
COUCHDB_IDENTIFIANT=$COUCHDB_USERNAME:$COUCHDB_PASSWORD

curl -X DELETE $COUCHDB_URL/tpa -u $COUCHDB_IDENTIFIANT

# Création de la base de données
curl -X PUT $COUCHDB_URL/tpa -u $COUCHDB_IDENTIFIANT