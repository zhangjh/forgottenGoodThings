
#### shadowsocks linux
1. 安装
```
apt-get install python-pip
pip install shadowsocks

================最新脚本一键安装============
wget --no-check-certificate -O shadowsocks.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh
chmod +x shadowsocks.sh
./shadowsocks.sh 2>&1 | tee shadowsocks.log
```

2. 编配文件
```
vi /etc/shadowsocks.json
{
    "server":"0.0.0.0",         //此处需要设置为0.0.0.0，否则可能会报"socket.error: [Errno 99] Cannot assign requested address"
    "server_port":xxxx,
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":"xxxxxxxx",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": true,
    "workers": 1
}
```

3. 启动
`ssserver -c /etc/shadowsocks.json -d start`
加上`-d`参数是后台启动

4. 自动启动
修改`/etc/rc.local`,将以上命令加入其中。

5. 调用方式
浏览器代理配置切换
