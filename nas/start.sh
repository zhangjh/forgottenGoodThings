#!/bin/bash
mkdir -vp /app/nextcloud/{mysql,data} /app/onlyoffice/{logs,data}
cp -r onlyoffice /app/nextcloud/data/apps

docker-compose up -d
