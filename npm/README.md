# Nginx Proxy Manager with Docker Compose

This repository provides a Docker Compose configuration to set up and run Nginx Proxy Manager, a simple and easy-to-use reverse proxy solution with a web-based GUI.

## Features
- Manage reverse proxies with SSL support.
- User-friendly web interface.
- Automatic SSL certificate provisioning using Let's Encrypt.

## Requirements
- Docker and Docker Compose installed on your system.

## Setup Instructions

### 1. Clone the Repository
Clone this repository to your local machine:

```bash
git clone https://github.com/tayyabtahir143/tayyabtahir.git
cd tayyabtahir/npm
```

### 2. Update Environment Variables
Modify the environment variables in the `docker-compose.yml` file to suit your requirements:

- Replace `#yourpassword` with a secure password for the database.
- Ensure `DB_MYSQL_USER` and `DB_MYSQL_PASSWORD` values match in both `app` and `db` services.

### 3. Set Up Volumes
Ensure the following directories are created for persistent data storage:

- `./data`: Stores application data.
- `./ssl`: Stores SSL certificates.
- `./db`: Stores database files.

```bash
mkdir -p data ssl db
```

### 4. Start the Services
Run the following command to start the containers:

```bash
docker-compose up -d
```

### 5. Access the Web Interface
- Open your browser and go to `http://<your-server-ip>:81`.
- Log in with the default credentials:
  - **Email**: `admin@example.com`
  - **Password**: `changeme`
- Change the default password after the first login.

## Configuration

### Reverse Proxy Setup
1. Log in to the web interface.
2. Add a new proxy host by specifying the domain name, forward hostname/IP, and port.
3. Optionally, enable SSL and select "Force SSL" to redirect HTTP traffic to HTTPS.

### Database
This configuration uses MariaDB-Aria as the database backend. The database credentials are defined in the `docker-compose.yml` file.

## Logs
To view logs for troubleshooting, use the following commands:

```bash
# View logs for the Nginx Proxy Manager
docker logs -f <container_name>

# View logs for the database
docker logs -f <container_name>
```

Replace `<container_name>` with the name of the running container (e.g., `nginx-proxy-manager_app_1`, `nginx-proxy-manager_db_1`).

## Stopping the Services
To stop the containers, run:

```bash
docker-compose down
```

## Notes
- Ensure the ports `80`, `81`, and `443` are open on your server.
- Back up the `./data`, `./ssl`, and `./db` directories regularly to prevent data loss.



---

Enjoy using Nginx Proxy Manager to simplify your reverse proxy management!

