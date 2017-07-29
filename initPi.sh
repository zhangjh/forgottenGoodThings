#!/bin/bash
## Raspiberry init shell
## Usage: sudo sh -x initPi.sh

touch /root/test
if [ $? -ne 0 ];then
    echo "Must run as root or sudo!!"
    exit
fi
rm /root/test

#0. 更新密码
if [ "$1" != "" ];then
    passwd pi
    if [ $? -eq 0 ];then
        su pi
    else
        exit
    fi
fi

#0.1 修改sh软链为bash
ls -l /bin/sh | grep -q dash
if [ $? -eq 0 ];then
  rm /bin/sh
  ln -s /bin/bash /bin/sh
fi

#1. 更新源
cat /etc/apt/sources.list | grep -q "aliyun"
if [ $? -ne 0 ];then
    cp /etc/apt/sources.list /etc/apt/sources.list.bak
    echo "deb http://mirrors.aliyun.com/raspbian/raspbian/ jessie main contrib non-free" > /etc/apt/sources.list
    echo "deb-src http://mirrors.aliyun.com/raspbian/raspbian/ jessie main contrib non-free" >> /etc/apt/sources.list
    apt-get update
    apt-get upgrade
fi

#2. 安装VNC
version=`which tightvncserver`
if [ "X${version}" == "X" ];then
    apt-get install tightvncserver
    vncpasswd
    tightvncserver -geometry 1024x768 :1
fi

#3. 安装ftp
version=`which vsftpd`
if [ "X${version}" == "X" ];then
    apt-get install vsftpd
    cp /home/pi/initConfig/vsftpd.conf /etc/
    service vsftpd start
fi

#4. 安装samba
version=`which samba`
if [ "X${version}" == "X" ];then
    apt-get install samba
    cp /home/pi/initConfig/smb.conf /etc/samba
fi

#5. 挂载硬盘
fdisk -l | grep -q "/dev/sda"
if [ $? -eq 0 ];then
    if [ ! -e /mnt/share ];then
        mkdir -p /mnt/share
    fi
    df -h | grep -q "/mnt/share"
    if [ $? -ne 0 ];then
        mount /dev/sda1 /mnt/share
    fi
    #8. 自动挂载
    echo "/dev/sda1 /mnt/share/ ntfs-3g slient,umask=0,locale=zh_CN.utf8 0 0" >> /etc/fstab
fi

#6. 设置vimrc
cp /home/pi/initConfig/vimrc.local /etc/vim/

#7. 设置开机启动
cp /home/pi/initConfig/rc.local /etc/

#9. 设置alias
echo "alias ll='ls -l'" > /home/pi/.bash_aliases
echo "alias la='ls -a'" >> /home/pi/.bash_aliases
echo "alias vi='vim'"   >> /home/pi/.bash_aliases

#10. 安装node
if [ ! -e /home/pi/node ];then
    tar -xvf /home/pi/initConfig/node.tgz -C /home/pi/
    if [ -e /usr/bin/node ];then
        cp /usr/bin/node /usr/bin/node.bak
    fi
    if [ -e /usr/bin/node ];then
        rm /usr/bin/node
    fi
    if [ -e /usr/bin/npm ];then
        rm /usr/bin/npm
    fi
    ln -s /home/pi/node/bin/node /usr/bin/
    ln -s /home/pi/node/lib/node_modules/npm/bin/npm-cli.js /usr/bin/npm
fi

#11. 设置无线
#cp /home/pi/initConfig/wpa.conf /etc
#cp /home/pi/initConfig/interfaces /etc/network/

