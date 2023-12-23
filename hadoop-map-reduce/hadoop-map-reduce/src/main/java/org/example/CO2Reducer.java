package org.example;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

import java.io.IOException;

public class CO2Reducer extends Reducer<Text, Text, Text, Text> {
    @Override
    protected void reduce(Text key, Iterable<Text> values, Context context) throws InterruptedException, IOException {
        // Calculer les moyennes des colonnes pour chaque marque
        double totalEmission = 0.0;
        double totalEnergyCost = 0.0;
        int count = 0;

        for (Text value : values) {
            String[] columns = value.toString().split(",");
            totalEmission += Double.parseDouble(columns[0]);
            totalEnergyCost += Double.parseDouble(columns[2]);
            count++;
        }

        double avgEmission = totalEmission / count;
        double avgEnergyCost = totalEnergyCost / count;

        // Émettre la marque avec les moyennes
        context.write(key, new Text(String.valueOf(avgEmission) + "," + String.valueOf(avgEnergyCost)));
    }
}