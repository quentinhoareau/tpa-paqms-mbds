import couchdb
import csv
from hdfs import InsecureClient

def read_hdfs_file(hdfs_url, hdfs_file_path):
    client = InsecureClient(hdfs_url, user='fichiers')  # Assurez-vous que le user est correct
    data = {}
    with client.read(hdfs_file_path, encoding='utf-8') as file:
        csv_reader = csv.reader(file, delimiter='\t')
        for row in csv_reader:
            if len(row) == 2:
                marque, values = row[0], row[1].split(',')
                marque = marque.lower()
                data[marque] = values
    return data

def update_couchdb_documents(couchdb_url, db_name, hdfs_data):
    couch = couchdb.Server(couchdb_url)
    db = couch[db_name]

    view_url = '_design/catalogue_views/_view/all_catalogue'
    for row in db.view(view_url):
        doc_id = row.id
        doc = db[doc_id]
        marque = doc.get('marque')
        marque = marque.lower()

        if marque in hdfs_data:
            doc['Bonus / Malus'], doc['Rejets CO2 g/km'], doc['Cout Energie'] = hdfs_data[marque]
            db.save(doc)
            print(f"Updated document: {doc_id}")

        else :
            doc['Bonus / Malus'], doc['Rejets CO2 g/km'], doc['Cout Energie'] = [0, 0, 0]
            db.save(doc)
            print(f"Updated document: {doc_id}")


if __name__ == "__main__":
    print("Start Update Catalogue")

    hdfs_url = "http://namenode:9870"
    hdfs_file_path = "results/part-r-00000"
    couchdb_url = "http://admin:password@tpa-couchdb:5984/"
    db_name = "tpa"

    hdfs_data = read_hdfs_file(hdfs_url, hdfs_file_path)
    print("HDFS data:", hdfs_data)

    update_couchdb_documents(couchdb_url, db_name, hdfs_data)
    print("End Update Catalogue")