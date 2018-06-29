title: [转]为什么浏览器User-agent总是有Mozilla字样
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -mozilla
    -windows
    -User-Agent
    -浏览器
    -gecko
---

今天早上查看处理UA的内容，看到这篇文章，实在是太有意思了，转载过来，分享给大家。

你是否好奇标识浏览器身份的User-Agent，为什么每个浏览器都有Mozilla字样？
```
Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.94 Safari/537.36
Mozilla/5.0 (Linux; U; Android 4.1.2; zh-tw; GT-I9300 Build/JZO54K) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30
Mozilla/5.0 (Windows NT 6.1; WOW64; rv:20.0) Gecko/20100101 Firefox/20.0
Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.0; Trident/5.0)
```
故事还得从头说起，最初的主角叫NCSA Mosaic，简称Mosaic（马赛克），是1992年末位于伊利诺伊大学厄巴纳-香槟分校的国家超级计算机应用中心（National Center for Supercomputing Applications，简称NCSA）开发，并于1993年发布的一款浏览器。它自称“NCSA_Mosaic/2.0（Windows 3.1）”，Mosaic可以同时展示文字和图片，从此浏览器变得有趣多了。

然而很快就出现了另一个浏览器，这就是著名的Mozilla，中文名称摩斯拉。一说 Mozilla = Mosaic + Killer，意为Mosaic杀手，也有说法是 Mozilla = Mosaic & Godzilla，意为马赛克和哥斯拉，而Mozilla最初的吉祥物是只绿色大蜥蜴，后来更改为红色暴龙，跟哥斯拉长得一样。

但Mosaic对此非常不高兴，于是后来Mozilla更名为Netscape，也就是网景。Netscape自称“Mozilla/1.0(Win3.1)”，事情开始变得更加有趣。网景支持框架（frame），由于大家的喜欢框架变得流行起来，但是Mosaic不支持框架，于是网站管理员探测user agent，对Mozilla浏览器发送含有框架的页面，对非Mozilla浏览器发送没有框架的页面。

后来网景拿微软寻开心，称微软的Windows是“没有调试过的硬件驱动程序”。微软很生气，后果很严重。此后微软开发了自己的浏览器，这就是Internet Explorer，并希望它可以成为Netscape Killer。IE同样支持框架，但它不是Mozilla，所以它总是收不到含有框架的页面。微软很郁闷很快就沉不住气了，它不想等到所有的网站管理员都了解IE并且给IE发送含有框架的页面，它选择宣布IE是兼容Mozilla，并且模仿Netscape称IE为“Mozilla/1.22(compatible; MSIE 2.0; Windows 95)”，于是IE可以收到含有框架的页面了，所有微软的人都嗨皮了，但是网站管理员开始晕了。

因为微软将IE和Windows捆绑销售，并且把IE做得比Netscape更好，于是第一次浏览器血腥大战爆发了，结果是Netscape以失败退出历史舞台，微软更加嗨皮。但没想到Netscape居然以Mozilla的名义重生了，并且开发了Gecko，这次它自称为“Mozilla/5.0(Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826”。

Gecko是一款渲染引擎并且很出色。Mozilla后来变成了Firefox，并自称“Mozilla/5.0 (Windows; U; Windows NT 5.1; sv-SE; rv:1.7.5) Gecko/20041108 Firefox/1.0”。Firefox性能很出色，Gecko也开始攻城略地，其他新的浏览器使用了它的代码，并且将它们自己称为“Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.2) Gecko/20040825 Camino/0.8.1”，以及“Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.8) Gecko/20071008 SeaMonkey/1.0”，每一个都将自己装作Mozilla，而它们全都使用Gecko。

Gecko很出色，而IE完全跟不上它，因此user agent探测规则变了，使用Gecko的浏览器被发送了更好的代码，而其他浏览器则没有这种待遇。Linux的追随者对此很难过，因为他们编写了Konqueror，它的引擎是KHTML，他们认为KHTML和Gecko一样出色，但却因为不是Gecko而得不到好的页面，于是Konqueror为得到更好的页面开始将自己伪装成“like Gecko”，并自称为“Mozilla/5.0 (compatible; Konqueror/3.2; FreeBSD) (KHTML, like Gecko)”。自此user agent变得更加混乱。

这时更有Opera跳出来说“毫无疑问，我们应该让用户来决定他们想让我们伪装成哪个浏览器。”于是Opera干脆创建了菜单项让用户自主选择让Opera浏览器变成“Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; en) Opera 9.51”，或者“Mozilla/5.0 (Windows NT 6.0; U; en; rv:1.8.1) Gecko/20061208 Firefox/2.0.0 Opera 9.51”， 或者“Opera/9.51 (Windows NT 5.1; U; en)”。
后来苹果开发了Safari浏览器，并使用KHTML作为渲染引擎，但苹果加入了许多新的特性，于是苹果从KHTML另辟分支称之为WebKit，但它又不想抛弃那些为KHTML编写的页面，于是Safari自称为“Mozilla/5.0 (Macintosh; U; PPC Mac OS X; de-de) AppleWebKit/85.7 (KHTML, like Gecko) Safari/85.5”，这进一步加剧了user agent的混乱局面。

因为微软十分忌惮Firefox，于是IE重装上阵，这次它自称为“Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0) ”，并且渲染效果同样出色，但是需要网站管理员的指令它这么做才行。
再后来，谷歌开发了Chrome浏览器，Chrome使用Webkit作为渲染引擎，和Safari之前一样，它想要那些为Safari编写的页面，于是它伪装成了Safari。于是Chrome使用WebKit，并将自己伪装成Safari，WebKit伪装成KHTML，KHTML伪装成Gecko，最后所有的浏览器都伪装成了Mozilla，这就是为什么所有的浏览器User-Agent里都有Mozilla。Chrome自称为“Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.2.149.27 Safari/525.13”。

因为以上这段历史，现在的User-Agent字符串变得一团糟，几乎根本无法彰显它最初的意义。追根溯源，微软可以说是这一切的始作俑者，但后来每一个人都在试图假扮别人，最终把User-Agent搞得混乱不堪。
一句话结论：因为网站开发者可能会因为你是某浏览器（这里是 Mozilla），所以输出一些特殊功能的程序代码（这里指好的特殊功能），所以当其它浏览器也支持这种好功能时，就试图去模仿 Mozilla 浏览器让网站输出跟 Mozilla 一样的内容，而不是输出被阉割功能的程序代码。大家都为了让网站输出最好的内容，都试图假装自己是 Mozilla 一个已经不存在的浏览器……

附各大浏览器诞生年表：

1993年1月23日：Mosaic
1994年12月：Netscape
1994年：Opera
1995年8月16日：Internet Explorer
1996年10月14日：Kongqueror
2003年1月7日：Safari
2008年9月2日：Chrome

注：本文转自简明现代魔法。