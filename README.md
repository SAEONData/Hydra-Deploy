# Hydra-Deploy

Docker-based deployment of an [ORY Hydra](https://www.ory.sh/docs/hydra/) server.

## Configuration

Create a `.env` file and set the following environment variables:

- **`HYDRA_IMAGE`**: the Hydra Docker image, e.g. `oryd/hydra:v1.2.3`
- **`URLS_SELF_ISSUER`**: URL of the Hydra public API
- **`SECRETS_SYSTEM`**: secret for encrypting the Hydra database; note that key rotation is not supported
- **`POSTGRES_HOST`**: Hydra database hostname / IP address (n/a for dev deployment)
- **`POSTGRES_PASSWORD`**: Hydra database password
- **`ODP_IDENTITY_URL`**: URL of the [ODP Identity](https://github.com/SAEONData/ODP-Identity) service

_N.B. Make sure to generate cryptographically strong secrets for `SECRETS_SYSTEM` and `POSTGRES_PASSWORD`,
and to back these up securely._

## Development Installation

In development mode we deploy the Hydra database in a container.

Run the setup script, which initializes the Hydra database:

    sudo ./setup-dev.sh

Start the Hydra server + DB containers in the background:

    sudo docker-compose -f development.yml up -d

## Staging/Production Installation

In production mode we assume that the Hydra database has been created externally on a
separate server to the Hydra server.

Run the setup script to initialize the Hydra database:

    sudo ./setup-prod.sh

Start the Hydra container in the background:

    sudo docker-compose -f production.yml up -d

## Check Status

    curl --insecure https://localhost:9000/health/ready
