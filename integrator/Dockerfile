from openjdk:11

ENV WSO2SI_RELEASE_FULL 1.1.0-rc3
ENV WSO2SI_RELEASE 1.1.0

RUN cd /opt && \
    wget "https://github.com/wso2/streaming-integrator-tooling/releases/download/v${WSO2SI_RELEASE_FULL}/wso2si-tooling-${WSO2SI_RELEASE_FULL}.zip" && \
    unzip "wso2si-tooling-${WSO2SI_RELEASE_FULL}.zip" && \
    rm "wso2si-tooling-${WSO2SI_RELEASE_FULL}.zip" && \
    mv "wso2si-tooling-${WSO2SI_RELEASE}" "wso2si-tooling"

ENV TF_VERSION 2.0.1
RUN cd "/opt/wso2si-tooling/lib/" && \
    wget "https://repo1.maven.org/maven2/io/siddhi/extension/execution/tensorflow/siddhi-execution-tensorflow/${TF_VERSION}/siddhi-execution-tensorflow-${TF_VERSION}.jar"

ENV PG_VERSION 42.2.18
RUN cd "/opt/wso2si-tooling/lib/" && \
    wget "https://jdbc.postgresql.org/download/postgresql-${PG_VERSION}.jar"

# Current CDC plugin version requires driver 5.1.
# See https://siddhi-io.github.io/siddhi-io-cdc/
ENV MY_VERSION 5.1.49
RUN cd /tmp && \
    wget "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MY_VERSION}.tar.gz" && \
    tar -xzvf "mysql-connector-java-${MY_VERSION}.tar.gz" && \
    mv "mysql-connector-java-${MY_VERSION}"/*.jar "/opt/wso2si-tooling/lib/" && \
    rm -rf "mysql-connector-java-${MY_VERSION}"

# Volumes for running as non-root.
RUN cd "/opt/wso2si-tooling" && \
    mv wso2 wso2.golden

VOLUME  "/opt/wso2si-tooling/wso2"
EXPOSE 9390

WORKDIR "/opt/wso2si-tooling"
CMD /bin/sh -c 'if ! [ -f wso2/server ]; then cp -pr "wso2.golden"/* "wso2"; fi; exec bin/tooling.sh'
