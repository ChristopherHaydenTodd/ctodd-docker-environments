#!/usr/bin/env bash
#
# Run Compose with Correct ENV Settings
#
# Example: ./run_rabbitmq.sh
#

MYSQL_ROOT_PASSWORD=""
MYSQL_PASSWORD=""

# Parse CLI Arguments
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        --root=*|--root-password=*|--root-pass=*)
        MYSQL_ROOT_PASSWORD="${1#*=}"
        shift
        ;;
        --user=*|--user-password=*|--user-pass=*)
        MYSQL_PASSWORD="${1#*=}"
        shift
        ;;
        *)
        shift
        ;;
    esac
done

if [ -z "${MYSQL_ROOT_PASSWORD}" ]
then
  echo "$(date +%c): No MySQL Root Password (--root=x) Specified, Exiting"
  exit 1
fi

if [ -z "${MYSQL_PASSWORD}" ]
then
  echo "$(date +%c): No MySQL User Password (--user=x) Specified, Exiting"
  exit 1
fi

echo "$(date +%c): Standing Up Wordpress and Wordpress DB"
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} MYSQL_PASSWORD=${MYSQL_PASSWORD} WORDPRESS_DB_PASSWORD=${MYSQL_PASSWORD} docker-compose up -d;
