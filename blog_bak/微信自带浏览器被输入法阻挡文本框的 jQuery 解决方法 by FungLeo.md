title: 微信自带浏览器被输入法阻挡文本框的 jQuery 解决方法 by FungLeo
date: 2016-03-29 14:49:08 +0800
update: 2016-03-29 14:49:08 +0800
author: fungleo
tags:
    -微信
    -浏览器
    -输入法
    -文本框
    -遮挡
---

#微信自带浏览器被输入法阻挡文本框的 jQuery 解决方法 by FungLeo

##前言

做好了项目之后,在各种浏览器里面测试,都没有问题.很高兴,交付后端使用.然而发现在微信自带浏览器里面,却是出现了问题.

我的页面是一堆文本框,需要用户输入,当页面比较长的时候,在下面的文本框会被输入法给挡住...我勒个去.

写了一段JS脚本,测试了一下,发现,在正常的浏览器当中,当调出输入法的时候,视窗的高度,会减少,以适应输入法占据的屏幕空间.在QQ自带的浏览器里面,也是完全正常的.只有在微信里面,存在这个问题.并且,表现形式非常奇葩:

|机型|表现形式|
|-
|iphone6|看上去正常,但视窗高度并没有改变.页面可以滑动|
|iphone5|不正常,能滑动,但默认没有滑动到当前input|
|红米note|正常,没有问题|
|小米4/5|不正常,不能滑动,无法使用|
与手机操作系统和微信版本都有关系,上面的表格只是我这边的测试结果.

反正无论如何,微信自带的浏览器不会因为调出输入法就改变视窗的高度,这是最核心的问题.

##思路

项目已经做好了,我现在只能打个补丁上去,通篇的解决这个该死的兼容性问题.项目中采用了jquery2版本.因此,这个补丁使用jquery语法来写.

1. 要将当前焦点的文本框调整到可视区域
2. 要给页面尾部增加空间,以抵消输入法的高度占据的空间
3. 考虑性能,只能给微信使用,其他浏览器不执行.

##开工

首先找来一段判断是否在微信浏览器的代码,如下:

```javascript
// 判断是否是微信
function is_weixn(){  
	var ua = navigator.userAgent.toLowerCase();  
	if(ua.match(/MicroMessenger/i)=="micromessenger") {  
		return true;  
	} else {  
		return false;  
	}  
}
```

考虑了一下我的项目中,所有出现这个问题的地方,都是使用了input标签.但是,并非所有的input标签都需要调用出输入法,比如按钮和多选框等.因此,我自己构建了一个判断是否需要调用输入法的函数,如下:

```javascript
// 判断是否为文本框
function is_text(type){
	if (type=="text" || type=="number" || type=="password" || type=="tel" || type=="url" || type=="email") {
		return true;
	};
}
```
最后,按照自己的想法,解决了一下这个问题,代码如下:
```javascript
// 用于解决微信自带浏览器输入法遮挡文本框的处理
$(function(){
	if (is_weixn()){
		var inp = $("input"),
			win = $(window),
			bod = $("body"),
			winH = win.height();
		inp.each(function(){
			var t = $(this),
				tTop = t.offset().top,
				tType = t.prop('type');
			if (is_text(tType)) {
				t.on('click',function(event) {
					bod.height(winH+300);
					bod.animate({scrollTop: tTop-100 + 'px'}, 200);
				});
			};
		});
	};
})
```
应该是有优化的空间的.不过我的JS水平真心一般.暂时先解决这个问题吧-_-|||

本文由FungLeo原创,转载请保留版权申明,以及首发地址: [http://blog.csdn.net/fungleo/article/details/51005911](http://blog.csdn.net/fungleo/article/details/51005911)