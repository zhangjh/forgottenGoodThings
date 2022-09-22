#!/bin/bash
WORK_DIR=`pwd`
function getWanIP() {
	# https://www.mebi.me/1766.html
    wanIP=`curl ip.3322.net`
	echo ${wanIP}
}

function installAliyunCli() {
	cd ${WORK_DIR}
	wget https://aliyuncli.alicdn.com/aliyun-cli-linux-3.0.32-amd64.tgz
	tar -xvf aliyun-cli-linux-3.0.32-amd64.tgz
	mv aliyun /usr/local/bin
	aliyun configure
}

## 需要传递一个子域名参数
function getDomainRecord() {
	ret=`aliyun alidns DescribeSubDomainRecords --SubDomain $1`
	ip=`echo $ret | awk -F'"Value":' '{print $2}' | awk -F',' '{print $1}' | awk -F'"' '{print $2}'`
	echo $ip
}

## 需要传递三个参数，1-recordId，2-rr，3-IP新值
function setDomainRecord() {
	## 781585031797680128 qt.zhangjh.me
	## 781584973153913856 nas.zhangjh.me
	aliyun alidns UpdateDomainRecord --RecordId $1 --RR $2 --Type A --Value $3
}

#installAliyunCli

wanIp=`getWanIP`
curIp=`getDomainRecord "nas.zhangjh.me"`
echo "wanIp: ${wanIp}, curIp: ${curIp}"

if [[ "$wanIp" != "$curIp" ]];then
	setDomainRecord 781585031797680128 qt $wanIp
	setDomainRecord 781584973153913856 nas $wanIp
else
	echo "公网IP未变动，暂不需要修改"
fi
