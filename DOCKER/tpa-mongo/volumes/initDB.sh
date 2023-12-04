#!/bin/bash
# Connexion à la console MongoDB
echo 'Connexion to MongoDB'
mongosh -u root -p example <<EOF
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
mongoimport --db TPA --collection catalogue --type csv --headerline --file "/tpa-mongo/datasource/Catalogue.csv"
mongoimport --db TPA --collection client --type csv --headerline --file "/tpa-mongo/datasource/Clients_10.csv"
mongoimport --db TPA --collection client --type csv --headerline --file "/tpa-mongo/datasource/Clients_19.csv"
mongoimport --db TPA --collection immatriculation --type csv --headerline --file "/tpa-mongo/datasource/Immatriculations.csv"
mongoimport --db TPA --collection marketing --type csv --headerline --file "/tpa-mongo/datasource/Immatriculations.csv"
echo 'Import finished'