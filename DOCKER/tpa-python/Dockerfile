FROM python:3.8

WORKDIR /tpa-python
COPY . /tpa-python/volumes

RUN pip install couchdb
RUN pip install hdfs psycopg2-binary psycopg2
CMD ["sh", "init.sh"]
CMD ["tail", "-f", "/dev/null"]