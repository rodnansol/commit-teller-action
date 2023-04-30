#!/bin/bash

VERSION=$1

echo "Downloading CLI app with version: ${VERSION}"

TAG="${VERSION}"
if [ $VERSION == 'early-access' ]; then
    TAG="early-access"
    VERSION="999-SNAPSHOT"
else
    VERSION=${VERSION#?}
fi

wget https://github.com/rodnansol/cli-app-template/releases/download/${TAG}/cli-app-cli-${VERSION}.jar -O cli-app.jar