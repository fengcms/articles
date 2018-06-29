title: jQury animate操作 background-position 方法
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -jquery
    -animate
    -css
---

今天遇到一个奇怪的问题，在使用jQury animate操作background-position的时候，怎么都不成功，在换成了css方法之后就成功了。问题是，css方法是没有动画效果的。

经过百度搜索了一番，语焉不详。CSDN上找到一篇文章：http://blog.csdn.net/goodshot/article/details/8648706，其中说到，animate操作的CSS参数是包括background-position的，但是写法要求是这样“backgroundPosition”赶紧尝试了一下，结果依然是失败。

到底为什么呢？又在知乎上找到了一条内容http://www.zhihu.com/question/20611410，看到其中的写法为

```
backgroundPositionX:300px,backgroundPositionY:200px
```
经过尝试确实解决了问题。

好吧，有点晕。不过还是理解了。

我的实战代码如下：

```
Butt.on("click",function(){
	var Ml = parseInt(XinBox.css('margin-left')),
		T = $(this);
	if (Ml==0) {
		XinBox.animate({"margin-left":"-495px"}, 200);
		T.animate({"backgroundPositionX":"0"}, 200);
	} else{
		XinBox.animate({"margin-left":"0"}, 200);
		T.animate({"backgroundPositionX":"-56px"}, 200);
	};
});
```