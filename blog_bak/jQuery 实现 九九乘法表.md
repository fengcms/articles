title: jQuery 实现 九九乘法表
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -jquery
    -javascript
---

突然看到了这么一道题。我想试试。

## HTML 结构 ##

```
<h1>九九乘法表</h1>
<h2>Demo 1</h2>
<div id="Feng9" class="cfb"></div>
<h2>Demo 2</h2>
<div id="Feng92" class="cfb"></div>
<h2>Demo 3</h2>
<div id="Feng93" class="cfb"><ul></ul></div>
```

## CSS 代码 ##

```
.cfb {
  border-bottom: 1px solid #ddd;
  text-align: center; }
  .cfb ul {
    clear: both;
    overflow: hidden;
    border-left: 1px solid #ddd; }
    .cfb ul li {
      float: left;
      width: 69px;
      border-top: 1px solid #ddd;
      border-right: 1px solid #ddd;
      color: #999; }
    .cfb ul em {
      font-weight: bold;
      color: #f60; }

```

## jQuery 代码 ##

```
$(function(){
	// 实现方法 1
	var Obj = $("#Feng9");

	for (var i = 1; i <= 9; i++) {
		Obj.append('<ul><li data-i='+i+'>1×'+i+'=<em> '+i+'</em></li></ul>');
	};

	var Ul = Obj.children('ul');

	Ul.each(function() {
		var T = $(this),
			Dt = T.children('li'),
			I = Dt.data("i");
		for (var i = 2; i <= I; i++) {
			T.append('<li>'+i+'×'+I+'=<em> '+i*I+'</em></li>');
		};
	});

	// 实现方法 2

	var Obj2 = $("#Feng92");
	for (var i = 1; i <= 9; i++) {
		Obj2.append('<ul class="ul_'+i+'"><li>1×'+i+'=<em> '+i+'</em></li></ul>');
		for (var j = 2; j <= i; j++) {
			Obj2.children('.ul_'+i+'').append('<li>'+j+'×'+i+'=<em> '+j*i+'</em></li>')
		};
	};
	// 实现方法 3
	var Obj3 = $("#Feng93").children('ul');
	for (var i = 1; i <= 9; i++) {
		for (var j = 1; j <= i; j++) {
			if (i==j) {
				Obj3.append('<li>'+j+'×'+i+'=<em> '+j*i+'</em></li></ul><ul>')
			} else {
				Obj3.append('<li>'+j+'×'+i+'=<em> '+j*i+'</em></li>');
			}
		};
	};
});
```

虽然是三个方法，其原理都是一个，下回看看能不能换个原理实现这东西。