## 1.编写dockerfile文件

dockerfile目录结构：

![image-20210416093802841](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210416093802841.png)

运行脚本（仅参考）：

不要nohup，后台运行会让docker一启动就停止

```shell
#!/bin/bash
echo '=================GDocker==================='
echo '==  nacos服务地址(nacos service address)：' $NACOS_SERVER
echo '==  服务的命名空间(nacos namesapce)：' $NACOS_NAMESPACE
echo '==  服务的group(nacos group)：' $NACOS_GROUP
echo '==  java版本(java version)：' $JAVA_HOME
echo '==========================================='
echo "---开始部署(Start deployment)---"
java -jar \
-Dspring.cloud.nacos.server-addr=$NACOS_SERVER \
-Dspring.cloud.nacos.config.namespace=$NACOS_NAMESPACE \
-Dspring.cloud.nacos.config.group=$NACOS_GROUP \
-Dspring.cloud.nacos.discovery.namespace=$NACOS_NAMESPACE \
/root/kipf-graph-ontological-service.jar
```

Dockerfile

```dockerfile
# FROM 设置基础镜像
FROM openjdk:11
# 设置镜像作者
MAINTAINER yijialuo
#设置环境信息
ENV TZ Asia/Shanghai
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
# -------docker启动参数------
# nacos服务地址
ENV NACOS_SERVER nacos-server:8848
# 命名空间
ENV NACOS_NAMESPACE pubilc
# 组
ENV NACOS_GROUP DEFAULT_GROUP
# 添加启动脚本
ADD ./docker/kipf_run.sh /root/kipf_run.sh
# 添加运行jar
ADD ./target/kipf-graph-ontological-service-*.jar /root/kipf-graph-ontological-service.jar
# 设置运行权限
RUN chmod 777 /root/kipf_run.sh /root/kipf-graph-ontological-service.jar
# 设置容器的入口
ENTRYPOINT ["/root/kipf_run.sh"]
```

## 2.Jenkins上创建部署任务

Jenkins地址：http://10.201.82.253:7001/ 用户：admin/admin

新建项目并选择模板![image-20210416094933469](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210416094933469.png)

## 3.编辑pipeline脚本

```pipeline
pipeline {
  agent any
  parameters {
  //这是git参数信息，可以在构建时选择构建那个分支
    gitParameter branchFilter: 'origin/(.*)', defaultValue: 'master', name: 'BRANCH', type: 'BRANCH',sortMode: 'ASCENDING'
    //这是选择构建模块，如果您分支中有多个服务请务必添加。作用：选择不同的服务进行构建
    choice(
            name: 'MODULE',
           choices: ['ontological', 'noumenon'],
            description: '模块选择 '
        )
 }
 //这是docker环境 一般默认即可(上传到私服必须配置好docker的私服地址)
 //【务必修改DOCKER_USERNAME:发布人、DOCKER_PASSWORD:发布人密码、DOCKER_STORE:发布到那个仓库中】
  environment {
        DOCKER_HARBOR_URL='10.202.41.81:7001'
        DOCKER_USERNAME="uploader"
        DOCKER_PASSWORD="Uploader123"
        DOCKER_STORE="kipf"
  }
  //默认即可
  tools {
        // maven构建工具
    maven "M3"
    git "Default"
  }
  //步骤
  stages {
    stage('git拉取') {
      steps {
      //【请修改credentialsId: 'xxx', url: 'xxx'】
        git branch: "${params.BRANCH}", credentialsId: '3484e6c8-bf21-4edf-8e7d-edb36a7175c6', url: 'https://gitlab.gridsum.com/industry-cloud/code/yqdsj/yqzshl/gpower.git'
        sh 'echo "获取成功，git位置：$(pwd)"'
      }
    }
    stage('参数信息验证') {
      steps {
      //这里是为了获取到分支名字版本信息，如：xxx-1.0.0-xxx,得到版本为1.0.0。酌情修改
        script {
            def list =params.BRANCH.split('-')
            d_tag_version =list[1]
        }
        echo "===========GJenkins============"
        echo "==    选择的分支：${params.BRANCH}"
        echo "==    操作模块：kipf-graph-${params.MODULE}-service"
        echo "==    打包版本：${d_tag_version}"
        echo "==    dcoker私服地址：${env.DOCKER_HARBOR_URL}"
        echo "==    docker私服发布人：${env.DOCKER_USERNAME}"
        echo "==    docker发布仓库：${env.DOCKER_STORE}"
        echo "==    maven信息："
        sh 'mvn --version'
        echo "==    JDK版本："
        sh 'java -version'
      }
    }
    stage('maven编译'){
      steps{
        //【请务必修改dir中的内容，修改为构建的目录】
        dir("./kipf-graph-${params.MODULE}/kipf-graph-${params.MODULE}-service"){
                sh 'echo "编译：$(pwd)"'
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
        }
      }
    }
    stage('docker镜像制作'){
      steps{
        //【请务必修改dir中的内容，修改为构建的目录】
          dir("./kipf-graph-${params.MODULE}/kipf-graph-${params.MODULE}-service"){
              sh "docker build -t ${env.DOCKER_HARBOR_URL}/${env.DOCKER_STORE}/${params.MODULE}:${d_tag_version} -f ./docker/Dockerfile ." 
            echo "${params.MODULE}的docker镜像制作"
          }
      }
    }
    stage('docker镜像发布'){
      steps{
        sh "docker login ${env.DOCKER_HARBOR_URL} -u ${env.DOCKER_USERNAME} -p ${env.DOCKER_PASSWORD}"
        sh "docker push ${env.DOCKER_HARBOR_URL}/${env.DOCKER_STORE}/${params.MODULE}:${d_tag_version}"
      }
    }
  }
}
```

参数生成器：

![image-20210416095442824](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210416095442824.png)

- git拉取步骤：【请修改credentialsId: 'xxx', url: 'xxx'】：

  ![image-20210416095622717](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210416095622717.png)

## 4.运行测试验证

![image-20210416100234322](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210416100234322.png)

![image-20210416100548214](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210416100548214.png)

访问Harbor:

![image-20210416100625855](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210416100625855.png)

## 问题：

- git信息获取失败

![image-20210416095915397](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210416095915397.png)

解决：点击 配置->取消参数化构建![image-20210416100015091](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210416100015091.png)->在点击配置->如果出现了新的参数构建点击保存，否则复制pipeline脚本再粘贴保存->点击Build with Parameters![image-20210416100156449](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210416100156449.png)

- 