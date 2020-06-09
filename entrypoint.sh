#!/bin/sh -l

cd $GITHUB_WORKSPACE
git clone https://github.com/${GITHUB_REPOSITORY}.git
REPO_NAME=$(echo ${GITHUB_REPOSITORY} | cut -d/ -f2-)
cd ${REPO_NAME}
git reset --hard $GITHUB_SHA
echo $DOCKER_API_KEY | docker login --username $REGISTRY_USERNAME --password-stdin
IMAGE_NAME=${REGISTRY_USERNAME}/${REPO_NAME}:${GITHUB_SHA}
appsody build -t ${IMAGE_NAME} --push
IBMCLOUD_VERSION_CHECK=false
IBMCLOUD_API_KEY=$IBMCLOUD_API_KEY
ibmcloud coligo target --name $PROJECT
ibmcloud coligo application create --name ${REPO_NAME} --image ${IMAGE_NAME}
time=$(date)
echo "::set-output name=time::$time"