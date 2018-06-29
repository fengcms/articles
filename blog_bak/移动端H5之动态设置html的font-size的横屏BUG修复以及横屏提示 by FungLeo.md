title: 移动端H5之动态设置html的font-size的横屏BUG修复以及横屏提示 by FungLeo
date: 2016-04-22 16:59:39 +0800
update: 2016-04-22 16:59:39 +0800
author: fungleo
tags:
    -移动端H5
    -移动端横屏处理
    -移动端横屏BUG
    -FungLeo
---

#移动端H5之动态设置html的font-size的横屏BUG修复以及横屏提示 by FungLeo

##前言

在上一篇 [移动端之在不同尺寸大小的手机上展示同一效果解决方案](http://blog.csdn.net/fungleo/article/details/51177863) 中,我们考虑的只是默认竖屏的情况.很显然,如果用户手机允许屏幕旋转,那么在横屏的情况下,页面就变得很恶心了.

因此我们需要进行一个处理,来判断浏览器是否是横屏,在横屏的情况下,要使用高度值来计算html的font-size.

##代码

因为项目引入了jquery,因此下面的代码全部是jquery语法.

```javascript
function htmlFontSize(){
	var win = $(window),
		winH = win.height(),
		winW = win.width(),
		hfz;
	winW > winH ? hfz = winH : hfz = winW;
	$("html").css('font-size',~~(hfz*100000/36)/100000+"px");
}
```

通过上面的代码,就可以在横屏的情况下正确的显示页面的大小了.但是,横屏的情况下,页面会变得比较怪异,应该给用户一个提示.

百度了一下,找到了横屏的事件与解决方法.

```javascript
function orientationChange() {
	if (window.orientation==90 || window.orientation==-90){
		alert("横屏下不能获得最佳体验,建议竖屏浏览网页!");
	}
};
```
横屏提示代码如上.

再然后,就是在正确的时候要执行这些函数了.

```javascript
$(function(){
	htmlFontSize();
	$(window).on("resize",function(){
		htmlFontSize();
	});
	orientationChange();
	$(window).on("orientationchange",function(){
		orientationChange();
	});
});
```

如上.效果是正确的.但是,好像我用了两个事件有点多余.因此,可以将代码整合到一个事件里面.

```javascript
$(function(){
	htmlFontSize();
	orientationChange();
	$(window).on("orientationchange",function(){
    	htmlFontSize();
		orientationChange();
	});
});
```

这里需要提醒的是resize事件在PC上进行调试的时候还是很好用的.

最后,这两个函数完全可以合并到一个函数里面.就不多写了.因为,领导说横屏下我做的效果还不错,就不用提示了:)

本文由FungLeo原创,允许转载.但转载必须署名作者,并保留文章首发链接.否则将追究法律责任.

首发地址:http://blog.csdn.net/FungLeo/article/details/51221622