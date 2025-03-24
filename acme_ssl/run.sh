#!/bin/bash
## 自动颁发ssl证书

WORK_DIR=`pwd`
cd ${WORK_DIR}

NGINX_CERT_DIR="/etc/nginx/cert"

ACME_DIR="/root/.acme.sh"
DOMAIN=$1

if [[ "X$DOMAIN" == "X" ]];
then
	echo "domain empty"
	exit 1
fi

ACME_CMD="${ACME_DIR}/acme.sh --issue -d ${DOMAIN} --standalone -k ec-256 --force"

SSL_PATH="${ACME_DIR}/${DOMAIN}_ecc"
echo ${SSL_PATH}

if [[ -e ${SSL_PATH} ]];then
	rm -rf ${SSL_PATH}
fi

## 执行命令
bash -c "${ACME_CMD}"
if [[ $? -ne 0 ]];then
	echo "acme failed"
	exit -1
fi

## 复制生成的证书到nginx
cp ${SSL_PATH}/*.key ${NGINX_CERT_DIR}/
cp ${SSL_PATH}/${DOMAIN}.cer ${NGINX_CERT_DIR}/${DOMAIN}_bundle.pem

## 重启nginx
if [[ $? -eq 0 ]];then
	nginx -s reload
fi
