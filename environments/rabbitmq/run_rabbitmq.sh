#!/usr/bin/env bash
#
# Run Compose with Correct ENV Settings
#
# Example: ./run_rabbitmq.sh
#

RABBITMQ_DEFAULT_USER=""
RABBITMQ_DEFAULT_PASS=""

# Parse CLI Arguments
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        --user=*|--username=*)
        RABBITMQ_DEFAULT_USER="${1#*=}"
        shift
        ;;
        --password=*|--pass=*)
        RABBITMQ_DEFAULT_PASS="${1#*=}"
        shift
        ;;
        *)
        shift
        ;;
    esac
done

if [ -z "${RABBITMQ_DEFAULT_USER}" ]
then
  echo "$(date +%c): No User Name Specified, Exiting"
  exit 1
fi

if [ -z "${RABBITMQ_DEFAULT_PASS}" ]
then
  echo "$(date +%c): No Password Name Specified, Exiting"
  exit 1
fi

echo "$(date +%c): Standing Up RabbitMQ"
RABBITMQ_DEFAULT_USER=${RABBITMQ_DEFAULT_USER} RABBITMQ_DEFAULT_PASS=${RABBITMQ_DEFAULT_PASS} docker-compose up -d;
