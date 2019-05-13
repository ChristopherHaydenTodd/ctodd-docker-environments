#!/usr/bin/env bash
#
# Push Docker Image To Repository
#

REPOSITORY=""
IMAGE_NAME=""
IMAGE_VERSION="latest"

# Parse CLI Arguments
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -R|-r|--repo)
        REPOSITORY="$2"
        shift
        shift
        ;;
        --repo=*)
        REPOSITORY="${1#*=}"
        shift
        ;;
        -N|-n|--name)
        IMAGE_NAME="$2"
        shift
        shift
        ;;
        --name=*)
        IMAGE_NAME="${1#*=}"
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

if [ -z "${REPOSITORY}" ]
then
  echo "$(date +%c): No Repository Specified, Exiting"
  exit 1
fi

if [ -z "${IMAGE_NAME}" ]
then
  echo "$(date +%c): No Image Name Specified, Exiting"
  exit 1
fi

IMAGE="${IMAGE_NAME}:${IMAGE_VERSION}"

echo "$(date +%c): Pushing ${IMAGE} to ${REPOSITORY}"
docker tag ${IMAGE} ${REPOSITORY}/${IMAGE}
docker push ${REPOSITORY}/${IMAGE}
