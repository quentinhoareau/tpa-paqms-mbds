# Documentation

## Prérequis 
- Clonage du projet sur votre système.
- Installation de Docker sur votre machine locale (Docker Desktop).
- Installation de Python sur votre machine locale.
- Si vous êtes sous Windows, il va falloir installer wsl2 (sous la forme d'un ubuntu ou debian peu importe)
- IMPORTANT : Vérifier que wsl2 est bien dans la version 2 (<a href="https://docs.docker.com/desktop/wsl/">suivre ce tuto</a>) et coché dans les paramètres de Docker Desktop l'utilisation de wsl2.

## Démarrage du script de construction du lac de données
Assurez-vous d'avoir complété les prérequis avant de procéder.

### Lancement du script `DOCKER/start.sh`
- Sous macOS :
  - Positionnez-vous dans le dossier racine du projet.
  - Exécutez la commande : `sh DOCKER/start.sh`.
 - Sous windows :
   - Ouvrir wsl2
   - Positionnez-vous dans le dossier racine du projet (cd /mnt/c/...) et se placer dans : ``` cd DOCKER ```
   - Executer la commande : ``` sh start.sh ```
   - Si vous avez une erreur de type : ``` Syntax error: redirection unexpected ``` (Malheureusement, il y a un problème d'encodage avec le script start.sh quand on clone le projet sous windows) :
      - Il va falloir vérifier plusieurs choses :
        - Vérifiez que le script `DOCKER/start.sh` est bien encodé en UTF-8.
        - Vérifiez que le script `DOCKER/start.sh` a bien les droits d'exécution.
        - Vérifiez que le script `DOCKER/start.sh` a bien les fins de ligne de type UNIX.
