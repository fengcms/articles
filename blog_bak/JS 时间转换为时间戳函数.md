title: JS 时间转换为时间戳函数
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -时间戳
    -时间转时间戳
---

在实际的项目中，一般都是数据库中存储的是时间戳，而页面上根据需要转换为时间。但是后端的同学直接写了一个时间存储了。给我的也是时间值。这我郁闷了，通过查阅资料，于是写了一个函数。


```
//时间格式 2015-12-05 00:00:00
function getTimeStamp (time){
	return new Date(time).getTime()/1000;
}
```
测试成功。

参考资料：[百度知道-js 中日期 转换成时间戳](http://zhidao.baidu.com/link?url=ysP1oxq_GtR7MlYVnCZ3u1b82qUzhdavZjS2JA6Rs4aYv1ADStWaaAbtaoZGdFvtHJyo612xZyuw6cjGcofgWq)