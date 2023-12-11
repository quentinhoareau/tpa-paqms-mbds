# Utiliser une image de base Python
FROM python:3.9

# Définir le répertoire de travail dans le conteneur
WORKDIR /usr/src

# Copier les fichiers de script Python dans le conteneur
COPY ./volumes /usr/src

# Installer les dépendances Python
RUN pip install hdfs psycopg2-binary psycopg2

CMD ["sh", "init.sh"]
