# Container image that runs your code
FROM debian:buster-slim

RUN apt-get update
RUN apt-install -y curl
RUN curl -sL https://ibm.biz/idt-installer | bash
ENV IBMCLOUD_VERSION_CHECK=false
ENV IBMCLOUD_API_KEY=api_key_value 

RUN curl -L https://storage.googleapis.com/knative-nightly/client/latest/kn-linux-amd64 > kn 
RUN chmod +x kn
RUN cp kn /usr/local/bin

RUN ibmcloud plugin install coligo

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# ibmcloud coligo project create --name PROJECT_NAME

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
