title: Python3 初学实践案例（8）使用 sqlite3 数据库存储生成的密码，prettytable 的使用
date: 2017-12-20 18:17:39 +0800
update: 2017-12-20 18:17:39 +0800
author: fungleo
tags:
    -数据库
    -python
    -sqlite3
    -密码
    -存储
---

# Python3 初学实践案例（8）使用 sqlite3 数据库存储生成的密码，prettytable 的使用

在前面我用 `python` 脚本实现的 `cli` 版本的密码生成与管理工具中，我使用文本文件来存储我们的生成的密码。详情见：http://blog.csdn.net/fungleo/article/details/78842597

这样做我感觉还是有一些欠妥。因为这样查看的时候，必须使用系统命令，或者其他 GUI 工具进行查看。如果我要用 `python` 来处理和分析这个文本文件，无疑工作量是巨大的。

因此，我希望用数据库来存储我们生成的密码，然后用 `sql` 语句来进行查询，顺便写一个查询工具，这样就可以很方便的使用了。

在数据库的选型上，我决定使用单文件数据库 `sqlite` 。因为这样我们不需要安装一个数据库服务，并且可以随时复制走。

再说，就一个表就可以搞定的事情，搞个大型数据库也确实有点脱裤子放屁的感觉。

> 本文是 `cli` 密码生成管理工具的衍生文章。 

## 开始实战

由于前面我们已经完成了密码生成工具的主体逻辑代码，这边只是将原来使用文本文件存储密码修改为数据库存储，所以，我不想大幅修改原有的文件。因此我新创建了一个 `db.py` 文件，来专门写相应的代码。

全部代码如下：

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
import sqlite3
import re
import sys
from prettytable import PrettyTable

DB_PATH = sys.path[0] + '/passwd.db'

def checkDB(db):
    db.execute('''SELECT name FROM sqlite_master
                WHERE type IN ('table','view') AND name NOT LIKE 'sqlite_%'
                ORDER BY 1''')
    o = db.fetchall()
    if len(o) == 0 or not bool(re.search(r'(\'passwd\',)',str(o))):
        db.execute('''CREATE TABLE passwd (
            id integer primary key autoincrement,
            name varchar(255),
            password varchar(255),
            time timestamp default current_timestamp
        )''')
def insertDb(name,passwd):
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    checkDB(c)
    c.execute("INSERT INTO passwd (name,password) VALUES ('" + name + "', '" + passwd + "')");
    conn.commit()
    conn.close()

def selectDb(pid,name):
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    checkDB(c)

    select = "SELECT * from passwd "
    if name:
        select += ('where name LIKE \'%' + name + '%\'')
    if pid:
        select += ('where id = \'' + str(pid) + '\'')
    select += 'ORDER BY id DESC'

    res = list(c.execute(select))
    if len(res) == 0:
        print('Info: record is empty')
    else:
        x = PrettyTable(['id','name','password','time'])
        x.align['name'] = 'l'
        x.padding_width = 1
        for row in res:
            x.add_row(list(row))
        print(x)
    conn.close()

def deleteDb(pid):
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    checkDB(c)
    c.execute('DELETE from passwd where id=' + str(pid) )
    conn.commit()
    o = conn.total_changes
    if o == 0:
        print('Failure: the password was not found')
    if o == 1:
        print('Success: ID ' + str(pid) + ' password has been deleted')
    conn.close()
```


## 代码解析

**确定数据库路径**

我们的脚本写好后，我们可以在系统的任何地方运行这个脚本。因此，数据库路径必须使用绝对路径，否则存在哪里就不太清楚了。

我希望文件存储在和 `db.py` 文件的同级目录下，因此，我需要先获取到 `db.py` 这个文件所在的目录。我们使用 `sys` 库的基本功能来实现，代码如下：

```python
import sys
DB_PATH = sys.path[0] + '/passwd.db'
```

其中 `sys.path[0]` 就是获取文件存在的绝对路径，后面加上数据库文件名。然后存一个常量，我们就可以在下面的函数中使用数据库位置常量来调用数据库了。

**sqlite 数据库的连接**

首先，我们需要引入库，然后创建连接，连接打开后，我们执行我们希望操作的 `sql` 语句，然后再关闭连接，就完成了我们希望的工作了。

```python
import sqlite3

