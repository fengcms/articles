title: mysql 命令行补全工具 mycli
date: 2017-05-10 11:57:45 +0800
update: 2017-05-10 11:57:45 +0800
author: fungleo
tags:
    -mysql
    -mysql命令行
    -mysql命令行补全
    -mysql命令行高亮
---

#mysql 命令行补全工具 mycli

## 前言

我们在连接mysql数据库的时候，大多数情况下是使用gui图形界面的工具的。但是，有时候连接数据库还是命令行方便，所以，我们通常都需要掌握一点命令行操作数据库的基础。

这里推荐一篇文章给大家看[Mysql命令大全](http://www.cnblogs.com/zhangzhu/archive/2013/07/04/3172486.html)，这里包含了绝大多数我们需要用到的mysql命令。

但是，默认的mysql命令行是不支持补全的，并且很讨厌的是，我们输入了错误的命令之后，由于命令行操作习惯，按ctrl+c想要取消的时候，tmd已经退出了mysql命令行工具。只能再次连接。想要删除错误的命令只能 `ctrl+a` `ctrl+u`进行删除。或者一直按`ctrl+w`进行删除。

还有，每个命令必须以`;`分号结尾，而我这样的马大哈老是忘记。

最重要的是，这玩意儿不支持补全！我这样的人，没有补全怎么操作命令行哦！

今天看到github上有一个开源项目叫`mycli`，感觉非常好，安装使用了一下，果然牛逼，已经克服了我的Mysql命令行操作恐惧了！因此，推荐给大家！

##安装

官方网站：http://mycli.net
github地址：https://github.com/dbcli/mycli

![操作演示](https://github.com/dbcli/mycli/raw/master/screenshots/main.gif)

mac安装方法
```#
$ brew update && brew install mycli
```

ubuntu安装命令
```#
sudo apt-get install mycli
```

arch安装命令
```#
sudo pacman -S mycli
```

windows未测试，手头上没有windows系统。

##使用方法
```#
$ mycli --help
Usage: mycli [OPTIONS] [DATABASE]

Options:
  -h, --host TEXT               Host address of the database.
  -P, --port INTEGER            Port number to use for connection. Honors
                                $MYSQL_TCP_PORT
  -u, --user TEXT               User name to connect to the database.
  -S, --socket TEXT             The socket file to use for connection.
  -p, --password TEXT           Password to connect to the database
  --pass TEXT                   Password to connect to the database
  --ssl-ca PATH                 CA file in PEM format
  --ssl-capath TEXT             CA directory
  --ssl-cert PATH               X509 cert in PEM format
  --ssl-key PATH                X509 key in PEM format
  --ssl-cipher TEXT             SSL cipher to use
  --ssl-verify-server-cert      Verify server's "Common Name" in its cert
                                against hostname used when connecting. This
                                option is disabled by default
  -v, --version                 Version of mycli.
  -D, --database TEXT           Database to use.
  -R, --prompt TEXT             Prompt format (Default: "\t \u@\h:\d> ")
  -l, --logfile FILENAME        Log every query and its results to a file.
  --defaults-group-suffix TEXT  Read config group with the specified suffix.
  --defaults-file PATH          Only read default options from the given file
  --myclirc PATH                Location of myclirc file.
  --auto-vertical-output        Automatically switch to vertical output mode
                                if the result is wider than the terminal
                                width.
  -t, --table                   Display batch output in table format.
  --csv                         Display batch output in CSV format.
  --warn / --no-warn            Warn before running a destructive query.
  --local-infile BOOLEAN        Enable/disable LOAD DATA LOCAL INFILE.
  --login-path TEXT             Read this path from the login file.
  -e, --execute TEXT            Execute query to the database.
  --help                        Show this message and exit.
```

##连接数据库

```#
$ mycli local_database

$ mycli -h localhost -u root app_db

$ mycli mysql://amjith@localhost:3306/django_poll
```

其他内容请查看官方网站

如果你熟练使用Mysql命令行，那么使用这个工具没有任何问题。如果你不熟练，使用这个工具可以跟快的使你熟练！

我爱开源！