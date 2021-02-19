# 海豚自定义插件

## 一、搭建开发环境

> 官网说明：https://dolphinscheduler.apache.org/zh-cn/docs/development/development-environment-setup.html

#### 准备工作

1. 首先从远端仓库fork [dolphinscheduler](https://github.com/apache/incubator-dolphinscheduler) 一份代码到自己的仓库中

2. 在开发环境中安装好MySQL/PostgreSQL、JDK、MAVEN

3. 把自己仓库clone到本地

   `git clone https://github.com/apache/incubator-dolphinscheduler.git`

4. git clone项目后，进入项目目录，执行以下命令。

```
1. git branch -a    #查看分支
2. git checkout dev #切换到dev分支
3. git pull #同步分支
4. mvn -U clean package -Prelease -Dmaven.test.skip=true   #由于项目使用了gRPC，所以需要先编译项目生成需要的类。
```

#### 安装node



#### 安装zookeeper



#### 创建数据库

官网使用的是mysql，这里采用PostgreSQL

1. 创建dolphinscheduler数据库（编码UTF-8）
2. 【可选】给dolphinscheduler数据库创建用户名为dolphinscheduler，密码为dolphinscheduler的用户

#### 搭建前端

1. 进入dolphinscheduler-ui的目录
   cd dolphinscheduler-ui
2. 执行npm install
3. 修改dolphinscheduler-ui模块的.env文件

```
# 后端api地址
API_BASE = http://localhost:12345
DEV_HOST = localhost
```

> QA:
>
> * npm慢：百度安装cnpm或者修改npm镜像

#### 搭建后端

1. 将项目导入到idea中
   file-->open

2. 修改根pom.xml

   ```xml
       <modules>
   <!--        <module>dolphinscheduler-ui</module>-->
           <module>dolphinscheduler-server</module>
           <module>dolphinscheduler-common</module>
           <module>dolphinscheduler-api</module>
           <module>dolphinscheduler-dao</module>
           <module>dolphinscheduler-alert</module>
           <module>dolphinscheduler-dist</module>
           <module>dolphinscheduler-remote</module>
           <module>dolphinscheduler-service</module>
           <module>dolphinscheduler-plugin-api</module>
           <module>dolphinscheduler-microbench</module>
       </modules>
   ```

3. 修改dao模块resource目录下datasource.properties文件中的数据库配置信息

   ```properties
   # postgresql
   spring.datasource.driver-class-name=org.postgresql.Driver
   spring.datasource.url=jdbc:postgresql://localhost:5432/dolphinscheduler?characterEncoding=UTF-8&allowMultiQueries=true
   spring.datasource.username=postgres
   spring.datasource.password=postgres
   ```

4. 刷新dao模块，运行org.apache.dolphinscheduler.dao.upgrade.shell.CreateDolphinScheduler的main方法，自动插入项目所需的表和数据

5. 修改service模块zookeeper.properties中链接信息(zookeeper.quorum)
   zookeeper.quorum=localhost:2181

#### 启动项目

1. 启动zookeeper
   ./bin/zkServer.sh start

2. 启动MasterServer，执行org.apache.dolphinscheduler.server.master.MasterServer类上添加

   ```java
   @PropertySource(ignoreResourceNotFound = false, value = "classpath:master.properties")
   ```

3. 类ache.dolphinscheduler.server.worker.WorkerServer类上添加

   ```java
   @PropertySource(ignoreResourceNotFound = false, value = "classpath:worker.properties")
   ```

4. 启动ApiApplicationServer，执行org.apache.dolphinscheduler.api.ApiApplicationServer类上添加

   ```java
   @PropertySource(ignoreResourceNotFound = false, value = "classpath:application-api.properties")
   ```

5. ,这里暂时不启动其它模块，如果启动其它模块，那么去查询script/dolphinscheduler-daemon.sh文件,设置相应的VM Options

   ```shell
       if [ "$command" = "api-server" ]; then
         LOG_FILE="-Dlogging.config=classpath:logback-api.xml -Dspring.profiles.active=api"
         CLASS=org.apache.dolphinscheduler.api.ApiApplicationServer
       elif [ "$command" = "master-server" ]; then
         LOG_FILE="-Dlogging.config=classpath:logback-master.xml -Ddruid.mysql.usePingMethod=false"
         CLASS=org.apache.dolphinscheduler.server.master.MasterServer
       elif [ "$command" = "worker-server" ]; then
         LOG_FILE="-Dlogging.config=classpath:logback-worker.xml -Ddruid.mysql.usePingMethod=false"
         CLASS=org.apache.dolphinscheduler.server.worker.WorkerServer
       elif [ "$command" = "alert-server" ]; then
         LOG_FILE="-Dlogback.configurationFile=conf/logback-alert.xml"
         CLASS=org.apache.dolphinscheduler.alert.AlertServer
       elif [ "$command" = "logger-server" ]; then
         CLASS=org.apache.dolphinscheduler.server.log.LoggerServer
       else
         echo "Error: No command named \`$command' was found."
         exit 1
       fi
   ```

6. 启动前端ui模块
   cd dolphinscheduler-ui目录，执行npm run start

#### 访问项目

1. 访问http://localhost:8888
   输入管理员账户admin,密码dolphinscheduler123进行登陆

#### 参考：

* https://www.cnblogs.com/djlsunshine/p/13214539.html

#### 问题记录

* 

二、插件之后端修改

三、插件之前端修改

四、插件之测试