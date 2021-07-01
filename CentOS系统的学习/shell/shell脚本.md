==注意配置==

1）修改/etc/profile文件：用来设置系统环境参数，比如$PATH. 这里面的环境变量是对系统内所有用户生效。使用bash命令，需要source  /etc/profile一下。
2）修改~/.bashrc文件：针对某一个特定的用户，环境变量的设置只对该用户自己有效。使用bash命令，只要以该用户身份运行命令行就会读取该文件。
3）把/etc/profile里面的环境变量追加到~/.bashrc目录

```
cat /etc/profile >> ~/.bashrc
# 然后分发.bashrc
xsync ~/.bashrc
```

## 1.分发脚本

免密登录设置

```
ssh-keygen -t rsa
```

```
ssh-copy-id 用户@主机名
```

```
sudo yum install rsync -y
#所有机器都有安装，否则无法分发
```

脚本xsync【放在在/home/seven/bin下】

```shell
#!/bin/bash
#1 获取输入参数个数，如果没有参数，直接退出
pcount=$#
if((pcount==0)); then
echo no args;
exit;
fi

#2 获取文件名称
p1=$1
fname=`basename $p1`
echo fname=$fname

#3 获取上级目录到绝对路径
pdir=`cd -P $(dirname $p1); pwd`
echo pdir=$pdir

#4 获取当前用户名称
user=`whoami`

#5 循环，配置分发的ip，或者host
for((host=103; host<105; host++)); do
        echo ------------------- hadoop$host --------------
        rsync -rvl $pdir/$fname $user@hadoop$host:$pdir
done

```

修改权限

```
chmod 777 xsync
```

在利用分发脚本分发~/.ssh文件夹

## 2.zk集器启动脚本

脚本zk-run-all.sh【放在在/home/seven/bin下】

```shell
#! /bin/bash
zk=/opt/module/zookeeper-3.4.10
case $1 in
"start"){
	for i in hadoop102 hadoop103 hadoop104
	do
		echo "==== $i ===="
		ssh $i "$zk/bin/zkServer.sh start"
	done
};;
"stop"){
	for i in hadoop102 hadoop103 hadoop104
	do
		echo "==== $i ===="
		ssh $i "$zk/bin/zkServer.sh stop"
	done
};;
"status"){
	for i in hadoop102 hadoop103 hadoop104
	do
		echo "==== $i ===="
		ssh $i "$zk/bin/zkServer.sh status"
	done
};;
esac
```

修改权限

```
chmod 777 zk-run-all.sh
```

## 3.在所有服务器运行相同命令

脚本xcall.sh【放在在/home/seven/bin下】

```shell
#! /bin/bash

for i in hadoop102 hadoop103 hadoop104
do
        echo --------- $i ----------
        ssh $i "$*"
done
```

修改权限

```
chmod 777 xcall.sh
```

使用

```
xcall.sh jps
```



## 4.查看日志

```
tail-logs.sh /data1_1T/dolphinscheduler/logs
```



```shell

function read_dir(){
        for file in `ls $1`
        do
                if [ -d $1"/"$file ]
        then
                read_dir $1"/"$file
        else
                extension=${file##*.}
                # 判断文件后缀
                if [ "${file##*.}"x = "log"x ];then
                        echo "=====$extension tail $file====="
                        echo ""
                        tail $1"/"$file
                        echo "" 
                fi
        fi
        done
}
echo $1

```

## 4.同步时间脚本

time-sync.sh 

```shell
#!/bin/bash
# 同步集群时间
log_date=$1 
if [ ! -n "$log_date" ]; then 
	echo "IS NULL"
	log_date=$(date "+%Y-%m-%d")
	echo log_date 
else 
	echo "NOT NULL" 
fi 

for i in hadoop102 hadoop103 hadoop104
do
	echo "====$i===="
	ssh -t $i "sudo date -s $log_date"
done
```

## 5.通过端口/名称杀死进程

```shell
#! /bin/bash

parm=$1

echo " -------参数$1 正在杀死进程-------"
ps -ef | grep $1 | grep -v grep |awk '{print $2}' | xargs kill

```

## 6.修改ip和hostname

```
sudo vim /etc/sysconfig/network-scripts/ifcfg-ens33
```

修改如下

```properties
TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="static"
IPADDR="192.168.196.102"#你的静态ip
NETMASK="255.255.255.0"
GATEWAY="192.168.196.2"#修改
DNS1="192.168.196.2"#修改
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="ens33"
UUID="ae9346c0-64fc-4e54-8687-2d5588b36215"
DEVICE="ens33"
ONBOOT="yes"
```

修改hostname

```
sudo hostnamectl set-hostname ***
```

修改hosts文件

```
sudo vim /etc/hosts
```

## 7.查看端口、进程

```shell
sudo netstat -lnp|grep 8852
sudo ps -elf | grep 进程id
sudo kill -9 $(ps -ef | grep 名称 | grep -v grep | awk '{print $2}')
```

## 8、执行同级目录的sh

```shell
echo $(dirname -- "$0")
cd -P -- $(dirname -- "$0")
echo $(pwd)
# 执行
```

9、通用springboot nacos run.sh

```shell

cd -P -- $(dirname -- "$0")
nacos_server=10.201.81.1:8840
nacos_namespace=kipf-dev
nacos_group=DEFAULT_GROUP
service_name=gscheduler-server
# 应当先查询端口占用情况
case $1 in
""){
	sh ./run.sh restart
};;
"start"){
	echo "start " $service_name
	nohup java -jar -Dspring.cloud.nacos.server-addr=$nacos_server -Dspring.cloud.nacos.config.namespace=$nacos_namespace -Dspring.cloud.nacos.config.group=$nacos_group -Dspring.cloud.nacos.discovery.namespace=$nacos_namespace -DLOG_PATH=$(pwd) $(pwd)/${service_name}*.jar >  $(pwd)/${service_name}.out 2> $(pwd)/${service_name}.err < /dev/null &
	sh ./run.sh status
};;
"restart"){
        echo "restart ${service_name}"
	sh ./run.sh stop
	sh ./run.sh start
};;
"stop"){
	echo "stop Gsnow"
	service_pid=`ps -ef | grep java | grep $service_name*.jar | grep -v grep  | awk '{print $2}'`
	if [  -n  "$service_pid"  ]; then
        	kill -9 $service_pid
        	printf "杀死进程：%s\n" "$service_pid"
	else
		printf "杀死失败:%s\n" $service_name
	fi
};;
"status"){
	echo "${service_name} status"
	service_pid=`ps -ef | grep java | grep $service_name*.jar | grep -v grep  | awk '{print $2}'`
	if [  -n  "$service_pid"  ]; then
            printf "%s服务运行中\t进程:%s\n" $service_name "$service_pid"
	else
            printf "无%s服务:%s\n" $service_name
	fi
};;
esac
```

9、替换文本中的内容

```shell
sed -i "s#原文件内容#替换文件内容#g" 文件路径
```

10、EOF写入文件

```shell
cat << EOF > 文件路径
文件内容
EOF
```



