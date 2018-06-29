title: jQuery 获取多选框值,以及多选框中文的函数实践 by FungLeo
date: 2016-05-16 13:51:29 +0800
update: 2016-05-16 13:51:29 +0800
author: fungleo
tags:
    -jquery
    -多选框
    -checkbox
    -FungLeo
    -Label
---

#jQuery 获取多选框值,以及多选框中文的函数实践 by FungLeo

##前言

本方法是我刚在项目中用的方法.可能有更加好的方法.但我不清楚.

搜索了几个方法,好像都有错误,不知道是别人的错误,还是我的错误.因此,我自己构造了以下方法,便于我在实践中使用.

分享出来,有谬误请大家指出.

##DOM结构

我的多选框的dom结构,都是下面这种的.都是基础知识,不做过多阐述.
```html
<label class="input_checkbox">
    <input type="checkbox" name="sell_area" vlaue="0">
    <span>甘肃</span>
</label>
<label class="input_checkbox">
    <input type="checkbox" name="sell_area" vlaue="1">
    <span>青海</span>
</label>
<label class="input_checkbox">
    <input type="checkbox" name="sell_area" vlaue="2">
    <span>陕西</span>
</label>
<label class="input_checkbox">
    <input type="checkbox" name="sell_area" vlaue="3">
    <span>宁夏</span>
</label>
```
使用这种方法的优点是,点击文字就可以选择多选框了.并且可以使用CSS来美化整个样式.

关于美化多选框和单选框的内容,可以参考我的博文《[关于单选框以及复选框的css美化方法](http://blog.csdn.net/fungleo/article/details/47980533)》

##JS代码

**返回已经选中的多选框的值函数**
```javascript
function returnCheckboxVal(name){
	var data="";
	$('input:checkbox[name="'+name+'"]:checked').each(function(){
		data += $(this).attr("vlaue")+",";
	});
	return data.substring(0,data.length-1);
}
```
通过这个函数,可以按照我们的需要,返回相应name值的多选框选中的项目的值,以`1,2,3`的方式返回

好,这里需要解释一下了,为什么我使用`$(this).attr("vlaue")`这种方式来获取.

其实我从搜索引擎找到的是 `$(this).val()` 的方式获取的.但是我很奇怪,我返回的值全部是`on`.

可能和我使用的是 `jquery2.0`的版本有关系,但具体是什么原因,我没有深究.

**返回已经选中的多选框的项目名称**

如上,可能我需要返回的是`甘肃,青海,陕西,宁夏`这样的项目名.当然,这个也是可以做到的.

不过,这个严重依赖我上面的DOM结构,如果结构不相同的话,需要做适当的修改的.

```javascript
function returnCheckboxItem(name){
	var data="";
	$('input:checkbox[name="'+name+'"]:checked').each(function(){
		data += $(this).siblings('span').html()+",";
	});
	return data.substring(0,data.length-1);
}
```

##总结

1. 网上搜索来的代码不一定都是正确的.但大体思路应该不会错.
2. 其中的差异可能是标点符号(中英文)\缩进(中文全角空格)\或者是使用的JQ版本不相同.
3. 所以找到的代码不能使用的时候,仔细排查一下,或许用更原始的方法可能会解决问题.
4. 尽快完成项目,更加重要.毕竟语言只是一个工具而已.

本文由FungLeo原创,允许转载.但转载必须署名作者,并保留文章首发链接.否则将追究法律责任.
首发地址: http://blog.csdn.net/FungLeo/article/details/51424587