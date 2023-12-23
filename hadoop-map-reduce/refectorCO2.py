import pandas as pd
import numpy as np

# Load the CO2.csv file
file_path = '../DOCKER/datasource/CO2.csv'  # Remplacez ceci par le chemin de votre fichier
co2_data = pd.read_csv(file_path)

# Splitting the 'Marque / Modele' column into 'Marque' and 'Modele'
co2_data[['Marque', 'Modele']] = co2_data['Marque / Modele'].str.split(' ', n=1, expand=True)

# Cleaning the 'Bonus / Malus' column
co2_data['Bonus / Malus'] = co2_data['Bonus / Malus'].str.replace(r'\s1$', '', regex=True)
co2_data['Bonus / Malus'] = co2_data['Bonus / Malus'].str.replace(r'[^\d-]', '', regex=True)
co2_data['Bonus / Malus'] = co2_data['Bonus / Malus'].replace({'': np.nan, '-': np.nan})
co2_data['Bonus / Malus'] = co2_data['Bonus / Malus'].astype(float)
co2_data['Bonus / Malus'] = co2_data['Bonus / Malus'].apply(lambda x: x / 10 if x == -60001 else x)

# Cleaning the 'Cout enerie' column
co2_data['Cout energie'] = co2_data['Cout enerie'].str.replace(r'[^\d.]', '', regex=True).astype(float)

# Displaying the cleaned data
cleaned_data = co2_data[['Marque', 'Modele', 'Bonus / Malus', 'Rejets CO2 g/km', 'Cout energie']]

# Save the cleaned data to a new CSV file
output_file_path = '../DOCKER/datasource/cleaned_CO2.csv'
cleaned_data.to_csv(output_file_path, index=False)