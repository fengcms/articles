# python 常用代码段汇总 动态模块加载 动态类或函数加载 RAS加密解密……

最近一直在写一套基于 `python` 的 `sanic` `web` 框架库的 `restFul` 接口的底层框架。由于我是初学，挑战这个任务基本上是属于不自量力型的。但目前我核心构架已经完全写出来了，我会在近期整理好相关资料后，写一系列的文章分享给大家。

这个挑战的过程很简单，因为大家知道我只是一个前端工程师。但是挑战的过程充满乐趣，今天，我就将我遇到的一些小的知识点，做一个汇总，也方便以后自己查找和复习。

## 判断数据类型

对于入参，我们经常需要判断数据类型，一般，我们的用法是 `type()` 方法。如下代码演示：

```python
type(__SOME_PARAME_) == str
```

但是我查阅相关的资料，更加推荐使用 `isinstance` 函数来进行判断，理由如下：

> isinstance() 与 type() 区别：
> 1. type() 不会认为子类是一种父类类型，不考虑继承关系。
> 2. isinstance() 会认为子类是一种父类类型，考虑继承关系。
> 如果要判断两个类型是否相同推荐使用 isinstance()。

我是不太明白这个意思，只是学会了它的用法如下：

```python
isinstance(1, int)
isinstance([1,2], list)
```

执行结果如下：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/38/53536f5eb813b4255587ed3767f3fc.jpg)

可以用来判断任何已知类型。

## 判断“字符串或数字”是否是整数（包括负数）

首先，判断一个字符串是否是正整数，我们会想到 `str.isdigit()` 方法。但如果输入的数字，则会报错，因为数字并不支持该方法。此外，它也不支持负数。很显然，这并不符合我的要求。

我的最终代码是：

```python
def isInt(num):
    try:
        num = int(str(num))
        return isinstance(num, int)
    except:
        return False
```

运行结果如下：

