-- CREATE TABLE marketing
CREATE TABLE marketing
(
    id                  SERIAL PRIMARY KEY,
    age                 INTEGER,
    sexe                CHAR(1),
    taux                INTEGER,
    situation_familiale VARCHAR(20),
    nb_enfants_a_charge INTEGER,
    deuxieme_voiture    BOOLEAN
);

-- CREATE TABLE catalogue
CREATE TABLE catalogue
(
    id              SERIAL PRIMARY KEY,
    marque          VARCHAR(255),
    nom             VARCHAR(255),
    puissance       INTEGER,
    longueur        VARCHAR(50),
    nbPlaces        INTEGER,
    nbPortes        INTEGER,
    couleur         VARCHAR(50),
    occasion        VARCHAR(5)     NOT NULL,
    prix            INTEGER        NOT NULL,
    bonus_malus     DECIMAL(10, 2) NOT NULL,
    rejets_co2_g_km DECIMAL(10, 1) NOT NULL,
    cout_energie    DECIMAL(10, 2) NOT NULL
);

-- CREATE TABLE clients
CREATE TABLE clients
(
    id                  SERIAL PRIMARY KEY,
    age                 INTEGER,
    sexe                CHAR(1),
    taux                INTEGER,
    situation_familiale VARCHAR(20),
    nb_enfants_a_charge INTEGER,
    deuxieme_voiture    VARCHAR(5),
    immatriculation     VARCHAR(15)
);

-- CREATE TABLE immatriculations
CREATE TABLE immatriculations
(
    id              SERIAL PRIMARY KEY,
    immatriculation VARCHAR(15),
    marque          VARCHAR(255),
    nom             VARCHAR(255),
    puissance       INTEGER,
    longueur        VARCHAR(50),
    nb_places       INTEGER,
    nb_portes       INTEGER,
    couleur         VARCHAR(50),
    occasion        VARCHAR(5),
    prix            DECIMAL(10, 2)
);

-- CREATE TABLE co2
CREATE TABLE co2
(
    id              SERIAL PRIMARY KEY,
    marque   VARCHAR(255),
    modele   VARCHAR(255),
    bonus_malus     VARCHAR(20),
    rejets_co2_g_km DECIMAL(10, 1),
    cout_energie    DECIMAL(10, 2)
);


-- TODO : TO BE REMOVED
INSERT INTO catalogue (marque, nom, puissance, longueur, nbPlaces, nbPortes, couleur, occasion, prix, bonus_malus,
                       rejets_co2_g_km, cout_energie)
VALUES ('Renault', 'Megane', 120, 'moyenne', 5, 5, 'gris', TRUE, 20000.00, 'B', 95.5, 120.00),
       ('Renault', 'Megane', 120, 'moyenne', 5, 5, 'rouge', TRUE, 20000.00, 'B', 95.5, 120.00),
       ('Renault', 'Megane', 120, 'moyenne', 5, 5, 'bleu', TRUE, 20000.00, 'B', 95.5, 120.00),
       ('Peugeot', '308', 110, 'moyenne', 5, 5, 'vert', FALSE, 19000.50, 'C', 90.0, 110.50),
       ('Citroen', 'C4', 95, 'compacte', 5, 5, 'bleu', TRUE, 18000.75, 'A', 85.2, 105.75),
       ('Fiat', '500', 85, 'courte', 4, 3, 'rouge', FALSE, 15000.25, 'B', 80.8, 100.25),
       ('Chevrolet', 'Spark', 80, 'courte', 4, 3, 'jaune', TRUE, 14000.50, 'C', 75.0, 90.50),
       ('Hyundai', 'i20', 100, 'compacte', 5, 5, 'orange', FALSE, 16000.75, 'A', 88.3, 110.75),
       ('Kia', 'Rio', 95, 'compacte', 5, 5, 'violet', TRUE, 17000.00, 'B', 91.5, 115.00),
       ('Nissan', 'Micra', 75, 'courte', 4, 3, 'rose', FALSE, 13000.25, 'C', 70.2, 85.25),
       ('Ford', 'Fiesta', 120, 'moyenne', 5, 5, 'noir', TRUE, 18500.50, 'A', 98.0, 115.50),
       ('Volkswagen', 'Polo', 110, 'moyenne', 5, 5, 'gris', FALSE, 17500.75, 'B', 93.2, 110.75),
       ('Toyota', 'Yaris', 90, 'compacte', 5, 5, 'blanc', TRUE, 16000.00, 'C', 86.5, 105.00),
       ('Mazda', '2', 85, 'courte', 4, 3, 'bleu', FALSE, 14500.25, 'A', 80.8, 95.25),
       ('Honda', 'Fit', 100, 'compacte', 5, 5, 'rouge', TRUE, 17000.50, 'B', 92.0, 110.50),
       ('Subaru', 'Impreza', 150, 'moyenne', 5, 5, 'vert', FALSE, 22000.75, 'C', 105.3, 130.75),
       ('Audi', 'A3', 130, 'moyenne', 5, 5, 'noir', TRUE, 25000.00, 'A', 115.5, 140.00),
       ('BMW', '1 Series', 140, 'moyenne', 5, 5, 'bleu', FALSE, 27000.25, 'B', 120.8, 150.25),
       ('Mercedes-Benz', 'A-Class', 110, 'compacte', 5, 5, 'gris', TRUE, 20000.50, 'C', 95.0, 115.50),
       ('Jaguar', 'X-Type', 180, 'longue', 5, 5, 'rouge', FALSE, 30000.75, 'A', 125.2, 160.75),
       ('Land Rover', 'Discovery Sport', 200, 'longue', 7, 5, 'blanc', TRUE, 40000.00, 'B', 135.0, 180.00),
       ('Tesla', 'Model S', 500, 'très longue', 5, 4, 'noir', FALSE, 80000.25, 'C', 200.0, 300.25),
       ('Porsche', '911', 450, 'moyenne', 2, 2, 'argent', TRUE, 120000.50, 'A', 180.5, 250.50);

