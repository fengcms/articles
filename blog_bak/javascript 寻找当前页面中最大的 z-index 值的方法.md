title: javascript 寻找当前页面中最大的 z-index 值的方法
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -javascript
    -z-index
    -Math.max
    -reduce
    -window.getComputedStyle
---

# javascript 寻找当前页面中最大的 z-index 值的方法

我们在写类似 `toast` 这样的组件的时候，会希望我们的弹出层在当前页面的最上层，也就是说，希望 `z-index` 值为最大。所以，我们需要找到当前页面中最大的 `z-index` 值，然后把这个值 `+1` 即可。

我们先来想一想思路。

我们可以把 `DOM` 中的所有元素集合起来，然后转化成一个数组，然后我们遍历这个数组，把所有元素的 `z-index` 值提取出来，然后就形成了一个纯数字的数组，最后从中取到最大值，就是当前页面中的最大的 `z-index` 值了。

好，将我们的思路，转化为代码，我们一个一个来解决。

## 将思路转化为代码

###找到所有的元素，转化为数组

**方法1：**

```js
Array.from(document.querySelectorAll('body *'))
```

我们用 `querySelectorAll` 形成的是一个类数组结构，但不是数组，不支持数组方法。因此，使用 `Array.from` 方法，将它转化为真正的数组。

**方法2：**

```js
Array.from(document.body.querySelectorAll('*'))
```

嗯，没什么区别，但是这样比上面好看一点。从性能上，要比第一种要强一点点。

**方法3：**

```js
[...document.body.querySelectorAll('*')]
```

用 ES6 方法，将类数组转化为数组。

**方法4：**

```js
[...document.all]
```

从 `body` 中寻找，和从全部中寻找，性能差异几乎没差，关键是，代码好看了许多。就酱紫。

###查找元素的 Z-INDEX 值

> 下面示例中 `__DOM__` 为伪代码，指 `dom` 元素。

**方法1（错误示范）：**

```js
__DOM__.style.zIndex
```

嗯，这样只能找到行内样式中的 `z-index` 值，如果是写在 `css` 文件中的，那么就找不到了。

所以，这是一个错误的示范。

**方法2:**

我们要找到元素的真实 `css` 属性，就必须使用 `window.getComputedStyle()` 方法。

```js
window.getComputedStyle(__DOM__).zIndex
```

这样，我们就可以拿到元素的 `z-index` 值了。但是问题是，我们拿到的不一定是一个数字，而可能是 `auto` 这样的字符串值，我们就需要处理一下了。

![window.getComputedStyle(__DOM__).zIndex](https://img-blog.csdn.net/2018060109552636?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0Z1bmdMZW8=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

逻辑非常简单，就是将这个值转化为数字，如果是 `NaN` 就覆盖为 `0` ，否则，就给原值即可。

```js
// 正常写法
Number(window.getComputedStyle(__DOM__).zIndex) || 0

// 简写写法
+window.getComputedStyle(__DOM__).zIndex || 0
```

![Number(window.getComputedStyle(__DOM__).zIndex)](https://img-blog.csdn.net/20180601095723430?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0Z1bmdMZW8=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

### 数组中寻找最大值

这个没什么难度了。

**方法1：**

```js
Math.max.apply(null, arr)
```

这个是一贯的寻找最大值的方法。

**方法2：**

```js
Math.max(...arr)
```

其实和第一种一样，不过是 ES6 的写法罢了。

**方法3：**

```js
arr.reduce((num1, num2) => {
    return num1 > num2 ? num1 : num2}
)
```

`reduce` 方法是一个比较高级的方法，它会把数组序号 0 的值和数组序号 1 的值用自定义的函数进行计算，然后将返回的结果，和数组序号 3 的值再次进行自定义函数的计算，直到数组里的每一个值都计算完成。

上面的代码就是一个简单的对比函数。

至于其他 `for` 循环，以及排序方法就不赘述了。

好，两个本质问题解决，下面我们来组装代码。

## 查找当前页面 z-index 最大值实现代码

**方法1**

```js
var arr = [...document.all].map(e => +window.getComputedStyle(e).zIndex || 0)
return arr.length ? Math.max(...arr) : 0
```

如上，我们轻松的实现了效果。

这里需要注意的是，`Math.max()` 方法如果对一个空数组进行处理，是会出错的，所以上面进行了一个数组长度判断，来避免出错。

**方法2**

前面用的方法，是我们之前的设想的思路，我感觉这个思路是大多数人都可以想到的。

但是这个方法，先整了一个数组，然后再在数组里面寻找最大值，我感觉这个运算量还是比较大的，我就想，可以不可以用更轻的运算，来实现这个功能。

我们来看一下，上面说的，我们从一组数组中寻找最大值的方法的方法3，`reduce()` 方法。我们是不是可以直接进行运算呢？说干就干，代码如下：

```js
return [...document.all].reduce((r, e) => Math.max(r, +window.getComputedStyle(e).zIndex || 0), 0)
```

我们知道，如果是空数组的话，用 `reduce` 是会出错的，所以，我们需要加上一个默认的计算值—— `0` 。如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/2e/1ccd6922dd9daff54ed22b8867ecaf.png)
>`initialValue`可选
>用作第一个调用 `callback` 的第一个参数的值。 如果没有提供初始值，则将使用数组中的第一个元素。 在没有初始值的空数组上调用 `reduce` 将报错。
>https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce

这样，就可以避免为空的时候的错误了。

>`document.all` 在获取元素类数组的时候，即便为空页面，也是可以得到非空的数组的。但是，我们写代码，一定要考虑异常状况。

## 小结

我听说这个题目是某些公司的面试题，然后我就思考了一下，写出了本文。和大多数写博客的人不一样，我不太喜欢一上来就扔一段代码给大家，我更希望把自己的思路给说清楚，这样便于大家理解。更重要的是，希望大家可以从我的思路中学习到解决问题的方法，而不仅仅是复制一段代码。

遇到问题，首先要做的是分析问题，把一个大的问题，拆分成几个小的问题，然后逐个的把这些小的问题解决，最终，把大问题给解决。

如果问题得到了解决，我们就需要尝试换一个思路，看看这个问题能不能用其他的思路来解决，无论这个其他的思路是有效的，还是无效的，亦或者是能效比不高的，都没有关系。举一反三的思考问题，才能使我们的学习更加进步。

本文由FungLeo原创，允许转载，但转载必须附带首发链接。

