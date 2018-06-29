title: javascript 数组的一些处理处理方法
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -javascript
    -数组处理
    -jquery
---

#javascript 数组的一些处理处理方法

今天的项目中，用到了很多数组的知识，这里做一个记录，学到了很多。

##javascript 过滤数组中的 空数组 的方法。

```javascript
var tagValue = [1,"",""];
var realValue = [];

for (var i = 0; i < tagValue.length; i++) {
	if (tagValue[i]!='') {
		realValue.push(tagValue[i]);
	}
};
```
**说明：**

循环 tagValue 数组，如果不为空，就把值插入到 realValue 这个数组中。最后，就得到了没有空值的数组 realValue

##两个数组进行比对的方法

> 问题详细描述：A数组包含所有的字符串，B数组有未知个字符串。如果A数组内的字符串包含B数组里的每一个字符串，则为真，否则为假。

举个例子
```
var a = [1,2,3,4,5,6,7,8,9];
var b = [1,3];
// 此时，拿 b 和 a 进行比对，得到的值应该是真
var b = [0,1]
// 此时，则为假
```
好，方法是：

```language
return a.filter(function(item){ return b.indexOf(item) !== -1 }).length === b.length
```
这是高手写的。虽然经过仔细研究明白了是啥，但是，还是不能很准确的说明。那么，就封装一个函数，便于下次使用吧。
```language
function arr_contrast(a,b){
    return a.filter(function(item){ return b.indexOf(item) !== -1 }).length === b.length
}
```

##JS多维数组的运用

JS不支持多维数组，但是可以用一个数组里包含数组来模拟多维数组。

读取方法为 `arr[1][2]` 这样。利用两次循环，可以很方便给多维数组添加值。

下面写一个多维数组的例子

```language
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>test</title>
<script src="js/jquery/jquery.js"></script>
</head>
<body>
<table id="table">
	<tr>
		<td>test11</td>
		<td>test12</td>
		<td>test13</td>
	</tr>
	<tr>
		<td>test21</td>
		<td>test22</td>
		<td>test23</td>
	</tr>
	<tr>
		<td>test31</td>
		<td>test32</td>
		<td>test33</td>
	</tr>
</table>
</body>
</html>
<script>
$(function(){
	var table = $("#table"),
		tr = table.find('tr');
	var arr = [];
	tr.each(function(trIndex) {
		var td = $(this).find('td');
		arr[trIndex]=[];
		td.each(function(tdIndex) {
			arr[trIndex][tdIndex] = $(this).html();
		});
	});
	console.log(arr);
})
</script>
```

##以上各个知识点的组合运用

今天做了一个DEMO，好吧，不详细描述了。代码如下

```language
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>点选图片</title>
<script src="js/jquery/jquery.js"></script>
</head>
<body>
<ul id="zoom">
	<li data-value="1:101,1:102,2:201,2:202,2:203,2:204,3:301,3:302"><img src="image/1.jpg"></li>
	<li data-value="1:102,1:103,2:201,2:203,2:204,3:301,3:303"><img src="image/2.jpg"></li>
	<li data-value="1:103,1:104,2:201,2:202,2:203,2:204,3:301,3:304"><img src="image/3.jpg"></li>
	<li data-value="1:104,1:101,2:201,2:202,2:204,3:303,3:304"><img src="image/4.jpg"></li>
</ul>
<p class="data_tag">
	<span data-name="color" data-value="1:101">101颜色</span>
	<span data-name="color" data-value="1:102">102颜色</span>
	<span data-name="color" data-value="1:103">103颜色</span>
	<span data-name="color" data-value="1:104">104颜色</span>
</p>
<p class="data_tag">
	<span data-name="rom" data-value="2:201">16G</span>
	<span data-name="rom" data-value="2:202">8G</span>
	<span data-name="rom" data-value="2:203">32G</span>
	<span data-name="rom" data-value="2:204">64G</span>
</p>
<p class="data_tag">
	<span data-name="love" data-value="3:301">移动</span>
	<span data-name="love" data-value="3:302">联通</span>
	<span data-name="love" data-value="3:303">电信</span>
	<span data-name="love" data-value="3:304">全网通</span>
</p>
</body>
</html>
<script>
$(function(){
	var zoom = $("#zoom"),
		zoomImg = zoom.children('li');
	var dataTag = $(".data_tag");
	var zoomImgVal = [],				// 存放所有图片信息的数组
		tagValue = [];					// 存放当前参数的数组
	zoomImg.each(function(index){
		var img = $(this),
			value = img.data('value');
		zoomImgVal[index]=[];
		var arr = value.split(",");
		for (var i = 0; i < arr.length; i++) {
			zoomImgVal[index][i]=arr[i];
		};
	});



	dataTag.each(function(tagIndex){
		var tag = $(this),
			tagSpan = tag.children('span');
		tagValue[tagIndex] = '';
		tagSpan.each(function(spanIndex){
			$(this).click(function() {
				var span = $(this),
					value = span.data('value');
				tagValue[tagIndex] = value;
				span.addClass('on').siblings('span').removeClass('on');
				var realValue = [];
				for (var i = 0; i < tagValue.length; i++) {
					if (tagValue[i]!='') {
						realValue.push(tagValue[i]);
					}
				};
				for (var i = 0; i < zoomImgVal.length; i++) {
					arr_contrast(zoomImgVal[i],realValue) ? zoomImg.eq(i).show() : zoomImg.eq(i).hide();
				};
			});
		});

	});

	function arr_contrast(a,b){
		return a.filter(function(item){ return b.indexOf(item) !== -1 }).length === b.length
	}
})
</script>

<style>
*{font-weight: normal;line-height: 1;list-style: none;margin: 0;padding: 0;}
body {font-family: tahoma,"微软雅黑";text-align: center;}
li {display: inline-block;}
img {width: 200px;}

p {display: block;clear: both;padding: 10px;}
span {padding: 10px;border: 3px solid #ddd;display: inline-block;cursor: pointer;}
span.on {background: #f60;border: 3px solid #f60;color: #fff;}

</style>
```

