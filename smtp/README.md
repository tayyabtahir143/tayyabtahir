# Postfix Mail Relay Docker Container

This repository provides a Dockerfile to set up a lightweight Postfix mail relay server. The container is configured to relay emails to a specific mail server and restrict email sending to designated IP ranges.

## Features
- Lightweight Postfix and Rsyslog setup.
- Configurable relay host and allowed IP ranges.
- Easy-to-use and deploy in Docker.

## Requirements
- Docker installed on your system.
- A valid mail server address to relay emails.

## Configuration

### 1. Update the Dockerfile

#### Replace the Mail Server Address
Replace the placeholder mail server address `tayyabtahir-com.mail.protection.outlook.com` in the Dockerfile with your actual mail server address or IP.

```dockerfile
postconf -e relayhost=<YOUR_MAIL_SERVER_ADDRESS>
```

#### Configure Allowed IP Ranges
Replace the default private IP ranges in the Dockerfile with your specific IP address or range if required. For example, if only one application will send emails through this relay server, use that application's IP instead.

```dockerfile
postconf -e mynetworks="<YOUR_IP_RANGES>"
```

## Building and Running the Container

### 1. Build the Docker Image
Run the following command to build the Docker image:

```bash
docker build -t postfix-mailrelay .
```

### 2. Run the Docker Container
Run the following command to start the container:

```bash
docker run -d --name postfix-relay -p 25:25 postfix-mailrelay
```

The container will expose port `25` to handle mail relay services.

## Logs
The container uses `rsyslog` to capture logs. Logs can be viewed in real-time using:

```bash
docker logs -f postfix-relay
```

## Environment Details
- Base Image: `ubuntu:16.04`
- Services Installed: `postfix`, `rsyslog`

## Example Use Case
This container can be used to:
- Relay emails from internal applications or servers to an external mail server.
- Restrict email sending to specified IP ranges for enhanced security.

## Notes
- Ensure your mail server is reachable from the container and configured to accept the email from this mail relay container.
- Make sure to replace the placeholder values in the Dockerfile with your specific requirements.

