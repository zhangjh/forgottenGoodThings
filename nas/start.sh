#!/bin/bash
mkdir -vp /app/nextcloud/mysql
mkdir -vp /app/nextcloud/data 
mkdir -vp /app/onlyoffice/logs
mkdir -vp /app/onlyoffice/data

docker-compose up -d

while [ true ];do
	docker ps | grep nextcloud
	if [ $? -eq 0 ];then
		cd plugins
		ls * | xargs -n1 tar -xf
		cp -r `ls -d */` /app/nextcloud/data/apps

		dirs=`ls -d */`
		if [ "$dirs" != "" ];then
			rm -rf ${dirs}
		fi	
		break;
	fi
done


