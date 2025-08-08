#!/bin/bash
set -e

# Remove old server PID if present
rm -f tmp/pids/server.pid

# Wait for DB to be ready
if [ "$RAILS_ENV" = "production" ] || [ "$RAILS_ENV" = "development" ]; then
  echo "Waiting for database at $DB_HOST:$DB_PORT..."
  until pg_isready -h "$DB_HOST" -p "$DB_PORT" > /dev/null 2>&1; do
    sleep 1
  done
fi

# Prepare database
bundle exec rails db:create db:migrate

# Execute CMD from Dockerfile or docker-compose
exec "$@"
