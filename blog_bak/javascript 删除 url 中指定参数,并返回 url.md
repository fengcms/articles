title: javascript 删除 url 中指定参数,并返回 url
date: 2016-06-23 13:52:18 +0800
update: 2016-06-23 13:52:18 +0800
author: fungleo
tags:
    -javascript
    -url
    -url删除参数
---

#javascript 删除 url 中指定参数,并返回 url

##前言

在之前写了一篇博文[《`javascript` 操作 `url` 中 `search` 部分方法函数》](http://blog.csdn.net/fungleo/article/details/51673681).在这篇博文里面,我们通过写好的函数可以对`url`中的各种参数进行查询,设置.唯独,忘记了删除.

而今天就是遇到要删除某个参数的问题.郁闷,于是,写了这个函数.

##实现代码

```js
// 删除url中某个参数,并跳转
function funcUrlDel(name){
	var loca = window.location;
	var baseUrl = loca.origin + loca.pathname + "?";
	var query = loca.search.substr(1);
	if (query.indexOf(name)>-1) {
		var obj = {}
		var arr = query.split("&");
		for (var i = 0; i < arr.length; i++) {
			arr[i] = arr[i].split("=");
			obj[arr[i][0]] = arr[i][1];
		};
		delete obj[name];
		var url = baseUrl + JSON.stringify(obj).replace(/[\"\{\}]/g,"").replace(/\:/g,"=").replace(/\,/g,"&");
		return url
	};
}
```
**功能:**删除`url`中指定的参数,并返回删除参数后的完整`url`

**使用方法**

示例
```
url: http//xx.com/list?page=1&a=5
```
执行代码
```js
funcUrlDel("page")
```
返回
```language
http//xx.com/list?a=5
```

**其他说明**

会忽略 `hash` 值,如果需要,自行加上即可.

- - -

本文由FungLeo原创,允许转载.但转载必须署名作者,并保留文章首发链接.否则将追究法律责任.
首发地址: http://blog.csdn.net/FungLeo/article/details/51742890
