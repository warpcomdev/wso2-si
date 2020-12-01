from openjdk:8

ENV WSO2SI_RELEASE_FULL 4.4.0-RC6
ENV WSO2SI_RELEASE 4.4.0

RUN mkdir -p /opt/golden && \
    cd /opt/golden && \
    wget "https://github.com/wso2/product-sp/releases/download/v${WSO2SI_RELEASE_FULL}/wso2sp-${WSO2SI_RELEASE}.zip"

ENV TF_VERSION 1.1.1
RUN cd "/opt/golden" && \
    wget "https://maven.wso2.org/nexus/content/repositories/public/org/wso2/extension/siddhi/execution/tensorflow/siddhi-execution-tensorflow/${TF_VERSION}/siddhi-execution-tensorflow-${TF_VERSION}.jar"

ENV PG_VERSION 42.2.18
RUN cd "/opt/golden" && \
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