INSERT INTO immatriculations (immatriculation, marque, nom, puissance, longueur, nbPlaces, nbPortes, couleur, occasion,
                              prix)
VALUES ('ABC123', 'Renault', 'Megane', 120, 'moyenne', 5, 5, 'gris', TRUE, 20000.00),
       ('EFG850', 'Renault', 'Megane', 120, 'moyenne', 5, 5, 'rouge', TRUE, 21000.00),
       ('EFG854', 'Renault', 'Megane', 120, 'moyenne', 5, 5, 'bleu', TRUE, 22000.00),
       ('DEF456', 'Peugeot', '308', 110, 'moyenne', 5, 5, 'vert', FALSE, 19000.50),
       ('GHI789', 'Citroen', 'C4', 95, 'compacte', 5, 5, 'bleu', TRUE, 18000.75),
       ('JKL012', 'Fiat', '500', 85, 'courte', 4, 3, 'rouge', FALSE, 15000.25),
       ('MNO345', 'Chevrolet', 'Spark', 80, 'courte', 4, 3, 'jaune', TRUE, 14000.50),
       ('PQR678', 'Hyundai', 'i20', 100, 'compacte', 5, 5, 'orange', FALSE, 16000.75),
       ('STU901', 'Kia', 'Rio', 95, 'compacte', 5, 5, 'violet', TRUE, 17000.00),
       ('VWX234', 'Nissan', 'Micra', 75, 'courte', 4, 3, 'rose', FALSE, 13000.25),
       ('YZA567', 'Ford', 'Fiesta', 120, 'moyenne', 5, 5, 'noir', TRUE, 18500.50),
       ('BCD890', 'Volkswagen', 'Polo', 110, 'moyenne', 5, 5, 'gris', FALSE, 17500.75),
       ('EFG123', 'Toyota', 'Yaris', 90, 'compacte', 5, 5, 'blanc', TRUE, 16000.00),
       ('HIJ456', 'Mazda', '2', 85, 'courte', 4, 3, 'bleu', FALSE, 14500.25),
       ('KLM789', 'Honda', 'Fit', 100, 'compacte', 5, 5, 'rouge', TRUE, 17000.50),
       ('NOP012', 'Subaru', 'Impreza', 150, 'moyenne', 5, 5, 'vert', FALSE, 22000.75),
       ('PQR345', 'Audi', 'A3', 130, 'moyenne', 5, 5, 'noir', TRUE, 25000.00),
       ('STU678', 'BMW', '1 Series', 140, 'moyenne', 5, 5, 'bleu', FALSE, 27000.25),
       ('VWX901', 'Mercedes-Benz', 'A-Class', 110, 'compacte', 5, 5, 'gris', TRUE, 20000.50),
       ('YZA234', 'Jaguar', 'X-Type', 180, 'longue', 5, 5, 'rouge', FALSE, 30000.75),
       ('BCD567', 'Land Rover', 'Discovery Sport', 200, 'longue', 7, 5, 'blanc', TRUE, 40000.00),
       ('EFG890', 'Tesla', 'Model S', 500, 'très longue', 5, 4, 'noir', FALSE, 80000.25),
       ('HIJ123', 'Porsche', '911', 450, 'moyenne', 2, 2, 'argent', TRUE, 120000.50);
