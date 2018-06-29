title: javascript 操作 url 中 search 部分方法函数
date: 2016-06-14 18:03:20 +0800
update: 2016-06-14 18:03:20 +0800
author: fungleo
tags:
    -javascript
    -url
    -url取值
    -url设置值
    -search
---

#javascript 操作 url 中 search 部分方法函数

##前言

首先,我们需要知道什么是 `search` , `search` 是 `window.location` 的一个属性.举个例子:

首先,我们这里有一个 `url`,是 `http://www.a.com/list/2.html?page=2&color=4&size=3#pic`.

我们访问访问这个地址,打开控制台,输入`window.location`,会得到如下图的结果

![](https://raw.githubusercontent.com/fengcms/articles/master/image/b6/fce76ccd8e1c7cc49a99faf583434a.jpg)
如上,我们要操作的就是上图中方框框出来的这个部分.

为什么要操作这个?

例如,我在第二页,需要跳转到第三页,就需要把上面的 `page=2` 给更新成 `page=3` 并且保证其他的参数保留.

又或者,本来没有`search`结果(如一般列表的第一页就啥都没有),但我现在需要加上`page=2`.

再来,我需要知道我现在在第几页,也就是说,我需要获取 `page`的值.

等等,都需要操作`search`.现在我们前后端分离,`search`是一个很重要的参数配置的方法.

##构建方法

###获取`search`中指定的某个参数值

百度一下,我们找到如下方法:

```js
function GetQueryString(name){
     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
     var r = window.location.search.substr(1).match(reg);
     if(r!=null)return  unescape(r[2]); return null;
}
```
方法出处:[用JS获取地址栏参数的方法](http://www.cnblogs.com/fishtreeyu/archive/2011/02/27/1966178.html)

###全功能方法

本来想写实现思路的,但一时想不起来了,直接给最终方法:

```js
function funcUrl(name,value,type){
	var loca = window.location;
	var baseUrl = type==undefined ? loca.origin + loca.pathname + "?" : "";
	var query = loca.search.substr(1);
	// 如果没有传参,就返回 search 值 不包含问号
	if (name==undefined) { return query }
	// 如果没有传值,就返回要查询的参数的值
	if (value==undefined){
		var val = query.match(new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"));
		return val!=null ? decodeURI(val[2]) : null;
	};
	var url;
	if (query=="") {
		// 如果没有 search 值,则返回追加了参数的 url
		url = baseUrl + name + "=" + value;
	}else{
		// 如果没有 search 值,则在其中修改对应的值,并且去重,最后返回 url
		var obj = {};
		var arr = query.split("&");
		for (var i = 0; i < arr.length; i++) {
			arr[i] = arr[i].split("=");
			obj[arr[i][0]] = arr[i][1];
		};
		obj[name] = value;
		url = baseUrl + JSON.stringify(obj).replace(/[\"\{\}]/g,"").replace(/\:/g,"=").replace(/\,/g,"&");
	};
	return url;
}
```

**使用方法**

1. `funcUrl()`获取完整`search`值(不包含问号)
2. `funcUrl(name)`返回 url 中 name 的值(整合上一段别人的方法)
3. `funcUrl(name,value)` 将`search`中`name`的值设置为`value`,并返回完整url
	- 返回内容如 `http://www.a.com/list/2.html?page=2&color=4&size=3#pic`
4. `funcUrl(name,value,type)` 作用和第三条一样,但这只返回更新好的`search`字符串
	- 这里的 `type` 可以是任意字符,比如`1`;
	- 返回内容举例 `page=2&color=4&size=3`;
	- 一般用于从`url`获取参数,再对接到接口上

##小结

本来想找个现成的插件来用,结果要么太大看不懂,要么不好使.当然,主要还是我水平太差的原因.

所以就造个轮子玩玩,虽然代码不够优雅,但是还是满足了我的需求.如果你有更好的建议,给我留言哦.

其实,主要是配合`vue`来用的,但这里没有`VUE`的内容,因此就不算`VUE`的系列教程了.

本文由FungLeo原创,允许转载.但转载必须署名作者,并保留文章首发链接.否则将追究法律责任.
首发地址: http://blog.csdn.net/FungLeo/article/details/51673681

- - - 
2016年6月24日补充

原来从别人那边整合过来的代码使用了`unescape`函数处理从url中传来的参数.但是发现中文在获取之后是乱码.经过查询,从 [w3school JavaScript unescape() 函数](http://www.w3school.com.cn/jsref/jsref_unescape.asp)得到以下内容:

>注释：ECMAScript v3 已从标准中删除了 unescape() 函数，并反对使用它，因此应该用 decodeURI() 和 decodeURIComponent() 取而代之。

因此,替换为了`decodeURI()`函数,就正常了.