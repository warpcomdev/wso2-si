#!/bin/sh

set -eo pipefail
export WSO2_HOME=/home/wso2carbon/wso2si

# WSO2 SI must be running for extension installer to work.
/bin/sh ${WSO2_HOME}/bin/server.sh &>/dev/null &

# Wait until port 9090 is available
while ! nc -z localhost 9090; do
  sleep 1;
done;

# Install extensions
for i in ${WSO_SI_EXTENSIONS}; do
  /bin/sh ${WSO2_HOME}/bin/extension-installer.sh install "$i";
done

# Stop WSO2 SI
/bin/sh ${WSO2_HOME}/bin/server.sh --stop
chmod -R a+rX ${WSO2_HOME}
