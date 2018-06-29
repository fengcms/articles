title: Javascript 的 Attribute 方法
date: 2015-09-10 11:13:28 +0800
update: 2015-09-10 11:13:28 +0800
author: fungleo
tags:
    -javascript
    -Attribute
---

和 jQuery 不一样，JQ提供了各种各样的查询不同参数的方法，比如 .data .val 之类的。但在原生js里面，这些方法通通不适用了。

而 js 的 Attribute 方法则可以满足绝大多数需求。

```
// 获取某个参数
.getAttribute("data-year");
// 设置某个参数
.setAttribute("value","2014");
// 删除某个参数
.removeAttribute("class");
```

这个方法适用很多场景。算是万能钥匙-_-~~~