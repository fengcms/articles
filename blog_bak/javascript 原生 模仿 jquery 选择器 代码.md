title: javascript 原生 模仿 jquery 选择器 代码
date: 2015-09-09 14:36:38 +0800
update: 2015-09-09 14:36:38 +0800
author: fungleo
tags:
    -javascript
---

使用这段代码可以简单的实现类似 $("#tab_ul") 选择器效果。当然，是基于原生的。

```
<script>
	Array.prototype.each=function(f){
		for(var i=0,l=this.length;i<l;i++)f.call(this[i],i);
			return this
	};
	Array.prototype.merge=function(arr){
		for(var i=0,l=arr.length;i<l;i++)this[this.length]=arr[i];
			return this
	};
	var rule=function(a,b){
		var e=[b||document];
		var types={
			'#':this.byId,
			'.':this.byClass,
			'>':this.byTagName,
			':':this.byAttr,
			'default':true
		},obj=[];
		for(var i=0,k=-1,l=a.length;i<l;i++){
			var s = a.charAt(i);
			if(typeof types[s]==='function'){
				k++;
				obj[k]=''
			}
			obj[k]+=s;
		}
		for(var i=0,l=obj.length;i<l;i++)e=types[obj[i].charAt(0)](e,obj[i].substr(1));
			return e
	};
	var byId=function(o,t){return [o[0].getElementById(t)]};
	var byTagName=function(o,t){
		var tags=[];
		o.each(function(i){tags.merge(o[i].getElementsByTagName(t))});
		return tags;
	};
	var byClass=function(o,t){
		var _=[];
		o.each(function(i){
			var m=this.getElementsByTagName('*');
			for(var j=0,k=m.length;j<k;j++){
				if((' '+m[j].className+' ').indexOf(' '+t+' ')!==-1)_.push(m[j])
			}
	});
		return _;
	};
	var $=function(a,b){return rule(a,b)};
</script>
```
使用方法示例
```
<script type="text/javascript">
/*示例*/
$('#test1.c1');/*取得test1下面所有class="c1"的元素*/
$('#test1>li');/*取得test1下面所有标签为li的元素*/
$('#test1.c1>a');/*取得#test1下面所有class="c1"元素下的标签为a的元素*/
//---------------------------------------------------------------
$('.c1',document.getElementById('test1'));/*第二个参数为范围,取得test1内的所有class="c1"的元素*/
</script>
```

转自：http://www.lowxp.com/g/article/detail/113