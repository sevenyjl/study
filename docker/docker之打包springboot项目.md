# Docker打包SpringBoot项目

## 1.快速入门

> 参考：https://www.cnblogs.com/zmsn/p/11697575.html

1. 创建springboot项目

2. 创建Dockerfile文件如：![image-20210219161916423](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210219161916423.png)

3. 编辑DockerFile

   ```dockerfile
   # FROM 设置基础镜像
   FROM openjdk:11
   # 设置镜像作者
   MAINTAINER seven
   # VOLUME 设置容器的挂载卷
   #设置环境信息
   ENV TZ Asia/Shanghai
   ENV LANG C.UTF-8
   ENV DEBIAN_FRONTEND noninteractive
   VOLUME /tmp
   # 编译时复制文件到镜像中
   ADD demo-docker-0.0.1-SNAPSHOT.jar test.jar
   # RUN 编译镜像时运行的脚本
   RUN bash -c 'touch /test.jar'
   # 设置容器的入口
   ENTRYPOINT ["java","-jar","/test.jar"]
   ```

   ![908364-20181030203718699-1692062658](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/908364-20181030203718699-1692062658.png)

4. 上传jar和DockerFile到服务器![image-20210219162132139](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210219162132139.png)

5. 制作docker镜像：

   ```shell
    sudo docker build -t demo-docker:v0.0.1 .
   ```

6. 查看生成镜像：docker images![image-20210219162414012](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210219162414012.png)

7. 运行镜像：

   ```shell
   sudo docker run -d -p 8111:8080 --name test-docker demo-docker:v0.0.1
   ```

   ![image-20210219162612201](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210219162612201.png)

## 2.Idea快速打包docker

1. 下载idea插件![image-20210219173816587](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210219173816587.png)

2. 修改docker远程配置（如果本地有win本地有docker可以用本地）![image-20210219173934787](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210219173934787.png)

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

   ![image-20210219174405828](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210219174405828.png)

5. 查看结果

   ![image-20210219174557569](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210219174557569.png)

![image-20210219174610231](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210219174610231.png)

> <svg t="1613728477345" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2267" width="15" height="15"><path d="M64.6 512c0 195.6 125.4 361.9 300.1 422.9 23.5 5.9 19.9-10.8 19.9-22.2v-77.6c-135.8 15.9-141.3-74-150.5-89-18.5-31.5-61.9-39.5-49-54.5 31-15.9 62.5 4 98.9 58 26.4 39.1 77.9 32.5 104.1 26 5.7-23.5 17.9-44.5 34.7-60.9-140.7-25.2-199.4-111.1-199.4-213.3 0-49.5 16.4-95.1 48.4-131.8-20.4-60.6 1.9-112.4 4.9-120.1 58.2-5.2 118.5 41.6 123.3 45.3 33.1-8.9 70.8-13.7 112.9-13.7 42.4 0 80.3 4.9 113.5 13.9 11.3-8.6 67.3-48.8 121.4-43.9 2.9 7.7 24.7 58.3 5.5 118.1 32.5 36.8 49 82.8 49 132.4 0 102.3-59 188.3-200.2 213.2 23.5 23.3 38.1 55.5 38.1 91.1v112.7c0.8 9 0 17.9 15.1 17.9C832.7 877 960.4 709.4 960.4 512.1c0-247.5-200.6-447.9-447.9-447.9C265 64.1 64.6 264.5 64.6 512z" fill="" p-id="2268"></path></svg>项目地址：https://github.com/sevenyjl/demo-docker

