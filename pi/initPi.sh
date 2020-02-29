#!/bin/bash
## Raspiberry init shell
## Usage: sudo sh -x initPi.sh

function Usage(){
    echo "sudo sh -x $0"
    echo " -pbsvfSnmriIatAh"
    echo " -p update passwd"
    echo " -b modify sh alias from dash to bash"
    echo " -s modify apt sources"
    echo " -v install vnc"
    echo " -f install ftp"
    echo " -S install samba"
    echo " -n install node"
    echo " -m mount usb disk"
    echo " -r set vimrc"
    echo " -i set auto startup"
    echo " -I install chinese input method"
    echo " -a set alias"
    echo " -t install transmission"
    echo " -A same as bsvfSnmria"
    echo " -h print this help message"
    exit 1
}

function checkSu(){
    touch /root/test
    if [ $? -ne 0 ];then
        echo "Must run as root or sudo!!"
        exit
    fi
    rm /root/test
}

function updatePasswd(){
    #0. 更新密码
    if [ "$1" != "" ];then
        passwd pi
        if [ $? -eq 0 ];then
            su pi
        else
            exit
        fi
    fi
}


function updateBash(){
    #0.1 修改sh软链为bash
    ls -l /bin/sh | grep -q dash
    if [ $? -eq 0 ];then
      rm /bin/sh
      ln -s /bin/bash /bin/sh
    fi
}

function updateSource(){
    #1. 更新源
    cat /etc/apt/sources.list | grep -q "aliyun"
    if [ $? -ne 0 ];then
        cp /etc/apt/sources.list /etc/apt/sources.list.bak
        version=`cat /etc/apt/sources.list | awk '{print $3}' | head -1`
        echo "deb http://mirrors.aliyun.com/raspbian/raspbian/ ${version} main contrib non-free" > /etc/apt/sources.list
        echo "deb-src http://mirrors.aliyun.com/raspbian/raspbian/ ${version} main contrib non-free" >> /etc/apt/sources.list
        apt-get update
        apt-get upgrade
    fi
}

function installInputMethod(){
    #12. Install chinese input method
    apt-get install ttf-wqy-zenhei
    apt-get install scim-pinyin
}

function installVnc(){
    #2. 安装VNC
    version=`which tightvncserver`
    if [ "X${version}" == "X" ];then
        apt-get install tightvncserver
        vncpasswd
        tightvncserver -geometry 1024x768 :1
    fi
}

function installFtp(){
    #3. 安装ftp
    version=`which vsftpd`
    if [ "X${version}" == "X" ];then
        apt-get install vsftpd
        cp ./initConfig/vsftpd.conf /etc/
        service vsftpd start
    fi
}

function installSamba(){
    #4. 安装samba
    version=`which samba`
    if [ "X${version}" == "X" ];then
        apt-get install samba
        cp ./initConfig/smb.conf /etc/samba
        /etc/init.d/smbd restart
        smbpasswd -a pi
    fi
}

function mountDisk(){
    #5. 挂载硬盘
    disk=`fdisk -l | grep "/dev/sda[0-9]" | awk '{print $1}'`
    if [ "X${disk}" != "X" ];then
        if [ ! -e /mnt/share ];then
            mkdir -p /mnt/share
            chown pi:pi /mnt/share
        fi
        df -h | grep -q "/mnt/share"
        if [ $? -ne 0 ];then
            version=`which ntfs-3g`
            if [ "X${version}" == "X" ];then
                apt-get install ntfs-3g
            fi
            mount ${disk} /mnt/share
        fi
        #8. 自动挂载
        cat /etc/fstab | grep -q "${disk}"
        if [ $? -ne 0 ];then
            echo "/dev/sda1 /mnt/share/ ntfs-3g slient,umask=0,locale=zh_CN.utf8 0 0" >> /etc/fstab
        fi
    fi
}

function setVimrc(){
    #6. 设置vimrc
    apt-get install vim
    cp ./initConfig/vimrc.local /etc/vim/
}

function updateStartup(){
    #7. 设置开机启动
    cp ./initConfig/rc.local /etc/
}

function setAlias(){
    #9. 设置alias
    echo "alias ll='ls -l'" > /home/pi/.bash_aliases
    echo "alias la='ls -a'" >> /home/pi/.bash_aliases
    echo "alias vi='vim'"   >> /home/pi/.bash_aliases
}

function installNode(){
    #10. 安装node
    if [ ! -e ~/.zshrc ];then
        apt-get install zsh
        if [ $? -ne 0 ];then
            exit 1;
        fi
        curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh && sh install.sh
    fi
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    which node
    if [ $? -ne 0 ];then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
    fi
    #if [ ! -e /home/pi/node ];then
        #tar -xvf ./initConfig/node.tgz -C /home/pi/
        #if [ -e /usr/bin/node ];then
        #    cp /usr/bin/node /usr/bin/node.bak
        #fi
        #if [ -e /usr/bin/node ];then
        #    rm /usr/bin/node
        #fi
        #if [ -e /usr/bin/npm ];then
        #    rm /usr/bin/npm
        #fi
        #ln -s /home/pi/node/bin/node /usr/bin/
        #ln -s /home/pi/node/lib/node_modules/npm/bin/npm-cli.js /usr/bin/npm
    #fi
}

function installTransMission() {
    apt-get install transmission transmission-daemon
    cp ./initConfig/transmission.json /etc/transmission-daemon/setting.json
}

#11. 设置无线
#cp ./initConfig/wpa.conf /etc
#cp ./initConfig/interfaces /etc/network/

function all(){
    checkSu
    updateBash
    updateSource
    installVnc
    installFtp
    installSamba
    installNode
    mountDisk
    setVimrc
    updateStartup
    installInputMethod
    setAlias
}

checkSu
while getopts "pbsvfSnmriIatAh" opt 
do
    case ${opt} in
      p) updatePasswd;;
      b) updateBash;;
      s) updateSource;;
      v) installVnc;;
      f) installFtp;;
      S) installSamba;;
      n) installNode;;
      m) mountDisk;;
      r) setVimrc;;
      i) updateStartup;;
      I) installInputMethod;;
      a) setAlias;;
      t) installTransMission;;
      A) all;;
      h) Usage;;
    esac
done
