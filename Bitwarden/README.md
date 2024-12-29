# Bitwarden Self-Hosting Installation Guide

Bitwarden provides an easy and secure way to self-host your password manager using a shell script. Follow this guide to set up your instance of Bitwarden on a Linux machine.

## Prerequisites

- A user account created specifically for Bitwarden (do **not** install as `root`).
- Access to the `/opt/bitwarden` directory for installation.
- Configured DNS records pointing to your Bitwarden instance.

## Installation Steps

### 1. Download the Installation Script
```bash
curl -Lso bitwarden.sh "https://func.bitwarden.com/api/dl/?app=self-host&platform=linux" && chmod 700 bitwarden.sh
```

### 2. Run the Installer Script
```bash
./bitwarden.sh install
```
This will create a `./bwdata` directory relative to the location of `bitwarden.sh`.

### 3. Complete the Installer Prompts
- **Domain name:** Enter the domain name for your Bitwarden instance.
- **Let's Encrypt SSL Certificate:** Choose `y` to generate a free SSL certificate or `n` to use an existing certificate.
- **Installation ID and Key:** Retrieve these from [Bitwarden](https://bitwarden.com/host) using a valid email address.
- **Region:** Enter `US` or `EU` based on your preference.
- **SSL Certificate Options:**
  - Use an existing certificate (`y`) or generate a self-signed certificate (`y` for testing).
  - If not using an SSL certificate, you must front your instance with an HTTPS proxy.

## Post-Installation Configuration

### 1. Environment Variables
Edit the file `./bwdata/env/global.override.env` and replace the following placeholders:

```bash
...
globalSettings__mail__smtp__host=<SMTP_HOST>
globalSettings__mail__smtp__port=<SMTP_PORT>
globalSettings__mail__smtp__ssl=<true|false>
globalSettings__mail__smtp__username=<SMTP_USERNAME>
globalSettings__mail__smtp__password=<SMTP_PASSWORD>
...
adminSettings__admins=<ADMIN_EMAIL>
...
```

Run the following command to apply your changes:
```bash
./bitwarden.sh restart
```

### 2. Installation File (Optional)
Modify `./bwdata/config.yml` for advanced configurations (e.g., proxy settings). Apply changes with:
```bash
./bitwarden.sh rebuild
```

## Start Bitwarden

To start your Bitwarden instance, run:
```bash
./bitwarden.sh start
```

Verify that all containers are running:
```bash
docker ps
```

## Access Bitwarden
Visit your instance in a web browser using the domain you specified (e.g., `https://bitwarden.example.com`). Register a new account and configure SMTP settings to enable email verification.

## Regular Maintenance

### Backups
Regularly back up your server and configurations.

### Updates
Keep your instance up to date by running:
```bash
./bitwarden.sh update
```

## Additional Commands

| Command         | Description                                                       |
|-----------------|-------------------------------------------------------------------|
| `install`       | Start the installer.                                              |
| `start`         | Start all containers.                                             |
| `restart`       | Restart all containers.                                           |
| `stop`          | Stop all containers.                                              |
| `update`        | Update all containers and the database.                           |
| `uninstall`     | Stop containers, delete data, and remove images.                  |
| `compresslogs`  | Compress server logs into a tarball (optionally for a date range).|
| `renewcert`     | Renew SSL certificates.                                           |
| `rebuild`       | Rebuild installation assets from `config.yml`.                    |
| `help`          | List all available commands.                                      |


