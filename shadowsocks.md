
#### shadowsocks linux
1. 安装
apt-get install python-pip
pip install shadowsocks

2. 编配文件
```
{
    "server":"xx.xx.xx.xx",
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
`sslocal -c /etc/shadowsocks.json -d start`
加上`-d`参数是后台启动

4. 自动启动
修改`/etc/rc.local`,将以上命令加入其中。

5. 调用方式
浏览器代理配置切换
