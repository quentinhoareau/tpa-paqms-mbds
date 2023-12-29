package org.example;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

import java.io.IOException;

public class CO2Analysis {

    public static class CO2Mapper extends Mapper<Object, Text, Text, Text> {
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

    public static class CO2Reducer extends Reducer<Text, Text, Text, Text> {
        @Override
        public void reduce(Text key, Iterable<Text> values, Context context) throws IOException, InterruptedException {
            double totalCO2 = 0, totalBonusMalus = 0, totalCoutEnergie = 0;
            int count = 0;

            for (Text value : values) {
                String[] parts = value.toString().split(",");

                // Ajout d'une vérification pour s'assurer que la chaîne n'est pas vide
                if (parts.length >= 3 && !parts[0].isEmpty() && !parts[1].isEmpty() && !parts[2].isEmpty()) {
                    try {
                        totalBonusMalus += Double.parseDouble(parts[0]);
                        totalCO2 += Double.parseDouble(parts[1]);
                        totalCoutEnergie += Double.parseDouble(parts[2]);
                        count++;
                    } catch (NumberFormatException e) {
                        // Gérer l'exception ou ignorer la valeur mal formatée
                        // Par exemple, vous pouvez écrire un message dans le log
                        System.err.println("NumberFormatException encountered, skipping the record: " + e.getMessage());
                    }
                }
            }

            if (count > 0) {
                double averageCO2 = totalCO2 / count;
                double averageBonusMalus = totalBonusMalus / count;
                double averageCoutEnergie = totalCoutEnergie / count;
                String averages = averageBonusMalus + "," + averageCO2 + "," + averageCoutEnergie;
                context.write(key, new Text(averages));
            }
        }
    }

    public static void main(String[] args) throws Exception {
        // Vérifiez que les chemins d'entrée et de sortie sont fournis
        if (args.length != 2) {
            System.err.println("Usage: CO2MapReduce <input path> <output path>");
            System.exit(-1);
        }

        // Configuration de base
        Configuration conf = new Configuration();
        Job job = Job.getInstance(conf, "CO2 Analysis");
        job.setJarByClass(CO2Analysis.class);

        // Configuration des classes Mapper et Reducer
        job.setMapperClass(CO2Mapper.class);
        job.setReducerClass(CO2Reducer.class);

        // Configuration des types de clés/valeurs de sortie du Mapper
        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(Text.class);

        // Configuration des types de clés/valeurs de sortie
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);

        // Configuration des chemins d'entrée et de sortie
        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));

        // Lancement du job et attente de sa complétion
        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
}