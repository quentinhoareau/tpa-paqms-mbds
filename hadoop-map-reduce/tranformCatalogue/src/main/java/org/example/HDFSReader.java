package org.example;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URI;
import java.util.HashMap;
import java.util.Map;

public class HDFSReader {
    public static Map<String, String[]> readHdfsFile(String hdfsUri, String filePath) throws Exception {
        Configuration conf = new Configuration();
        FileSystem fs = FileSystem.get(URI.create(hdfsUri), conf);
        Path path = new Path(filePath);

        Map<String, String[]> data = new HashMap<>();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(fs.open(path)))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(" ");
                if (parts.length == 2) {
                    String marque = parts[0];
                    String[] values = parts[1].split(",");
                    data.put(marque, values);
                }
            }
        }
        return data;
    }
}
