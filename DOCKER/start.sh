# --- Docker compose --- #
docker-compose down
docker-compose up -d --build

# --- MongoDB --- #
#docker exec -it tpa-mongo sh ./tpa-mongo/initDB.sh
#docker exec -it tpa-postgres sh ./tpa-postgres/importPostgresDatasource.sh

# --- CouchDB --- #
# Attente de la disponibilité de CouchDB
until curl --output /dev/null --silent --head --fail http://localhost:5984; do
    printf 'Waiting for CouchDB to start...\n'
    sleep 1
done

# Exécution du script d'initialisation de la base de données CouchDB
docker exec -it tpa-couchdb sh ./init.sh


