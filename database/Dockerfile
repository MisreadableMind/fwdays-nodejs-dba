FROM postgres:14.2-alpine

ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=fwdays_local

# initialization scripts executed automatically by image from this directory
WORKDIR docker-entrypoint-initdb.d/