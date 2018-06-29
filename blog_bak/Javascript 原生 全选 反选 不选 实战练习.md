title: Javascript 原生 全选 反选 不选 实战练习
date: 2015-09-11 10:52:12 +0800
update: 2015-09-11 10:52:12 +0800
author: fungleo
tags:
    -javascript
    -checkbox
    -for循环
    -遍历
---

今早上班时，同事给我提了这个选题，如果能做这个的话，那么对遍历，以及属性查询的知识点都应该有所掌握了。我决定尝试一下。

##思路

 1. 首先，把所有的 input 都找出来
 2. for循环 input 找到 type 为 checkbox 并且 name 为我想要的
 3. 查询他的checked 值，给予对应的操作

循环前几天已经写过了。不是问题。昨天刚到了犀牛书，翻书查找怎么查询元素的属性。有书果然比百度快。百度搜到的可能是牛唇不对马嘴的答案。

##实战 
###html & CSS

```
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>CheckBox test</title>
<style>
table {border-collapse: collapse;border: 1px solid #ddd;width: 300px;margin: 100px auto;line-height: 2;}
	table tr {border-bottom: 1px solid #ddd;}
label {cursor: pointer;display: block;}
</style>
</head>
<body>
	<table>
		<tr>
			<th><button id="CheckAll">全选</button> <button id="ClearAll">不选</button> <button id="ReAll">反选</button></th>
		</tr>
		<tr>
			<td><label><input type="checkbox" name="test" value="love1"><span>love1</span></label></td>
		</tr>
		<tr>
			<td><label><input type="checkbox" name="test" value="love2"><span>love2</span></label></td>
		</tr>
		<tr>
			<td><label><input type="checkbox" name="test" value="love3"><span>love3</span></label></td>
		</tr>
		<tr>
			<td><label><input type="checkbox" name="test" value="love4"><span>love4</span></label></td>
		</tr>
		<tr>
			<td><label><input type="checkbox" name="test" value="love5"><span>love5</span></label></td>
		</tr>
		<tr>
			<td><label><input type="checkbox" name="test" value="love6"><span>love6</span></label></td>
		</tr>
		<tr>
			<td><label><input type="checkbox" name="test" value="love7"><span>love7</span></label></td>
		</tr>
		<tr>
			<td><label><input type="checkbox" name="test" value="love8"><span>love8</span></label></td>
		</tr>
		<tr>
			<td><label><input type="checkbox" name="test" value="love9"><span>love9</span></label></td>
		</tr>
		<tr>
			<td><label><input type="checkbox" name="test" value="love10"><span>love10</span></label></td>
		</tr>
	</table>
</body>
</html>
```
###javascript
```
var ButtCheck = document.getElementById("CheckAll"),
	ButtClear = document.getElementById("ClearAll"),
	buttRe = document.getElementById("ReAll"),
	InpCheck = document.getElementsByTagName("input");

ButtCheck.onmouseup = function(){
	CheckAll("test");
};

ButtClear.onmouseup = function(){
	ClearAll("test");
};
buttRe.onmouseup = function(){
	ReCheck("test");
};

function CheckAll(Name){
	for (var i = 0; i < InpCheck.length; i++) {
		var This = InpCheck[i]
		if ((This.type=="checkbox")&&(This.name==Name)) {
			This.checked = true;
		};
	};
};

function ClearAll(Name){
	for (var i = 0; i < InpCheck.length; i++) {
		var This = InpCheck[i]
		if ((This.type=="checkbox")&&(This.name==Name)) {
			This.checked = false;
		};
	};
};

function ReCheck(Name){
	for (var i = 0; i < InpCheck.length; i++) {
		var This = InpCheck[i]
		if ((This.type=="checkbox")&&(This.name==Name)) {
			This.checked ? This.checked = false : This.checked = true;
		};
	};
}
```

学习原生JS的关键点，就是，思路思路思路！~

效果见：http://runjs.cn/detail/m0biuryy 
今天搞了个这个东西，分享代码倒是相当简单。

------------------

想想还是太不完美了，为什么要分为三个函数呢？能不能整合成一个函数呢？

下面就是我的优化代码：

```
function CheckBox(Method,Name){
	var Input = GetTag(_Doc,"input");
	for (var i = 0; i < Input.length; i++) {
		var This = Input[i]
		if ((This.type=="checkbox")&&(This.name==Name)) {
			switch (Method)
			{
				case "CheckAll":			// 全选
				This.checked = true;
				break;
				case "ClearAll":			// 全不选
				This.checked = false;
				break;
				case "ReCheck":				// 反选
				This.checked ? This.checked = false : This.checked = true;
				break;
			}
		};
	};
}
```
其中我用了一个自定义函数 GetTag(_Doc,"input") ，它相当于
```
.document.getElementsByTagName("input");
```
```
// 多选框操作
/*
CheckBox("CheckAll","test");	name为 test 的多选框 全选 操作
CheckBox("ClearAll","test");	name为 test 的多选框 全不选 操作
CheckBox("ReCheck","test");		name为 test 的多选框 反选 操作
*/
```

又练习了一下 switch 方法