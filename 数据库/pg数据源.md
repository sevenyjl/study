# postgres环境搭建

## win环境搭建

> 搭建方式有exe和zip

下载：https://get.enterprisedb.com/postgresql/postgresql-10.16-1-windows-x64.exe
自用渠道：

1.运行exe

选择安装目录

![image-20210324205509527](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210324205509527.png)

![image-20210324205640638](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210324205640638.png)

设置用户名和密码postgres/root，端口默认设置5432

![image-20210324210255189](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210324210255189.png)

2.打开navicat

![image-20210324210509296](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210324210509296.png)

navicat破解教程见：https://gitee.com/GTeam_seven/study/blob/master/%E6%95%B0%E6%8D%AE%E5%BA%93/%E6%95%B0%E6%8D%AE%E5%BA%93%E7%AE%A1%E7%90%86%E8%BD%AF%E4%BB%B6.md

> 参考安装文档：https://www.runoob.com/postgresql/windows-install-postgresql.html
>
> 视频地址：https://haokan.baidu.com/v?vid=3908241243113628075

## linux环境搭建

### 在线安装

1.下载安装

安装yum repo RPM:

```shell
yum install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-
x86_64/pgdg-redhat-repo-latest.noarch.rpm
```

安装客户端：

```shell
yum install postgresql11
```

安装服务端：

```shell
yum install postgresql11-server
```

初始化数据库并设置开机启动服务

```shell
/usr/pgsql-11/bin/postgresql-11-setup initdb
systemctl enable postgresql-11
systemctl start postgresql-11
```

2.调整配置

2.1 允许外部连接 

```shell
cd /var/lib/pgsql/11/data 
vim postgresql.conf
```

```properties
#listen_addresses = 'localhost'
listen_addresses = '*'
```

`vim pg_hba.conf`

```shell
# TYPE DATABASE USER ADDRESS METHOD
host all all 0.0.0.0/0 md5
```

重启 systemctl restart postgresql-11

2.2 防火墙放开5432端口

```shell
sudo firewall-cmd --zone=public --add-port=5432/tcp
```

3.设置密码

```shell
sudo -u postgres psql postgres;
\password postgres Enter new password:
```

### 离线安装

## docker环境搭建

