# docker安装&卸载

> 环境：centos7
>
> docker版本：

## 安装

> 参考：https://blog.csdn.net/somken/article/details/105863921
>
> 参考：https://blog.csdn.net/lettuce_/article/details/103821200

yum-utils提供了yum-config-manager 效用，并device-mapper-persistent-data和lvm2由需要 devicemapper 存储驱动程序。

```shell
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
```

设置稳定的安装源(存储库)

```shell
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

安装最新docker-ce

```shell
sudo yum -y install docker-ce docker-ce-cli containerd.io
```

启动服务

```shell
 sudo systemctl start docker
```

校验安装

```shell
 sudo  docker version
```

设置国内镜像

```shell
sudo tee /etc/docker/daemon.json <<-'EOF'
{
    "insecure-registries":[
        "10.202.41.81:7001"
    ],
    "registry-mirrors":[
        "https://v16stybc.mirror.aliyuncs.com"
    ]
}
EOF
```

insecure-registries：表示私服

重启：

```shell
sudo systemctl daemon-reload
sudo systemctl restart docker
```

## 卸载

> 参考：https://blog.csdn.net/liujingqiu/article/details/74783780

docker-io、docker-ce、docker-ee的区别

docker-io, docker-engin 是以前早期的版本，版本号是 1.*，默认centos7 安装的是docker-io，最新版是 1.13。

docker-ce 是社区版本，适用于刚刚开始docker 和开发基于docker研发的应用开发者或者小型团队。

docker-ee 是docker的企业版，适用于企业级开发，同样也适用于开发、分发和运行商务级别的应用的IT 团队。

