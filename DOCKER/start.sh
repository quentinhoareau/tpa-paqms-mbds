# --- Refactor Data --- #
echo "Refactor CSV File to utf8..."
pip install pandas
python3 ./script_formatage.py

# --- Docker compose --- #
echo "Docker compose..."
docker-compose down
docker-compose up -d --build
echo "Docker compose done"

until $(curl --output /dev/null --silent --head --fail http://localhost:9870); do
    printf 'Waiting for namenode:  http://localhost:9870 to start...\n'
    sleep 5
done

echo Implementing HDFS...
docker cp ./datasource/CO2.csv datanode:/usr
docker exec -it datanode bash < ./tpa-datanode/hdfs.sh

# --- MongoDB --- #
echo "Init MongoDB database..."
docker exec -it tpa-mongo sh ./tpa-mongo/initDB.sh

# --- CouchDB --- #
# Attente de la disponibilité de CouchDB
until $(curl --output /dev/null --silent --head --fail http://localhost:5984); do
    printf 'Waiting for CouchDB : http://localhost:5984 to start...\n'
    sleep 5
done
echo "Init CouchDB database..."
docker exec -it tpa-couchdb sh /tpa-couchdb/init.sh
docker exec -it tpa-python python3 /tpa-python/populate-couchdb.py


# --- Postgres --- #
docker exec -it tpa-postgres sh ./tpa-postgres/initDB.sh
