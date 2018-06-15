# Python3 初学实践案例（14）打造一个私人图床服务器

近来工作压力颇大，一直都在从事项目的开发工作，所以自学 `python` 的进度也拉下来一截，哎。由于进来很多项目用 `react` 编写，所以准备些一些相关的博客文章。但是博客的图片管理颇让人烦恼。之前尝试过把新浪微博当成图床，但是上传的稳定性一直是一个问题。使用 csdn 的博客图片上传功能吧，一直也比较不方便。因此，昨天突发奇想，决定写一个私人的图床服务器，放在我自己的服务器上。

## 需求分析

要干什么，首先要明确，到底要TM干什么。列出需求如下：

1. 这是一个图片上传服务，需要随时接收我的图片文件。
2. 只能接收我上传文件，因此需要认证机制。
3. 只能在我允许的站点显示图片，其他站点都应该是无权访问，所谓防盗链机制。
4. 图片不允许重复上传，毕竟硬盘不大。
5. 因为只是自己使用，所以文件校验和图片大小校验等，可以放松。

综上，是我的需求。将他们详细分析一下，得到：

1. 我需要一个 `http` 的接口服务，为 `Post` 接口，用来接受我的图片上传请求。
2. 图片不校验大小，采用 `nginx` 的默认配置，图片文件格式校验采用后缀名。
3. 该接口必须使用密钥验证，没有密钥的人无法访问。嗯，随机一个加密字符串就可以。
4. 图片命名采用 `md5` 的方式，我不能保证自己不上传重复文件，但要保证服务器不会重复浪费磁盘空间。
5. 因为要防盗链，虽然可以使用 `nginx` 来进行配置，但是，还是在 `python` 中实现比较好。
6. 所以需要一个 `get` 接口，通过接口判断是否具有权限，返回不同图片。

## 开发图床

### 技术选型

首先，是使用 `python3.6` 为开发语言，这个是确定了的。但是如何开发这个，我花了5分钟考虑了一下。第一种呢，是全部自己实现。也不是不可以，但是我感觉耗费的时间有点不值当子。第二种呢，是使用公司目前采用的自研开发框架，这个是最顺手的，但问题是，我就是干这么个小活儿，不至于杀鸡用牛刀。嗯，那就采用第三方的框架，并迅速的锁定了 `sanic` 框架。

`sanic` 是一个比较新的，但是发展比较快的框架。其特征是速度非常快。据他们官方网站自己说，`sanic` 是最快的 `python` 框架。

>`sanic` 官方文档地址：http://sanic.readthedocs.io/en/latest/

开干。

### 最终代码

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
from sanic import Sanic
from sanic.response import json, text, file
import os, sys
import hashlib
import base64

app = Sanic()
# 图片存储目录
baseDir = sys.path[0] + '/image/'
# 校验 Token 写死就成，反正自己用的嘛
token = 'SheIsABeautifulGirl'
# 允许的域名列表
allowHost = [
            'localhost',
            'ilovethisword',
            'i.fengcss.com',
            'blog.csdn.net'
        ]

# 成功返回方法
def ok(data):
    if type(data) == list:
        return json({"data": {"list": data}, "status": 0})
    else:
        return json({"data": data, "status": 0})
# 失败返回方法
def fail(data):
    return json({"data": data, "status": 1})

# 获取图片后缀名
def getSuffix(filename):
    tempArr = filename.split('.')
    suffix = tempArr[-1]
    fileType = ['jpg', 'jpeg', 'gif', 'png']
    if len(tempArr) < 2:
        return 'error name'
    elif suffix not in fileType:
        return 'error type'
    else:
        return suffix
# 检查请求地址是否授权
def checkHost(host):
    for i in allowHost:
        if i in host:
            return True
    return False

# 上传图片文件接口
@app.route('/api/v1/upimg', methods=['POST'])
async def upimg(request):
    # 判断用户是否具有上传权限
    if request.headers.get('token') != token:
        return fail('您没有使用本服务的权限')
    image = request.files.get('file').body
    # 判断文件是否支持
    imageName = request.files.get('file').name
    imageSuffix = getSuffix(imageName)
    if 'error' in imageSuffix:
        return fail(imageSuffix)
    # 组织图片存储路径
    m1 = hashlib.md5()
    m1.update(image)
    md5Name = m1.hexdigest()
    
    # 用 md5 的前两位来建文件夹，防止单个文件夹下图片过多，又或者根目录下建立太多的文件夹
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

