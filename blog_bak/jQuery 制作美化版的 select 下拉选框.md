title: jQuery 制作美化版的 select 下拉选框
date: 2015-11-04 17:39:13 +0800
update: 2015-11-04 17:39:13 +0800
author: fungleo
tags:
    -jquery
    -select
    -下拉菜单
---

#jQuery 制作美化版的 select 下拉选框

##前言

在web前端工作中，总有一些东西是你搞不定的，比如 select 。原生的这玩意儿难看咱就不说了，关键是，在各个浏览器里面的表现形式那是千差万别啊。所以，我们在日常的工作中，总是尝试去美化它。

我烦了。所以，我决定写一段js来彻底解决这个问题。

##思路

1. 用 input 文本框来传值。
2. 禁止其输入功能。
3. 用 ul li 来模拟下拉菜单。
4. 用 data 来模拟 value

## 开干

###html
```
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>FengSelect.jquery Demo</title>
<link rel="stylesheet" href="style/FengSelect.css">
<script src="/Public/jquery/jquery.js"></script>
<script src="js/FengSelect.js"></script>
</head>
<body>
<div class="web">
<form action="">
	<label class="fengselect">
		<input type="text" name="love" placeholder="请选择你要的参数">
		<ul>
			<li data-value="1">参数1</li>
			<li data-value="2">参数2</li>
			<li data-value="3">参数3</li>
			<li data-value="4">参数4</li>
			<li data-value="5">参数5</li>
			<li data-value="6">参数6</li>
			<li data-value="7">参数7</li>
			<li data-value="8">参数8</li>
			<li data-value="9">参数9</li>
			<li data-value="10">参数10</li>
		</ul>
	</label>
	<label class="fengselect">
		<input type="text" name="sex" placeholder="请选择你要的参数">
		<ul>
			<li data-value="1">参数1</li>
			<li data-value="2">参数2</li>
			<li data-value="3">参数3</li>
			<li data-value="4">参数4</li>
			<li data-value="5">参数5</li>
			<li data-value="6">参数6</li>
			<li data-value="7">参数7</li>
			<li data-value="8">参数8</li>
			<li data-value="9">参数9</li>
			<li data-value="10">参数10</li>
		</ul>
	</label>
	<label class="fengselect">
		<input type="text" name="age" placeholder="请选择你要的参数">
		<ul>
			<li data-value="1">参数1</li>
			<li data-value="2">参数2</li>
			<li data-value="3">参数3</li>
			<li data-value="4">参数4</li>
			<li data-value="5">参数5</li>
			<li data-value="6">参数6</li>
			<li data-value="7">参数7</li>
			<li data-value="8">参数8</li>
			<li data-value="9">参数9</li>
			<li data-value="10">参数10</li>
		</ul>
	</label>
	<label class="fengselect">
		<input type="text" name="test" placeholder="请选择你要的参数">
		<ul>
			<li data-value="1">参数1</li>
			<li data-value="2">参数2</li>
			<li data-value="3">参数3</li>
			<li data-value="4">参数4</li>
			<li data-value="5">参数5</li>
			<li data-value="6">参数6</li>
			<li data-value="7">参数7</li>
			<li data-value="8">参数8</li>
			<li data-value="9">参数9</li>
			<li data-value="10">参数10</li>
		</ul>
	</label>
	<select name="select">
		<option value="1">参数1</option>
		<option value="2">参数2</option>
		<option value="3">参数3</option>
		<option value="4">参数4</option>
		<option value="5">参数5</option>
		<option value="6">参数6</option>
		<option value="7">参数7</option>
		<option value="8">参数8</option>
		<option value="9">参数9</option>
		<option value="10">参数10</option>
	</select>
	<input type="submit" value="提交">
</form>
</div>
</body>
</html>
```

###scss

```
@import url("/Public/style/reset.css");

.fengselect {
	position: relative;width: 130px;
	input {height: 16px;padding: 8px;border: 1px solid #ddd;border-radius: 3px;outline: none;width: 112px;}
	ul {
		position: absolute;width: 118px;padding: 5px;border: 1px solid #ddd;border-radius: 3px;background: #fafafa;
		li {
			cursor: pointer;
			&:not(:last-child) {border-bottom: 1px solid #ddd;}
		}
	}
}
```

###javascript

```
$(function(){
	var FengSelect = $(".fengselect");
	FengSelect.each(function(){
		var t = $(this),
			inp = t.find('input'),
			optBox = t.find('ul'),
			opt = t.find('li');
		inp.attr('readonly', 'readonly');
		optBox.hide();
		t.hover(function() {
			optBox.stop().slideDown();
		}, function() {
			optBox.stop().slideUp();
		});
		t.on("click","li",function(){
			var value = $(this).data('value');
			inp.val(value);
		})
	});
})
```

## 总结

1. 在`jquery`中，我以前一直用 `children` 而避免用 `find` 因为我 认为 寻找子集，比寻找所有的子孙元素要快。近日看到一篇文章，说 `find` 是原生方法 ，是比`children`的效率要搞的。
2. 执行下一个动画之前，一定要`.stop()`上一个动画。
3. `input` 使用 `readonly` 之后，是可以继续传值的。而使用了 `disabled` 之后，是没办法传值的。

##其他

在线演示：http://runjs.cn/detail/kwfsoab4

css 部分，完全可以随你去自定义，我写的只是一个草稿，用来演示效果而已。
html结构如下：
```
	<label class="fengselect">
        <input type="text" name="test" placeholder="请选择你要的参数">
        <ul>
            <li data-value="1">参数1</li>
            <li data-value="2">参数2</li>
        </ul>
    </label>
```
input 和 ul 元素，存与 class 为 fengselect 的 label 下。li 来写值和显示值。

JS部分，只要复制到页面里面，或者直接引用就可以了。