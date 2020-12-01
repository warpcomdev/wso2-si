from openjdk:11

ENV WSO2SI_RELEASE_FULL 4.4.0-rc6
ENV WSO2SI_RELEASE 4.4.0

RUN cd /opt && \
    wget "https://github.com/wso2/product-sp/releases/download/v${WSO2SI_RELEASE_FULL}/wso2sp-${WSO2SI_RELEASE}.zip" && \
    unzip "wso2si-tooling-${WSO2SI_RELEASE_FULL}.zip" && \
    rm "wso2si-tooling-${WSO2SI_RELEASE_FULL}.zip" && \
    mv "wso2si-tooling-${WSO2SI_RELEASE}" "wso2si-tooling"

ENV TF_VERSION 2.0.0
RUN cd "/opt/wso2si-tooling/lib" && \
    wget "https://repo1.maven.org/maven2/org/wso2/extension/siddhi/execution/tensorflow/siddhi-execution-tensorflow/${TF_VERSION}/siddhi-execution-tensorflow-${TF_VERSION}.jar"

ENV PG_VERSION 42.2.18
RUN cd "/opt/wso2si-tooling/lib" && \
    wget "https://jdbc.postgresql.org/download/postgresql-${PG_VERSION}.jar"

# Current CDC plugin version requires driver 5.1.
# See https://siddhi-io.github.io/siddhi-io-cdc/
ENV MY_VERSION 5.1.49
RUN cd /tmp && \
    wget "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MY_VERSION}.tar.gz" && \
    tar -xzvf "mysql-connector-java-${MY_VERSION}.tar.gz" && \
    mv "mysql-connector-java-${MY_VERSION}"/*.jar "/opt/wso2si-tooling/lib" && \
    rm -rf "mysql-connector-java-${MY_VERSION}"

# Los enlaces de MSSQL funcionan regular, he tenido
# que incluir el driver JDBC en el repo.
COPY mssql-jdbc-8.4.1.jre8.jar "/opt/wso2si-tooling/lib"

# Volumes for running as non-root.
RUN cd "/opt/wso2si-tooling" && \
    mv wso2 wso2.golden

VOLUME  "/opt/wso2si-tooling/wso2"
EXPOSE 9390

# Replace references to runtime.pid
RUN for i in `find "/opt/wso2si-tooling-${WSO2SI_RELEASE}" -name "*.sh"`; do \
    sed -i 's/\$RUNTIME_HOME.runtime.pid/\/tmp\/runtime.pid/g' "$i"; \
    done

EXPOSE 9390

WORKDIR "/opt/wso2si-tooling"
CMD /bin/sh -c 'cp -pr "wso2.golden"/* "wso2"; exec bin/editor.sh'
