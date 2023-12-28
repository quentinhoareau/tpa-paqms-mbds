package org.example;
import java.util.Arrays;
import java.util.Map;

public class transformCatalogue {

    public static void main(String[] args) throws Exception {
        System.out.println("Start Update Catalogue");
        String hdfsUri = "hdfs://namenode:8020";
        String hdfsFilePath = "results/part-r-00000";
        String couchDbUrl = "http://tpa-couchdb:5984/tpa/";

        Map<String, String[]> hdfsData = HDFSReader.readHdfsFile(hdfsUri, hdfsFilePath);
        System.out.println("HDFS data: " + hdfsData.toString());
        CouchDBUpdater.updateCouchDBDocuments(couchDbUrl, hdfsData);
        System.out.println("End Update Catalogue");
    }
}