echo "removing results"
hdfs dfs -ls /user/fichiers/
hdfs dfs -rm -r /user/fichiers/results
echo "runing CO2 analysis"
hadoop jar usr/hadoop-map-reduce.jar /user/fichiers/cleaned_CO2.csv /user/fichiers/results
echo "CO2 analysis done"
hdfs dfs -cat /user/fichiers/results/*