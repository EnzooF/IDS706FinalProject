SHELL := /bin/bash
ifneq (,$(wildcard ./.env))
    include .env
    export
endif

run:
	python3 amazon.py
install:
	pip install -r requirements.txt
lint:
	pylint --disable=R,C,W ./app
gen_db_data:
	cd db && python3 gen.py
load_db_data:
	cd db && PGPASSWORD=${DB_PASSWORD} psql -h ${DB_HOST} -p ${DB_PORT} -d ${DB_NAME} -U ${DB_USER} -f "./create.sql" -f "./load.sql"
gen_model:
	sqlacodegen "postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}" --tables purchase
up:
	docker-compose up -d
build:
	docker-compose build
