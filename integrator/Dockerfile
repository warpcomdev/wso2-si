# Use jdk 8 for nashorn (javascript) support, deprecated in jdk11
FROM openjdk:8

ENV WSO2SI_RELEASE_FULL 1.1.0-rc3
ENV WSO2SI_RELEASE 1.1.0

RUN mkdir -p /opt/golden && \
    cd /opt/golden && \
    wget "https://github.com/wso2/streaming-integrator-tooling/releases/download/v${WSO2SI_RELEASE_FULL}/wso2si-tooling-${WSO2SI_RELEASE_FULL}.zip" 

ENV TF_VERSION 2.0.1
RUN cd /opt/golden && \
    wget "https://repo1.maven.org/maven2/io/siddhi/extension/execution/tensorflow/siddhi-execution-tensorflow/${TF_VERSION}/siddhi-execution-tensorflow-${TF_VERSION}.jar"

ENV PG_VERSION 42.2.18
RUN cd /opt/golden && \
    wget "https://jdbc.postgresql.org/download/postgresql-${PG_VERSION}.jar"

# Current CDC plugin version requires driver 5.1.
# See https://siddhi-io.github.io/siddhi-io-cdc/
ENV MY_VERSION 5.1.49
RUN cd /tmp && \
    wget "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MY_VERSION}.tar.gz" && \
    tar -xzvf "mysql-connector-java-${MY_VERSION}.tar.gz" && \
    mv "mysql-connector-java-${MY_VERSION}"/*.jar "/opt/golden" && \
    rm -rf "mysql-connector-java-${MY_VERSION}"

VOLUME  "/opt/wso2si"
EXPOSE 9390

WORKDIR "/opt/wso2si"
ADD bootstrap.sh /bootstrap.sh
CMD /bin/sh /bootstrap.sh
