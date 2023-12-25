package org.example;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;
import java.io.IOException;

public class CO2Reducer extends Reducer<Text, Text, Text, Text> {
    @Override
    public void reduce(Text key, Iterable<Text> values, Context context) throws IOException, InterruptedException {
        int totalCO2 = 0, totalBonusMalus = 0, totalCoutEnergie = 0;
        int count = 0;

        for (Text value : values) {
            String[] parts = value.toString().split(",");

            totalCO2 += Integer.parseInt(parts[0]);
            totalBonusMalus += Integer.parseInt(parts[1]);
            totalCoutEnergie += Integer.parseInt(parts[2]);
            count++;
        }

        String averages = (totalCO2 / count) + "," + (totalBonusMalus / count) + "," + (totalCoutEnergie / count);
        context.write(key, new Text(averages));
    }
}