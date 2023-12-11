# Import the required libraries
import couchdb
import time
import csv

def save_csv_to_couchdb(csv_file_path, couchdb_url='http://admin:password@tpa-couchdb:5984/', db_name='tpa', retry_interval=3):
    # Connect to CouchDB
    server = couchdb.Server(couchdb_url)

    # Create or select the database
    while True:
        try:
            if db_name in server:
                db = server[db_name]
            else:
                db = server.create(db_name)

            # Read data from CSV file
            with open(csv_file_path, 'r') as csv_file:
                csv_reader = csv.DictReader(csv_file)

                # Insert each row into the database
                for row in csv_reader:
                    # Insert data into the database
                    doc_id, doc_rev = db.save(row)

                    # Print the generated document ID and revision
                    print(f"Document ID: {doc_id}")
                    print(f"Document Revision: {doc_rev}")

            # If everything is good, break out of the loop
            break

        except Exception as e:
            # If an exception occurs, print the error, sleep, and retry
            print(f"An error occurred: {e}")
            print(f"Retrying in {retry_interval} seconds...")
            time.sleep(retry_interval)

save_csv_to_couchdb('/tpa-python/datasource/Marketing_utf8.csv')
save_csv_to_couchdb('/tpa-python/datasource/Catalogue_utf8.csv')