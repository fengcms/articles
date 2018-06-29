title: Python3 初学实践案例（10）对象转字典 object to dict
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -python
    -对象
    -字典
    -dict
    -object
---

# Python3 初学实践案例（10）对象转字典 object to dict

我在写代码的时候遇到一个问题，就是 `sqlalchemy` 从数据库中查的的结果是一个对象，我虽然可以直接把这个对象用 `x.id` 的方式取出来内容，但是总是感觉不爽，我希望可以更好的处理这个对象。但是打印出来的结果一直是 `<__main__.Passwd object at 0x10ea50cc0>` 这样的东西。

通过查看文档，我找到了一个函数 `vars(obj)` 。这个函数可以把对象转换成字典。文档地址：https://docs.python.org/3/library/functions.html?highlight=vars#vars

但是输出的结果是这样的：

```python
{'_sa_instance_state': <sqlalchemy.orm.state.InstanceState object at 0x10e773cf8>, 'name': 'sunmingyuan', 'id': 2, 'password': '/t22664Q44', 'time': datetime.datetime(2017, 12, 20, 5, 11, 22)}
```

虽然这个结果已经可以让我使用了，但是感觉还是怪怪的对么。所以，我接着搜索，终于找到了一个手写的函数，可以很好的处理这个问题：

```python
def row2dict(row):
    d = {}
    for column in row.__table__.columns:
        d[column.name] = str(getattr(row, column.name))

    return d
```

用这个函数处理的结果就非常优雅了。

```python
{'id': '17', 'name': 'love', 'password': 'xxxxx', 'time': '2017-12-22 05:08:27'}
```

参考地址：https://stackoverflow.com/questions/1958219/convert-sqlalchemy-row-object-to-python-dict

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

