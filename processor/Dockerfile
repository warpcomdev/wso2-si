from openjdk:8

ENV WSO2SI_RELEASE_FULL 4.4.0-RC6
ENV WSO2SI_RELEASE 4.4.0

RUN cd /opt && \
    wget "https://github.com/wso2/product-sp/releases/download/v${WSO2SI_RELEASE_FULL}/wso2sp-${WSO2SI_RELEASE}.zip" && \
    unzip "wso2sp-${WSO2SI_RELEASE}.zip" && \
    rm "wso2sp-${WSO2SI_RELEASE}.zip" && \
    mv "wso2sp-${WSO2SI_RELEASE}" "wso2si-tooling"

ENV TF_VERSION 1.1.1
RUN cd "/opt/wso2si-tooling/lib" && \
    wget "https://maven.wso2.org/nexus/content/repositories/public/org/wso2/extension/siddhi/execution/tensorflow/siddhi-execution-tensorflow/${TF_VERSION}/siddhi-execution-tensorflow-${TF_VERSION}.jar"

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

# Volumes for running as non-root. Move out of the way everything
# that WSO2 might want to write to.
RUN cd "/opt/wso2si-tooling" && \
    mkdir wso2/rw && \
    for i in .bundles .jars lib tmp cdc; do \
    (mv "$i" wso2/rw || mkdir "wso2/rw/$i") && \
    ln -s "wso2/rw/$i" "$i"; \
    done && \
    chmod -R a+rX . && \
    mv wso2 wso2.golden

VOLUME  "/opt/wso2si-tooling/wso2"
EXPOSE 9390

WORKDIR "/opt/wso2si-tooling"
CMD /bin/sh -c 'if ! [ -f wso2/server ]; then cp -pr "wso2.golden"/* "wso2"; fi; exec bin/editor.sh'
