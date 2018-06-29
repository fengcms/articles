title: Python3 初学实践案例（9）sqlacodegen 根据已有数据库生成 ORM 使用的 model.py
date: 2017-12-21 17:30:06 +0800
update: 2017-12-21 17:30:06 +0800
author: fungleo
tags:
    -数据库
    -python
    -orm
    -sqlacodege
    -sqlalchemy
---

# Python3 初学实践案例（9）sqlacodegen 根据已有数据库生成 ORM 使用的 model.py

前面我们在连接数据库的时候，我们使用的是 `sql` 语句来实现的。但是组织 `sql` 语句是一个比较困难的事情，因此，我们可以使用 `ORM` 库将数据库变成一个类，然后通过操作这个类来实现对数据库的操作。

所以我打算学习 `sqlalchemy` 这个 `ORM` 库。但是发现，自己来书写这个类是非常困难的。主要是很多语法都不知道如何来写。

但是我想，这样重复性的工作，一定有工具可以实现。于是我找到了 `sqlacodegen` 这个工具，这个工具，可以将已有的数据库生成为 `ORM` 使用的 `model.py` 文件。

## 安装与使用 sqlacodegen 工具

安装特别简单：

```#
pip install sqlacodegen
```

安装完成后，我们运行

```#
sqlacodegen --version
```

就可以输出它的版本号了。当然，我们可以通过 `-h` 参数来查看帮助信息，具体如下：

```#
$ sqlacodegen --help
usage: sqlacodegen [-h] [--version] [--schema SCHEMA] [--tables TABLES]
                   [--noviews] [--noindexes] [--noconstraints] [--nojoined]
                   [--noinflect] [--noclasses] [--outfile OUTFILE]
                   [url]

Generates SQLAlchemy model code from an existing database.

positional arguments:
  url                SQLAlchemy url to the database

optional arguments:
  -h, --help         show this help message and exit
  --version          print the version number and exit
  --schema SCHEMA    load tables from an alternate schema
  --tables TABLES    tables to process (comma-separated, default: all)
  --noviews          ignore views
  --noindexes        ignore indexes
  --noconstraints    ignore constraints
  --nojoined         don't autodetect joined table inheritance
  --noinflect        don't try to convert tables names to singular form
  --noclasses        don't generate classes, only tables
  --outfile OUTFILE  file to write output to (default: stdout)
```

好像参数很多的样子，但是很好理解，不要视图，不要索引以及其他的。

最重要的参数就是 `[url]` 这个是数据库连接语句。

比如我连接我前面生成的那个保存密码的数据库，就可以用下面的语句：

```#
sqlacodegen sqlite:///passwd.db
```

然后就可以在终端内输出响应的模型文件的代码了。

我们当然需要保存到文件当中，可以通过两个命令来实现。

```#
// 第一种是使用系统命令
sqlacodegen sqlite:///passwd.db > model.py
// 第二种是使用工具自带功能
sqlacodegen --outfile y.py sqlite:///passwd.db
```

>其他人写的文章一定是告诉你使用工具自带功能的命令，但是你看，还是系统命令更加简洁吧~关键是这个工具没有参数缩写，差评~

## sqlacodegen 工具的输出结果

我的那个保存密码的数据库的输出结果如下：

```pythom
# coding: utf-8
from sqlalchemy import Column, DateTime, Integer, String, Table, text
from sqlalchemy.sql.sqltypes import NullType
from sqlalchemy.ext.declarative import declarative_base


Base = declarative_base()
metadata = Base.metadata


class Passwd(Base):
    __tablename__ = 'passwd'

    id = Column(Integer, primary_key=True)
    name = Column(String(255))
    password = Column(String(255))
    time = Column(DateTime, server_default=text("current_timestamp"))

t_sqlite_sequence = Table(
    'sqlite_sequence', metadata,
    Column('name', NullType),
    Column('seq', NullType)
)
```

嘿嘿，要引用什么样的库，以及各种标准写法，全部在里面了，真好呀~太方便啦！

如果是一个比较大型的数据库，使用这个工具就实在是太方便了。

不过目前对于我来说，最关键的问题还是，赶紧去看 `sqlalchemy` 文档~

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

