#!/bin/bash
# Connexion à la console PostgresSQL
echo 'Connexion to PostgresSQL'
createdb -U postgres -h localhost -p 5432 -e tpa_postgres
psql -U postgres -d tpa_postgres -a -f create_db.sql
echo 'Base de donnée et tables crées'
echo 'Import data in collection'
# Importation des données
echo 'Import finished'