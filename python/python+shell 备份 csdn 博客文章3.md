# python+shell 备份 csdn 博客文章3 备份图片

前面，我们将所有的博客文章全部备份下来了。但是，博客当中的那些图片，还是散落在各处。有的在第三方的网站上，有的在 CSDN 的服务器上，有的直接引用的其他地方的图片。

前几天，我写了一篇博文[《利用 github 和 python3 以及 MWeb 打造自己的博文图床》](https://blog.csdn.net/fungleo/article/details/80706829)，搞了一个自己的本地图床服务，然后将所有图片推送到 `github` 服务上，利用 `github` 的 `raw` 地址，就搞到了一个不限量的好图床。

依然如此，那就折腾一下，将我所有博文中的图片，全部上传到那里去，并且将文章中的所有的图片地址，全部换成 `github` 的地址。

说干就干，首先想思路：

## 备份图片的整体思路

1. 通过循环每一个博客文章文档的每一行内容，查找所有的图片路径，并保存为字典。
2. 用 `shell` 循环这个字典下载所有的图片文件
3. 再写一个脚本，循环所有的图片文件，全部 `post` 到我的图床服务
    并且，将图片文件名，和返回的文件名，生成字典，用于下一步的操作。
4. 再一次循环博客文章的每一行内容，通过上一步匹配的字典，将原有的图片路径替换为更新后的路径。

任何一个复杂的问题，我们认真分析后都能够解决。

## 查找所有图片路径脚本

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
import linecache
import requests as req
from io import BytesIO
import json
import os

def saveImg (mdFile):
    print(mdFile)
    with open(mdFile, 'r', encoding="utf-8") as mdTxt:
        for line in mdTxt:
            if '![' in line and '](' in line:
                imgUrl = line.split('(')[1].split(')')[0]
                print('\t' + imgUrl)
                os.system('echo "' + imgUrl + '" >> imgUrl.txt')

def findMdFile ():
    sdir = './markdown/'
    res = []
    for f in os.listdir(sdir):
        fp = os.path.join(sdir, f)
        if '.md' in fp:
            res.append(fp)

    for i in res:
        saveImg(i)

findMdFile()
```

好，通过这个脚本，我们就把所有的图片路径，全部保存在了 `imgUrl.txt` 这个文本文件里面了。

## 下载所有的图片

本来尝试用 `python` 下载的，但是总是403，遂作罢。

建立一个专门存放图片的 `img` 文件夹，然后新建一个脚本文件，输入以下内容：

```shell
for i in $(cat ../imgUrl.txt); do
  curl -O $i;
  sleep 1;
done
```

运行，经过十几分钟的等待，所有的图片都已经下载好了。

具体多长时间，要看你博文的图片数量。

## 将图片上传到我的图床服务

> 这里我是用我自己的解决方案，如果你是使用第三方的图床，可以简单修改下面的脚本就可以实现你的需要。

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
import os
import imghdr
import requests as req
import json


# 在源目录中找到所有图片并输出为数组
def findImg(sdir):
    res = []
    for f in os.listdir(sdir):
        fp = os.path.join(sdir, f)
        if not os.path.isdir(fp):
            if imghdr.what(fp):
                res.append(fp)
    return res

def upImg ():
    imgs = findImg('./img/')
    for i in imgs:
        files = {'file': ('imgName', open(i, 'rb'), 'image/jpeg')}
        r = req.post('http://localhost:7000/upimg', files=files)
        rJson = json.loads(r.text)
        if rJson['status'] == 0:
            rPath = rJson['data']['path']
            os.system('echo "' + i + '\t' + rPath + '" >> imgDict.txt')
            print('Succ: ' + i + ' | ' + rPath)
        else:
            os.system('echo "' + i + '" >> imgErr.txt')
            print('upErr: ' + i)
        print(i)

upImg()
```

通过这个脚本，我们将所有的图片，全部上传到了我的图床服务里面了。并且，返回了一个 `imgDict.txt` 的字典文件，里面对比新老图片地址。

## 替换所有博文中的老图片地址为新图片地址

写上面的脚本的时候，输出的字典是一个用制表符分割的字典。为了方便使用，我批量改成了数组包含元组的格式。然后重命名为 `imgDict.py` 方便在下面的脚本使用。

> 字典格式为 `DICT = [('oldName', 'newPath'), ('oldName', 'newPath')]`

![](https://raw.githubusercontent.com/fengcms/articles/master/image/a3/748c0a09b7487ee3947e62da3c886b.jpg)

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
import linecache
import requests as req
from io import BytesIO
import json
import os
import imgDict

imgFix = 'https://raw.githubusercontent.com/fengcms/articles/master/image'

DICT = imgDict.DICT


def writeFile (i, line, tarFile):
    if i == 0:
        with open(tarFile, 'w+') as f:
            f.write(line)
            f.close()
    else:
        with open(tarFile, 'a') as f:
            f.write(line)
            f.close()

def reImg (line):
    if '![' in line and '](' in line:
        for i in DICT:
            if i[0] in line:
                return '![](' + imgFix + i[1] + ')'
    return line

def saveImg (mdFile):
    mdName = mdFile.replace('markdown/', '').replace('/', ':')
    print(mdName)
    souFile = open('markdown/' + mdName, 'r', encoding="utf-8")
    tarFile = './calcMarkdown/' + mdName
    with souFile as mdTxt:
        i = 0
        for line in mdTxt:
            writeFile(i, reImg(line), tarFile)
            i += 1

def findMdFile ():
    sdir = 'markdown/'
    res = []
    for f in os.listdir(sdir):
        fp = os.path.join(sdir, f)
        if '.md' in fp:
            res.append(fp)

    for i in res:
        saveImg(i)

findMdFile()
```

好，通过上面的脚本，我顺利的将所有博客文章中的图片路径全部替换为新的图片路径，并保存到了 `calcMarkdown` 目录下面。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/d4/e141832c15be2a22a06431ae7c4343.jpg)

> shell 学得不好，不过我感觉，最后一步用 python 还是代码量太多了，换成 shell 可能三两行就好了。不过目的已经达到，懒得接着研究了。

其实对于看官来说，重点不在于我做了写什么，而是这些代码都是比较基础的 `python` 代码，希望对于看官能有所帮助。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

