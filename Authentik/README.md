# Authentik Deployment with Docker Compose

This repository provides a Docker Compose setup for deploying [Authentik](https://goauthentik.io/), an open-source identity provider.

## Features
- Deploy Authentik with PostgreSQL and Redis.
- Supports email notifications and custom templates.
- Health checks for PostgreSQL and Redis services.
- Configuration via `.env` file for easy customization.

## Prerequisites
- Docker and Docker Compose installed on your system.
- A valid `.env` file with required environment variables.

## Setup Instructions

### 1. Clone the Repository
Clone this repository to your local machine:

```bash
git clone https://github.com/your-repo/authentik-docker-compose.git
cd authentik-docker-compose
```

### 2. Configure Environment Variables
Create a `.env` file in the project root or update the provided one. Ensure the following variables are configured correctly:

```env
AUTHENTIK_EMAIL__HOST=192.168.100.150
AUTHENTIK_EMAIL__PORT=25
AUTHENTIK_EMAIL__USE_TLS=false
AUTHENTIK_EMAIL__USE_SSL=false
AUTHENTIK_EMAIL__TIMEOUT=10
AUTHENTIK_EMAIL__FROM=authentik@tayyabtahir.net
COMPOSE_PORT_HTTP=10000
COMPOSE_PORT_HTTPS=10443
AUTHENTIK_ERROR_REPORTING__ENABLED=true
PG_PASS=#passwordT#
AUTHENTIK_SECRET_KEY=#key#
```

### 3. Start the Services
Run the following command to start all services:

```bash
docker-compose up -d
```

### 4. Access the Authentik Web Interface
- Open your browser and navigate to `http://<your-server-ip>:10000`.
- To use HTTPS, navigate to `https://<your-server-ip>:10443`.

### 5. Default Credentials
- **Username**: `admin`
- **Password**: `authentik-admin`

Change the default credentials after the first login.

## Configuration

### Email Settings
Ensure the `.env` file includes valid email configuration for notifications:

```env
AUTHENTIK_EMAIL__HOST=<SMTP_SERVER>
AUTHENTIK_EMAIL__PORT=25
AUTHENTIK_EMAIL__USE_TLS=false
AUTHENTIK_EMAIL__USE_SSL=false
AUTHENTIK_EMAIL__FROM=authentik@yourdomain.com
```

### Custom Templates
You can add custom templates by placing them in the `./custom-templates` directory.

### Persistent Storage
Data is stored in the following directories:
- `./database`: PostgreSQL data
- `./redis`: Redis data
- `./media`: Authentik media files
- `./certs`: Certificates

Ensure these directories are backed up regularly.

## Logs
To view service logs, run:

```bash
docker-compose logs -f
```

## Stopping the Services
To stop all running containers, use:

```bash
docker-compose down
```

## Notes
- The PostgreSQL and Redis services include health checks to ensure they are running correctly.
- Authentik requires the `AUTHENTIK_SECRET_KEY` in the `.env` file. Ensure it is securely stored and kept confidential.
- You can adjust the HTTP and HTTPS ports in the `.env` file with `COMPOSE_PORT_HTTP` and `COMPOSE_PORT_HTTPS`.

## Resources
- [Authentik Documentation](https://goauthentik.io/docs)
- [Docker Compose Documentation](https://docs.docker.com/compose/)

