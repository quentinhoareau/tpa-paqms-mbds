echo "removing results"
hdfs dfs -ls .
hdfs dfs -rm -r results

echo "runing CO2 analysis"
hadoop jar usr/hadoop-map-reduce.jar /user/fichiers/cleaned_CO2.csv results
echo "CO2 analysis done"
hdfs dfs -cat results/*
echo "runing Catalogue transformation on CouchDB"
hadoop jar usr/transformCatalogue.jar
echo "Catalogue transformation done"