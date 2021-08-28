---
title: 04晋级-与springboot的使用

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
[---, title: 04晋级-与springboot的使用.md, , author: seven, , avatar: https://sevenpic.oss-cn-beijing.aliyuncs.com/img/seven.jpg, , authorLink: yjl.cool, , authorAbout: 不懂猫，更不懂开发的人, , authorDesc: , , categories: 技术, , comments: true, , date: 2021-08-23 21:54:40, , tags: , , keywords: , , description: null, , photos: null, , ---, # SpringBoot使用prometheus, , ## 1.添加pom, , ```xml, <dependency>,             <groupId>io.micrometer</groupId>,             <artifactId>micrometer-registry-prometheus</artifactId>,         </dependency>,         <dependency>,             <groupId>org.springframework.boot</groupId>,             <artifactId>spring-boot-starter-actuator</artifactId>,         </dependency>, ```, , ## 2.添加配置, , ```yml, # 开启暴露endpoints配置，例如/actuator/prometheus, management:,   endpoints:,     web:,       exposure:,         include:,           - prometheus, ```, , ## 3.运行并将服务配置到prometheus.yml, , ![image-20210323180757042](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210323180757042.png), , ```yaml, - job_name: 'demo_prometheus',   scrape_interval: 5s,   metrics_path: '/actuator/prometheus',   static_configs:,   - targets: ['127.0.0.1:10081'], ```, , prometheus启动命令添加参数 --web.enable-lifecycle, , 然后热重启：curl -XPOST http://localhost:9090/-/reload , , ## 4.校验查看, , ![image-20210323180827292](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210323180827292.png), , 查询, , ![image-20210323180920804](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210323180920804.png), , ## 常用promsql查询, , - , , ## 结合Grafana, , > [demo](https://gitee.com/GTeam_seven/demo-prometheus-springboot)]