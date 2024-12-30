# Firefox in Docker

This repository provides a Docker Compose configuration to run a Firefox browser instance in a containerized environment.

## Features
- Run Firefox in a secure and isolated container.
- Configure custom user credentials.
- Persistent storage for Firefox configuration and data.
- Easily accessible through mapped ports.

## Requirements
- Docker and Docker Compose installed on your system.

## Setup Instructions

### 1. Clone the Repository
Clone this repository to your local machine:

```bash
git clone https://github.com/tayyabtahir143/tayyabtahir.git
cd tayyabtahir/Firefox
```

### 2. Configure Environment Variables
Edit the `docker-compose.yml` file to set the appropriate environment variables:

- **PUID** and **PGID**: Set these to match your system user and group IDs to ensure proper file permissions.
- **TZ**: Set the timezone for your location (e.g., `Australia/Brisbane`).
- **FIREFOX_CLI**: (Optional) URL that Firefox will open by default.
- **CUSTOM_USER**: Set the custom username for the Firefox instance.
- **PASSWORD**: Set a secure password for the custom user.

### 3. Volumes
The configuration uses the `./data` directory to store persistent data for Firefox. Ensure this directory exists:

```bash
mkdir -p data
```

### 4. Start the Container
Run the following command to start the Firefox container:

```bash
docker-compose up -d
```

### 5. Access Firefox
- Open your browser and navigate to `http://<your-server-ip>:3000` or `http://<your-server-ip>:3001`.

## Configuration

### Shared Memory
The container uses a `shm_size` of `1gb` to ensure Firefox runs smoothly. You can adjust this value if necessary.

### Security Options
The `seccomp:unconfined` option is included to enable additional functionality. This is optional and can be removed if not required.

## Logs
To view logs for the Firefox container, run:

```bash
docker logs -f firefox
```

## Stopping the Container
To stop the running Firefox container, use:

```bash
docker-compose down
```

## Notes
- Firefox data is stored persistently in the `./data` directory. Back up this directory regularly to prevent data loss.
- Ensure the mapped ports (`3000` and `3001`) are open and available on your system.


---

Enjoy using Firefox in a Dockerized environment!

