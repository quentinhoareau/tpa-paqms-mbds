#!/bin/bash
# Connexion à la console MongoDB
echo 'Connexion to MongoDB'
mongosh <<EOF
use tpa
db.createCollection("immatriculations")
db.createCollection("clients")
exit
EOF

echo 'Collections created'
echo 'Import data in collection'
# Importation des données
mongoimport --db tpa --collection immatriculations --type csv --headerline --file "./datasource/Immatriculations_utf8.csv"
mongoimport --db tpa --collection clients --type csv --headerline --file "./datasource/Clients_10_utf8.csv"
mongoimport --db tpa --collection clients --type csv --headerline --file "./datasource/Clients_19_utf8.csv"
echo 'Import finished'