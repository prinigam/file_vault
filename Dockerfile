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

# Make entrypoint script executable
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ARG RAILS_ENV=development
ENV RAILS_ENV=$RAILS_ENV

RUN if [ "$RAILS_ENV" = "production" ]; then bundle exec rake assets:precompile; fi

EXPOSE 3000

ENTRYPOINT ["entrypoint.sh"]

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
