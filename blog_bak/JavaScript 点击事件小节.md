title: JavaScript 点击事件小节
date: 2015-09-10 11:33:43 +0800
update: 2015-09-10 11:33:43 +0800
author: fungleo
tags:
    -javascript
    -onclick
    -事件
---

在初学JS的过程中，所有的事件都是一个　 onclick  但是这个事件是不太合适的。

```
onclick  //点击实现建议用下面的 onmouseup 事件替代
onmouseup  // 当点击时鼠标放开
onmousedown	//鼠标按钮被按下。
onmousemove	//鼠标被移动。
onmouseout	//鼠标从某元素移开。
onmouseover	//鼠标移到某元素之上。

```

而在手机上，则又不一样了

```
ontouchstart	//当按下手指时
ontouchmove	//当移动手指时
ontouchend	//当移走手指时
ontouchcancel	//当一些更高级别的事件发生的时候（如电话接入或者弹出信息）会取消当前的touch操作，即触发ontouchcancel。一般会在ontouchcancel时暂停游戏、存档等操作。
```

```
可以用 ontouchend 在移动端替代　 onclick
```