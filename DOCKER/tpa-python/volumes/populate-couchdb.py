# Import the required libraries
import couchdb
import time
import csv

# CouchDB configuration
couchdb_url = 'http://admin:password@tpa-couchdb:5984/'  # Replace with your CouchDB URL

# Connect to CouchDB
server = couchdb.Server(couchdb_url)

# Create or select the database (replace 'tpa' with your desired database name)
db_name = 'tpa'
retry_interval = 3  # Adjust the retry interval as needed
while True:
    try:
        if db_name in server:
            db = server[db_name]
        else:
            db = server.create(db_name)

        # Read data from CSV file
        csv_file_path = '/tpa-python/datasource/Marketing.csv'  # Replace with your CSV file path
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
