package org.example;
import org.apache.http.HttpHeaders;
import org.apache.http.HttpResponse;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.*;
import org.apache.http.client.methods.HttpPost;

import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Map;

import static java.lang.Thread.sleep;

public class CouchDBUpdater {
    public static void updateCouchDBDocuments(String couchDbUrl, Map<String, String[]> hdfsData) throws Exception {
        String auth = "admin:password";
        byte[] encodedAuth = Base64.getEncoder().encode(auth.getBytes(StandardCharsets.ISO_8859_1));
        String authHeader = "Basic " + new String(encodedAuth);

        try {
            HttpClient client = HttpClientBuilder.create().build();
            HttpGet getRequest = new HttpGet(couchDbUrl + "_design/catalogue_views/_view/all_catalogue/");

            // Préparer l'en-tête d'autorisation
            getRequest.setHeader(HttpHeaders.AUTHORIZATION, authHeader);
            System.out.println("Get Request: " + getRequest.toString());
            HttpResponse getResponse = client.execute(getRequest);

            String json = EntityUtils.toString(getResponse.getEntity());
            JSONObject jsonObject = new JSONObject(json);
            JSONArray rows = jsonObject.getJSONArray("rows");

            System.out.println("Updating documents...");

            for (int i = 0; i < rows.length(); i++) {
                JSONObject doc = rows.getJSONObject(i).getJSONObject("value");
                String marque = doc.getString("marque");
                if (hdfsData.containsKey(marque)) {
                    String[] values = hdfsData.get(marque);
                    doc.put("Bonus / Malus", values[0]);
                    doc.put("Rejets CO2 g/km", values[1]);
                    doc.put("Cout Energie", values[2]);

                    // PUT request to update the document in CouchDB
                    HttpPut putRequest = new HttpPut(couchDbUrl + doc.getString("_id") + "?rev=" + doc.getString("_rev"));
                    putRequest.setHeader(HttpHeaders.AUTHORIZATION, authHeader);
                    doc.remove("_rev");
                    putRequest.setHeader("Content-Type", "application/json");
                    putRequest.setEntity(new StringEntity(doc.toString()));
                    System.out.println("Put Request: " + putRequest.toString());
                    System.out.println("Put Request Body: " + doc.toString());
                    HttpResponse putResponse = client.execute(putRequest);
                    System.out.println("Updated document: " + doc.getString("_id"));
                }
                sleep(500);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
