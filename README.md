# Documentation

## Prérequis 
- Clonage du projet sur votre système.
- Installation de Docker sur votre machine locale (Docker Desktop).
- Installation de Python sur votre machine locale.
- Si vous êtes sous Windows, il va falloir installer wsl2 (sous la forme d'un ubuntu ou debian peu importe)
- IMPORTANT : Vérifier que wsl2 est bien dans la version 2 (<a href="https://docs.docker.com/desktop/wsl/">suivre ce tuto</a>) et coché dans les paramètres de Docker Desktop l'utilisation de wsl2.
- IMPORTANT : Vérifier dans les paramètres de Docker Desktop > Resources > WSL INTEGRATION que votre distribution wsl2 est bien coché (Ubuntu ou Debian peu importe).

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
        - Vérifiez que le script `DOCKER/start.sh` a bien les fins de ligne de type UNIX :
          - Pour se faire : vous pouvez utiliser notepad++ et ouvrir les fichiers de script .sh et les scripts python (c'est important car tout les fichiers sh doivent être au format UNIX) :
          - > Scripts python : script_formatage.py, script_formatage_CO2.py, populate_couchdb.py, transformCatalogue.py 
          - > Script sh : start.sh, init.sh (x2), initDB.sh (x2), hdfs.sh, runMapReduce.sh
          - Une fois les fichiers ouverts, en bas à droite de la fenêtre, vous avez le type d'encodage et le type de fin de ligne.
          - Si c'est "Windows (CR LF)" il faut le passer en "UNIX (LF)" et sauvegarder ensuite le fichier
 ### Utilisation de NiFi
  Pour la mise en place Nifi "from scratch" avec des images, veuillez consulter le rapport (partie **Bus de données en NIFI**)
  Si le template est déjà chargé (il doit être chargé au premier lancement, docker le conserve ensuite en mémoire), on exécute toutes les chaines de processeurs unes par unes (par exemple, on prend une chaine GetMongo,   et on démarre tous les processeurs qui lui sont connectés. Ensuite, on fait un clique droit sur GetMongo, et on clique sur "Run Once"

