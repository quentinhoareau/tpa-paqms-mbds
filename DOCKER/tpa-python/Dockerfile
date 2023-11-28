FROM python:3.8

WORKDIR /tpa-python
COPY . /tpa-python

RUN pip install couchdb
CMD ["sh", "init.sh"]
