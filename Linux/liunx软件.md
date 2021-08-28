---
title: liunx软件

author: seven

avatar: https://sevenpic.oss-cn-beijing.aliyuncs.com/img/seven.jpg

authorLink: yjl.cool

authorAbout: 不懂猫，更不懂开发的人

authorDesc: 

categories: 技术

comments: true

date: 2021-08-23 22:20:28

tags: [linux,软件]

keywords: Linux常用软件

description: Linux常用软件收集[持续更新]

photos: https://img1.baidu.com/it/u=2109258559,1445079708&fm=26&fmt=auto&gp=0
---

## vim

安装命令

* centos7：

  ```shell
  sudo yum install vim -y
  ```

* ubuntu：

  ```shell
  apt-get install vim
  ```

## docker

安装命令

* centos7：

  ```shell
  sudo yum install docker -y
  ```

* ubuntu：

  ```shell
  apt-get install docker
  ```

## miniserve文件服务

> 文件管理服务

安装命令

* centos7：

* ubuntu：

  ```shell
  sudo curl -L https://github.com/svenstaro/miniserve/releases/download/v0.4.1/miniserve-linux-x86_64 -o /usr/local/bin/miniserve
  sudo chmod +x /usr/local/bin/miniserve
  ```

命令

```bash
miniserve --help
miniserve 0.4.1
Sven-Hendrik Haase <svenstaro@gmail.com>, Boastful Squirrel <boastful.squirrel@gmail.com>
For when you really just want to serve some files over HTTP right now!

USAGE:
    miniserve [FLAGS] [OPTIONS] [--] [PATH]

FLAGS:
    -u, --upload-files       Enable file uploading
    -h, --help               Prints help information
    -P, --no-symlinks        Do not follow symbolic links
    -o, --overwrite-files    Enable overriding existing files during file upload
        --random-route       Generate a random 6-hexdigit route
    -V, --version            Prints version information
    -v, --verbose            Be verbose, includes emitting access logs

OPTIONS:
    -a, --auth <auth>                    Set authentication (username:password)
    -c, --color-scheme <color_scheme>    Default color scheme [default: Squirrel]  [possible values:
                                         Archlinux, Zenburn, Monokai, Squirrel]
    -i, --if <interfaces>...             Interface to listen on
    -p, --port <port>                    Port to use [default: 8080]

ARGS:
    <PATH>    Which path to serve
```

## Nginx

安装命令

* centos7：

  ```shell
  sudo yum install nginx -y
  ```

* ubuntu：

  ```shell
  apt-get install nginx
  ```

## JDK

> 常用版本：java-1.8.0-openjdk.x86_64、java-11-openjdk.x86_64

安装命令

* centos7：

  ```shell
  sudo yum install java-1.8.0-openjdk.x86_64 -y
  ```

* ubuntu：

  ```shell
  apt-get install java-1.8.0-openjdk.x86_64
  ```

## Haproxy服务代理

安装命令

* centos7：

  ```shell
  sudo yum install haproxy -y
  ```

* ubuntu：

  ```bash
  apt-get install haproxy
  ```

配置编辑

```shell
cd /etc/haproxy
vim haproxy.cfg
```

eg:

```tex
#后端mysql配置，访问虚机地址+端口号可以访问后端的mysql，例如：192.168.108.133:7306可以访问140/133的mysql数据库
listen  mysql
        bind 0.0.0.0:3306
        mode tcp
        balance roundrobin
        server mysql1 192.168.108.140:3306
        server mysql2 192.168.108.133:3306
```

