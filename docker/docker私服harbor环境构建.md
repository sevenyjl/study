# Harbor环境搭建

> 官网：https://harbor.com/
>
> github：https://github.com/goharbor/harbor

## 1.下载

https://github.com/goharbor/harbor/releases

> 此次版本为：v2.2.0

## 2.部署

前置条件

```shell
sudo yum install docker -y
sudo yum install docker-compose -y
```

解压

```shell
tar -zxvf harbor-offline-installer-v2.2.0.tgz 
```

harbor
├── common.sh
├── docker-compose.yml
├── harbor.v2.2.0.tar.gz
├── harbor.yml.tmpl
├── install.sh
├── LICENSE
└── prepare

进入目录

```shell
cd harbor
# 复制配置文件
cp harbor.yml.tmpl harbor.yml
# 编辑配置文件
vim harbor.yml
```

> 更多配置信息见官网说明

```yaml
# The IP address or hostname to access admin UI and registry service.
# DO NOT use localhost or 127.0.0.1, because Harbor needs to be accessed by external clients.
hostname: 你的ip
http:
  # port for http, default is 80. If https enabled, this port will redirect to https port
  port: 7001

# https related config 不用https请注释掉否则会报错
#https:
  # https port for harbor, default is 443
#  port: 443
  # The path of cert and key files for nginx
#  certificate: /your/certificate/path
#  private_key: /your/private/key/path

```

运行脚本

```shell
./prepare 
sh install.sh
```

## 3.验证

访问：ip:port/harbor

默认用户：admin/Harbor123

![image-20210325102350258](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210325102350258.png)

## 4.配置docker上传

1.修改docker的daemon.json 

```shell
 sudo vim /etc/docker/daemon.json 
```

修改如下：

```json
{
	"insecure-registries": [
    	"ip:port(或者域名)"
  	]
}
```

重启docker

```shell
sudo systemctl restart docker
```

2.制作镜像

私服地址如：ip:7001

```shell
sudo docker tag 源镜像 私服地址/library/image:0.0.1
```

3.上传镜像

```shell
#登录私服
sudo docker login -u uploader -p Uploader123 私服地址
#Login Succeeded
sudo docker push 私服地址/library/hello-world
#The push refers to a repository [xx.xx.xx.xx:7001/library/hello-world]
#f22b99068db9: Layer already exists 
#latest: digest: sha256:1b26826f602946860c279fce658f31050cff2c596583af237d971f4629b57792 size: 525
```

4.验证

![image-20210325110547861](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210325110547861.png)

5.从私服中获取镜像

> 执行步骤4-1修改docker的daemon.json 

![image-20210325110742873](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210325110742873.png)

```shell
sudo docker pull 私服地址/library/hello-world:latest
```

## 5.其他命令

1.停止/启动

在harbor目录下进行(有docker-compose.yml)

```shell
#查看状态
docker-compose ps
#停止，强烈建议docker重启前，执行这个命令防止僵尸容器产生.
docker-compose stop
#启动
docker-compose start
```

![image-20210325140037307](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210325140037307.png)

## 错误收集

- 开启了https当没有相关配置

  ```log
  [Step 4]: preparing harbor configs ...
  prepare base dir is set to /root/harbor
  ERROR:root:Error: The protocol is https but attribute ssl_cert is not set
  ```

- 重启docker后，harbor服务挂了

  > 2021年3月25日 11:15:49：可能是未先执行`docker-compose stop`对harbor进行停止，直接重启docker导致镜像找不到了
  >

  强制卸载harbor相关镜像（不用担心数据，数据是做了持久化存储）

  ```shell
  # 这一步是在harbor目录下执行
  docker-compose stop
  docker rm -f $(docker ps | grep goharbor | awk '{print $1}')
  docker rmi $(docker images | grep goharbor | awk '{print $3}')
  ```

  **如果还强制停不了**

  ```shell
  # docker的containers目录下，取消镜像挂载(todo 筛选取消/编写脚本)
  umount ./*/mounts/shm
  # 删除容器
  rm -rf ./*
  # 重启dokcer
  systemctl restart docker
  ```

- 

  

