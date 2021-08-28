---
title: idea设置技巧

author: seven

avatar: https://sevenpic.oss-cn-beijing.aliyuncs.com/img/seven.jpg

authorLink: yjl.cool

authorAbout: 不懂猫，更不懂开发的人

authorDesc: 

categories: 技术

comments: true

date: 2021-08-23 22:20:28

tags: [idea]

keywords: idea

description: idea常用设计技巧

photos: https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.pptjia.com%2Fimage%2F20171027%2F02b26e7ea1989bff63852b6410de5655.jpg&refer=http%3A%2F%2Fimg.pptjia.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632762574&t=fc0d651dbe26568e90a3732fd1ee0da5

---
> 查考设置：https://www.w3cschool.cn/intellij_idea_doc/intellij_idea_doc-lr532e72.html

# 1.idea启动不打开项目

选择File --->Settings ---> Appearance & Behavior

![image-20210607093734355](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210607093734355.png)

# 2.自定义代码提示

> 参考：https://blog.csdn.net/lycz_tpself/article/details/76726813

# 3.idea设置同步

Lgz6!fqTY4XY@#K gamil

file -->![image-20210804105437562](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210804105437562.png)

# 4.idea连接docker

## 1.安装docker插件

docker

![image-20210317104220857](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210317104220857.png)

## 2.开启dockerTCP

```shell
sudo vim /etc/docker/daemon.json
```

添加"hosts": ["tcp://0.0.0.0:2376","unix:///var/run/docker.sock"] 

2376表示tcp的端口

如下：

```json
{
"registry-mirrors": [
    "https://registry.docker-cn.com",
    "http://hub-mirror.c.163.com",
    "https://docker.mirrors.ustc.edu.cn"
],
"hosts": ["tcp://0.0.0.0:2376","unix:///var/run/docker.sock"]
}
```

## 3.重启docker

```
sudo systemctl daemon-reload 
sudo systemctl restart docker
```

## 4.添加docker服务

编写Dockerfile->点击三角形运行->选择Server->添加dockerServer

![image-20210317104458956](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210317104458956.png)

![image-20210317105509183](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210317105509183.png)

**注意：TCP Engine API URL要加tcp://。如：tcp://192.168.0.106:2376**

## 5.配置dockerRun

![image-20210317105730267](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210317105730267.png)

> docker相关参考文档：
>
> https://blog.csdn.net/qq_36414013/article/details/103283775

# 5.idea远程debug

1. 添加Remote JVM DeBug

   ![image-20210122145808189](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210122145808189.png)

   复制命令：-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005

2. 进入服务器，查询服务命令：ps -elf | grep 服务。拿到命令后，复制如：java -jar xxx.jar

3. kill该服务，运行命令：java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005 -jar xxx.jar

4. idea中启动![image-20210122150042071](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210122150042071.png)

