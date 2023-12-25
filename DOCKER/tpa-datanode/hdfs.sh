hdfs dfs -rm -r /user/fichiers/*
hdfs dfs -test -e /user/fichiers/cleaned_CO2.csv || { hdfs dfs -mkdir -p /user/fichiers && hdfs dfs -put /usr/cleaned_CO2.csv /user/fichiers; }
