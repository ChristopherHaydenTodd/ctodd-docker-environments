#!/usr/bin/env bash
#
# Run Compose with Correct ENV Settings
#
# Example: ./run_mysql.sh
#

MYSQL_USER=""
MYSQL_PASSWORD=""
MYSQL_ROOT_PASSWORD=""

# Parse CLI Arguments
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        --user=*)
        MYSQL_USER="${1#*=}"
        shift
        ;;
        --pass=*|--password=*)
        MYSQL_PASSWORD="${1#*=}"
        shift
        ;;
        --root=*|--root-password=*)
        MYSQL_ROOT_PASSWORD="${1#*=}"
        shift
        ;;
        *)
        shift
        ;;
    esac
done

if [ -z "${MYSQL_USER}" ]
then
  echo "$(date +%c): No MySQL User Specified (--user=), Exiting"
  exit 1
fi

if [ -z "${MYSQL_PASSWORD}" ]
then
  echo "$(date +%c): No MySQL Password Specified (--password=), Exiting"
  exit 1
fi

if [ -z "${MYSQL_ROOT_PASSWORD}" ]
then
  echo "$(date +%c): No MySQL Root Password Specified (--root-password=), Exiting"
  exit 1
fi

echo "$(date +%c): Standing Up MySQL"
MYSQL_USER=${MYSQL_USER} MYSQL_PASSWORD=${MYSQL_PASSWORD} MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} docker-compose up -d;
