title: 【转载】文件上传那些事儿，文件ajax无刷上传
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -文件上传
    -文件上传进度
    -文件ajax上传
---

#文件上传那些事儿，文件ajax无刷上传

> 最近做了一个vue的文件上传组件，整准备整理一下，微博上看到这篇文章，讲得非常详细，就转载过来了。

##导语

　　正好新人导师让我看看能否把产品目前使用的FileUploader从老的组件库分离出来的，自己也查阅了相关的各种资料，对文件上传的这些事有了更进一步的了解。把这些知识点总结一下，供自己日后回顾，也供有需要的同学参考，同时也欢迎各位大牛拍砖指点共同学习。

##FileUpload 对象

　　在网页上传文件，最核心元素就是这个HTML DOM的FileUpload对象了。什么鬼？好像不太熟啊~别急，看到真人就熟了：
```html
<input type="file">
```

　　就是他啊！其实在 HTML 文档中该标签每出现一次，一个 FileUpload 对象就会被创建。该标签包含一个按钮，用来打开文件选择对话框，以及一段文字显示选中的文件名或提示没有文件被选中。

　　把这个标签放在<form>标签内，设置form的action为服务器目标上传地址，并点击submit按钮或通过JS调用form的submit()方法就可以实现最简单的文件上传了。

```html
<form id="uploadForm" method="POST" action="upload" enctype="multipart/form-data">
    <input type="file" id="myFile" name="file"></input>
    <input type="submit" value="提交"></input>
</form>
```
这样就完成功能啦？没错。但是你要是敢提交这样的代码，估计脸要被打肿

　　都什么年代了，我们要的是页面无刷新上传！

##更优雅的上传

　　现代网页通过什么来实现用户与服务器的无刷新交互？

　　——XMLHttpRequest

　　对，就是这个你很熟悉的家伙。如果你开发的产品支持的浏览器是现代浏览器，那么恭喜你，文件上传就是这么easy！特别强调强调现代浏览器是因为我们接下来讨论的XMLHttpRequest指的是XMLHttpRequest Level 2。

　　那什么是Level 1？为什么不行？因为它有如下限制：

1. 仅支持文本数据传输, 无法传输二进制数据.
2. 传输数据时, 没有进度信息提示, 只能提示是否完成.
3. 受浏览器 同源策略 限制, 只能请求同域资源.
4. 没有超时机制, 不方便掌控ajax请求节奏.

而XMLHttpRequest Level 2针对这些缺陷做出了改进：

1. 支持二进制数据, 可以上传文件, 可以使用FormData对象管理表单.
2. 提供进度提示, 可通过 xhr.upload.onprogress 事件回调方法获取传输进度.
3. 依然受 同源策略 限制, 这个安全机制不会变. XHR2新提供 Access-Control-Allow-Origin 等headers, 设置为 * 时表示允许任何域名请求, 从而实现跨域CORS访问(有关CORS详细介绍请耐心往下读).
4. 可以设置timeout 及 ontimeout, 方便设置超时时长和超时后续处理.

