import couchdb
import time
import csv


def convert_value(value):
    try:
        # Tente de convertir en entier
        return int(value)
    except ValueError:
        try:
            # Sinon, tente de convertir en flottant
            return float(value)
        except ValueError:
                return value

def save_csv_to_couchdb(csv_file_path, document_type, couchdb_url='http://admin:password@tpa-couchdb:5984/', db_name='tpa', retry_interval=3):
    # Connect to CouchDB
    server = couchdb.Server(couchdb_url)
    # Create or select the database
    while True:
        try:
            if db_name in server:
                db = server[db_name]
                # Read data from CSV file
                with open(csv_file_path, 'r') as csv_file:
                    csv_reader = csv.DictReader(csv_file)
                    nbDoc = 0

                    # Insert each row into the database with the specified document type
                    for row in csv_reader:
                        # Add the document_type field to the document
                        row['document_type'] = document_type
                        converted_row = {key: convert_value(value) for key, value in row.items()}
                        # Insert data into the database
                        doc_id, doc_rev = db.save(converted_row)
                        nbDoc += 1
                        # Print the generated document ID and revision
                        
                    print(f"Number of documents inserted for {csv_file_path}: {nbDoc}")

                # If everything is good, break out of the loop
                break
            else:
                raise Exception(f"Database '{db_name}' not found.")
        except Exception as e:
            # If an exception occurs, print the error, sleep, and retry
            print(f"An error occurred: {e}")
            print(f"Retrying in {retry_interval} seconds...")
            time.sleep(retry_interval)


def create_or_update_view(db_name, design_doc_name, view_name, map_function, couchdb_url='http://admin:password@tpa-couchdb:5984/'):
    server = couchdb.Server(couchdb_url)
    db = server[db_name]

    # Vérifier si le document de design existe déjà
    if design_doc_name in db:
        design_doc = db[design_doc_name]
    else:
        design_doc = {"_id": f"_design/{design_doc_name}", "views": {}}

    # Ajouter ou mettre à jour la vue dans le document de design
    design_doc["views"][view_name] = {"map": map_function}

    # Sauvegarder le document de design
    db.save(design_doc)
    print(f"View '{view_name}' has been created/updated in design document '{design_doc_name}'.")



# Insert data from Marketing CSV with a document_type of 'marketing'
save_csv_to_couchdb('/tpa-python/datasource/Marketing_utf8.csv', 'marketing')

# Insert data from Catalogue CSV with a document_type of 'catalogue'
save_csv_to_couchdb('/tpa-python/datasource/Catalogue_utf8.csv', 'catalogue')

# Creation de la vue pour avoir seulement les documents de "catalogue"
create_or_update_view(db_name='tpa',
                      design_doc_name="catalogue_views",
                      view_name="all_catalogue",
                      map_function="function (doc) { if (doc.document_type === 'catalogue') { emit(doc._id, doc); } }")

create_or_update_view(db_name='tpa',
                      design_doc_name="marketing_views",
                      view_name="all_marketing",
                      map_function="function (doc) { if (doc.document_type === 'marketing') { emit(doc._id, doc); } }")