# 1.安装docker插件

docker

![image-20210317104220857](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210317104220857.png)

# 2.开启dockerTCP

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

# 3.重启docker

```
sudo systemctl daemon-reload 
sudo systemctl restart docker
```

# 4.添加docker服务

编写Dockerfile->点击三角形运行->选择Server->添加dockerServer

![image-20210317104458956](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210317104458956.png)

![image-20210317105509183](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210317105509183.png)

**注意：TCP Engine API URL要加tcp://。如：tcp://192.168.0.106:2376**

# 5.配置dockerRun

![image-20210317105730267](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210317105730267.png)

> docker相关参考文档：
>
> https://blog.csdn.net/qq_36414013/article/details/103283775