cd hadoop-spark-kafka
docker-compose up -d

docker exec -it tpa-mongo sh ./tpa-mongo/initDB.sh
docker exec -it tpa-postgres sh ./tpa-postgres/importPostgresDatasource.sh
docker cp ./hadoop-spark-kafka/volumes/datasource/CO2.csv datanode:/usr
docker exec -it datanode bash
hdfs dfs -test -e /user/fichiers/CO2.csv || { hdfs dfs -mkdir -p /user/fichiers && hdfs dfs -put /usr/CO2.csv /user/fichiers; }
