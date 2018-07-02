# Python 打造自己的图床升级篇 - PIL 为图片添加水印

在前文 [《利用 github 和 python3 以及 MWeb 打造自己的博文图床》](https://blog.csdn.net/fungleo/article/details/80706829) 一文中，我们实现了图床功能。在使用的这段时间里面，感觉相当良好，运行也十分稳定。

但是，我没有实现给图片添加水印的功能，略有遗憾。今日，简单看了一下 PIL 的库，实现了水印功能，特与各位看官分享。

## 分析情况

![](https://raw.githubusercontent.com/fengcms/articles/master/image/e2/d54c585d167322542d76cb05b88f35.jpg)

> 上图中的水印，就是自动加上的，感觉还可以哈。

如上图中所示，我们直接将读取到的二进制文件，直接存储到了硬盘中。而我们要给图片添加水印，则就是在这里进行处理。

首先，我们需要判断图片是否为 `jpg` 图片，非 `jpg` 图片我不准备做添加水印的处理，否则，可能会写坏掉一些 `gif` 的动图。`png` 图片在我的博文中使用得也比较少，所以不做处理了。

然后就是，一些过分小的图片，就不要添加水印了，否则有碍图片的观瞻。

另外，还有一个问题是， `PIL` 的 `Image.open()` 函数，接收的是一个图片的地址，而我这边是已经拿到了图片的二进制，并且存在了内存中。我一开始想，莫非需要我先保存到硬盘，然后读取到 `PIL` 中，进行水印处理，然后再一次写入硬盘。

但是，我个人认为这个逻辑虽然说不是不可以，但是在我看来比较蠢。我希望在内存中直接解决，然后一次性存储到硬盘，因此，我找到了 `BytesIO` 这个可爱的方法。

## 最终代码

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
from sanic import Sanic
from sanic.response import json, text, file
import os, sys
import hashlib
from PIL import Image
from io import BytesIO

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
    print(hexStr)
    SUPPORT_TYPE = {
            'ffd8ffe':'jpg',
            '89504e470d0a1a0a0000':'png',
            '474946383961':'gif',
        }
    for i in SUPPORT_TYPE:
        if i in hexStr:
            return SUPPORT_TYPE[i]
    return 'error type'

def saveImage(savePath, image):
    tempFile = open(savePath, 'wb')
    tempFile.write(image)
    tempFile.close()

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

    # 如果是 jpg 图片，则添加水印
    if imageSuffix == 'jpg':
        bImg = BytesIO(image)
        img = Image.open(bImg)
        imgW = img.size[0]
        imgH = img.size[1]

        if imgW >= 300 and imgH >= 100:
            mark = Image.open("mark.png")
            layer = Image.new('RGBA', img.size, (0,0,0,0))
            layer.paste(mark, (imgW - 180, imgH - 60))
            out = Image.composite(layer, img, layer)
            out.save(savePath, 'JPEG', quality = 100)
        else:
            saveImage(savePath, image)

    # 否则直接将文件写入到硬盘
    else:
        saveImage(savePath, image)

    # 给客户端返回结果
    return ok({"path": resPath})

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=7000)
```


因为需要经过两次判断，`else` 时都是直接写入硬盘，因此，将原来的写入硬盘的方法直接封装为一个函数。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/31/20aa8f721db9160b23be6e5f0564d4.jpg)

> 如上，当图片尺寸小于 `300*100` 的时候，就不添加水印了。

关键是，直接保存图片的话，图片的存储质量并不是很好，因此，我加上了指定质量为 `100`。

更多 `PIL` 内容，请阅读官方文档：http://pillow.readthedocs.io/en/latest/

嗯，现在看来，我的这个图床就已经很完美了。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


