# Utiliser une image de base Python
FROM python:3.9

# Définir le répertoire de travail dans le conteneur
WORKDIR /usr/src

# Copier les fichiers de script Python dans le conteneur
COPY ./connecteurs-py /usr/src

# Installer les dépendances Python
RUN pip install hdfs psycopg2-binary psycopg2

# Commande pour garder le conteneur en vie pour le débogage
CMD tail -f /dev/null
