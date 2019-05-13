#!/usr/bin/env bash
#
# Build and Tag Docker Image (Locally)
#
# Example: ./build_image.sh --image=python-dev-env --version=latest \
#     --dockerfile=../environments/python-dev-env/
#

DOCKERFILE="."
IMAGE_NAME=""
IMAGE_VERSION="latest"

# Parse CLI Arguments
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -D|-d|--dockerfile)
        DOCKERFILE="$2"
        shift
        shift
        ;;
        --dockerfile=*)
        DOCKERFILE="${1#*=}"
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

if [ -z "${IMAGE_NAME}" ]
then
  echo "$(date +%c): No Image Name Specified, Exiting"
  exit 1
fi

IMAGE="${IMAGE_NAME}:${IMAGE_VERSION}"

echo "$(date +%c): Building and Tagging ${IMAGE} from Dockerfile ${DOCKERFILE}"
docker build --tag=${IMAGE} ${DOCKERFILE}
