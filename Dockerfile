FROM jenkins/jenkins:lts

USER root

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update && apt-get install -y git-core curl build-essential openssl libssl-dev python python3 nodejs python3-pip zip

# sceptre build tool and aws cli
RUN pip3 install sceptre==2.3.0 awscli==1.18.39

# drop back to the regular jenkins user - good practice
USER jenkins