title: 【转载】谷歌 HTML:CSS 规范
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -html
    -css
    -谷歌
    -规范
---

#【转载】谷歌 HTML/CSS 规范
##背景

这篇文章定义了 HTML 和 CSS 的格式和代码规范，旨在提高代码质量和协作效率。

##通用样式规范

###协议

省略图片、样式、脚本以及其他媒体文件 URL 的协议部分（http:,https:），除非文件在两种协议下都不可用。这种方案称为 protocol-relative URL，好处是无论你是使用 HTTPS 还是 HTTP 访问页面，浏览器都会以相同的协议请求页面中的资源，同时可以节省一部分字节。
```html
<!-- Not recommended -->
<script src="https://www.google.com/js/gweb/analytics/autotrack.js"></script>
<!-- Recommended -->
<script src="//www.google.com/js/gweb/analytics/autotrack.js"></script>
```
```css
/* Not recommended */
.example {
  background: url("https://www.google.com/images/example");
}
/* Recommended */
.example {
  background: url("//www.google.com/images/example");
}
```
##通用格式规范

###缩进

一次缩进2个空格，不要使用 tab 或者混合 tab 和空格的缩进。
```html
<ul>
  <li>Fantastic
  <li>Great
</ul>
```
```css
.example {
  color: blue;
}
```
###大小写

以下都应该用小写：HTML 元素名称，属性，属性值（除非 text/CDATA），CSS 选择器，属性，属性值。
```html
<!-- Not recommended -->
<A HREF="/">Home</A>
<!-- Recommended -->
<img src="google.png" alt="Google">
```
```css
/* Not recommended */
color: #E5E5E5;
/* Recommended */
color: #e5e5e5;
```
###结尾空格

结尾空格不仅多余，而且在比较代码时会更麻烦。
```html
<!-- Not recommended -->
<p>What?_
<!-- Recommended -->
<p>Yes please.
```
##通用元规范

###编码

在 HTML 中通过 `<meta charset=”utf-8″>` 指定编码方式，CSS 中不需要指定，因为默认是 UTF-8。

###注释

使用注释来解释代码：包含的模块，功能以及优点。

###任务项

用 TODO 来标记待办事项，而不是用一些其他的标记，像 @@。
```html
<!-- TODO: remove optional tags -->
<ul>
  <li>Apples</li>
  <li>Oranges</li>
</ul>
```
##HTML 风格规范

###文档类型

HTML 文档应使用 HTML5 的文档类型：`<!DOCTYPE html>`。
孤立标签无需封闭自身，`<br>` 不要写成 `<br />`。

###HTML 正确性

尽可能使用正确的 HTML。
```html
<!-- Not recommended -->
<title>Test</title>
<article>This is only a test.
<!-- Recommended -->
<!DOCTYPE html>
<meta charset="utf-8">
<title>Test</title>
<article>This is only a test.</article>
```
###语义化

根据使用场景选择正确的 HTML 元素（有时被错误的称为“标签”）。例如，使用 h1 元素创建标题，p 元素创建段落，a 元素创建链接等等。正确的使用 HTML 元素对于可访问性、可重用性以及编码效率都很重要。
```html
<!-- Not recommended -->
<div onclick="goToRecommendations();">All recommendations</div>
<!-- Recommended -->
<a href="recommendations/">All recommendations</a>
```
###多媒体元素降级

对于像图片、视频、canvas 动画等多媒体元素，确保提供其他可访问的内容。图片可以使用替代文本（alt），视频和音频可以使用文字版本。
```html
<!-- Not recommended -->
<img src="spreadsheet.png">
<!-- Recommended -->
<img src="spreadsheet.png" alt="Spreadsheet screenshot.">
```
###关注分离

标记、样式和脚本分离，确保相互耦合最小化。

###实体引用

如果团队中文件和编辑器使用同样的编码方式，就没必要使用实体引用，如 `&mdash;`， `&rdquo;`，`&#x263a;`，除了一些在 HTML 中有特殊含义的字符（如 `<` 和 `&`）以及不可见的字符（如空格）。
```html
<!-- Not recommended -->
The currency symbol for the Euro is “&eur;”.
<!-- Recommended -->
The currency symbol for the Euro is “€”.
```
###type 属性

在引用样式表和脚本时，不要指定 type 属性，除非不是 CSS 或 JavaScript。因为 HTML5 中已经默认指定样式变的 type 是 text/css，脚本的type 是 text/javascript。

```html
<!-- Not recommended -->
<link rel="stylesheet" href="//www.google.com/css/maia.css"
  type="text/css">
<!-- Recommended -->
<link rel="stylesheet" href="//www.google.com/css/maia.css">
<!-- Not recommended -->
<script src="//www.google.com/js/gweb/analytics/autotrack.js"
  type="text/javascript"></script>
<!-- Recommended -->
<script src="//www.google.com/js/gweb/analytics/autotrack.js"></script>
```
##HTML 格式规范

