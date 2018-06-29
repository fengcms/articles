title: 初探 利用 javascript 开发 Chrome 浏览器插件
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -javascript
    -浏览器插件
    -chrome
---

#初探 利用 javascript 开发 Chrome 浏览器插件

##前言

这几天运维组的小伙伴正在给新开发的一个商城录入一些数据。其中图片不是很好找，于是，在某个B2C网站下载图片。主要是要下载放大镜中的那几组图片。

所有女生都大声尖叫，这活儿不是人干的……于是，技术组老大临时任命我开发一个 chrome 插件来帮助他们解决这个问题。

我嘞个去……我长这么大，也从没想过我要开发那个玩意儿啊，我只是个苦逼的菜鸟前端啊！硬着头皮上吧~

##技术原理分析

1. 搞明白chrome 插件是怎么开发的
2. 搞明白 这个网站的图片的特征是啥

##技术可行性分析

###网站图片规则
放大镜中的图片，都在一个列表里，其中，还有一个特征，就是包含`src-large`属性，那么，利用这个参数，就可以获得所有的图片的url了。`src-large`为大图 `src-medium` 为中图 `src` 为小图。
###Chrome 浏览器插件原理
1. 首先，这个插件要先对页面分析，得到上面所需要的所有图片的URL
2. 其次，要对这些URL进行处理，得到能用的格式。
3. 最后，把这些图片全部下载下来。

##开工
首先翻墙，google 相关资料。此时此刻，百度已经不管啥鸟用了。由于英文水平很菜，还是要借助百度翻译，一步一步来。

###manifest.json 插件基础文件

在这个插件中，规定插件的名称、版本、以及所需要的权限，以及后台执行的js文件，和其他信息。
别看不长，累死我了。
```languag
{
    "name": "test",
    "description": "test",
    "version": "2.0",
    "permissions": [
        "activeTab", "notifications", "downloads", "http://*/*", "https://*/*"

    ],

    "background": {
        "scripts": ["bg.js"],
        "persistent": false
    },
    "browser_action": {
        "default_title": "test",
        "default_icon": "icon.png"
    },
    "manifest_version": 2
}

```

### bg.js 插件后台执行文件

```language
// 当点击插件按钮的时候开始执行
chrome.browserAction.onClicked.addListener(function(tab) {
	// 对当前页面进行执行
    chrome.tabs.executeScript({
    		// 执行这个JS文件 下面讲
            file: 'context.js'
        },
        // 用上面执行出来的结果，在进行
        function(results) {
        	// 把传过来的一堆文本，用;号分割，形成数组
            var urls = results[0].split(";");
            // 循环这个数组
            for (var i = 0; i < urls.length; i++) {
            	// 然后下载它
                chrome.downloads.download({
                    url: urls[i]
                });
            };

        });
});
```
实际最终的代码，要比上面更复杂一些，主要是加了下载到不同的文件夹功能，这个不赘述了，这里只讲关键的。

###context.js 页面执行文件

```language
// 本来是用数组的，但是数组里的内容是可以重复的，为了避免重复，改用 set
var allPicArray = new Set();
// 把包含[src-large]的元素全部找出来，形成组
var bigPic = document.querySelectorAll("[src-large]");
// 循环它，并把循环的结果，加入到 allPicArray 里面
for (var i = 0; i < bigPic.length; i++) {
    allPicArray.add(bigPic[i].attributes["src-large"].value);
};
// 把包含中图的元素全部找出来，形成组，本来是准备和大图用一个的，但是出错，不知道为什么
var medPic = document.querySelectorAll("[src-medium]");
// 循环中图结果，并把中图加入到 allPicArray 里面
for (var i = 0; i < medPic.length; i++) {
    allPicArray.add(medPic[i].attributes["src-medium"].value);
};
// 到这里又不出错了，顺利把所有小图全部加入到 allPicArray
for (var i = 0; i < medPic.length; i++) {
    allPicArray.add(medPic[i].attributes["src"].value);
};
// 定义一个空文本
var o = "";
// 把得到的所有结果，后面加个;号，然后组成一大段文本
allPicArray.forEach(function(d) {
    o += d + ";";
});
// 把这一大段文本，直接扔到插件里面去，交给插件处理
o

```

##结果

完美！收获赞美一片！我居然也会开发浏览器插件了-_-|||

##总结

什么事情，原理清楚了，善用搜索引擎，一定能够找到解决方法。谷歌比百度在这方面强太多了。问题是，我英文真心很烂，只能半猜半蒙~

还有就是，问人，可能比问搜索引擎更加有效。当有过不去的坎儿的时候，尝试问组里的大拿，虽然他可能不懂这个程序，但是原理性的东西是相同的，很可能一句话点醒梦中人。

##感谢

感谢康哥，没康哥，我压根写不出来。~
好吧，其实康哥写了大半，而且是关键的~
