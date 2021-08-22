# Mysql安装部署教程

## 1.Centos7安装

> mysql8.0 for linux
>
> 参考博客：https://blog.51cto.com/11555417/2406110

## 2.win安装mysql5.7

[下载地址](https://cdn.mysql.com//Downloads/MySQL-5.7/mysql-5.7.33-winx64.zip)

1. 解压zip

2. 创建一个my.ini文件

   ```ini
   [Client]
   port = 3306
    
   [mysqld]
   #设置3306端口
   port = 3306
   skip-grant-tables
   # 设置mysql的安装目录
   #basedir=
   # 设置mysql数据库的数据的存放目录
   #datadir=
   # 允许最大连接数
   max_connections=200
   # 服务端使用的字符集默认为8比特编码的latin1字符集
   character-set-server=utf8
   # 创建新表时将使用的默认存储引擎
   default-storage-engine=INNODB
    
   [mysql]
   # 设置mysql客户端默认字符集
   default-character-set=utf8
   ```

3. ./bin目录下，管理员运行cmd并执行命令：mysqld --initialize --user=mysql --console

   ![image-20210221122510143](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210221122510143.png)初始密码为：**N8Dyjpq+kvz#**需要我们记住它

4. 运行命令：

   ```cmd
   mysqld --install mysql
   net start mysql
   ```

   启动mysql服务

5. 运行mysql

   ```cmd
   mysql -u root -p
   ```

   并输入刚刚初始的秘密的N8Dyjpq+kvz#

6. 修改密码：set password=password('你的新密码');

   **注意：**8.0貌似有密码复杂度严重，需要设置参考：

7. 设置数据库连接工具可以登录

   ```
   
   ```

   



