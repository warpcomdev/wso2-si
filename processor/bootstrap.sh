#!/bin/sh

set -e pipefail
cd /opt/wso2si

# Si el volumen no está inicializado, descomprimo las herramientas.
# Hay tantos directorios y ficheros que el ejecutable modifica, que me he rendido
# intentando sacarlos a un volumen.
if ! [ -d wso2 ]; then
    unzip "/opt/golden/wso2sp-${WSO2SI_RELEASE}.zip"
    mv    "wso2sp-${WSO2SI_RELEASE}"/* .
    rmdir "wso2sp-${WSO2SI_RELEASE}"
    cp    "/opt/golden"/*.jar lib
fi

exec ./bin/editor.sh
