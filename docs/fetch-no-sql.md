# CouchDB

### Retreive Marketing document
- Lancer le start.sh
- Exécuter ces commandes bash sur votre marchine local

```bash
curl -X POST http://admin:password@localhost:5984/tpa/_find -H "Content-Type: application/json" -d '{
   "selector": {
      "document_type": "marketing"
   },
   "limit": 999
}'
```

### Retreive Marketing document
```bash
curl -X POST http://admin:password@localhost:5984/tpa/_find -H "Content-Type: application/json" -d '{
   "selector": {
      "document_type": "catalogue"
   },
    "limit": 999
}'
```

# MongoDB:
- Lancer le start.sh
- Exécuter ces commandes bash sur le container mongodb 
```bash
mongosh
use tpa
db.clients.find();
db.immatriculations.find();
```

