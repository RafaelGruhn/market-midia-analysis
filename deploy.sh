#!/bin/bash
set -x

if [ "$MODE" = "staging" ]; then
  echo "Updating your branch $BRANCH..."
  echo $LAST_COMMIT > django/HASH
  docker-compose -f docker-compose.yml -f docker-compose.staging.yml build --force-rm --parallel nginx django
  docker-compose -f docker-compose.yml -f docker-compose.staging.yml rm -sf nginx django
  docker-compose -f docker-compose.yml -f docker-compose.staging.yml up -d nginx django
  echo "Update branch and build the new deploy."

elif [ "$MODE" = "production" ]; then
  echo "Updating your branch $BRANCH..."
  echo $LAST_COMMIT > django/HASH
  docker-compose -f docker-compose.yml -f docker-compose.staging.yml build --force-rm --parallel nginx django
  docker-compose -f docker-compose.yml -f docker-compose.staging.yml rm -sf nginx django
  docker-compose -f docker-compose.yml -f docker-compose.staging.yml up -d nginx django
  echo "Update branch and build the new deploy."
fi
