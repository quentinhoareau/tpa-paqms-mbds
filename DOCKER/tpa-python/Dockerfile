FROM python:3.8

WORKDIR /tpa-python
COPY . /tpa-python/volumes

RUN pip install couchdb
CMD ["tail", "-f", "/dev/null"]