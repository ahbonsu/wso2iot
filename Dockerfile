FROM debian:stretch

LABEL name="avintis/wso2iot-docker-build" \
      maintainer="a.hauenstein@avintis.com" \
      vendor="Avintis SA" \
      version="3.3.0" \
      release="1" \
      summary="Avintis - WSO2IoT 3.3.0 Container" \
      description="WSO2 IoT Server" \
      run="echo hello"

# set dependant files directory
ARG FILES=./files
# set wso2 product configurations
ARG WSO2_HOME=/wso2
ARG WSO2_SERVER=wso2iot
ARG WSO2_SERVER_VERSION=3.3.0
ARG WSO2_SERVER_DIST=${WSO2_SERVER}-${WSO2_SERVER_VERSION}
ARG WSO2_SERVER_HOME=${WSO2_HOME}/${WSO2_SERVER_DIST}
# set jdk configurations
ARG JDK_DIST=jdk1.8.0*
ARG JAVA_HOME=${WSO2_HOME}/java


# install required packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends --no-install-suggests \
    curl netcat openjdk-8-jdk

# copy jdk, wso2 product distribution to WSO2 home directory and copy mysql connector jar to product distribution
COPY ${FILES}/${JDK_DIST} ${JAVA_HOME}
COPY ${FILES}/${WSO2_SERVER_DIST} ${WSO2_SERVER_HOME}
COPY ${FILES}/mysql-connector-java-*-bin.jar ${WSO2_SERVER_HOME}/lib
COPY ${FILES}/uid_entrypoint ${WSO2_HOME}

# set permissions
RUN chmod -R u+x ${WSO2_SERVER_HOME}/bin ${WSO2_HOME}/uid_entrypoint && \
    chgrp -R 0 ${WSO2_HOME} && \
    chmod -R g=u ${WSO2_HOME} /etc/passwd

# set environment variables
ENV JAVA_HOME=${JAVA_HOME} \
    PATH=$JAVA_HOME/bin:$PATH \
    WSO2_SERVER_HOME=${WSO2_SERVER_HOME} \
    WORKING_DIRECTORY=${WSO2_HOME}

EXPOSE 9443 8280 8243

USER 10001
WORKDIR ${WSO2_HOME}

ENTRYPOINT [ "/bin/bash", "/wso2/uid_entrypoint" ]
