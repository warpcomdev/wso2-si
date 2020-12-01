#!/bin/sh

set -e pipefail
cd /opt/wso2si

# Si el volumen no está inicializado, descomprimo las herramientas.
# Hay tantos directorios y ficheros que el ejecutable modifica, que me he rendido
# intentando sacarlos a un volumen.
if ! [ -d wso2 ]; then
    unzip "/opt/golden/wso2si-tooling-${WSO2SI_RELEASE_FULL}.zip"
    mv    "wso2si-tooling-${WSO2SI_RELEASE}"/* "wso2si-tooling-${WSO2SI_RELEASE}"/.bundles "wso2si-tooling-${WSO2SI_RELEASE}"/.jars .
    rmdir "wso2si-tooling-${WSO2SI_RELEASE}"
    cp    "/opt/golden"/*.jar lib
fi

exec ./bin/tooling.sh
