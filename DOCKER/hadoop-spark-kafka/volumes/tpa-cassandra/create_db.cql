-- Connect to Cassandra and create the keyspace
CREATE KEYSPACE IF NOT EXISTS tpa WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

-- Use the keyspace
USE tpa;

-- Create tables (equivalent to collections in MongoDB)
CREATE TABLE IF NOT EXISTS catalogue (
                                         id UUID PRIMARY KEY,
                                         marque TEXT,
                                         nom TEXT,
                                         puissance TEXT,
                                         longueur TEXT,
                                         nbPlaces INT,
                                         nbPortes INT,
                                         couleur TEXT,
                                         occasion BOOLEAN,
                                         prix INT
);

CREATE TABLE IF NOT EXISTS client (
                                      id UUID PRIMARY KEY,
                                      age INT,
                                      sexe TEXT,
                                      taux DECIMAL,
                                      situationFamiliale TEXT,
                                      nbEnfantsAcharge INT,
                                      deuxiemeVoiture BOOLEAN,
                                      immatriculation TEXT
);

CREATE TABLE IF NOT EXISTS immatriculation (
                                               id UUID PRIMARY KEY,
                                               immatriculation TEXT,
                                               marque TEXT,
                                               nom TEXT,
                                               puissance INT,
                                               longueur TEXT,
                                               nbPlaces INT,
                                               nbPortes INT,
                                               couleur TEXT,
                                               occasion BOOLEAN,
                                               prix INT
);

CREATE TABLE IF NOT EXISTS marketing (
                                         id UUID PRIMARY KEY,
                                         age INT,
                                         sexe TEXT,
                                         taux INT,
                                         situationFamiliale TEXT,
                                         nbEnfantsAcharge INT,
                                         deuxiemeVoiture BOOLEAN
);

COPY immatriculation (immatriculation, marque, nom, puissance, longueur, nbPlaces, nbPortes, couleur, occasion, prix) FROM 'Immatriculations.csv' WITH HEADER = true;