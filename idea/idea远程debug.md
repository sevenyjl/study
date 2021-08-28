---
title: idea远程debug

author: seven

avatar: https://sevenpic.oss-cn-beijing.aliyuncs.com/img/seven.jpg

authorLink: yjl.cool

authorAbout: 不懂猫，更不懂开发的人

authorDesc: 

categories: 技术

comments: true

date: 2021-08-23 22:20:28

tags: 

keywords: 

description: null

photos: null

---
1. 添加Remote JVM DeBug

   ![image-20210122145808189](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210122145808189.png)

   复制命令：-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005

2. 进入服务器，查询服务命令：ps -elf | grep 服务。拿到命令后，复制如：java -jar xxx.jar

3. kill该服务，运行命令：java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005 -jar xxx.jar

4. idea中启动![image-20210122150042071](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210122150042071.png)

