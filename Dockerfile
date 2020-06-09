# Container image that runs your code
FROM debian:buster-slim

RUN apt-get update
RUN apt-get install -y curl docker
RUN curl -sL https://ibm.biz/idt-installer | bash

RUN curl -L https://storage.googleapis.com/knative-nightly/client/latest/kn-linux-amd64 > kn 
RUN chmod +x kn
RUN cp kn /usr/local/bin

RUN ibmcloud plugin install coligo

RUN apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable"
RUN apt-get update
RUN apt-get install docker-ce


# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# ibmcloud coligo project create --name PROJECT_NAME

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
