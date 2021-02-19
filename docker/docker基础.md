win10 安装docker 见官网。



docker进入容器内

```
docker run xxx
docker ps
docker exec -it 1ajifqwqs /bin/bash
```

docker退出容器

```
exit
```

列出所有容器 ID

```
docker ps -aq
```

停止所有容器

```
docker stop $(docker ps -aq)
```

停止单个容器

```
docker stop 要停止的容器名
```

删除所有容器

```
docker rm $(docker ps -aq)
```

删除单个容器

```
docker rm 要删除的容器名
```

删除所有的镜像

```
docker rmi $(docker images -q)
```



docker容器内部更新 apt-get update

1. 切换更新源

   ```
   mv /etc/apt/sources.list /etc/apt/sources.list.bak
   echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib" >> /etc/apt/sources.list
   echo "deb http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list
   echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib" >>/etc/apt/sources.list
   echo "deb-src http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list
   ```

2. 更新

   ```
   apt-get update
   ```

3. 测试安装vim

   ```
    apt-get install vim 
   ```

   



# docker安装nginx【省略】

# docker安装PG

1. 拉取PG

   ```shell
   sudo docker pull postgres
   ```

2. 