###HTML 引号

属性值用双引号。
```html
<!-- Not recommended -->
<a class='maia-button maia-button-secondary'>Sign in</a>
<!-- Recommended -->
<a class="maia-button maia-button-secondary">Sign in</a>
```
##CSS 风格规范

###ID 和 Class 命名

使用有含义的 id 和 class 名称。
```css
/* Not recommended: meaningless */
#yee-1901 {}

/* Not recommended: presentational */
.button-green {}
.clear {}
/* Recommended: specific */
#gallery {}
#login {}
.video {}

/* Recommended: generic */
.aux {}
.alt {}
```
###ID 和 Class 命名风格

id 和 class 应该尽量简短，同时要容易理解。
```css
/* Not recommended */
#navigation {}
.atr {}
/* Recommended */
#nav {}
.author {}
```
###选择器

除非需要，否则不要在 id 或 class 前加元素名。
```css
/* Not recommended */
ul#example {}
div.error {}
/* Recommended */
#example {}
.error {}
```
###属性简写

尽量使用 CSS 中可以简写的属性 (如 font)，可以提高编码效率以及代码可读性。
```css
/* Not recommended */
border-top-style: none;
font-family: palatino, georgia, serif;
font-size: 100%;
line-height: 1.6;
padding-bottom: 2em;
padding-left: 1em;
padding-right: 1em;
padding-top: 0;
/* Recommended */
border-top: 0;
font: 100%/1.6 palatino, georgia, serif;
padding: 0 1em 2em;
```
###0 和单位

值为 0 时不用添加单位。
```css
margin: 0;
padding: 0;
开头的 0
```
值在 -1 和 1 之间时，不需要加 0。
```css
font-size: .8em;
```
###16进制表示法
```css
/* Not recommended */
color: #eebbcc;
/* Recommended */
color: #ebc;
```
###前缀

使用带前缀的命名空间可以防止命名冲突，同时提高代码可维护性。
```css
.adw-help {} /* AdWords */
#maia-note {} /* Maia */
```
###ID 和 Class 命名分隔符

选择器中使用连字符可以提高可读性。
```css
/* Not recommended: does not separate the words “demo” and “image” */
.demoimage {}

/* Not recommended: uses underscore instead of hyphen */
.error_status {}
/* Recommended */
#video-id {}
.ads-sample {}
```
##CSS 格式规范

###书写顺序

按照属性首字母顺序书写 CSS 易于阅读和维护，排序时忽略带有浏览器前缀的属性。
```css
background: fuchsia;
border: 1px solid;
-moz-border-radius: 4px;
-webkit-border-radius: 4px;
border-radius: 4px;
color: black;
text-align: center;
text-indent: 2em;
```
###块级内容缩进

为了反映层级关系和提高可读性，块级内容都应缩进。
```css
@media screen, projection {

  html {
    background: #fff;
    color: #444;
  }

}
```
###声明结束

每行 CSS 都应以分号结尾。
```css
/* Not recommended */
.test {
  display: block;
  height: 100px
}
/* Recommended */
.test {
  display: block;
  height: 100px;
}
```
###属性名结尾

属性名和值之间都应有一个空格。
```css
/* Not recommended */
h3 {
  font-weight:bold;
}
/* Recommended */
h3 {
  font-weight: bold;
}
```
###声明样式块的分隔

在选择器和 {} 之间用空格隔开。
```css
/* Not recommended: missing space */
#video{
  margin-top: 1em;
}

/* Not recommended: unnecessary line break */
#video
{
  margin-top: 1em;
}
/* Recommended */
#video {
  margin-top: 1em;
}
```
###选择器分隔

每个选择器都另起一行。
```css
/* Not recommended */
a:focus, a:active {
  position: relative; top: 1px;
}
/* Recommended */
h1,
h2,
h3 {
  font-weight: normal;
  line-height: 1.2;
}
```
###规则分隔

规则之间都用空行隔开。
```css
html {
  background: #fff;
}

body {
  margin: auto;
  width: 50%;
}
```
###CSS 引号

属性选择器和属性值用单引号，URI 的值不需要引号。
```css
/* Not recommended */
@import url("//www.google.com/css/maia.css");

html {
  font-family: "open sans", arial, sans-serif;
}
/* Recommended */
@import url(//www.google.com/css/maia.css);

html {
  font-family: 'open sans', arial, sans-serif;
}
```
##CSS 元规则

###分段注释

用注释把 CSS 分成各个部分。
```css
/* Header */

#adw-header {}

/* Footer */

#adw-footer {}

/* Gallery */

.adw-gallery {}
```
##结语

坚持遵循代码规范。

写代码前先看看周围同事的代码，然后决定代码风格。

代码规范的意义在于提供一个参照物。这里提供了一份全局的规范，但是你也得参照公司内部的规范，否则阅读你代码的人会很痛苦。
