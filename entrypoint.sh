#!/bin/sh -l

cd $GITHUB_WORKSPACE
git clone https://github.com/${GITHUB_REPOSITORY}.git
REPO_NAME=$(echo ${GITHUB_REPOSITORY} | cut -d/ -f2-)
cd ${REPO_NAME}
git reset --hard $GITHUB_SHA
DOCKER_ID=$3
echo $4 | docker login --username $DOCKER_ID --password-stdin
IMAGE_NAME=${DOCKER_ID}/${REPO_NAME}:${GITHUB_SHA}
appsody build -t ${IMAGE_NAME} --push
IBMCLOUD_VERSION_CHECK=false
IBMCLOUD_API_KEY=$2
ibmcloud coligo target --name $1
ibmcloud coligo application create --name ${REPO_NAME} --image ${IMAGE_NAME}
time=$(date)
echo "::set-output name=time::$time"