# 请求图片接口
@app.route('/', methods=['GET'])
async def img(request):
    # 判断是否为网站请求，否则就加上自定义的字符串（允许本地访问）
    host = request.headers.get('referer') or 'ilovethisword'
    # 判断请求接口是否带参数，否则加上自定义字符串（没有这个文件夹，返回404）
    args = request.args.get('path') or 'ilovemywife'
    # 拼接文件地址
    path = baseDir + args
    # 如果不在允许列表，则展示 401 图片
    if not checkHost(host):
        path = baseDir + '/7b/e49a54f761da42174d6121fa13e0b3.png'
    # 如果文件不存在，则展示 404 图片
    if not os.path.exists(path):
        path = baseDir + '/b4/74335c3944f42275e3caa13930a9b9.png'
    # 返回文件
    return await file(path)
# 启动服务
if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8000)
```

## 部署图床

程序开发完成后，通过本地测试，确定没啥问题，决定上生产环境。（就是放到我的小破驴上去）

`centos 7` 系统 `yum` 源中 `python` 最高版本为 3.4 ，嗯，安装一下。不详述了，详情请查看[How to Install Python 3.6.4 on CentOS 7](https://www.rosehosting.com/blog/how-to-install-python-3-6-4-on-centos-7/)

搞好环境之后，先找个地方把文件村上。这里我的存储位置是 `/srv/py-tuchuang/run.py`

### 配置 python 服务

首先，我们使用 `chmod +x /srv/py-tuchuang/run.py` 命令，让程序具有执行权限。

然后，我们用 `vim /usr/lib/systemd/system/py-tuchuang.service` 命令创建一个程序文件，然后输入以下内容

```shell
[Unit]
Description=Python image upload and download Service
After=network.target
Wants=network.target

[Service]
Type=simple
# 用户要配置有文件读写权限的，实在不行就root
User=root
Group=root
# 重要的就是下面的这句话
ExecStart=/srv/py-tuchuang/run.py

[Install]
WantedBy=multi-user.target
```

保存退出之后，我们使用下面的命令，分别设置立即启动和开机启动

```shell
# 启动服务
systemctl start py-tuchuang.service
# 将服务设置为开机启动
systemctl enable py-tuchuang.service
```

好，以上，我们的服务就已经配置好了。但是，我们程序中设定我们的服务是跑在 `127.0.0.1` 这个 `ip` 上的。所以，他只能跑在本地，你不能访问到，所以，我们需要一层代理。

### 配置 nginx 代理

`nginx` 是我服务器上现成的，毕竟服务器不是为了专门干这么一件破事儿嘛。

`vim /etc/nginx/nginx.conf` 编辑配置文件，在合适位置添加如下内容

```shell
server {
  server_name __YOU_DOMAIN_IN_HERE__;
  location / {
    proxy_pass  http://127.0.0.1:8000;
  }
}
```

然后保存退出，重启 `nginx` 服务。然后就可以啦。

## 使用图床

图床已经搭建好了，我们如何使用呢？方法有很多哦！

### 命令行上传图片

其实非常简单，我们在命令行中输入以下命令就可以上传文件了。

```shell
curl http://__YOU_DOMAIN_IN_HERE__/api/v1/upimg -F "file=@__UPFILE__PATH__" -H "token: SheIsABeautifulGirl" -v
```

将上面的 `__YOU_DOMAIN_IN_HERE__` 替换为你的服务域名， `__UPFILE__PATH__` 修改为你要上传的文件路径，然后，就可以上传文件啦~

再写一个脚本，完全可以啦。不过还是破烦。

### 自己写一个前端页面，专门用来上传

...省略

> 用 `jquery` 或者 `vue` 或者其他什么，写一个上传文件的前端脚本还是不难的，不过不在本文讨论范围之内。

### 配置 MWeb 编辑器图床

如下图配置 MWeb 编辑器，然后在里面写文章的时候，就太TM方便啦。随便一个屏幕截图，也不需要保存，直接到编辑器中粘贴，就会自动上传，并获取地址，变成 markdown 代码存好。

![20180614104107](https://raw.githubusercontent.com/fengcms/articles/master/image/7f/bd8f43f8166b9b14f3e024996ffa4d.png)

本地图片也是非常方便，直接往编辑器中一拖动，就可以了。

好，这就是本人自己搞一个私人图床服务器的全部过程，希望对大家有所帮助。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


