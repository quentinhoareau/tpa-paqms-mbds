package org.example;

import org.apache.http.HttpResponse;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import java.io.IOException;

public class CouchDBDataFetcher {

    public static void main(String[] args) {
        String couchDbUrl = "http://admin:password@127.0.0.1:5984/tpa/catalogue/_all_docs?include_docs=true";
        String username = "admin";
        String password = "password";

        try {
            // Configuration de l'authentification
            CredentialsProvider provider = new BasicCredentialsProvider();
            UsernamePasswordCredentials credentials = new UsernamePasswordCredentials(username, password);
            provider.setCredentials(AuthScope.ANY, credentials);

            // Création du client HttpClient
            HttpClient client = HttpClientBuilder.create().setDefaultCredentialsProvider(provider).build();

            // Création de la requête HTTP GET
            HttpGet request = new HttpGet(couchDbUrl);

            // Exécution de la requête
            HttpResponse response = client.execute(request);

            // Conversion de la réponse en chaîne de caractères
            String jsonResponse = EntityUtils.toString(response.getEntity());

            // Traitement de la réponse JSON
            System.out.println(jsonResponse);
            // Vous pouvez utiliser une bibliothèque comme Jackson ou Gson pour analyser cette réponse JSON

            //Analyse de la réponse JSON

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}