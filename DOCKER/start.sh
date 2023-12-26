#-- Installing pyhton on your computer --#
echo "Installing pyhton on your computer..."
sudo apt update
sudo apt install python3 python3-pip
python3 --version
pip3 --version

# --- Refactor Data --- #
echo "Refactor CSV File to utf8..."
pip3 install pandas
python3 ./script_formatage.py
sudo cp -r ./datasource/datasource_utf8/mongo/ ./tpa-mongo/volumes/datasource

# --- Refactor CO2 --- #
echo "Refactor CO2 File to Readable CO2 file..."
pip3 install numpy
python3 ./script_formatage_CO2.py

# --- Docker compose --- #
echo "Docker compose..."
docker-compose down
docker-compose up -d --build
echo "Docker compose done"

until $(curl --output /dev/null --silent --head --fail http://localhost:9870); do
    printf 'Waiting for namenode:  http://localhost:9870 to start...\n'
    sleep 5
done

sleep 5

# --- init HDFS et ajout CO2 dans HDFS ---#
echo "Implementing HDFS..."
docker cp ./datasource/cleaned_CO2.csv datanode:/usr
docker cp ../hadoop-map-reduce/hadoop-map-reduce/out/artifacts/hadoop_map_reduce_jar/hadoop-map-reduce.jar datanode:/usr
docker cp ../hadoop-map-reduce/CatalogueImportCouchDB/out/artifacts/CatalogueImportCouchDB_jar/CatalogueImportCouchDB.jar datanode:/usr
docker exec -it datanode bash < ./tpa-datanode/hdfs.sh
docker exec -it datanode bash hdfs dfs -test -e /user/fichiers/cleaned_CO2.csv

# --- MongoDB --- #
echo "Init MongoDB database..."
docker exec -it tpa-mongo sh ./tpa-mongo/initDB.sh
docker exec -it tpa-postgres sh ./tpa-postgres/importPostgresDatasource.sh


# --- CouchDB --- #
until $(curl --output /dev/null --silent --head --fail http://localhost:5984); do
    printf 'Waiting for CouchDB : http://localhost:5984 to start...\n'
    sleep 5
done
echo "Init CouchDB database..."
docker exec -it tpa-couchdb sh /tpa-couchdb/init.sh
docker exec -it tpa-python python3 /tpa-python/populate-couchdb.py


# --- Postgres --- #
docker exec -it tpa-postgres sh ./tpa-postgres/initDB.sh