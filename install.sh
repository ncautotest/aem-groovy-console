#!/bin/bash

PROJECT_DIR_PARENT="${HOME}/projects/aem6"
mkdir -p ${PROJECT_DIR_PARENT}
PROJECT_NAME="cq-groovy-console"
# take port as 1st command line argument or use 4502 by default
PORT=${1:-4502}

echo PROJECT DIR="${PROJECT_DIR_PARENT}/${PROJECT_NAME}"
echo PORT=${PORT}

if [ ! -d "${PROJECT_DIR_PARENT}/${PROJECT_NAME}" ]; then
	cd "${PROJECT_DIR_PARENT}"
	git clone --depth 1 "https://github.com/Citytechinc/${PROJECT_NAME}.git"
	cd "${PROJECT_NAME}"
else
	cd "${PROJECT_DIR_PARENT}/${PROJECT_NAME}"
	git pull
fi

mvn clean install -P local  -DskipTests -Dmaven.test.skip=true  -Daem.port.author=${PORT}
open http://localhost:${PORT}/etc/groovyconsole.html
