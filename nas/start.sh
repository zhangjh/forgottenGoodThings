#!/bin/bash
mkdir -vp /app/nextcloud/mysql
mkdir -vp /app/nextcloud/data 
mkdir -vp /app/onlyoffice/logs
mkdir -vp /app/onlyoffice/data

chown -R www-data:www-data /home/zhangjh
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

## 重启时同步挂载盘
docker exec --user www-data nas_nextcloud_1 php occ files:scan --all
