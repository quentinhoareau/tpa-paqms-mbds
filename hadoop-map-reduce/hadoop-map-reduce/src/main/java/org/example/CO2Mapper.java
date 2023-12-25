package org.example;

import java.io.IOException;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import java.io.IOException;

public class CO2Mapper extends Mapper<Object, Text, Text, Text> {
    @Override
    public void map(Object key, Text value, Context context) throws IOException, InterruptedException {
        String[] parts = value.toString().split(",");

        if (parts.length >= 5) {
            String marque = parts[0];
            String bonusMalus = parts[2];
            String emissionsCO2 = parts[3];
            String coutEnergie = parts[4];

            String combinedValues = emissionsCO2 + "," + bonusMalus + "," + coutEnergie;
            context.write(new Text(marque), new Text(combinedValues));
        }
    }
}