-- CREATE TABLE marketing
CREATE TABLE marketing (
    id SERIAL PRIMARY KEY,
    age INTEGER,
    sexe CHAR(1),
    taux INTEGER,
    situation_familiale VARCHAR(20),
    nb_enfants_a_charge INTEGER,
    deuxieme_voiture BOOLEAN
);

-- CREATE TABLE catalogue
CREATE TABLE catalogue (
    id SERIAL PRIMARY KEY,
    marque VARCHAR(255) NOT NULL,
    nom VARCHAR(255) NOT NULL,
    puissance INTEGER NOT NULL,
    longueur VARCHAR(50),
    nbPlaces INTEGER,
    nbPortes INTEGER,
    couleur VARCHAR(50),
    occasion BOOLEAN NOT NULL,
    prix DECIMAL(10, 2) NOT NULL
);

-- CREATE TABLE clients
CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    age INTEGER,
    sexe CHAR(1),
    taux INTEGER,
    situation_familiale VARCHAR(20),
    nb_enfants_a_charge INTEGER,
    deuxieme_voiture BOOLEAN,
    immatriculation VARCHAR(15)
);

-- CREATE TABLE immatriculations
CREATE TABLE immatriculations (
    id SERIAL PRIMARY KEY,
    immatriculation VARCHAR(15) NOT NULL,
    marque VARCHAR(255) NOT NULL,
    nom VARCHAR(255) NOT NULL,
    puissance INTEGER NOT NULL,
    longueur VARCHAR(50),
    nbPlaces INTEGER,
    nbPortes INTEGER,
    couleur VARCHAR(50),
    occasion BOOLEAN NOT NULL,
    prix DECIMAL(10, 2) NOT NULL
);

-- CREATE TABLE co2
CREATE TABLE co2 (
    id SERIAL PRIMARY KEY,
    marque_modele VARCHAR(255) NOT NULL,
    bonus_malus VARCHAR(20) NOT NULL,
    rejets_co2_g_km DECIMAL(10, 1) NOT NULL,
    cout_energie DECIMAL(10, 2) NOT NULL
);

