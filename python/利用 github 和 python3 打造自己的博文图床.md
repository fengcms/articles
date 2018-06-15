# 利用 github 和 python3 以及 MWeb 打造自己的博文图床

这两天一直在纠结图床的问题，因为用自己的服务器来做图床这个事情我考虑再三，觉得比较不靠谱-_-|||，因为我的服务器只是一个小小的低配服务器，用来当自己的博客图床本来这个问题不大，但是我的博文基本都是在 `csdn` 上，流量还是颇为可观的。把自己的服务器给搞垮了，那可是吃不消的一件事情。

虽然之前考虑过用 `github` 来做自己的图床，但是考虑两个问题，一个是国内访问速度较慢，另一个则是 `github` 作为全球最大的同性交流平台，我不忍心把它当成一个图床来使用。

不过这不是最近被微软收购了么，微软这么财大气粗的，应该不在乎我把它当成图床了吧。

说干就干，还是先厘清思路。

## 厘清把 github 当图床的思路

1. 在 `github` 新建一个项目，存放图片，以及自己的博文。
2. 本地搞一个 `python3` 的服务，将图片用规律存储到本地。
3. `MWeb` 的相关想法。
    1. 将图片全部存放在本地，和自己的博文存放在一起。
    2. 用 `MWeb` 写博文的时候，图片用其自带的图床管理 `api` 将图片存放到本机目录。
    3. 由于 `github` 的图片路径是有规律的，所以计算出来最终路径，直接保存到博文当中。
4. 用 `git` 将文章和图片全部推到仓库，然后就啥都可以了。

## python 脚本撰写以及启动

在上一篇博文[《打造一个私人图床服务器》](https://blog.csdn.net/fungleo/article/details/80690367)中，我们已经完成了一个图床的脚本，这里只要适当修改就可以了。其实就是删除一些代码就可以了。

### main_upimg.py 主程序代码

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
from sanic import Sanic
from sanic.response import json, text, file
import os, sys
import hashlib

app = Sanic()
baseDir = '/Users/fungleo/Documents/Blog/articles/image/'

# 成功以及失败的返回脚本
def ok(data):
    return json({"data": data, "status": 0})

def fail(data):
    return json({"data": data, "status": 1})

# 字节码转16进制字符串
def bytes2hex(bytes):
    hexstr = u""
    for i in range(10):
        t = u"%x" % bytes[i]
        if len(t) % 2:
            hexstr += u"0"
        hexstr += t
    return hexstr.lower()

# 根据16进制字符串获取文件后缀
def getSuffix(hexStr):
    SUPPORT_TYPE = {
            'ffd8ffe000104a464946':'jpg',
            '89504e470d0a1a0a0000':'png',
            '47494638396126026f01':'gif',
        }
    for i in SUPPORT_TYPE:
        if i == hexStr:
            return SUPPORT_TYPE[i]
    return 'error type'

# 上传文件接口
@app.route('/upimg', methods=['POST'])
async def upimg(request):

    # 判断参数是否正确
    if not request.files and not request.files.get('file'):
        return fail('error args')
    image = request.files.get('file').body

    # 判断文件是否支持
    imageSuffix = getSuffix(bytes2hex(image))
    if 'error' in imageSuffix:
        return fail(imageSuffix)

    # 组织图片存储路径
    m1 = hashlib.md5()
    m1.update(image)
    md5Name = m1.hexdigest()

    saveDir = baseDir + md5Name[0:2] + '/'
    savePath = saveDir + md5Name[2:] + '.' + imageSuffix
    resPath = '/' + md5Name[0:2] + '/' + md5Name[2:] + '.' + imageSuffix

    # 如果文件夹不存在，就创建文件夹
    if not os.path.exists(saveDir):
        os.makedirs(saveDir)

    # 将文件写入到硬盘
    tempFile = open(savePath, 'wb')
    tempFile.write(image)
    tempFile.close()

    # 给客户端返回结果
    return ok({"path": resPath})

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=7000)
```

在上一篇博文当中，我使用了读取文件的后缀名来判断文件的类型，这是非常简陋的。例如，我使用屏幕截图保存到剪切板，然后在编辑器中粘贴，这时候就是没有文件的名字的，这就会出现问题。另外，使用后缀名这种方法也是略显小儿科，因此，我这边改成了读取二进制文件的头部字节，并转成16进制，然后辨别图片类型。这样就可靠多了。

另外这里，我们还可以对图片进行缩放，以及添加水印等操作，今天我就不写了，大家感兴趣，回头可以查看我的 `github` 仓库 https://github.com/fengcms/python-learn-demo/tree/master/img-github ，我写了之后会更新进去的。

### MAC\Linux 设置 python 脚本开机启动

脚本写好之后，测试一下，没有问题，我们就可以将服务启动起来了。

我们可以使用 `python3 main_upimg.py` 启动脚本，但是这回打开一个终端窗口，我希望的是，可以在笔记本开机的时候，就把这个脚本启动起来，然后我随时想写脚本，这个服务就在默默的为我提供服务。

想想都感人。

我们可以使用 `nohup command &` 这样的命令，来让服务默默的跑起来，因此，我们的这个命令就是

```shell
nohup python3 main_upimg.py &
```

但是，这样还是需要我们启动电脑之后执行一下，这个事情对于我这种人来说，是不能接受的。所以，我要把它写成一个开机启动的脚本。

创建 `run.sh` 文件，并输入以下内容，因为不在当前文件夹下运行，所以要加上脚本的全部路径，如果你也想和我一样做的话，请把路径修改为你的路径。

> linux\mac 下面，可以用 `pwd` 命令来查看当前文件夹的完整路径

```shell
#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
nohup python3 /Users/fungleo/Sites/python/github/img-github/main_upimg.py &
```

新建好文件之后，我们使用 `chmod +x run.sh` 将其赋予执行权限，然后把它添加到开机运行。

开机运行设置，请查看 [mac设置shell脚本开机自启动](https://www.cnblogs.com/dongfangzan/p/5976791.html)，我这里就不做赘述了。

#### 杀死服务进程

经过上面的配置，我们的脚本就已经非常安静的在那里等着我们随时调用了，呼之即来，非常爽快。

但是，我们如何招之即去呢？其实非常简单，我们用 `ps` 这个显示当前系统的进程状态，以及配合 `kill` 命令，则可以很好的管理我们的进程了。

```shell
# 查看当前进程
ps | grep main_upimg.py
# 通过上面的命令，我们可以看到我们的进程号，然后用下面的命令，结束它。
kill -9 进程号
```

## 配置 MWeb 编辑器

通过上面的一系列折腾之后，我们的图床服务就算是搞好了，下面我们要来配置我们的编辑器，通过编辑器的配置，我们可以很方便的使用我们的图床。

![配置 MWeb 编辑器](https://raw.githubusercontent.com/fengcms/articles/master/image/08/bc6a7c69afc6ed4bc453b51043c653.jpg)

如上配置，主要是图片的前缀为 `https://raw.githubusercontent.com/fengcms/articles/master/image/` 这个地址。其他的都不是特别重要。

我一直使用 `MWeb` 编辑器来撰写博客，不太清楚其他的 `markdown` 编辑器。不过我想高级一点的编辑器都应该支持这个功能才对。大家参考使用吧。

最后就是，写好了博客之后，用 `git` 把内容以及图片全部更新到仓库中，所有的图片就全部生效了。之后，爱把博文转发到哪里去，就发到哪里去，应该没有任何问题。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

