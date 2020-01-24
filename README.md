# Hydra-Deploy

Docker-based deployment of an [ORY Hydra](https://www.ory.sh/docs/hydra/) server and database.

## Installation

Create a `.env` file and set the following environment variables:

- **`URLS_SELF_ISSUER`**: URL of the Hydra public API
- **`SECRETS_SYSTEM`**: secret for encrypting the Hydra database; note that key rotation is not supported
- **`POSTGRES_PASSWORD`**: Hydra database password
- **`ODP_IDENTITY_URL`**: URL of the [ODP Identity](https://github.com/SAEONData/ODP-Identity) service

_N.B. Make sure to generate cryptographically strong secrets for `SECRETS_SYSTEM` and `POSTGRES_PASSWORD`,
and to back these up securely._

Run the setup script, which initializes the Hydra database:

    sudo ./setup.sh

Start the Hydra containers in the background:

    sudo docker-compose up -d

Check that Hydra is running:

    curl --insecure https://localhost:9001/health/ready
