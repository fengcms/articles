title: CentOS7 初次安装记录（三）配置PHP和MYSQL
date: 2015-11-17 17:50:35 +0800
update: 2015-11-17 17:50:35 +0800
author: fungleo
tags:
    -centos
    -mysql
    -php
---

#CentOS7 初次安装记录（三）配置PHP和MYSQL

##配置 php 环境

跌跌撞撞，终于把apache环境给弄好了。下面我们来配置PHP环境。

照旧，还是yum安装

```language
yum -y install php
```
顺利安装成功！

我们来新建一个text.php 文件看看成功了没。

```language
vi /var/www/html test.php
// 在里面输入
<?php 
echo phpinfo();
?>
:wq
// 保存退出
```

在浏览器里输入 http://192.168.1.254/test.php 访问看看

我勒个去，咋回事儿？文本输出？

原来忘记重启apache了。`systemctl restart httpd.service` 重启一下。

再次访问。嗯已经成功，顺利安装了php5.4.16

然后就是安装PHP常用扩展

```language
yum -y install php-mysql php-gd php-imap php-ldap php-mbstring php-odbc php-pear php-xml php-xmlrpc
// 重启 apache 服务
systemctl restart httpd.service
```
这回别忘了重启

PHP安装还算顺利，下面来整MYSQL

##配置 mysql 数据库

还是yum安装。我除了yum也不会别的了-_-~~~

```language
yum -y install mysql mysql-server
```
文件比较大，下载需要点时间。

发现问题，`mysql-server` 找不到，百度了一下，原来已经换成了`mariadb-server` 我X，改动太大了吧

重新安装

```language
yum -y install mariadb mariadb-server
```
再抽根烟，安装完成，设定 mysql 自启动
```language
systemctl enable mariadb.service
```

接下来设置mysql密码

```language
mysql_secure_installation
```
我XXXXX，怎么又报错了啊？？还让不让人活了啊~~
```language
ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/lib/mysql/mysql.sock'
```
仔细看了一下，好像刚刚没启动mysql服务。启动一下

```language
systemctl restart mariadb.service
```
重新输入 `mysql_secure_installation` 命令配置 mysql 数据库 一路回车，直到

```language
Set root password? [Y/n] 
//输入 y 回车
//然后输入两次新密码
//然后会有一堆问题，全部 y 回车
// OK 后重启mysql服务
systemctl restart mariadb.service
```

好了。这回貌似成功了。用mysql数据库管理软件，连接一下mysql。提示连接不成功，正常。刷新一下权限

```language
mysql -u root -p
// 输入刚刚设置的密码 回车 进入mysql 控制台
flush privileges;
// 再次连接，登陆上去了！
```
好了，apache + php + mysql 已经顺利安装上了。

明天接着捣鼓 虚拟机的配置。

**总结**

CentOS7 更换了大量的命令，有很多东西和6.5有相当的差异。必须好好调整一下。