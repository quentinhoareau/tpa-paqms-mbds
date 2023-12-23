package org.example;

import java.io.IOException;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
public class CO2Mapper extends Mapper<LongWritable, Text, Text, Text> {
    @Override
    protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
    // Diviser la ligne en colonnes
    String[] columns = value.toString().split(",");

    // Émettre la marque comme clé et les autres colonnes comme valeur
        if (columns.length >= 4) {
            String car = columns[0].trim();
            String emission = columns[1].trim();
            String bonusMalus = columns[2].trim();
            String energyCost = columns[3].trim();

            context.write(new Text(car), new Text(emission + "," + bonusMalus + "," + energyCost));
        }
    }
}

