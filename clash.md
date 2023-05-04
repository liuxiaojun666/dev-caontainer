## 下载clash

```bash
docker pull dreamacro/clash
```

## 启动clash

```bash
docker run -d --name clash -p 7890:7890 -p 7891:7891 -v /root/clash/config.yaml:/root/.config/clash/config.yaml dreamacro/clash
```

## 把下面的写入配置文件

```bash
alias proxy='export http_proxy="http://127.0.0.1:7890";https_proxy="http://127.0.0.1:7890";echo "proxy on";sh ~/clash/update-config.sh'
alias proxySock5='export http_proxy="socks5://127.0.0.1:7891";https_proxy="socks5://127.0.0.1:7891";echo "proxy on";sh ~/clash/update-config.sh'
alias unproxy='unset http_proxy;unset https_proxy;echo "proxy off"'
```

## 后续使用
  
```bash
# 启动代理
proxy
# 关闭代理
unproxy
```

