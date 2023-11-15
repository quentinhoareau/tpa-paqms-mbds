cd hadoop-spark-kafka
docker-compose up -d

docker exec -it tpa-mongo sh ./tpa-mongo/initDB.sh
docker exec -it tpa-postgres sh ./tpa-postgres/importPostgresDatasource.sh