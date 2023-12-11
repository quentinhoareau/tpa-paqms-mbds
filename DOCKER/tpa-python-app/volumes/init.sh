until $(curl --output /dev/null --silent --head --fail http://namenode:9870); do
    printf 'Waiting for namenode: http://namenode:9870 to start...\n'
    sleep 2
done
printf 'Serveur namenode started, waiting for HDFS files is ready...\n'
sleep 15 #TODO : find a better way to wait for the file to be copied

python3 main.py

tail -f /dev/null