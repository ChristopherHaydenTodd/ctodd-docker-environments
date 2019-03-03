#!/usr/bin/env bash
#
# Run Compose with Correct ENV Settings
#
# Example: ./run_mysql.sh
#

POSTGRES_USER=""
POSTGRES_PASSWORD=""

# Parse CLI Arguments
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        --user=*)
        POSTGRES_USER="${1#*=}"
        shift
        ;;
        --pass=*|--password=*)
        POSTGRES_PASSWORD="${1#*=}"
        shift
        ;;
        *)
        shift
        ;;
    esac
done

if [ -z "${POSTGRES_USER}" ]
then
  echo "$(date +%c): No Postgres User Specified (--user=), Exiting"
  exit 1
fi

if [ -z "${POSTGRES_PASSWORD}" ]
then
  echo "$(date +%c): No Postgres Password Specified (--password=), Exiting"
  exit 1
fi

echo "$(date +%c): Standing Up Postgres"
POSTGRES_USER=${POSTGRES_USER} POSTGRES_PASSWORD=${POSTGRES_PASSWORD} docker-compose up -d;
