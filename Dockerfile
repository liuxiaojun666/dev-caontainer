FROM ubuntu:20.04

# 接收参数
ARG USER=test
ARG PASSWORD=test
ARG ROOT_PASSWORD=root
ARG RSA_PUBLIC_KEY=""

RUN apt-get -qq update 
# 腾讯云tke中https访问需要该依赖
RUN apt-get -qq install -y --no-install-recommends ca-certificates curl
# 确定docker内时区
RUN apt-get -qq install -y tzdata && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone
# 安装工具
RUN apt-get -qq install -y wget
RUN apt-get -qq install -y git
RUN apt-get -qq install -y vim
RUN apt-get -qq install -y iputils-ping
# 安装ssh
RUN apt-get -qq install -y openssh-server
# 设置root密码
RUN echo "root:${ROOT_PASSWORD}" | chpasswd
# 添加用户，拥有root权限
RUN useradd -m -s /bin/bash ${USER}
RUN echo "${USER}:${PASSWORD}" | chpasswd
RUN echo "${USER} ALL=(ALL) ALL" >> /etc/sudoers
# 重启ssh

# 切换用户
USER ${USER}
WORKDIR /home/${USER}
# 设置ssh
RUN mkdir -p /home/${USER}/.ssh
RUN echo "${RSA_PUBLIC_KEY}" > /home/${USER}/.ssh/authorized_keys
# 安装nvm，修改版本号为最新版本
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
# 切换回root
USER root
# 启动ssh
EXPOSE 22
CMD ["/etc/init.d/ssh", "start" "-D"]

# docker build -t dev-env:10 . --build-arg USER=dev --build-arg PASSWORD=dev --network=host
# docker run -itd --name code-dev -p 12222:22 -v /home/dev/code:/home/dev/code dev-env:10 /etc/init.d/ssh start -D
# ssh -p 12222 dev@localhost
