#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

test -f "$ROOT/Dockerfile"
test -f "$ROOT/Jenkinsfile"
test -f "$ROOT/docker-compose.yml"
test -f "$ROOT/app/index.html"
test -s "$ROOT/Dockerfile"
test -s "$ROOT/Jenkinsfile"
grep -q '^FROM nginx:stable-alpine$' "$ROOT/Dockerfile"
grep -q "docker build" "$ROOT/Jenkinsfile"
grep -q "docker run" "$ROOT/Jenkinsfile"
grep -q 'services:' "$ROOT/docker-compose.yml"
grep -q 'build: .' "$ROOT/docker-compose.yml"
grep -q '<title>Project 11 - Jenkins CI/CD</title>' "$ROOT/app/index.html"

echo 'Project 11 structural tests passed.'
