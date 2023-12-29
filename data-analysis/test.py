import csv

def afficher_valeurs_colonne(fichier_csv):
    try:
        with open(fichier_csv, 'r', newline='') as csvfile:
            lecteur_csv = csv.reader(csvfile)
            
            # Ignorer l'en-tête
            en_tete = next(lecteur_csv, None)
            if en_tete is not None:
                print(f"En-tête du CSV : {en_tete}")

                print("Affichage des différentes valeurs de la colonne :")

                # Utiliser un ensemble pour stocker les valeurs uniques
                ages = set()
                sexes = set()
                taux = set()
                sfs = set()
                nbes = set()
                scndvs = set()
                imms = set()

                # Parcourir chaque ligne et ajouter la valeur à l'ensemble
                for ligne in lecteur_csv:
                    if ligne:
                        age = ligne[0]
                        ages.add(age)
                        sexe = ligne[1]
                        sexes.add(sexe)
                        tau = ligne[2]
                        taux.add(tau)
                        sf = ligne[3]
                        sfs.add(sf)
                        nbe = ligne[4]
                        nbes.add(nbe)
                        scndv = ligne[5]
                        scndvs.add(scndv)
                        imm = ligne[6]
                        imms.add(imm)

                # Afficher les valeurs uniques
                for age in ages:
                    print(f"- Age : {age}")

                for sexe in sexes:
                    print(f"- sexe : {sexe}")

                #for tau in taux:
                #    print(f"- taux : {tau}")

                for sf in sfs:
                    print(f"- sf : {sf}")

                for nbe in nbes:
                    print(f"- nbe : {nbe}")

                for scndv in scndvs:
                    print(f"- scndv : {scndv}")

                #for imm in imms:
                #    print(f"- imm : {imm}")

    except FileNotFoundError:
        print(f"Le fichier '{fichier_csv}' n'a pas été trouvé.")
    except Exception as e:
        print(f"Une erreur s'est produite : {e}")

# Exemple d'utilisation
fichier_csv = 'Clients_19.csv'  # Remplacez ceci par le chemin de votre fichier CSV

afficher_valeurs_colonne(fichier_csv)