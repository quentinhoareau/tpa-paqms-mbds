import pandas as pd
import numpy as np
import os
# Path to the original and temporary cleaned file
file_path = '../DOCKER/datasource/CO2.csv'
temp_file_path = '../DOCKER/datasource/temp_cleaned_CO2.csv'  # Chemin pour le fichier temporaire nettoyé

# Read the content of the file, remove quotes and save to a temporary file
with open(file_path, 'r') as file, open(temp_file_path, 'w') as temp_file:
    for line in file:
        cleaned_line = line.replace('"', '')
        temp_file.write(cleaned_line)

# Load the CO2.csv file
co2_data = pd.read_csv(temp_file_path)

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

if os.path.exists(temp_file_path):
    os.remove(temp_file_path)
    print("Le fichier temp_CO2 a été supprimé.")
else:
    print("Le fichier temp_CO2 n'existe pas.")