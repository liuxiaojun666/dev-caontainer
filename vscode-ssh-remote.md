### 下载vscode 插件
  
ssh-remote插件

### 配置ssh

生成公钥和私钥
```bash
ssh-keygen -t rsa -C "
```

将公钥复制到服务器上
```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub
```

服务器上配置
```bash
vim /etc/ssh/sshd_config
```
修改配置
```bash
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
```

重启ssh服务
```bash
service sshd restart
```

将本地的公钥复制到服务器上的authorized_keys文件中
```bash
vim ～/.ssh/authorized_keys
```


### 服务器端端vscode 插件安装慢的问题

手动下载vscode插件，然后用vsix安装

## 映射目录写入权限问题

在服务器宿主机上执行
```bash
chown -R 1000:1000 /home/xxx
```

## 服务器端口映射问题

在vscode终端面板旁边的端口功能中添加端口，即可在本地访问服务器的端口
