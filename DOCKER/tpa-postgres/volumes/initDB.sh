#!/bin/bash

# Fonction pour vérifier la disponibilité du serveur PostgreSQL
check_postgres_server() {
    pg_isready -U postgres -h localhost -q
}

# Attendre que le serveur PostgreSQL soit disponible
while ! check_postgres_server; do
    echo "En attente du serveur PostgreSQL..."
    sleep 1
done

# Le serveur PostgreSQL a répondu
echo 'Connexion à PostgresSQL'
createdb -U postgres -h localhost -e tpa_postgres
psql -U postgres -d tpa_postgres -a -f ./tpa-postgres/createDB.sql
echo 'Base de données et tables créées'
echo 'Importation des données dans la collection'
echo 'Importation terminée'