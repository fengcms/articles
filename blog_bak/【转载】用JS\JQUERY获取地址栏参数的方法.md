title: 【转载】用JS\JQUERY获取地址栏参数的方法
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -jquery
    -正则表达式
    -javascript
    -地址栏参数
---

#前言
最近在做一个项目，里面需要通过jq来获取地址栏参数。以前没接触过，因此百度了一下，找到这篇文章，写得非常好。因此转载来分享与大家。
#转载原文
##正则获取
方法一：采用正则表达式获取地址栏参数：（ 强烈推荐，既实用又方便！）
```
function GetQueryString(name)
{
     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
     var r = window.location.search.substr(1).match(reg);
     if(r!=null)return  unescape(r[2]); return null;
}
 
// 调用方法
alert(GetQueryString("参数名1"));
alert(GetQueryString("参数名2"));
alert(GetQueryString("参数名3"));

```
**下面举一个例子:**

若地址栏URL为：abc.html?id=123&url=http://www.maidq.com

那么，但你用上面的方法去调用：alert(GetQueryString("url"));

则会弹出一个对话框：内容就是 http://www.maidq.com

如果用：alert(GetQueryString("id"));那么弹出的内容就是 123 啦；

当然如果你没有传参数的话，比如你的地址是 abc.html 后面没有参数，那强行输出调用结果有的时候会报错：

所以我们要加一个判断 ，判断我们请求的参数是否为空，首先把值赋给一个变量：

```
var myurl=GetQueryString("url");
if(myurl !=null && myurl.toString().length>1)
{
   alert(GetQueryString("url"));
}
```
这样就不会报错了！
##传统方法
这个比较复杂，也不好用，有兴趣的可以去原文看。我觉得还是正则的这个好，简单实用。

###附加
转载地址：http://www.cnblogs.com/fishtreeyu/archive/2011/02/27/1966178.html
