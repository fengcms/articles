title: CentOS7 初次安装记录（四）修改mysql数据库数据存储位置
date: 2015-11-18 10:31:49 +0800
update: 2015-11-18 10:31:49 +0800
author: fungleo
tags:
    -centos
    -mysql
    -数据库存储位置移动
---

#CentOS7 初次安装记录（四）修改mysql数据库数据存储位置

昨天跌跌撞撞终于算把服务器基础给搭建好了。但是都只是默认状态，现在，我想给服务器配置到我顺手使用的地步

##移动 mysql 数据库文件存储位置

默认mysql存储的位置在系统盘上。一般我们在使用阿里云等服务器的时候都会配备一个数据盘用来存储数据。所以，今天学习一下如何移动 数据库文件存储位置。

首先，在 `home` 下建立文件夹 `service/mysql/data/` 新建文件夹命令为 `mkdir` 谢天谢地，作为为数不多我能记住的命令，这个命令没有变化。

停止MYSQL服务 `systemctl stop mariadb.service` 

移动 mysql 数据库文件 `mv /var/lib/mysql　/home/service/mysql/data/`

进入`/etc/`文件夹 看一下有没有一个 `my.cnf`的文件。

编辑配置文件 `vi /etc/my.cnf`。

把其中的 `datadir` 和 `socket` 修改为如下

```language
datadir=/home/service/mysql/data/
socket=/home/service/mysql/data/mysql.sock
```
保存退出文件编辑。

重启mysql 服务 `systemctl start mariadb.service` 我XXXXXX，又报错！！！

到 `service/mysql/data/` 目录下瞅一眼，咦？咋还有一个mysql文件夹呢，再进去看，我勒个去，我这文件夹建的，也忒深了吧!_!~

重新 `vi /etc/my.cnf` 文件，将修改为~~~
```language
datadir=/home/service/mysql/data/mysql/
socket=/home/service/mysql/data/mysql/mysql.sock
```
保存退出，重启mysql服务 `systemctl start mariadb.service` 成功！

PS：我下回绝对不这么建立文件夹。。。。累死个娘的了~~~