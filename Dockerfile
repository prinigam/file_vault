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

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ARG RAILS_ENV=development
ENV RAILS_ENV=$RAILS_ENV
EXPOSE 3000
ENTRYPOINT ["/bin/bash", "bin/docker-entrypoint.sh"]
