include .env

SHELL := /bin/bash
MAX_LINE_LENGTH := 119
POETRY_VERSION := $(shell poetry --version 2>/dev/null)

help: ## List all commands
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9 -]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

check-poetry:
	@if [[ "${POETRY_VERSION}" == *"Poetry"* ]] ; \
	then \
		echo "Found ${POETRY_VERSION}, ok." ; \
	else \
		echo 'Please install poetry first, with e.g.:' ; \
		echo 'make install-poetry' ; \
		exit 1 ; \
	fi

install-poetry: ## install or update poetry
	@if [[ "${POETRY_VERSION}" == *"Poetry"* ]] ; \
	then \
		echo 'Update poetry v$(POETRY_VERSION)' ; \
		poetry self update ; \
	else \
		echo 'Install poetry' ; \
		pip3 install -U poertry ; \
	fi

install: check-poetry ## install python-poetry_publish via poetry
	poetry install

generate-config: check-poetry ## generate config from template "homesserver.yaml"
	poetry run python3 -m synapse.app.homeserver \
		--server-name ${SYNAPSE_SERVER_NAME} \
		--config-path homeserver.yaml \
		--generate-config \
		--report-stats=${SYNAPSE_REPORT_STATS}

start-server: check-poetry ## start synapse server
	poetry run python3 -m synapse.app.homeserver \
		--config-path homeserver.yaml