title: 解决因为手机设置字体大小导致h5页面在webview中变形的BUG
date: 2017-06-15 23:25:17 +0800
update: 2017-06-15 23:25:17 +0800
author: fungleo
tags:
    -webview
    -h5页面
    -rem
---

#解决因为手机设置字体大小导致h5页面在webview中变形的BUG

首先，我们做了一个H5页面，在各种手机浏览器中打开都没问题。我们采用了`rem`单位进行布局，通过JS来动态计算网页的视窗宽度，动态设置`html`的`font-size`，一切都比较完美。

这时候，你自信满满的将`h5`地址交给了APP工程师，做了一个`WEBVIEW`嵌套，然后就顺利交工了。

测试组在一堆手机中测试`APP`，突然，在某个手机上打开，你的页面布局了乱了，字变大或者变小，总之很奇葩。

你怀疑是`APP`的问题，但是客户端死活不承认。你在该手机浏览器中查看，确保没有一毛钱问题，也死活不承认是你的问题。于是测试人员对你俩不死不休的要求修改。于是，客户端给你加了调试工具后，你打开`chrome`进行调试，发现一个非常非常奇葩的问题：

**我明明设置的`html`字号是`100px`，为什么在`APP`中就变成了`86`（或者其他数字），你找遍所有的代码，都没有发现这个`86`是从哪里来的，你快疯了！！找了N多人帮忙，都没能解决这个问题！！我很希望能够告诉你，赶紧来看我这篇博文，因为，你现在经历的一切，我TM刚刚经历过~~**

好，你怎么也不会想到是手机设置字体大小造成的。因为默认浏览器中的内容是不受系统字体大小设置控制的，至少我遇到的几台手机都是这样的情况。但是APP不一样，APP是受那个玩意儿控制的！！

问题描述清楚了，出现这个问题，有以下因素

1. 你的页面采用了`rem`单位，并且是采用`js`动态计算`html`的`font-size`
2. 你的页面被加在了APP中的`webview`中
3. 这该死的手机被重设了字体大小

##解决方法

一般，我们动态计算好`html`的`font-size`之后，我们就啥都不干了，就走了。但是，我们现在知道了，我们设置的大小不一定是真实的大小，所以，我们需要在设置完字体大小之后，再去重新获取一下`html`的`font-size`，看看实际的这个值，和我们设置的是不是一样。如果不一样，就要根据比例再设置一次。

以下是我的完整代码：

```js
function htmlFontSize(){
	var h = Math.max(document.documentElement.clientHeight, window.innerHeight || 0);
	var w = Math.max(document.documentElement.clientWidth, window.innerWidth || 0);
	var width = w > h ? h : w;
	width = width > 720 ? 720 : width
	var fz = ~~(width*100000/36)/10000
	document.getElementsByTagName("html")[0].style.cssText = 'font-size: ' + fz +"px";
	var realfz = ~~(+window.getComputedStyle(document.getElementsByTagName("html")[0]).fontSize.replace('px','')*10000)/10000
	if (fz !== realfz) {
		document.getElementsByTagName("html")[0].style.cssText = 'font-size: ' + fz * (fz / realfz) +"px";
	}
}
```

恶心的。。。不想再多言。。。

祝好，不谢！

##2017年10月31日补充 安卓端设置 webview 解决此问题

之前我用JS解决这个问题的方法虽然能够在一定程度上解决问题，但是还是很不优雅，也不方便。

今天看到有网友给我留言，说在安卓端设置 webview 一个参数就能解决问题。原话如下：

> 解决办法：安卓客户端通过webview配置webview.getSettings().setTextZoom(100)就可以禁止缩放，按照百分百显示。

经过测试，确定，这个设置是能够完美解决问题的。

所以，如果你现在看到这篇文章，尝试用我的代码来解决问题，更好的做法，是去找安卓客户端开发工程师，让他增加这样一个参数。

如果不方便，再来用我的JS代码解决。

> PS:留言中有人说我的代码不能解决问题。我的代码肯定是能够解决问题的。但是需要根据你的项目自己去调整算法。我的默认设置是给 html 设置字体大小为  100px 
