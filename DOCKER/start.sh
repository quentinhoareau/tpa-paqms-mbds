# --- Refactor Data --- #

# --- Docker compose --- #
docker-compose down
docker-compose up -d --build

until $(curl --output /dev/null --silent --head --fail http://localhost:9870); do
    printf 'Waiting for namenode:  http://localhost:9870 to start...\n'
    sleep 2
done

docker cp ./datasource/CO2.csv datanode:/usr
docker exec -it datanode bash < ./tpa-datanode/hdfs.sh

# --- MongoDB --- #
docker exec -it tpa-mongo sh ./tpa-mongo/initDB.sh
#docker exec -it tpa-postgres sh ./tpa-postgres/importPostgresDatasource.sh

# --- CouchDB --- #
# Attente de la disponibilité de CouchDB
until $(curl --output /dev/null --silent --head --fail http://localhost:5984); do
    printf 'Waiting for CouchDB : http://localhost:5984 to start...\n'
    sleep 2
done

# Exécution du script d'initialisation de la base de données CouchDB
docker exec -it tpa-couchdb sh /tpa-couchdb/init.sh