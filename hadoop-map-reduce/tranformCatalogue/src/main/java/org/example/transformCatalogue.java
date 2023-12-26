package org.example;


import java.util.Map;

public class transformCatalogue {

    public static void main(String[] args) throws Exception {
        String hdfsUri = "hdfs:///";
        String hdfsFilePath = "/results/part*";
        String couchDbUrl = "http://127.0.0.1:5984/tpa/";

        Map<String, String[]> hdfsData = HDFSReader.readHdfsFile(hdfsUri, hdfsFilePath);
        CouchDBUpdater.updateCouchDBDocuments(couchDbUrl, hdfsData);
    }
}