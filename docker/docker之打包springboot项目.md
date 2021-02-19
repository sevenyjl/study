# Docker打包SpringBoot项目

## 1.快速入门

> 参考：https://www.cnblogs.com/zmsn/p/11697575.html

1. 创建springboot项目

2. 创建Dockerfile文件如：![image-20210219161916423](docker之打包springboot项目图片/image-20210219161916423.png)

3. 编辑DockerFile

   ```dockerfile
   # FROM 设置基础镜像
   FROM openjdk:11
   # 设置镜像作者
   MAINTAINER seven
   # VOLUME 设置容器的挂载卷
   VOLUME /tmp
   # 编译时复制文件到镜像中
   ADD demo-docker-0.0.1-SNAPSHOT.jar test.jar
   # RUN 编译镜像时运行的脚本
   RUN bash -c 'touch /test.jar'
   # 设置容器的入口
   ENTRYPOINT ["java","-jar","/test.jar"]
   ```

   ![908364-20181030203718699-1692062658](docker之打包springboot项目图片/908364-20181030203718699-1692062658.png)

4. 上传jar和DockerFile到服务器![image-20210219162132139](docker之打包springboot项目图片/image-20210219162132139.png)

5. 制作docker镜像：

   ```shell
    sudo docker build -t demo-docker:v0.0.1 .
   ```

6. 查看生成镜像：docker images![image-20210219162414012](docker之打包springboot项目图片/image-20210219162414012.png)

7. 运行镜像：

   ```shell
   sudo docker run -d -p 8111:8080 --name test-docker demo-docker:v0.0.1
   ```

   ![image-20210219162612201](docker之打包springboot项目图片/image-20210219162612201.png)

## 2.Idea快速打包docker

1. 下载idea插件![image-20210219173816587](docker之打包springboot项目图片/image-20210219173816587.png)

2. 修改docker远程配置（如果本地有win本地有docker可以用本地）![image-20210219173934787](docker之打包springboot项目图片/image-20210219173934787.png)

   **注意：**此处需要docker开启TCP

   - sudo vim /etc/docker/daemon.json 

   - 加入："hosts": ["tcp://0.0.0.0:2376","unix:///var/run/docker.sock"]

     ```json
     {
     "registry-mirrors": [
         "https://registry.docker-cn.com",
         "http://hub-mirror.c.163.com",
         "https://docker.mirrors.ustc.edu.cn"
     ],
     "hosts": ["tcp://0.0.0.0:2376","unix:///var/run/docker.sock"],
     "graph": "/data1/docker"
     }
     ```

   - 重启

     ```shell
     sudo systemctl daemon-reload 
     sudo systemctl restart docker
     ```

   > 参考：https://www.imooc.com/article/details/id/28426

3. 编写DockerFile

   ```dockerfile
   # FROM 设置基础镜像
   FROM openjdk:11
   # 设置镜像作者
   MAINTAINER seven
   # VOLUME 设置容器的挂载卷
   VOLUME /tmp
   # 编译时复制文件到镜像中，注意此处是当前开发路径‘target/demo-docker-0.0.1-SNAPSHOT.jar’
   COPY target/demo-docker-0.0.1-SNAPSHOT.jar test.jar
   # RUN 编译镜像时运行的脚本
   RUN bash -c 'touch /test.jar'
   # 设置容器的入口
   ENTRYPOINT ["java","-jar","/test.jar"]
   ```

4. idea 配置docker启动

   ![image-20210219174405828](docker之打包springboot项目图片/image-20210219174405828.png)

5. 查看结果

   ![image-20210219174557569](docker之打包springboot项目图片/image-20210219174557569.png)

![image-20210219174610231](docker之打包springboot项目图片/image-20210219174610231.png)