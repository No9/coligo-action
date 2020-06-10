#!/bin/sh -l

cd $GITHUB_WORKSPACE
git clone https://github.com/${GITHUB_REPOSITORY}.git
REPO_NAME=$(echo ${GITHUB_REPOSITORY} | cut -d/ -f2-)
cd ${REPO_NAME}
git reset --hard $GITHUB_SHA
echo $REGISTRY_API_KEY | docker login $REGISTRY --username $REGISTRY_USERNAME --password-stdin
IMAGE_NAME=${REGISTRY_USERNAME}/${REPO_NAME}:${GITHUB_SHA}
appsody build -t ${IMAGE_NAME} --push

IBMCLOUD_VERSION_CHECK=false
curl -L https://storage.googleapis.com/knative-nightly/client/latest/kn-linux-amd64 > kn 
chmod +x kn
cp kn /usr/local/bin
curl -fsSL https://clis.cloud.ibm.com/download/bluemix-cli/1.1.0/linux64 > ibmcloud.tar.gz
tar xvzf ibmcloud.tar.gz
./Bluemix_CLI/install
ibmcloud plugin install container-registry      
ibmcloud plugin install kubernetes-service
ibmcloud plugin install coligo
ibmcloud plugin show coligo
ibmcloud login --apikey $IBM_CLOUD_API_KEY -r us-south
ibmcloud coligo target --name $PROJECT
ibmcloud coligo application create --name ${REPO_NAME} --image ${IMAGE_NAME}
time=$(date)
echo "::set-output name=time::$time"