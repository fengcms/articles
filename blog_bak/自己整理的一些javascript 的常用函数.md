title: 自己整理的一些javascript 的常用函数
date: 2015-09-10 17:33:33 +0800
update: 2015-09-10 17:33:33 +0800
author: fungleo
tags:
    -javascript
    -函数
---

刚学，就觉得原生实在是太不好写了。为了学习，也不能总用JQ，所以，就整理了一些常用的函数，以便自己在需要的时候，随时使用。

```
/*
集合一些常用的方法，便于在网页中调用，以免重复造轮子
*/
var _Doc = document;

// index(this/obg) 索引方法
function index(current, obj){
	for (var i = 0; i < obj.length; i++) {
		if (obj[i] == current) {
			return i; 
		}
	}
}

// hide(obj) / show(obj) 隐藏/显示 方法

function hide(obj){
	obj.style.display = 'none';
}
function show(obj){
	obj.style.display = 'block';
}

// getId(IdName) / 获取ID 方法

function GetId(IdName){
	return _Doc.getElementById(IdName);
}

// GetTag(TagName) / 获取 tagname 方法

function GetTag(Fathers,TagName){
	return Fathers.getElementsByTagName(TagName);
}

// ajax 方法 转载于：http://www.cnblogs.com/yjzhu/archive/2013/01/28/2879542.html

function ajax(url, fnSucc, fnFaild){
	//1.创建对象
	var oAjax = null;
	if(window.XMLHttpRequest){
		oAjax = new XMLHttpRequest();
	}else{
		oAjax = new ActiveXObject("Microsoft.XMLHTTP");
	}
	
	//2.连接服务器  
	oAjax.open('GET', url, true);   //open(方法, url, 是否异步)
	
	//3.发送请求  
	oAjax.send(null);
	
	//4.接收返回
	oAjax.onreadystatechange = function(){  //OnReadyStateChange事件
		if(oAjax.readyState == 4){  		//4为完成
			if(oAjax.status == 200){   		 //200为成功
				fnSucc(oAjax.responseText) 
			}else{
				if(fnFaild){
					fnFaild();
				}
			}
		}
	};
}

// Load(url,obj) 方法，将上面的ajax方法简化，改造成直接load一个页面进来

function Load(url,obj){
	ajax(url,function(str){
		obj.innerHTML = str;
	});
}

// 去除字符串两端的空格
function DelBlank(str){
	return str.replace(/(^\s*)|(\s*$)/g, '');
}

// 从一段字符串中删除固定的另一段字符串

function DelSomeStr(Str,SomeStr)
{
    return Str.replace(SomeStr,"");
}

// 判断一段字符串中是否包含空格

function HasBlank(str){
	if (str.indexOf(" ")==-1) {
		return true;
	} else{
		return false;
	};
}

// 判断一个元素是否包含 class 如果有，返回真，否则返回假
function HasClass(obj){
	if (obj.getAttribute("class")) {
		return true;
	} else{
		return false;
	};
}

// 获取他原有的class

function GetClass(obj){
	if (HasClass(obj)) {
		return obj.getAttribute("class");
	}
}

// 给一个元素添加 class

function AddClass(obj,CName){

	// 原来是否有class

	if (HasClass(obj)) {

		// 获取原有样式，两端去空格后，存储到 OldClass
		var OldClass = DelBlank(GetClass(obj));

		// 如果原有样式和要添加的样式不一样的话，就在原有样式的结尾，加上新样式
		// 否则，就不用做啥了
		if (CName!=OldClass) {
			obj.className = OldClass+' '+CName;
		}
	} else{
		
		// 原来没有样式就直接加样式
		obj.className = CName;
	};
}

// 删除某个元素的 class
function RemoveClass(obj,CName){
	if (HasClass(obj)){
		var OldClass = DelBlank(GetClass(obj));
		// 这里没有做深处理。如果只有一个样式，并且删除之后，会留下一个为空的 class 不影响
		obj.setAttribute("class", DelBlank(DelSomeStr(OldClass,CName)))
	}
}
```

这是今天写的。我会把我的新想法，逐步整理到这个里面来。