#!/bin/bash
# Connexion à la console MongoDB
echo 'Connexion to MongoDB'
mongosh <<EOF
use tpa
db.createCollection("catalogue")
db.createCollection("client")
db.createCollection("immatriculation")
db.createCollection("marketing")
exit
EOF

echo 'Collections created'
echo 'Import data in collection'
# Importation des données
mongoimport --db tpa --collection catalogue --type csv --headerline --file "/tpa-mongo/datasource/Catalogue.csv"
mongoimport --db tpa --collection client --type csv --headerline --file "/tpa-mongo/datasource/Clients_10.csv"
mongoimport --db tpa --collection client --type csv --headerline --file "/tpa-mongo/datasource/Clients_19.csv"
mongoimport --db tpa --collection immatriculation --type csv --headerline --file "/tpa-mongo/datasource/Immatriculations.csv"
mongoimport --db tpa --collection marketing --type csv --headerline --file "/tpa-mongo/datasource/Immatriculations.csv"
echo 'Import finished'