　　关于XMLHttpRequest的细节就不在这里赘述了，有兴趣可以移步[这篇博客](http://louiszhai.github.io/2016/11/02/ajax/)。目前, 主流浏览器基本上都支持XHR2, 除了IE系列需要IE10及更高版本. 因此IE10以下是不支持XHR2的.

　　上面提到的FormData就是我们最常用的一种方式。通过在脚本里新建FormData对象，把File对象设置到表单项中，然后利用XMLHttpRequest异步上传到服务器：

```js
var xhr = new XMLHttpRequest();
var formData = new FormData();
var fileInput = document.getElementById("myFile");
var file = fileInput.files[0];
formdata.append('myFile', file);
 
xhr.open("POST", "/upload.php");
 
xhr.onload = function(){
    if(this.status === 200){
        //对请求成功的处理
    }
}
 
xhr.send(formData);
xhr = null;
```
完成最基本的需求无法满足我们对用户体验的追求，所以我们还想要支持上传进度显示和上传图片预览。

##上传进度

　　因为是XMLHttpRequest Level 2, 所以很容易就可以支持对上传进度的监听。细心地小伙伴会发现在chrome的developer tools的console里new一个XHR对象，调用点运算符就可以看到智能提示出来一个onprogress事件监听器，那是不是我们只要绑定XHR对象的progress事件就可以了呢？

　　很接近了，但是XHR对象的直属progress事件并不是用来监听上传资源的进度的。XHR对象还有一个属性upload, 它返回一个XMLHttpRequestUpload 对象，这个对象拥有下列下列方法：

1. onloadstart
2. onprogress
3. onabort
4. onerror
5. onload
6. ontimeout
7. onloadend

这些方法在XHR对象中都存在同名版本，区别是后者是用于加载资源时，而前者用于资源上传时。其中onprogress 事件回调方法可用于跟踪资源上传的进度，它的event参数对象包含两个重要的属性loaded和total。分别代表当前已上传的字节数（number of bytes）和文件的总字节数。比如我们可以这样计算进度百分比：

```js
xhr.upload.onprogress = function(event) {
    if (event.lengthComputable) {
        var percentComplete = (event.loaded / event.total) * 100;
        // 对进度进行处理
    }
}
```
其中事件的lengthComputable属性代表文件总大小是否可知。如果 lengthComputable 属性的值是 false，那么意味着总字节数是未知并且 total 的值为零。

如果是现代浏览器，可以直接配合HTML5提供的元素使用，方便快捷的显示进度条。

```html
<progress id="myProgress" value="50" max="100">
</progress>
```
其value属性绑定上面代码中的percentComplete的值即可。再进一步我们还可以对<progress>的样式统一调整，实现优雅降级方案，具体参见[这篇文章](http://www.zhangxinxu.com/wordpress/2013/02/html5-progress-element-style-control/)。

再说说我在测试这个progress事件时遇到的一个问题。一开始我设在onprogress事件回调里的断点总是只能走到一次，并且loaded值始终等于total。觉得有点诡异，改用console.log打印loaded值不见效，于是直接加大上传文件的大小到50MB，终于看到了5个不同的百分比值。

因为xhr.upload.onprogress在上传阶段(即xhr.send()之后，xhr.readystate=2之前)触发，每50ms触发一次。所以文件太小网络环境好的时候是直接到100%的。

##图片预览

普通青年的图片预览方式是待文件上传成功后，后台返回上传文件的url，然后把预览图片的img元素的src指向该url。这其实达不到预览的效果和目的。

属于文艺青年的现代浏览器又登场了：“使用HTML5的FileReader API吧！” 让我们直接上代码，直奔主题：
```js
function handleImageFile(file) {
       var previewArea = document.getElementById('previewArea');
       var img = document.createElement('img');
       var fileInput = document.getElementById("myFile");
       var file = fileInput.files[0];
       img.file = file;
       previewArea.appendChild(img);
 
       var reader = new FileReader();
       reader.onload = (function(aImg) {
            return function(e) {
                 aImg.src = e.target.result;
            }
       })(img);
       reader.readAsDataURL(file);
}
```
这里我们使用FileReader来处理图片的异步加载。在创建新的FileReader对象之后，我们建立了onload函数，然后调用readAsDataURL()开始在后台进行读取操作。当图像文件加载后，转换成一个 data: URL，并传递到onload回调函数中设置给img的src。

另外我们还可以通过使用对象URL来实现预览

```js
var img = document.createElement("img");
img.src = window.URL.createObjectURL(file);;
img.onload = function() {
    // 明确地通过调用释放
    window.URL.revokeObjectURL(this.src);
}
previewArea.appendChild(img);
```
##多文件支持

什么？一个一个添加文件太烦？别急，打开一个开关就好了。别忘了我们文章一开头就登场的FileUpload对象，它有一个multiple属性。只要这样
```html
<input id="myFile" type="file" multiple>
```
我们就能在打开的文件选择对话框中选中多个文件了。然后你在代码里拿到的FileUpload对象的files属性就是一个选中的多文件的数组了。
```js
var fileInput = document.getElementById("myFile");
var files = fileInput.files;
var formData = new FormData();
 
for(var i = 0; i < files.length; i++) {
    var file = files[i];
    formData.append('files[]', file, file.name);
}
```
FormData的append方法提供第三个可选参数用于指定文件名，这样就可以使用同一个表单项名，然后用文件名区分上传的多个文件。这样也方便前后台的循环操作。

##二进制上传

有了FileReader，其实我们还有一种上传的途径，读取文件内容后直接以二进制格式上传。

```js
var reader = new FileReader();
reader.onload = function(){
    xhr.sendAsBinary(this.result);
}
// 把从input里读取的文件内容，放到fileReader的result字段里
reader.readAsBinaryString(file);
```
不过chrome已经把XMLHttpRequest的sendAsBinary方法移除了。所以可能得自行实现一个
```js
XMLHttpRequest.prototype.sendAsBinary = function(text){
    var data = new ArrayBuffer(text.length);
    var ui8a = new Uint8Array(data, 0);
    for (var i = 0; i < text.length; i++){ 
        ui8a[i] = (text.charCodeAt(i) & 0xff);
    }
    this.send(ui8a);
}
```
这段代码将字符串转成8位无符号整型，然后存放到一个8位无符号整型数组里面，再把整个数组发送出去。

到这里，我们应该可以结合业务需求实现一个比较优雅的文件上传组件了。等等，哪里优雅了？都不支持拖拽！

##拖拽的支持

利用HTML5的drag & drop事件，我们可以很快实现对拖拽的支持。首先我们可能需要确定一个允许拖放的区域，然后绑定相应的事件进行处理。看代码

```js
var dropArea;
 
dropArea = document.getElementById("dropArea");
dropArea.addEventListener("dragenter", handleDragenter, false);
dropArea.addEventListener("dragover", handleDragover, false);
dropArea.addEventListener("drop", handleDrop, false);
 
// 阻止dragenter和dragover的默认行为，这样才能使drop事件被触发
function handleDragenter(e) {
    e.stopPropagation();
    e.preventDefault();
}
 
function handleDragover(e) {
    e.stopPropagation();
    e.preventDefault();
}
 
function handleDrop(e) {
    e.stopPropagation();
    e.preventDefault();
 
    var dt = e.dataTransfer;
    var files = dt.files;
 
    // handle files ...
}
```

这里可以把通过事件对象的dataTransfer拿到的files数组和之前相同处理，以实现预览上传等功能。有了这些事件回调，我们也可以在不同的事件给我们UI元素添加不同的class来实现更好交互效果。

好了，一个比较优雅的上传组件可以进入生产模式了。什么？还要支持IE9？好吧，让我们来看看IE10以下的浏览器如何实现无刷新上传。

##借用iframe

之前说了要实现文件上传使用FileUpload对象（选择文件）即可。这在低版本的IE里也是适用的。那我们为什么还要用iframe呢？

因为在现代浏览器中我们可以用XMLHttpRequest Level 2来支持二进制数据，异步文件上传，并且动态创建FormData。而低版本的IE里的XMLHttpRequest是Level 1。所以我们通过XHR异步向服务器发上传请求的路走不通了。只能老老实实的用form的submit。

而form的submit会导致页面的刷新。原因分析好了，那么答案就近在咫尺了。我们能不能让form的submit不刷新整个页面呢？答案就是利用iframe。把form的target指定到一个看不见的iframe，那么返回的数据就会被这个iframe接受，于是乎就只有这个iframe会刷新。而它又是看不见的，用户自然就感知不到了。

```js
window.__iframeCount = 0;
var hiddenframe = document.createElement("iframe");
var frameName = "upload-iframe" + ++window.__iframeCount;
hiddenframe.name = frameName;
hiddenframe.id = frameName;
hiddenframe.setAttribute("style", "width:0;height:0;display:none");
document.body.appendChild(hiddenframe);
 
var form = document.getElementById("myForm");
form.target = frameName;
```
然后响应iframe的onload事件，获取response
```js
hiddenframe.onload = function(){
    // 获取iframe的内容，即服务返回的数据
    var resData = this.contentDocument.body.textContent || this.contentWindow.document.body.textContent;
    // 处理数据 。。。
 
    //删除iframe
    setTimeout(function(){
        var _frame = document.getElementById(frameName);
        _frame.parentNode.removeChild(_frame);
    }, 100);
}
```
iframe的实现大致如此，但是如果文件上传的地址与当前页面不在同一个域下就会出现跨域问题。导致iframe的onload回调里的访问服务返回的数据失败。

这时我们再祭出JSONP这把利剑，来解决跨域问题。首先在上传之前注册一个全局的函数，把函数名发给服务器。服务器需要配合在response里让浏览器直接调用这个函数。

```js
// 生成全局函数名，避免冲突
var CALLBACK_NAME = 'CALLBACK_NAME';
var genCallbackName = (function () {
    var i = 0;
    return function () {
        return CALLBACK_NAME + ++i;
    };
})();
 
var curCallbackName = genCallbackName();
window[curCallbackName] = function(res) {
    // 处理response 。。。
 
    // 删除iframe
    var _frame = document.getElementById(frameName);
    _frame.parentNode.removeChild(_frame);
    // 删除全局函数本身
    window[curCallbackName] = undefined;
}
 
// 如果已有其他参数，这里需要判断一下，改为拼接 &callback=
form.action = form.action + '?callback=' + curCallbackName;
```
好了，实现一个文件上传组件的基本知识点大致总结了一下。在这些基础知识之上我们开始可以为我们的业务开发各种酷炫的File Uploader了。在之后的开发中会把相关的更细的知识点也总结进来，不足之处也欢迎大家指正。

原文地址：https://www.qcloud.com/community/article/985614
作者：谭伟华

如果转载侵犯版权请私信告知