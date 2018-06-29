title: Styling Broken Images (给加载失败的图片加上css样式) - 不完全翻译
date: 2017-02-22 10:06:21 +0800
update: 2017-02-22 10:06:21 +0800
author: fungleo
tags:
    -css
    -图片
    -加载失败
    -alt
---

# Styling Broken Images (给加载失败的图片加上css样式) - 不完全翻译

## 前言

> Broken images are ugly.
￼![](http://www.baidu.com/)
But they don’t always have to be. We can use CSS to apply styles to the <img> element to provide a better experience than the default.

图片加载失败的默认样式是很难看的。但是我们可以加上样式来处理

## 两个知识点 （Two Facts About The <img> Element）

>1. We can apply regular typography-related styling to the <img> element. These styles will be applied to the alternative text, if it is displayed, and will not affect the working image.
>2. The <img> element is a replaced element. This is an element “whose appearance and dimensions are defined by an external resource” (Sitepoint). Because the element is controlled by an external source, the :before and :after pseudo-elements typically shouldn’t work with it. However, when the image is broken and not loaded, these pseudo-elements can appear. 

1. 如果图片没有加载出来，我们可以给`alt`值增加样式
2. 如果图片没有加载出来，我们可以设置`:before`和`:after`伪元素。当然，图片正常加载时是没作用的。

## 实战
准备一张图片先
```html
<img src="http://bitsofco.de/broken.jpg" alt="Kanye Laughing">
```

### 给失败图片添加帮助信息

> One way we can handle broken images is to provide a message to the user saying that the image is broken. Using the attr() expression, we can even display the link to the broken image.

我们可以给加载失败的图片提供帮助文案，甚至可以利用`attr()`属性将图片的原始路径显示出来
![](https://raw.githubusercontent.com/fengcms/articles/master/image/c4/2e0445ef917db07fae45b3ac41b500.jpg)
```css
img {  
  font-family: 'Helvetica';
  font-weight: 300;
  line-height: 2;  
  text-align: center;

  width: 100%;
  height: auto;
  display: block;
  position: relative;
}

img:before {  
  content: "We're sorry, the image below is broken :(";
  display: block;
  margin-bottom: 10px;
}

img:after {  
  content: "(url: " attr(src) ")";
  display: block;
  font-size: 12px;
}
```
我们可以把里面的英文变成中文的哈~

### 替换默认文本（alt值）

>Alternatively, we can use the pseudo-elements to replace the default alt text that shows, by positioning the pseudo-element on top of the default text, hiding it from view.

我们可以把`alt`值读取出来，放在伪元素里面显示，然后用定位的方式进行排版

![](https://raw.githubusercontent.com/fengcms/articles/master/image/39/2763495064ac64b8428d52025f299c.jpg)
```css
img {  
  font-family: 'Helvetica';
  font-weight: 300;
  line-height: 2;  
  text-align: center;

  width: 100%;
  height: auto;
  display: block;
  position: relative;
}
img:after {  
  content: "\f1c5" " " attr(alt);

  font-size: 16px;
  font-family: FontAwesome;
  color: rgb(100, 100, 100);

  display: block;
  position: absolute;
  z-index: 2;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: #fff;
}

```

### 更好看的样式

已经这样了，不如发挥才智，做的更漂亮吧！

![](https://raw.githubusercontent.com/fengcms/articles/master/image/af/bfb1b5b5da17e67432d0b776cc184f.jpg)

```css
img {  
  font-family: 'Helvetica';
  font-weight: 300;
  line-height: 2;  
  text-align: center;

  width: 100%;
  height: auto;
  display: block;
  position: relative;

  min-height: 50px;
}

img:before {  
  content: " ";
  display: block;

  position: absolute;
  top: -10px;
  left: 0;
  height: calc(100% + 10px);
  width: 100%;
  background-color: rgb(230, 230, 230);
  border: 2px dotted rgb(200, 200, 200);
  border-radius: 5px;
}

img:after {  
  content: "\f127" " Broken Image of " attr(alt);
  display: block;
  font-size: 16px;
  font-style: normal;
  font-family: FontAwesome;
  color: rgb(100, 100, 100);

  position: absolute;
  top: 5px;
  left: 0;
  width: 100%;
  text-align: center;
}

```

如果图片加载成功，那么这些css是没有作用的。原文在这里放了一个黑人照片，我不喜欢。就不放了。

## 浏览器兼容性

| Browser | Alt Text | :before | :after |
|-------|--------|-------|-------|
| Chrome (Desktop and Android) | √ | √ | √ |
| Firefox (Desktop and Android) | √ | √ | √ |
| Opera (Desktop) | √ | √ | √ |
| Opera Mini | √ ** | ✘ | ✘ |
| Safari (Desktop and iOS) | √ * | ✘ | ✘ |
| iOS Webview (Chrome, Firefox, others) | √ * | ✘ | ✘ |

`*`  `alt` 需要一定的宽度，否则不会显示
`**` 字体无法设置样式

## 小结
>For browsers that don’t support the pseudo-elements, the styles applied are ignored, so they don’t interfere in a breaking way. This means that we can still apply the styles and serve a more pleasant experience for users on a supporting browser.

总结就是一句，这个用法是可以完美降级的，大家放心使用！

原文地址：[Styling Broken Images
](https://bitsofco.de/styling-broken-images/)

英文不好，第一次翻译文章，大家见谅。

