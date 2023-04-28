# vscode ssh remote

用vscode远程开发，可以在本地开发，远程运行，远程调试，远程编译，远程部署，远程测试，远程运行命令等等。

## docker打包一个ubuntu镜像

具体的Dockerfile可以参考[这里]('./Dockerfile')

```bash
# 打包一个ubuntu镜像，可传入用户名和密码
docker build -t dev-env:10 . --build-arg USER=dev --build-arg PASSWORD=dev --network=host
# 运行镜像
docker run -itd --name code-dev -p 2222:22 -v /home/dev/code:/home/dev/code dev-env:10 /etc/init.d/ssh start -D
# 连接进入容器
ssh -p 2222 dev@localhost
```

**需要防火墙开放2222端口**

## 过程中可能会下载失败，使用clssh代理

具体的clssh使用方法可以参考[这里](./clssh.md)

## 连接远程服务器

具体参考[这里](./vscode-ssh-remote.md)
