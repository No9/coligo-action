# Container image that runs your code
FROM ubuntu:bionic-20200403

RUN apt-get update
RUN apt-get install -y curl

RUN apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
RUN apt-get update
RUN apt-get install -y docker-ce
ENV IBMCLOUD_VERSION_CHECK=false
RUN curl -L https://storage.googleapis.com/knative-nightly/client/latest/kn-linux-amd64 > kn 
RUN chmod +x kn
RUN cp kn /usr/local/bin
RUN curl -fsSL https://clis.cloud.ibm.com/download/bluemix-cli/1.1.0/linux64 > ibmcloud
RUN chmod +x ibmcloud
RUN mv ibmcloud /usr/local/bin
RUN ibmcloud plugin install container-registry      
RUN ibmcloud plugin install kubernetes-service
RUN ibmcloud plugin install coligo

RUN curl -fsSL https://github.com/appsody/appsody/releases/download/0.6.3/appsody_0.6.3_amd64.deb > appsody.deb
RUN apt-get install -y ./appsody.deb

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
