import couchdb
import time
import csv

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
                        # Insert data into the database
                        doc_id, doc_rev = db.save(row)
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

# Insert data from Marketing CSV with a document_type of 'marketing'
save_csv_to_couchdb('/tpa-python/datasource/Marketing_utf8.csv', 'marketing')

# Insert data from Catalogue CSV with a document_type of 'catalogue'
save_csv_to_couchdb('/tpa-python/datasource/Catalogue_utf8.csv', 'catalogue')