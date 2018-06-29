title: 如何用原生 javascript 写一个选项卡？
date: 2015-09-09 17:05:35 +0800
update: 2015-09-09 17:05:35 +0800
author: fungleo
tags:
    -javascript
    -选项卡
---

买的基本原生 javascript的书还在路上。所以对js还是懵懂无知。

当时学习jquery的时候，是以写一个 选项卡 为开始的。当然，用jq写是非常简单的。

选项卡原理我是非常清楚。那么按照这个原理来写吧。首先，构建html框架

#html框架1
```
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>JavaScript Tab Test</title>
<style>
	* {padding: 0;margin: 0;list-style: none;font-style: normal;}
	body {font-family: tahoma;}
	#tab {border-left: 1px solid #ddd;border-bottom: 1px solid #ddd;float: left;margin:100px;}
	#tab_ul {width: 500px;}
		#tab_ul li {width: 99px;border: 1px solid #ddd;background: #fff;border-left:none;float: left;height: 40px;line-height: 40px;text-align: center;cursor: pointer;background: #f9f9f9;}
		#tab_ul li.on {border-bottom: 1px solid #fff;background: #fff;}
	#tab_div {border-right: 1px solid #ddd;clear: both;}
		#tab_div div {height: 200px;line-height: 200px;text-align: center;font-size: 80px;}
	.block {display: block;}
	.none {display: none;}
</style>
</head>
<body>
<div id="tab">
	<ul id="tab_ul">
		<li class="on">Title 1</li>
		<li>Title 2</li>
		<li>Title 3</li>
		<li>Title 4</li>
		<li>Title 5</li>
	</ul>
	<div id="tab_div">
		<div class="block">content 1</div>
		<div class="none">content 2</div>
		<div class="none">content 3</div>
		<div class="none">content 4</div>
		<div class="none">content 5</div>
	</div>
</div>
</body>
</html>
```
为了方便检查，html css 之类的全部在一起了。

然后写下了第一个版本。
# javascript Beta 1
```
// 获取 tab li 和 con div 两个数组 并 赋予变量
var _tabLi = document.getElementById("tab_ul").getElementsByTagName("li");
var _conDiv = document.getElementById("tab_div").getElementsByTagName("div");

// 循环，对 _tabLi 进行处理
for (var i = 0; i < _tabLi.length; i++) {

	// 点击某个 li 进行处理
	_tabLi[i].onclick = function(){

		// 给自己加上class
		this.className = "on";

		// 给兄弟元素删除class
		var _sib = siblings(this);

		for (var j = 0; j < _sib.length; j++) {
			// 删除样式
			_sib[j].removeAttribute("class");
		};

		
		// 获取当前的索引
		var _index = index(this,_tabLi);

		// 对内容元素进行处理
		for (var j = 0; j < _conDiv.length; j++) {
			if (j==_index) {
				// 这里和下面分别用了两种设置样式名的方式
				_conDiv[j].className = "block"
			} else{

				_conDiv[j].setAttribute("class", "none")
			};
		};
	}
};
// 获取元素索引函数
function index(current, obj){
	for (var i = 0; i < obj.length; i++) {
		if (obj[i] == current) { 
			return i; 
		} 
	} 
} 

// 查询兄弟元素函数
function siblings(elm) {
	var a = [];
	var p = elm.parentNode.children;
	for(var i =0,pl= p.length;i<pl;i++) {
		if(p[i] !== elm) a.push(p[i]);
	}
	return a;
}

```

注释得比较清楚了。但是感觉还是太繁琐了。我不是一次性写出来的，而是查了半天资料，百度了千百回才写出来的。下面是我优化过的。

