#!/bin/bash
set -e

# Remove old server PID if present
rm -f tmp/pids/server.pid

# Wait for DB to be ready
if [ "$RAILS_ENV" = "production" ] || [ "$RAILS_ENV" = "development" ]; then
  echo "Waiting for database..."
  while ! nc -z db 5432; do
    sleep 1
  done
fi

# Create and migrate DB
bundle exec rails db:create db:migrate

# Precompile assets only in production
if [ "$RAILS_ENV" = "production" ]; then
  bundle exec rake assets:precompile
fi

# Start server
exec bundle exec rails server -b 0.0.0.0 -p 3000
