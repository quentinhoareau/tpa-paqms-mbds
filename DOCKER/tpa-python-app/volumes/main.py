from hdfs import InsecureClient

# Création du client HDFS
client = InsecureClient('http://namenode:9870', user='hdfs')

# Chemin du fichier dans HDFS
chemin_fichier_hdfs = '/user/fichiers/CO2.csv'

# conn = psycopg2.connect(
#     host="postgresql-container",
#     database="nom_base_de_donnees",
#     user="utilisateur",
#     password="mot_de_passe"
# )
# cur = conn.cursor()

# Lecture du fichier
with client.read(chemin_fichier_hdfs, encoding='utf-8') as reader:
    for line in reader:
        print(line)
        # requête SQL query = "INSERT INTO table (colonne1, colonne2, colonne3) VALUES (%s, %s, %s)"
        # cur.execute(query, line)

# # Valider la transaction
# conn.commit()
#
# # Fermer la connexion
# cur.close()
# conn.close()
