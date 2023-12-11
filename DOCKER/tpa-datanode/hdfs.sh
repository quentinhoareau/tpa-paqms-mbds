hdfs dfs -rm -r /user/fichiers/*
hdfs dfs -test -e /user/fichiers/CO2.csv || { hdfs dfs -mkdir -p /user/fichiers && hdfs dfs -put /usr/CO2.csv /user/fichiers; }
