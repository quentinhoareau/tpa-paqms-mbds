package org.example;


import java.util.Map;

public class transformCatalogue {

    public static void main(String[] args) throws Exception {
        String hdfsUri = "hdfs://namenode:8020";
        String hdfsFilePath = "results/part-r-00000";
        String couchDbUrl = "http://admin:password@127.0.0.1:5984/tpa/";

        Map<String, String[]> hdfsData = HDFSReader.readHdfsFile(hdfsUri, hdfsFilePath);
        CouchDBUpdater.updateCouchDBDocuments(couchDbUrl, hdfsData);
    }
}