---
title: nginx常用设置

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
1.nginx反向代理header丢失问题

```conf
http {
	...
    # 开启支持header下划线
    underscores_in_headers on;
    server {
    ...
    }
}
```

2.nginx反向代理下划线问题
