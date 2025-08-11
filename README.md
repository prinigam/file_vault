# File Vault

>A secure file upload and management platform built with Ruby on Rails.

---

## Features
- **User authentication** (Devise)
- **File uploads** with validations
- **File compression** for large files
- **Dashboard** and sharing features
- **Responsive UI** (Bootstrap)

---

## Prerequisites
- Ruby (>= 3.0)
- Rails (>= 7)
- PostgreSQL
- Node.js & Yarn (for JS dependencies)
- ImageMagick (for ActiveStorage)
- Docker & Docker Compose (optional)

---

## Setup Instructions

### Option 1: Standard (Without Docker)

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

3. **Setup the database**
    ```bash
    rails db:create
    rails db:migrate
    rails db:seed # optional, for demo data
    ```

4. **Setup credentials**
    - Copy `config/master.key.example` to `config/master.key` if needed
    - Edit credentials:
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

This setup uses an entrypoint script that automatically prepares the database when the container starts.

1. **Clone the repository**
    ```bash
    git clone https://github.com/prinigam/file_vault.git
    cd file_vault
    ```

2. **Build and start the containers**
    ```bash
    sudo docker-compose up --build
    ```
    This starts:
    - Rails app (port 3000)
    - PostgreSQL
    - Redis
    Visit [http://localhost:3000](http://localhost:3000).

    **Note:** Database creation and migrations run automatically via `entrypoint.sh`.
    To seed demo data manually:
    ```bash
    sudo docker-compose exec web rails db:seed
    ```

3. **Edit credentials (inside the container)**
    ```bash
    sudo docker-compose exec web EDITOR=vim rails credentials:edit
    ```

---

## Environment Variables
- Check `config/database.yml` for DB settings
- Check `config/storage.yml` for storage settings
- Store sensitive keys in Rails credentials

### Example `.env` for AWS S3 Storage
```

You'll need environment keys to put into env file, for this please ask for credtials
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_REGION=
AWS_BUCKET=
```

## Troubleshooting
- Ensure PostgreSQL and Redis are running
- Verify `.env` and Rails credentials for missing keys
- For file uploads, ensure ImageMagick is installed
- For Docker: If DB changes don’t apply, run:
    ```bash
    sudo docker-compose exec web rails db:migrate
    ```

---

## License
For more details, see the branch commit messages and comments in the source code.


## Live URL
If you're having trouble running server locally, then hit http://15.206.80.147/ to see running liver server
