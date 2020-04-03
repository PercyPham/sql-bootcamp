#!/bin/bash

# ------------------ Ensure network created -----
output=$(docker inspect try-sql 2>&1)
ret=$?

if [[ $ret -ne 0 ]]; then
  # this means the network doesn't exist yet, we will create one:
  echo "Creating network try-sql"
  docker network create -d bridge try-sql >/dev/null
else
  echo "> Network try-sql already created"
fi
# ------------------ End - Ensure network created


# ------------------ Start running Postgres ---------
RUNNING_PG_CONTAINER_ID=$(docker ps -qf "name=^try-pg$")
PG_CONTAINER_ID=$(docker ps -aqf "name=^try-pg$")

if [[ -n ${RUNNING_PG_CONTAINER_ID} ]]; then
  echo "> Local Postgres already started"
elif [[ -n ${PG_CONTAINER_ID} ]]; then
  echo "> Found a local Postgres container, restarting ..."
  docker start try-pg >/dev/null
  echo "> Restarted existing local Postgres"
else
  echo "> No local Postgres container found"
  echo "> Starting a new local Postgres ..."
  docker run --name try-pg \
    --network try-sql \
    -e POSTGRES_USER=percy \
    -e POSTGRES_PASSWORD=minhhung \
    -e POSTGRES_DB=todolist \
    -p 5432:5432 \
    -v /var/lib/postgresql/data \
    -d \
    postgres:12.1-alpine \
    >/dev/null
  echo "> Local Postgres has been started"
fi
# ------------------ End running Postgres ---------



# ------------------ Start running PgAdmin -----
RUNNING_PGADMIN_CONTAINER_ID=$(docker ps -qf "name=^try-pgadmin$")
PGADMIN_CONTAINER_ID=$(docker ps -aqf "name=^try-pgadmin$")

if [[ -n ${RUNNING_PGADMIN_CONTAINER_ID} ]]; then
  echo "> Local PgAdmin already started"
elif [[ -n ${PGADMIN_CONTAINER_ID} ]]; then
  echo "> Found a local PgAdmin container, restarting ..."
  docker start try-pgadmin >/dev/null
  echo "> Restarted existing local PgAdmin"
else
  echo "> No local PgAdmin container found"
  echo "> Starting a new local PgAdmin ..."
  docker run --name try-pgadmin \
    --network try-sql \
    -e 'PGADMIN_DEFAULT_EMAIL=sqldb-admin@example.com' \
    -e 'PGADMIN_DEFAULT_PASSWORD=sqldb-admin' \
    -p 8000:80 \
    -v /var/lib/pgadmin \
    -v /$(pwd)/pgadmin-data:/data \
    -d \
    dpage/pgadmin4:4.17 \
    >/dev/null
  echo "> Local PgAdmin has been started"
fi
# ------------------ End running PgAdmin -------
