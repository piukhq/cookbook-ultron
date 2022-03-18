# cookbook-ultron

Deploys ClickHouse and prepares server for an AirByte deployment (kicked off manually by DevOps, see below)

## Clickhouse

Deploys ClickHouse using config file found in `./templates/config`

## AirByte

Due to AirByte not supporting a sane deployment method, docker-compose is required for deployment, due to time constraints this will remain a manual deployment step but be well documented in this `README.md` file.

### Installation Steps

Following the installation of ClickHouse, Docker and `docker-compose` will be installed.

AirBytes [Git Repo](https://github.com/airbytehq/airbyte) will be cloned to `/opt/airbyte` and kept up to date on each Chef Run, this is a reletively expensive operation but the documentation suggests this is the recommended method.

The Application should be launched, manually, using `docker-compose up -d` from the cloned directory. This will need to be tested to confirm it survives server restarts. 

---
**NOTE**

Monitoring of AirByte will be critical to the success of this application. We need to figure out a good method for determining application availability.

Due to DockerHub limits, rate limiting COULD occur, hopefully not, but be mindful. If it does, you'll just have to wait a few hours and retry.

---
