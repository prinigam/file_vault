

# syntax = docker/dockerfile:1
FROM ruby:3.0.6-bullseye

# Install system dependencies
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    nodejs \
    yarn \
    imagemagick \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy app code
COPY . .

# Remove old server PID if present
RUN rm -f tmp/pids/server.pid

# Precompile assets only in production
ARG RAILS_ENV=development
ENV RAILS_ENV=$RAILS_ENV
RUN if [ "$RAILS_ENV" = "production" ]; then bundle exec rake assets:precompile; fi

# Expose app port
EXPOSE 3000

# Start server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