conn = sqlite3.connect(DB_PATH)
c = conn.cursor()
c.execute("__这里是一条SQL语句__");
conn.commit()
conn.close()
```

如上，基本就是一条 `sql` 语句的执行全过程了。当然，我们可以在一个连接内操作多条 `SQL` 语句，但是就我们的这个工具来说，一般都是一条一条的执行，需要执行的时候创建连接，连接好了之后，我们执行代码，然后提交，然后关闭。

> 如果数据库不存在，就会创建一个数据库文件，这个是个自动的机制，我们就不用管了。

**在数据库中创建表**

一个新创建的数据库当中是没有任何表的。我们不能要求我们的用户自己去搞好一个表再来使用。因此，当数据库不存在，在第一次链接的时候会自动创建这个数据库，但是这个数据库中是没有任何表的，所以，我们需要检查数据库中有没有表，如果有表，那么有没有我们使用的这个表，如果不符合条件，我们则需要创建一个表，并且这个表的结构要符合我们的设计。

整体代码如下：

```python
import re
def checkDB(db):
    db.execute('''SELECT name FROM sqlite_master
                WHERE type IN ('table','view') AND name NOT LIKE 'sqlite_%'
                ORDER BY 1''')
    o = db.fetchall()
    if len(o) == 0 or not bool(re.search(r'(\'passwd\',)',str(o))):
        db.execute('''CREATE TABLE passwd (
            id integer primary key autoincrement,
            name varchar(255),
            password varchar(255),
            time timestamp default current_timestamp
        )''')
```

如上，我们这个函数的作用就是检查状况，如果需要创建一个表，就直接创建。那么，在我们需要检查的地方，使用这个函数就可以检查了，如下代码：

```python
def insertDb(name,passwd):
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    # 就是这里，我先检查了一下。
    checkDB(c)
    c.execute("INSERT INTO passwd (name,password) VALUES ('" + name + "', '" + passwd + "')");
    conn.commit()
    conn.close()
```

> 上面我使用了正则来检查数据库中是否存在我们需要的 `passwd` 表，所以我们需要引入正则库。

**优雅的在终端内展示表格**

我们可以使用 `select` 语句从数据库中查出来内容，然后使用 `list()` 方法就可以转换成可以循环的列表。但是如何优雅的在终端内展示表格呢？这里，我使用了一个 `python` 的库 `prettytable` 来解决我的问题。

> 不使用 `list()` 函数也可以循环的。

演示如下：

```python
from prettytable import PrettyTable

# 从数据库拿到结果，转换成列表
res = list(c.execute(select))
# 给输出的表格设定表头，有几列就设定几个
x = PrettyTable(['id','name','password','time'])
# 可以给指定列设定文字对齐，默认是居中对齐，下面是改成了 left 左对齐
x.align['name'] = 'l'
# 设定表格内填充为 1 个空格，让表格可读性更高
x.padding_width = 1
# 循环数据
for row in res:
    # 插入每一行的数据
    x.add_row(list(row))
# 打印表格
print(x)
```

好，这样我们就可以输出优雅的表格了。其结果如下：

```#
+----+--------------+------------+---------------------+
| id | name         |  password  |         time        |
+----+--------------+------------+---------------------+
| 4  | 123          |  zTAT8DCU  | 2017-12-20 08:31:35 |
| 3  | sunmingyuan2 | TxmKZt:44s | 2017-12-20 05:11:36 |
| 2  | sunmingyuan  | /t22664Q44 | 2017-12-20 05:11:22 |
+----+--------------+------------+---------------------+
```

其他内容都是基础的 `sql` 语句的内容。更多 `sql` 内容可以访问 http://www.w3school.com.cn/sql/index.asp 获取。

## 补充查看和删除密码的管理脚本 seepw.py 代码

上面我们的 `db.py` 脚本中，除了生成密码的脚本中我们需要的插入语句外，我还写了查看以及删除语句的函数。我使用了另外一个脚本 `seepw.py` 来实现相应的功能。其代码如下：

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
import db
import argparse

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.description='This program is used to manage the password saved in the database'
    parser.add_argument("-v", "--version",action='version', version='%(prog)s 1.0')
    group = parser.add_mutually_exclusive_group()
    group.add_argument("-i", "--id", help="The ID of the password you want to look at")
    group.add_argument("-n", "--name", help="The NAME of the password you want to look at")
    group.add_argument("-d", "--delete", help='Delete mode, the parameter is ID')
    args = parser.parse_args()
    name = args.name if args.name else False
    pId = args.id if args.id else False
    dId = args.delete

    if dId:
        if dId.isdigit():
            db.deleteDb(dId)
        else:
            print('Error: The parameters of the delete mode must be number')
    else:
        db.selectDb(pId,name)
```

这个脚本没什么更多的解释，只是去配置了 `argparse` 库的各种参数然后判断用户是想查看还是删除，然后执行对应的方法即可。

## 补充生成密码的修改

首先是去除原有的使用文本文件存储的所有代码，引用我们的 `db.py` 文件，然后在需要插入密码到数据库的地方使用下面的方法即可往数据库中插入保存的数据。

```python
db.insertDb(name,passwd)
```

接下来我会抽时间写一个一键安装脚本，到时候放到 `github` 上面，给大家使用。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

