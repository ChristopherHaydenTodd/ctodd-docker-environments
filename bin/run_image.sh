#!/usr/bin/env bash
#
# Run Docker Image Locally
#
# ./run_image.sh --image=ctodd_python_dev --version=latest
#

CONTAINER_NAME=""
IMAGE_NAME=""
IMAGE_VERSION="latest"

# Parse CLI Arguments
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -N|-n|-name)
        CONTAINER_NAME="$2"
        shift
        shift
        ;;
        --name=*)
        CONTAINER_NAME="${1#*=}"
        shift
        ;;
        -C|-c|--container)
        CONTAINER_NAME="$2"
        shift
        shift
        ;;
        --container=*)
        CONTAINER_NAME="${1#*=}"
        shift
        ;;
        -I|-i|--image)
        IMAGE_NAME="$2"
        shift
        shift
        ;;
        --image=*)
        IMAGE_NAME="${1#*=}"
        shift
        ;;
        -V|-v|--version)
        IMAGE_VERSION="$2"
        shift
        shift
        ;;
        --version=*)
        IMAGE_VERSION="${1#*=}"
        shift
        ;;
        *)
        shift
        ;;
    esac
done

if [ -z "${IMAGE_NAME}" ]
then
  echo "$(date +%c): No Image Name Specified, Exiting"
  exit 1
fi

IMAGE="${IMAGE_NAME}:${IMAGE_VERSION}"

if [ -z "${CONTAINER_NAME}" ]
then
  CONTAINER_NAME=IMAGE
fi

echo "$(date +%c): Running Container ${CONTAINER_NAME} of image ${IMAGE}"
docker run --rm --detach --name=${CONTAINER_NAME} ${IMAGE}
