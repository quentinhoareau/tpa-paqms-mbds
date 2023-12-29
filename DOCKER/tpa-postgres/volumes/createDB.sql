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
    marque VARCHAR(255),
    nom VARCHAR(255),
    puissance INTEGER,
    longueur VARCHAR(50),
    nbPlaces INTEGER,
    nbPortes INTEGER,
    couleur VARCHAR(50),
    occasion BOOLEAN,
    prix DECIMAL(10, 2)
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
    immatriculation VARCHAR(15),
    marque VARCHAR(255),
    nom VARCHAR(255),
    puissance INTEGER,
    longueur VARCHAR(50),
    nbPlaces INTEGER,
    nbPortes INTEGER,
    couleur VARCHAR(50),
    occasion BOOLEAN,
    prix DECIMAL(10, 2)
);

-- CREATE TABLE co2
CREATE TABLE co2 (
    id SERIAL PRIMARY KEY,
    marque_modele VARCHAR(255),
    bonus_malus VARCHAR(20),
    rejets_co2_g_km DECIMAL(10, 1),
    cout_energie DECIMAL(10, 2)
);

