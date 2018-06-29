title: [转载]CSS居中完全指南
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -css
    -居中
    -垂直居中
---

原载于[CSS-Trick](https://css-tricks.com/centering-css-complete-guide/)，本文着重提取文中的方法，不完全翻译。如有需要，直接原文查看。

人们经常抱怨在CSS中居中元素的问题，其实这个问题其实并不复杂，只是因为方法众多，需要根据情况从众多方法中选取一个出来。接下来，我们做一个‘决定树’来帮我们把问题变的简单一点。首先你需要居中：

*   水平

    *   需要居中 `inline` 或者 `inline-*` 元素（如文字或者链接）？

    *   需要居中 `block` 类的元素？

    *   需要居中多个 `block` 元素？

*   垂直

    *   需要居中 `inline` 或者 `inline-*` 元素（如文字或者链接）？

    *   需要居中 `block` 类的元素？

*   既水平又垂直

    *   固定宽高

    *   不固定宽高

    *   使用 `flexbox`

## 水平居中

### 水平居中 `inline` 或者 `inline-*` 元素

你可以轻松的在一个 `block` 元素中水平居中一个 `inline` 元素，以下代码对 `inline`，`inline-block`，`inline-table` 和 `inline-flex` 等有效

```language
.parent {
  text-align: center;
}
```

### 水平居中 `block` 类的元素

在 `block` 元素被设定固定宽度的情况下，可以使用设置元素 `margin-left` 和 `margin-right` 的值为 `auto` 的方法实现水平居中。

```language
.child {
  width: 400px;
  margin: 0 auto;
}
```

### 水平居中多个 `block` 类的元素

通过 `inline-block`实现

```language
.parent {
  text-align: center;
}
.child {
  display: inline-block;
  text-align: left;
}
```

通过 `flexbox` 实现

```language
.parent {
  display: flex;
  justify-content: center;
}
```

## 垂直居中

### 垂直居中 `inline` 或者 `inline-*` 元素

#### 单行

`inline/text` 元素可以简单的用设置相同的上下 `padding` 值达到垂直居中的目的。

```language
.center {
  pading-top: 30px;
  padding-bottom: 30px;
}
```

如果因为某种原因不能使用 `padding` 的方法，你还可以设置 `line-height` 等于 `height`来达到目的。

```language
.center {
  height: 100px;
  line-height: 100px;
  white-space: nowrap;
}
```

#### 多行

相同的上下 `padding` 也可以适用于此种情况，如果不能生效，你可以尝试将该元素的父元素的 `dispaly` 设置为 `table` ，同时该元素的 `dispaly` 设置为 `table-cell`，然后设置 `vertical-align`。

```language
.parent {
  display: table;
  width: 200px;
  height: 400px;
}
.child {
  display: table-cell;
  vertical-align: middle;
}
```

如果上述方法不能使用，你可以尝试使用 `flexbox`,一个单独的 `flexbox` 子元素可以轻易的在其父元素中居中。谨记，这种方法需要父元素有固定的高度。

```language
.parent {
  display: flex;
  justify-content: center;
  flex-direction: column;
  height: 400px;
}
```

如果上述两种方式均不能使用，你可以使用“幽灵元素”技术，这种方法采用伪元素 `::before` 撑开高度 ，文字垂直居中。

```language
.parent {
  position: relative;
}
.parent::before {
  content: " ";
  display: inline-block;
  height: 100%;
  width: 1%;
  vertical-align: middle;
}
.child {
  display: inline-block;
  vertical-align: middle;
}
```

> 转载说明，上面的代码是原文给的。但是这段代码会产生一些问题，我在另外一篇博文中阐释了原因以及解决方案，请移步 [CSS 幽灵元素方案垂直居中注意事项](http://blog.csdn.net/FungLeo/article/details/77344476)

### 垂直居中 block 类的元素

#### 已知元素高度

```language
.parent {
  position: relative;
}
.child {
  position: absolute;
  top: 50%;
  height: 100px;
  margin-top: -50px; /* account for padding and border if not using box-sizing: border-box; */
}
```

#### 未知元素高度

```language
.parent {
  position: relative;
}
.child {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
}
```

#### 使用 `flexbox`

```language
.parent {
  display: flex;
  flex-direction: column;
  justify-content: center;
}
```
## 既水平又垂直

### 固定宽高

```language
.parent {
  position: relative;
}

.child {
  width: 300px;
  height: 100px;
  padding: 20px;

  position: absolute;
  top: 50%;
  left: 50%;

  margin: -70px 0 0 -170px;
}
```

### 不固定宽高
```language
.parent {
  position: relative;
}
.child {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
```

### 使用 `flexbox`
```language
.parent {
  display: flex;
  justify-content: center;
  align-items: center;
}
```

- - -

英文原文地址:https://css-tricks.com/centering-css-complete-guide/
中文原文地址:https://segmentfault.com/a/1190000004517401