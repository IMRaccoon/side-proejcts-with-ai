#!/usr/bin/env bash
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
root="$(cd "$here/.." && pwd)"

# OpenAPI
openapi-generator generate -c "$root/codegen/openapi-config.json"

# jOOQ (스키마 준비 후 실행)
mvn -f "$root/app/pom.xml" -DskipTests=true -Pjooq-codegen generate-sources