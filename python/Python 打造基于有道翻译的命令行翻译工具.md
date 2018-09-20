# Python 打造基于有道翻译的命令行翻译工具（命令行爱好者必备）

之前基于百度写了一篇博文 [Python 打造基于百度翻译的命令行翻译工具](https://blog.csdn.net/FungLeo/article/details/81045207)，本来这工具用得挺好的。但是没想到，近期处于不知道啥原因，不能用了。破解人家的接口难免会有这样的情况发生，也不能怪人家百度对吧。

加上最近工作比较忙，所以也没有去再研究，今天正好有点时间，我就打算重新写一个命令行的翻译工具。想来破解人家的是不对，不如使用人家提供的 `Api` ，代码清晰简单，使用应该更加长久。

## 开发

百度提供的接口实在是太挫了，于是看有道翻译的接口，果然很是不错。遂决定基于有道的 `Api` 来写这个工具。首先到 https://ai.youdao.com/register.s 进行注册，注册之后创建一个应用，以及创建一个自然语言翻译实例。进行绑定后，拿到 `AppId` 和 `AppKey` 两个关键参数。

然后，我们在本地创建 `config.py` 文件，录入以下代码：

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-

APPID = 'Your AppId'
APPKey = 'Your AppKey'
```

将自己申请得到的参数填写到上面的文件中。然后我们创建 `fanyi.py` 文件，写入以下代码：

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-

import requests
import argparse
import random
import hashlib
import json
from config import APPID, APPKey
from prettytable import PrettyTable

def fanyi(word, goNext):
    baseUrl = 'https://openapi.youdao.com/api'
    salt = str(random.randint(1000000, 9999999))
    sign = APPID + word + salt + APPKey
    m1 = hashlib.md5()
    m1.update(sign.encode('utf-8'))
    md5Sign = m1.hexdigest()

    queryFrom = {
            'appKey': APPID,
            'q': word,
            'from': 'auto',
            'to': 'auto',
            'salt': salt,
            'sign': md5Sign,
        }
    r = requests.post(baseUrl, data=queryFrom)
    if r.status_code == 200:
        res = json.loads(r.text)
        if res['errorCode'] == '0':
            showRes(word, res)
            if goNext:
                print('\n')
                inputWord(False)
        else:
            print(res['errorCode'])
            exit()
    else:
        print(r.status_code)
        exit()

def showRes(word, res):
    tableHead = ['原词', word]

    x = PrettyTable(tableHead)
    x.padding_width = 1
    x.align = 'l'

    print('\n\033[1;36m简单结果\033[0m')

    for i in res['translation']:
        x.add_row(['结果', i])
    print(x)

    if 'basic' in res:
        print('\n\033[1;36m有道词典\033[0m')
        basic = res['basic']

        if 'wfs' in basic:
            wfs = basic['wfs']
            x = PrettyTable(['演化', '结果'])
            x.padding_width = 1
            x.align = 'l'
            for i in wfs:
                x.add_row([i['wf']['name'], i['wf']['value']])
            print(x)

        if 'explains' in basic:
            exps = basic['explains']
            x = PrettyTable(['示例'])
            x.padding_width = 1
            x.align = 'l'
            for i in exps:
                x.add_row([i])
            print(x)

    if 'web' in res:
        print('\n\033[1;36m网络释义\033[0m')
        x = PrettyTable(['相关词汇', '翻译'])
        x.padding_width = 1
        x.align = 'l'
        for i in res['web']:
            x.add_row([i['key'], ', '.join(i['value'])])
        print(x)

def inputWord (isFirst):
    if isFirst:
        print('\n\033[1;36m英汉互译词典\033[0m by FungLeo')
        print('\033[35mTip：退出程序请输入 \033[1;31mexit\033[4;0m\n')
    word = input('请输入要翻译的内容：')
    if word == 'exit':
        print('\033[0m很高兴为您服务')
        exit()
    else:
        fanyi(word, True)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.description = 'YouDao Fanyi Cli'
    parser.add_argument('-v', '--version', action = 'version', version = '%(prog)s V0.0.1')
    parser.add_argument('word', type = str, help = '需要翻译的单词', nargs = '?')

    args = parser.parse_args()

    if args.word == None:
        inputWord(True)
    else:
        fanyi(args.word, False)
```

如上代码就开发完成了。代码逻辑没什么要说的，只是简单的请求接口，另外把拿到的数据进行了一些美化而已。此外就是命令行工具的一些基本配置了。

有道翻译官方文档地址：http://ai.youdao.com/docs/doc-trans-api.s

## 测试

我们可以用 `-v` 以及 `-h` 来分别查看版本号以及帮助信息。如下图所示：

![版本以及帮助信息](https://raw.githubusercontent.com/fengcms/articles/master/image/0c/f2ef0a02e1f27dd425c381670c93ce.jpg)

我们可以用直接跟需要翻译的词或句子（句子需要用双引号包含），进行随时翻译后立即关闭的服务。如下图所示：

![随时翻译后立即关闭](https://raw.githubusercontent.com/fengcms/articles/master/image/df/a6026381407359ad6789e658585294.jpg)

我们还可以不输入参数，进入连续翻译模式，如下图所示：

![连续翻译模式](https://raw.githubusercontent.com/fengcms/articles/master/image/89/1c5dbbe81036e61a481d6af6f1ebb8.jpg)

如上，这些功能已经非常适合我的需要了，也就无所他求了。

有道翻译非常厚道的赠送了 `100` 元初始资金用户调用接口，相信足够我用很长时间。如果花完了也没关系，再冲钱就是了。

之前之所以破解百度的翻译来写，是因为百度提供的 `Api` 实在太烂，没办法才破解。我们不是不愿意付费，而是我们只愿意为优秀的服务付费。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

