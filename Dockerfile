FROM python:3.8-alpine3.16 as py3

FROM jenkins/jenkins:latest

USER root

COPY --from=py3 /usr/local/lib /usr/local/lib
COPY --from=py3 /usr/local/bin /usr/local/bin
COPY --from=py3 /usr/local/include /usr/local/include
COPY --from=py3 /usr/local/share /usr/local/share

ARG JENKINS_ADMIN_PASSWORD
ARG JENKINS_ADMIN_ID
ARG JENKINS_HOST
ARG GITHUB_REPO_JOB_DSL
ARG JAVA_OPTS

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
ENV JENKINS_HOME /var/jenkins_home

# install docker-cli and its dependencies
RUN apt update && apt install -y lsb-release \
    software-properties-common \
    apt-transport-https \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] \
    https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt update && apt install -y docker-ce-cli \
    && rm -rf /var/lib/apt/lists/*

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --clean-download-directory --list --view-security-warnings -f /usr/share/jenkins/ref/plugins.txt