优化思路就是删调 **查询兄弟元素的函数**
#javascript beta 2
```
// 获取 tab li 和 con div 两个数组 并 赋予变量
var _tabLi = document.getElementById("tab_ul").getElementsByTagName("li");
var _conDiv = document.getElementById("tab_div").getElementsByTagName("div");

// 循环，对 _tabLi 进行处理
for (var i = 0; i < _tabLi.length; i++) {
	
	_tabLi[i].onclick = function(){

		// 获取当前的索引
		var _index = index(this,_tabLi);
		// 对控制菜单进行处理
		for (var j = 0; j < _tabLi.length; j++) {
			if (j==_index) {
				_tabLi[j].className = "on"
			} else{
				_tabLi[j].removeAttribute("class");
			};
		};
		// 对内容元素进行处理
		for (var j = 0; j < _conDiv.length; j++) {
			if (j==_index) {
				_conDiv[j].className = "block";
			} else{

				_conDiv[j].className = "block";
			};
		};
	}
};
// 获取元素索引函数
function index(current, obj){
	for (var i = 0; i < obj.length; i++) {
		if (obj[i] == current) { 
			return i; 
		} 
	} 
} 
```

优化过第二个版本之后，发现自己真的是不细心啊，居然重复循环，可以整合到一起的啊~！

#javascript beta 3

```
// 获取 tab li 和 con div 两个数组 并 赋予变量
var _tabLi = document.getElementById("tab_ul").getElementsByTagName("li");
var _conDiv = document.getElementById("tab_div").getElementsByTagName("div");


for (var i = 0; i < _tabLi.length; i++) {
	_tabLi[i].onclick = function(){
		// 获取当前的索引
		var _index = index(this,_tabLi);
		
		// 分别进行处理
		for (var j = 0; j < _tabLi.length; j++) {
			if (j==_index) {
				_tabLi[j].className = "on";
				_conDiv[j].className = "block";
			} else{
				_tabLi[j].removeAttribute("class");
				_conDiv[j].className = "block";
			};
		};
	}
};
// 获取元素索引函数
function index(current, obj){
	for (var i = 0; i < obj.length; i++) {
		if (obj[i] == current) { 
			return i; 
		} 
	} 
} 
```

#html 框架2

上面虽然实现了效果，但是html还是复杂了一些。因为没必要有一些初始的样式。我希望html能够更加简洁。

```
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>JavaScript Tab Test</title>
<style>
* {padding: 0;margin: 0;list-style: none;font-style: normal;}
body {font-family: tahoma;}
#tab {border-left: 1px solid #ddd;border-bottom: 1px solid #ddd;float: left;margin:100px;}
#tab_ul {width: 500px;}
	#tab_ul li {width: 99px;border: 1px solid #ddd;background: #fff;border-left:none;float: left;
		height: 40px;line-height: 40px;text-align: center;cursor: pointer;background: #f9f9f9;}
	#tab_ul li.on {border-bottom: 1px solid #fff;background: #fff;}
#tab_div {border-right: 1px solid #ddd;clear: both;}
	#tab_div div {height: 200px;line-height: 200px;text-align: center;font-size: 80px;display: none;}
</style>
</head>
<body>
<div id="tab">
	<ul id="tab_ul">
		<li>Title 1</li>
		<li>Title 2</li>
		<li>Title 3</li>
		<li>Title 4</li>
		<li>Title 5</li>
	</ul>
	<div id="tab_div">
		<div>content 1</div>
		<div>content 2</div>
		<div>content 3</div>
		<div>content 4</div>
		<div>content 5</div>
	</div>
</div>
</body>
</html>
```
注意，这里我默认给#tab_div 下的div 设置为隐藏属性了。

#javascript beta 4

```
// 获取 tab li 和 con div 两个数组 并 赋予变量
var _tabLi = document.getElementById("tab_ul").getElementsByTagName("li");
var _conDiv = document.getElementById("tab_div").getElementsByTagName("div");
for (var i = 0; i < _tabLi.length; i++) {
	// 对元素进行初始化
	_tabLi[0].className = "on";
	_conDiv[0].style.display = "block";

	// 点击切换处理
	_tabLi[i].onclick = function(){
		// 获取当前的索引
		var _index = index(this,_tabLi);

		// 分别进行处理
		for (var j = 0; j < _tabLi.length; j++) {
			if (j==_index) {
				_tabLi[j].className = "on";
				_conDiv[j].style.display = "block";
			} else{
				_tabLi[j].removeAttribute("class");
				_conDiv[j].style.display = "none";
			};
		};
	}
};
// 获取元素索引函数
function index(current, obj){
	for (var i = 0; i < obj.length; i++) {
		if (obj[i] == current) { 
			return i; 
		} 
	} 
} 
```