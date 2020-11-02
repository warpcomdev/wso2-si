FROM wso2/streaming-integrator:1.1.0

# Esta lista de extensiones se obtiene de la ejecución de
# extension-installer.sh list --all | grep NOT_INSTALLED
# extension-installer.sh list --all | grep PARTIAL
# He eliminado:
# - l7 porque da error de install
# - jms y prometheus porque tienen dependencias que dan problemas.
# - rdms_oracle y cdc-oracle por lo mismo.
# - kafka porque no hay en la plataforma.
ENV WSO_SI_EXTENSIONS "cdc-mongodb cdc-mssql cdc-mysql cdc-postgresql mongodb rdbms-mssql rdbms-mysql rdbms-postgresql azuredatalake elasticsearch cassandra google-cloud-storage googlepubsub hbase ibmmq mqtt nats rabbitmq redis s3 snmp sqs"

ADD install-extensions.sh /opt/install-extensions.sh
RUN /bin/sh /opt/install-extensions.sh

# Override default configuration
ADD deployment.yaml /home/wso2carbon/wso2si/conf/server/deployment.yaml
