title: jQuery 选项卡插件 FengTab by FungLeo
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -jquery
    -选项卡
    -jquery插件
    -选项卡插件
---

好无聊啊，权当练手，写了一个选项卡插件

## Html 结构 ##
```
	<h2>Demo 1</h2>
	<div id="FengTab" class="FengTab">
		<ul class="tab">
			<li>Title 1</li>
			<li>Title 2</li>
			<li>Title 3</li>
			<li>Title 4</li>
		</ul>
		<div class="con">
			<div>content 1</div>
			<div>content 2</div>
			<div>content 3</div>
			<div>content 4</div>
		</div>
	</div>
	<h2>Demo 2</h2>
	<div id="FengTab2">
		<div class="caidan">
			<div>标题1</div>
			<div>标题2</div>
			<div>标题3</div>
		</div>
		<ul class="neirong">
			<li>内容1</li>
			<li>内容2</li>
			<li>内容3</li>
		</ul>
	</div>
```

只要层级是对的，至于里面你想用啥用啥，都可以设定的。demo1是默认结构。

## FengTab 插件代码 ##

```
/*******************************************************************
 * @authors FengCms 
 * @web     http://www.fengcms.com
 * @email   web@fengcms.com
 * @date    2015年9月4日
 * @version FengTab Beta 2.0
 * @copy    Copyright © 2013-2018 Powered by DiFang Web Studio  
 *******************************************************************/
(function($) {
	$.fn.FengTab = function(F) {
		F = $.extend({
			defaultIndex	: 0,				// 默认显示第几个，第一个为 0
			trigger 		: "click",			// 交互方式，click 为 点击切换，mouseover 为鼠标碰到就切换
			Tab 			: ".tab",			// 设定选项卡菜单区域 class
			TabLi 			: "li",				// 设定选项卡菜单 元素
			Con 			: ".con",			// 设定选项卡内容区域 class
			ConDiv 			: "div",			// 设定选项卡内容 元素
			CurName			: "on",				// 设定选项卡菜单选中时 class
			showWay 		: "slow"			// 设定切换方式 有 slow down 和 show 三个选项
		}, F);

		var Obj = $(this),
			Tab = Obj.find(F.Tab),
			Con = Obj.find(F.Con),
			TabLi = Tab.children(F.TabLi),
			ConDiv = Con.children(F.ConDiv);
		TabLi.each(function() {
			var T = $(this),
				I = T.index();
			if (I==F.defaultIndex){
				T.addClass(F.CurName);
			};
			T.on(F.trigger,function(){
				T.addClass(F.CurName).siblings(F.TabLi).removeClass(F.CurName);
				Action(I);
			});
		});
		ConDiv.each(function() {
			var T = $(this),
				I = T.index();
			if (I!=F.defaultIndex){
				T.hide();
			};
		});
		function Action(I) {
			switch (F.showWay) {
			case "down":
				ConDiv.stop().eq(I).slideDown(500).siblings().slideUp(500);
				break;
			case "slow":
				ConDiv.eq(I).fadeIn(200).siblings().hide();
				break;
			default:
				ConDiv.eq(I).show().siblings().hide();
			}
		};
	}
})(jQuery);


```

## FengTab使用代码 ##

```
<script>
$(function(){
	$("#FengTab").FengTab();
	$("#FengTab2").FengTab({
		defaultIndex	: 2,				// 默认显示第几个，第一个为 0
		trigger 		: "mouseover",			// 交互方式，click 为 点击切换，mouseover 为鼠标碰到就切换
		Tab 			: ".caidan",			// 设定选项卡菜单区域 class
		TabLi 			: "div",				// 设定选项卡菜单 元素
		Con 			: "ul",			// 设定选项卡内容区域 class
		ConDiv 			: "li",			// 设定选项卡内容 元素
		CurName			: "cur",				// 设定选项卡菜单选中时 class
		showWay 		: "down"			// 设定切换方式 有 slow down 和 show 三个选项
	});
});
</script>
```

css代码就不写了，各自发挥吧~