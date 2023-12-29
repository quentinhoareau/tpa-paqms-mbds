import csv

def corriger_null(ligne):
    ligne_corrigee = []

    for element in ligne:
        if element.strip() in ["", "?", "N/D"]:
            ligne_corrigee.append("NULL")
        elif element.strip().lstrip('-').isdigit() and int(element.strip()) < 0:
            ligne_corrigee.append("NULL")
        else:
            ligne_corrigee.append(element.strip())

    return ligne_corrigee
   
def corriger_sexe(sexe):
    if sexe.strip().lower() in ["femme", "féminin"]:
        return "F"
    elif sexe.strip().lower() in ["homme", "masculin"]:
        return "M"
    else:
        return sexe.strip()

def corriger_situation_familiale(situation):
    if situation.strip().lower() in ["seule", "seul"]:
        return "Célibataire"
    else:
        return situation.strip()

def corriger_ligne(ligne):
    ligne = corriger_null(ligne)
    ligne[1] = corriger_sexe(ligne[1])
    ligne[3] = corriger_situation_familiale(ligne[3])
    return ligne

with open('Clients_10.csv', 'r', newline='') as csvfile_1, open('Clients_19.csv', 'r', newline='') as csvfile_2, open('Clients_clean.csv', 'w', newline='') as csvfile_clean:
    lecteur_1_csv = csv.reader(csvfile_1)
    lecteur_2_csv = csv.reader(csvfile_2)
    ecrivain_csv = csv.writer(csvfile_clean)

    en_tete_1 = next(lecteur_1_csv, None)
    en_tete_2 = next(lecteur_2_csv, None)

    ecrivain_csv.writerow(en_tete_1)

    if en_tete_1 is not None:
        print(f"En-tête du CSV_1 : {en_tete_1}")
        for ligne in lecteur_1_csv:
            #print(f"-ligne originale {ligne}")
            ligne_corrigee = corriger_ligne(ligne)
            #print(f"-ligne corrigee {ligne_corrigee}")
            if all(element != "NULL" for element in ligne_corrigee):
                ecrivain_csv.writerow(ligne_corrigee)
    
    if en_tete_2 is not None:
        print(f"En-tête du CSV_2 : {en_tete_2}")
        for ligne in lecteur_2_csv:
            #print(f"-ligne originale {ligne}")
            ligne_corrigee = corriger_ligne(ligne)
            #print(f"-ligne corrigee {ligne_corrigee}")
            if all(element != "NULL" for element in ligne_corrigee):
                ecrivain_csv.writerow(ligne_corrigee)