![判断“字符串或数字”是否是整数（包括负数）](https://raw.githubusercontent.com/fengcms/articles/master/image/33/d95d4b0bf8ba26ae52f0793fed8525.jpg)

无论是数字还是数字字符串，都能被 `int` 执行，并且包含负数。但是，浮点型数字能被 `int` 正确执行，而浮点型数字字符串缺不行。因此，我先将输入参数转化成字符串型，就可以避免这个小坑了。

唯一的问题是，如果是其他内容，则会出现报错。因此，这里使用了 `try` 方法来执行这段代码，报错直接返回 `False` 。

## 将下划线命名字符串修改为大驼峰命名字符串

思路，首先，将入参字符串转小写，然后用下划线分割成列表数据，过滤空后，将每段的字符串的首字母转大写，其余继续原样拼装后，组成一个大字符串就是结果。

代码如下：


```python
def str2Hump(text):
    arr = filter(None, text.lower().split('_'))
    res = ''
    for i in arr:
        res =  res + i[0].upper() + i[1:]
    return res
```

运行结果如下：

![将下划线命名字符串修改为大驼峰命名字符串](https://raw.githubusercontent.com/fengcms/articles/master/image/d2/ac31a7af0cd6328f6f917a6e630a3c.jpg)

如果要实现小驼峰，也是非常简单的。第一组不转换直接拼装就可以了。

## 计算字符串或二进制内容 md5 值

我们用 `hashlib` 库来实现对一个参数的 `md5` 值的计算。特殊的是，字符串需要申明编码。因此，我写了一个方法连兼容这两个场景：

```python
import hashlib
def getMd5(source):
    if isinstance(source, str):
        source = source.encode('utf-8')
    m1 = hashlib.md5()
    m1.update(source)
    res = m1.hexdigest()
    return res
```

因为需要计算的地方入参有限，所以没有做更多细致的考量。

## url query 参数转字典型数据

我们经常使用 `url` 来传一些参数，`query` 参数的典型格式是：`page=0&pagesize=10&sort=-channel_id%2Cid` 这样的。其中，包含中文和一些其他字符在内的，都会转码。因此，我们需要先解码，然后再进行转换。

此外，参数并不会每一次都在，因此又可能是传进来空字符串的情况，因此，还需要特殊处理。

我的代码是：

```python
from urllib.parse import unquote
def query2Dict(text):
    try:
        text = unquote(text)
        obj = dict([i.split('=') for i in text.split('&')])
        return obj
    except Exception as e:
        return {}
```

原理非常简单，先用 `&` 进行分割成一维数组，然后数组的每一段都用 `=` 号分割，形成一个二维数组，最后将这个规律的二维数组利用 `dict` 方法转化成字典型数据即可。

如果传入的参数不是 `query` 数据，或者为空，则会解析失败，返回一个空的字典。

![url query 参数转字典型数据](https://raw.githubusercontent.com/fengcms/articles/master/image/a8/218a41e22ac77717a5e0c7cff1de59.jpg)

如上效果所示。

`sanic` 框架有自己的 `query` 参数获取方法，`request.args` 方法就是用来取这个参数的。但是经过对比，还是我的方法比较靠谱。如果你自己在使用 `sanic` 框架，可以对比一下。

## Python RSA 加密以及解密

非对称加密是目前比较常用的一种加密类型。`RSA` 是一种非常常用的非对称加密方法。其使用公钥加密，然后用私钥解密。这是非常安全的。

我们先将公钥和私钥存储为文本文件，放在项目中，然后我写了下面两个方法分别来实现加密和解密

```python
from Crypto.PublicKey import RSA
from Crypto.Cipher import PKCS1_v1_5 as CPK
import base64
# 加密方法
def rsaEncrypt(keypath, string):
    with open(keypath, 'r') as f:
        pubkey = f.read()
        rsaKey = RSA.importKey(pubkey)
        cipher = CPK.new(rsaKey)
        res = base64.b64encode(cipher.encrypt(string.encode(encoding="utf-8")))
        return res.decode(encoding = 'utf-8')
# 解密方法
def rsaDecrypt(keypath, enCode):
    with open(keypath, 'r') as f:
        prikey = f.read()
        rsaKey = RSA.importKey(prikey)
        cipher = CPK.new(rsaKey)
        res = cipher.decrypt(base64.b64decode(enCode), "ERROR")
        return res.decode(encoding = 'utf-8')
```

然后在需要使用的地方传入公钥或者私钥的文件地址，以及要加密或者解密的字符串，就能返回相应的结果了。

## 根据字典键名查看键值不会报错的方法

一般情况下，我们会用类似 `someDict['keyName']` 的方法，来获取键值内容。但是，如果这个键名不存在的话，就会报错。所以，在不确定的地方，推荐使用 `get` 方法来进行获取。就像 `someDict.get('keyName')` 这样。

实际运行效果如下：

![根据字典键名查看键值不会报错的方法](https://raw.githubusercontent.com/fengcms/articles/master/image/38/a1efbebaf0797aa3dc18c1ae4bf422.jpg)

如上图所示，这样取是不会报错的，只是没有返回而已。

## 根据字符串动态获取或执行类或函数

例如，我们在 `model.py` 这个文件中，有一个 `class Test` 的一个类。我们当然可以使用 `from model import Test` 这样的代码来进行引入。

但是问题是，如果你这个 `Test` 是通过程序动态计算出来的，你根本就不知道这个字符串具体是什么，改怎么办呢？

其实，解决方法非常简单，演示代码如下：

```python
import model
classModel = getattr(model, 'Test')
```

这样，我们就拿到了这个 `Test` 的类了。并赋予了变量 `classModel` ，我们可以用这个变量去做应该做的事情了。

上面是演示了类根据字符串名称引入的方法。事实上，如果是 `def` 函数，也同样是可以用 `getattr` 函数引用。

因为这样的参数，让我们可以写出来非常灵活的代码。

## pkgutil 动态引入模块

引入模块的方法非常简单，只要 `import os` 这样就可以引入了。但是，和上面一样，你会在一个文件夹中写越来越多的功能各异的业务代码，然后交给程序统一处理，这里，就需要动态引入了。

这里，我们使用 `pkgutil` 来实现这个功能，演示代码如下：

```python
import pkgutil
# 引入存放未知模块的目录名称
import process
modules = {}
for _, name, __ pkgutil.iter_modules(process.__path__):
    m = _.find_module('process.' + name).load_module('process.' + name)
    modules[name] = m
```

然后，我们就可以用 `modules[name]` 来使用这个未知模块了。

其实 `process.__path__` 就是一个文件夹路径的列表而已，并且，它还支持相对路径，所以上面的代码可以优化为如下代码：

```python
import pkgutil

r = 'process'
modules = {}
for _, name, __ pkgutil.iter_modules([r]):
    m = _.find_module(r + '.' + name).load_module(r + '.' + name)
    modules[name] = m
```

好，连事先引入文件夹都省了。但上面的代码，是单层目录，如果是多层目录应该怎么办呢？那就这样写：

```python
import pkgutil
r = 'process'
modules = {}
for x, n, _ in pkgutil.iter_modules([r]):
    m = x.find_module(r + '.' + n).load_module(r + '.' + n)
    for xx, nn, __ in pkgutil.iter_modules([r + '/' + n]):
        mm = xx.find_module(r + '.' + n + '.' + nn).\
                load_module(r + '.' + n + '.' + nn)
        for xxx, nnn, ___ in pkgutil.iter_modules([r + '/' + n + '/' + nn]):
            mmm = xxx.find_module(r + '.' + n + '.' + nn + '.' + nnn).\
                    load_module(r + '.' + n + '.' + nn + '.' + nnn)
            modules[n+nn+nnn] = mmm
```

我写的代码中，用到了一个三层的未知模块引入，所以，我写了上面这段代码。我表示呵呵~

> 每一个文件夹中，都必须包含 `__init__` 文件，否则文件夹不会被自动识别为模块。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

