# python+shell 备份 csdn 博客文章2 优化版

在上一篇博文中[《python+shell 备份 csdn 博客文章》](https://blog.csdn.net/fungleo/article/details/80854002)，我们顺利的备份了所有的博客文章。但是，我缺遗漏了一个非常重要的信息，那就是博文更新的日期。原因是，CSDN 提供的接口中并没有保存这个数据。


所以，我需要拿到这个数据。还是按照之前的思路，从我的博客首页去爬取。

> 这篇博文不在赘述整个思路了，思路可以去上一篇博文去看。

## 优化获取 ID PYTHON 脚本

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
import  urllib.request
from bs4 import BeautifulSoup
import os

def getid (x):
    url = r'https://blog.csdn.net/fungleo/article/list/'+str(x)
    res = urllib.request.urlopen(url)
    html = res.read().decode('utf-8')
    soup = BeautifulSoup(html,'html.parser')
    links = soup.find_all('div', 'article-item-box')

    for i in links:
        idStr = i['data-articleid']
        timeStr = i.find_all('span', 'date')[0].string
        outStr = '("' + idStr + '", "' + timeStr + '"),\n'
        with open('idtime.txt', 'a+') as f:
            f.write(outStr)
            f.close()

def do ():
    for i in range(14):
        getid(i)

do()
```

这里，我们将文章的 ID 和日期，组成一个元组，用逗号分隔。然后我们可以手工加上一个方括号，组成一个由元组构成的数组，方便我们后面使用。

## 下载 JSON 文件

由于我已经下载过 `json` 文件，这里无需重复下载。看官可以去上一篇博文查看如何下载 `json` 文件。


不过由于我们的 `idtime.txt` 文件中，不仅仅是包含 ID 还包含时间，所以，上一篇博文的脚本需要调整一下：

```shell
for i in $(cat idtime.txt | cut -f 2 -d '"'); do sh t.sh $i > $i.json; sleep 1; done
```

主要的调整，就是用 `cut` 工具，将 ID 给提取出来而已。

下载好所有的 `json` 文件后，创建一个 `json` 文件夹，然后把这些文件全部给放进去。


## 优化 JSON 转 MARKDOWN 脚本

首先，我们手工修改一下 `idtime.txt` 文件，整体缩进一格，修改为如下格式

```python
TIME = [
    #__第二行开始为原有内容，并缩进一行__
]
```

然后将文件重命名为 `timeid.py`

好，然后就是下面的脚本。

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
import os
import json
import timeid

sourceDir = './json'

def getDate(name):
    for i in timeid.TIME:
        if i[0] in name:
            return i[1]
    return '2018-06-29 00:00:00'
def readJson (filPath):
    f = open(filPath, encoding='utf-8')
    data = json.load(f)

    date = getDate(f.name)
    title = data['data']['title']
    saveTitle = title.replace('/', ':')
    content = data['data']['markdowncontent']
    tags = data['data']['tags'].split(',')

    if content:
        mdFile = open('''./markdown/{title}.md'''.format(title=saveTitle), 'a+')
        mdFile.write('title: ' + title + '\n')
        mdFile.write('date: ' + date + ' +0800\n')
        mdFile.write('update: ' + date + ' +0800\n')
        mdFile.write('author: fungleo\n')
        mdFile.write('tags:\n')
        for tag in tags:
            mdFile.write('    -' + tag + '\n')

        mdFile.write('---\n\n')
        mdFile.write(content)



def findJson ():
    for fil in os.listdir(sourceDir):
        filPath = os.path.join(sourceDir, fil)
        readJson(filPath)

findJson()
```
再跑一边这个脚本，就将所有的博客文章全部生成在了 `markdown` 这个文件夹下面了。



本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


