# ssh-keygen
github的密钥生成：

`ssh-keygen -t rsa -C $email`

生成的密钥需要进行特殊的权限控制：

1. .ssh 为**700**权限
2. .ssh/* 为**600**权限
