#!/usr/bin/env bash
#
# Run Compose with Correct ENV Settings
#
# Example: ./run_minio.sh
#

MINIO_ACCESS_KEY=""
MINIO_SECRET_KEY=""

# Parse CLI Arguments
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        --access=*|--access-key=*|--user=*|--username=*)
        MINIO_ACCESS_KEY="${1#*=}"
        shift
        ;;
        --secret=*|--secret-key=*|--password=*|--pass=*)
        MINIO_SECRET_KEY="${1#*=}"
        shift
        ;;
        *)
        shift
        ;;
    esac
done

if [ -z "${MINIO_ACCESS_KEY}" ]
then
  echo "$(date +%c): No Access Key Specified (--access-key=), Exiting"
  exit 1
elif [ ${#MINIO_ACCESS_KEY} -lt 5 ]
then
  echo "$(date +%c): Access Key Needs to Be 5 Characters or More, Exiting"
  exit 1
fi

if [ -z "${MINIO_SECRET_KEY}" ]
then
  echo "$(date +%c): No Password Name Specified (--secret-key=), Exiting"
  exit 1
elif [ ${#MINIO_SECRET_KEY} -lt 8 ]
then
  echo "$(date +%c): Secret Key Needs to Be 8 Characters or More, Exiting"
  exit 1
fi

echo "$(date +%c): Standing Up Minio"
MINIO_ACCESS_KEY=${MINIO_ACCESS_KEY} MINIO_SECRET_KEY=${MINIO_SECRET_KEY} docker-compose up -d;
