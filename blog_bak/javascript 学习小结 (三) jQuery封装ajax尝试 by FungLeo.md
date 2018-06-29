title: javascript 学习小结 (三) jQuery封装ajax尝试 by FungLeo
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -javascript
    -jquery
    -ajax
    -前端框架
    -FungLeo
---

#javascript 学习小结 (三) jQuery封装ajax尝试 by FungLeo

##前言

在JS学习中,对于原生的很多东西我理解得并不透彻.但是使用jQuery来操作DOM,基本上还是非常熟练的.但是对于AJAX数据交互的处理,我不是很理解.

近期团队交给我一个后端全接口提供给我的项目.我要利用这些接口来自己组织前端代码.为了学习,我决定不使用VUE或者其他的前端框架来做.而是只使用jQuery框架,数据的部分全部使用拼接字符串的形式实现.

获取数据,显示数据,提交数据.

在这个项目中(比较小的一个项目),并没有采用本地缓存等比较先进的方式,而是全部基于DOM和URL来进行实现我所需要的功能.

当然,这样做很傻.但是却可以让我更加透彻的理解一些东西.目前这个项目已经接近尾声.这篇博文,就是把我其中的一点代码拿出来分享.

##jQuery 的 AJAX 有没有封装的必要性?

实话实说,基本上没有这个必要性.因为本身已经非常精简了.

但是,在我这个项目中,使用到了两个功能,分别是 get 获取数据和 post 提交数据.其中的共用代码还是非常多的.

因此,我封装一下,一来可以掌握一下回调函数的基本使用.二来,可以让代码量少一些.

##封装的函数

```javascript
// ajax get json 方法
function getJson(url,func){
	$.ajax({
		type:'get',
		url:url,
		xhrFields: {withCredentials: true},
		crossDomain: true,
		success: function(data){
			if (data.status==0) {
				func(data);
			} else {
				alert(data.data);
				gourl("//www.xxx.com/");
			}
		},
		error: function(data){
			alert(JSON.stringify(data));
		}
	});
}
// ajax post json 方法
function postJson(url,access,func){
	$.ajax({
		type:'post',
		url:url,
		dataType:"json",
		xhrFields: {withCredentials: true},
		crossDomain: true,
		data:JSON.stringify(access),
		success: function(data){
			if (data.status == 0) {
				func(data);
			}else {
				alert(data.data);
			}
		},
		error: function(data){
			alert(JSON.stringify(data));
		}
	});
}
```
如上面的代码所示,我封装了 `getJson()` 和 `postJson()` 两个函数.

能够这样封装的前提是,后端提供的接口的格式都是统一规范的.并且,对于成功和出错的处理方式都是一致的.

如果不能满足这个条件,那么这样的封装是没有任何意义的.

##使用方法
**get数据**
```javascript
function getBuyOrderList(status,page){
	var url = "//www.xxx.com/api/buy-order?status="+status+"&page="+page;
	getJson(url,function(data){
		console.log(data);
	});
}
```
拿到数据之后怎么处理,直接替换上面的代码中的`console.log(data);`即可.

这样,我在我的项目中使用到获取数据的地方的代码量就相对少了很多了.

**POST数据**
```javascript
function sendInquireJson(){
	var id = getGoodsId();
	var url = "//www.xxx.com/api/inquire/"+id;
	postJson(url,buildInquireJson(),function(){
		alert("提交成功");
		gourl("https://www.yaoyingli.com/scm/");
	});
}
```
我先通过`buildInquireJson()`这个函数组织好JSON数据,然后通过`sendInquireJson()`函数就能传上去了.

##总结

我前文已经说过,jQuery 的 ajax 已经很精简了,我们在一般情况下是完全没必要封装的.

如果所有的接口都是统一规范的,并且所有的处理都是一致的,那么可以封装一下,可以减少我们的代码量

可以尝试把各种各样重复的代码进行封装.前提是你知道你在封装什么,以及怎么用它

命名很重要,基本上我的命名原则就是,一看这个名字我就知道它是干嘛的.例如上面的`buildInquireJson()`这个函数,我虽然没有在文章中提供这个函数的代码.但是一看这个名字就知道,这是一个组装`Inquire`这个玩意儿的`json`数据的函数.

本文由FungLeo原创,允许转载.但转载必须署名作者,并保留文章首发链接.否则将追究法律责任.
首发地址: http://blog.csdn.net/FungLeo/article/details/51497604