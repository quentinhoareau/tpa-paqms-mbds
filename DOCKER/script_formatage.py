import os
import shutil
import pandas as pd

output_folder = './datasource/datasource_utf8'

# Créer le dossier de sortie s'il n'existe pas déjà
os.makedirs(output_folder, exist_ok=True)
os.makedirs(output_folder + '/mongo', exist_ok=True)
os.makedirs(output_folder + '/couchdb', exist_ok=True)

# Charger les fichiers CSV avec le bon encodage (par exemple, latin-1)
input_files = [
    './datasource/CO2.csv',
]

input_files_mongo = [
    './datasource/Immatriculations.csv',
    './datasource/Clients_10.csv',
    './datasource/Clients_19.csv',
]

input_files_couchdb = [
    './datasource/Catalogue.csv',
    './datasource/Marketing.csv',
]

# Convertir chaque fichier en UTF-8
def funToConvertUTF8(input_file, path_output_folder):
    # Extraire le nom du fichier pour générer le nom du fichier de sortie
    file_name = input_file.split('/')[-1].split('.')[0]
    output_file = f'./datasource/datasource_utf8{path_output_folder}{file_name}_utf8.csv'

    # Vérifier si le fichier d'entrée est déjà au format UTF-8
    try:
        df_input = pd.read_csv(input_file, encoding='utf-8')
        os.makedirs(os.path.dirname(output_file), exist_ok=True)
        shutil.copy2(input_file, output_file)  # Copier le fichier
        del df_input  # Libérer la référence au DataFrame
        print(f"Le fichier {file_name} est déjà au format UTF-8. Copié tel quel vers {output_file}")
        return
    except UnicodeDecodeError:
        # Le fichier nécessite une conversion
        pass

    # Convertir le fichier en UTF-8
    df = pd.read_csv(input_file, encoding='latin-1')

    # Supprimer le fichier de sortie s'il existe déjà
    if os.path.exists(output_file):
        try:
            os.remove(output_file)
        except PermissionError:
            print(f"PermissionError: Impossible de supprimer {output_file}, vérifier que le fichier n'est pas ouvert dans un autre programme")
            return

    # Sauvegarder le fichier CSV avec l'encodage UTF-8
    df.to_csv(output_file, encoding='utf-8', index=False, mode='w')

    # Afficher un message indiquant que le fichier est traité
    print(f"Le fichier {file_name} a été converti en UTF-8 et enregistré sous {output_file}".encode('utf-8').decode('utf-8'))

for input_file in input_files:
    funToConvertUTF8(input_file, '/')

for input_file in input_files_mongo:
    funToConvertUTF8(input_file, '/mongo/')

for input_file in input_files_couchdb:
    funToConvertUTF8(input_file, '/couchdb/')