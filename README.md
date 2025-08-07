# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

# File Vault

A secure file upload and management platform built with Ruby on Rails.

## Features
- User authentication (Devise)
- File uploads with validations
- File compression for large files
- Dashboard and sharing features
- Responsive UI (Bootstrap)

## Prerequisites
- Ruby (>= 3.0)
- Rails (>= 7)
- PostgreSQL
- Node.js & Yarn (for JS dependencies)
- ImageMagick (for ActiveStorage)
- Docker (optional)


## Setup Instructions

### Option 1: Standard (No Docker)

1. **Clone the repository**
    ```bash
    git clone https://github.com/prinigam/file_vault.git
    cd file_vault
    ```

2. **Install dependencies**
    ```bash
    bundle install
    yarn install
    ```

3. **Setup database**
    ```bash
    rails db:create
    rails db:migrate
    rails db:seed # optional, for demo data
    ```

4. **Setup credentials**
    - Copy `config/master.key.example` to `config/master.key` if needed
    - Edit credentials with:
      ```bash
      EDITOR=vim rails credentials:edit
      ```

5. **Start the Rails server**
    ```bash
    rails server
    ```
    Visit [http://localhost:3000](http://localhost:3000) in your browser.

---

### Option 2: Docker Setup

1. **Clone the repository**
    ```bash
    git clone https://github.com/prinigam/file_vault.git
    cd file_vault
    ```

2. **Build and start containers**
    ```bash
    sudo docker-compose up --build
    ```
    This will start Rails, PostgreSQL, and Redis in containers. The app will be available at [http://localhost:3000](http://localhost:3000).

3. **Database setup (if needed)**
    If you see database errors, run migrations inside the web container:
    ```bash
    sudo docker-compose exec web rails db:create db:migrate db:seed
    ```

4. **Credentials**
    - If you need to edit credentials, run:
      ```bash
      sudo docker-compose exec web EDITOR=vim rails credentials:edit
      ```

## Environment Variables
- See `config/database.yml` and `config/storage.yml` for DB and storage config
- Use Rails credentials for secrets

## Troubleshooting
- Ensure PostgreSQL and Redis are running
- Check `.env` and credentials for missing keys
- For file uploads, ensure ImageMagick is installed

## License

For more details, see the branch commit messages and documentation/comments in each module.
