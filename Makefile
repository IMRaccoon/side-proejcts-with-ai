SHELL := /bin/bash
PROJECT := household-budget

.PHONY: up down test fmt codegen

up:
\tcd $(PROJECT)/infra && docker compose up -d

down:
\tcd $(PROJECT)/infra && docker compose down -v

test:
\tcd $(PROJECT)/app && mvn -B verify

fmt:
\tcd $(PROJECT)/app && mvn spotless:apply

codegen:
\tcd $(PROJECT) && ./scripts/codegen.sh || true