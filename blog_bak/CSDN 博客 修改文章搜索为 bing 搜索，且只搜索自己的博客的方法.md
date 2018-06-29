title: CSDN 博客 修改文章搜索为 bing 搜索，且只搜索自己的博客的方法
date: 2017-11-10 14:09:25 +0800
update: 2017-11-10 14:09:25 +0800
author: fungleo
tags:
    -搜索
    -博客
    -bing
    -csdn
    -html
---

# CSDN 博客 修改文章搜索为 bing 搜索，且只搜索自己的博客的方法

`csdn` 自带的博客搜索调用的百度的代码，但是搜索效果很不理想，而且默认为全站搜索。

在我们的博客里面进行搜索的大多数人，都应该是希望只搜索当前博客的。所以我就写了一段代码，来实现这个功能。

> 首先，你必须是博客专家，有插入 `html` 的权限。

## 插入自定义组件

`CSDN` 的博客专家允许插入自定义的 `html` 代码。但是我尝试了一下，不能直接执行 `js` 代码，否则这个功能的实现就是一件非常简单的事情了。

由于不能执行 `js` 代码，我只能另辟蹊径，用一个 `form` 将关键词传出去，然后在我自己的网站里面接收这个关键词，并进行搜索工作。

如何插入自定义组件不谈，只说插入代码如下：

```html
<div class="search-bing">
  <form action="http://www.fengcms.com/blogsearch.php" method="get" target="_blank">
    <input class="bing-keyword" name="keyword" type="text" placeholder="请输入关键词">
    <input class="bing-submit" type="submit" value="搜索">
  </form>
</div>
<style>
  .search-bing {position: relative;height: 40px;}
  .bing-keyword,.bing-submit {
    display: block;border: 1px solid;box-sizing: border-box;height: 40px;padding: 5px;border-radius: 0;outline: none;
  }
  .bing-keyword {
    width: 100%;border-color: #ddd;
  }
  .bing-keyword:focus {
    border-color: #20A0FF;
  }
  .bing-submit {
    position: absolute; width: 50px;right: 0;top: 0;font-size: 14px;cursor: pointer;background: #20A0FF;color: #fff;border-color: #20A0FF;
  }
  .bing-submit:hover,.bing-submit:focus {
    background: #1D8CE0;border-color: #1D8CE0;
  }
</style>
```

代码没什么特殊的，只是一个普通表单。另外加上一点样式而已。

## 关键词PHP处理程序

如上代码，表单会把关键词传送给 `http://www.fengcms.com/blogsearch.php` 这个地址。然后我这里如何处理呢，请看代码如下：

```php
<?php
$url = "https://cn.bing.com/search?q=site%3Ablog.csdn.net%2Ffungleo+".$_GET["keyword"];
echo "<script>";
echo "window.location.href='$url'";
echo "</script>";
?>
```

代码非常简单，通过 `$_GET` 获取关键词参数，与 `bing` 搜索的地址拼接，然后通过 `js` 跳转走，就好了。

由于我不会 `php` 所以用了 `js` 的跳转方式。可能直接写 `php` 会更短。

## 关键词JS处理程序

脑子坏掉了，还查了点PHP的东西来实现，其实，纯 html + js 照样实现这个需求，代码如下：

```html
<!DOCTYPE html>
<html lang="zh-CN">
  <meta charset="UTF-8">
  <script>
  function GetQueryString(name){
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if(r!=null)return  decodeURI(r[2]); return null;
  }
  window.location.href="https://cn.bing.com/search?q=site%3Ablog.csdn.net%2Ffungleo+" + GetQueryString('keyword')
  </script>
</html>
``` 
## 2017年11月21日 补充一个大家都能用的HTML代码

本来想来我这篇文章应该没什么人看。但是我看访问量都挺高。我上面说的实现方法是需要自己有一个存放处理程序的服务器或者虚拟主机。既然大家有需要，我写了一个公共的代码，你们只要插入这段代码即可。

```html
<div class="search-bing">
  <form action="http://www.fengcms.com/blogsearch.html" method="get" target="_blank">
    <input class="bing-keyword" name="keyword" type="text" placeholder="请输入关键词">
    <!-- 请将下面的 fungleo 替换成你自己的博客二级路径 -->
    <input type="hidden" name="blog" value="fungleo">
    <input class="bing-submit" type="submit" value="搜索">
  </form>
</div>
<style>
  .search-bing {position: relative;height: 40px;}
  .bing-keyword,.bing-submit {
    display: block;border: 1px solid;box-sizing: border-box;height: 40px;padding: 5px;border-radius: 0;outline: none;
  }
  .bing-keyword {
    width: 100%;border-color: #ddd;
  }
  .bing-keyword:focus {
    border-color: #20A0FF;
  }
  .bing-submit {
    position: absolute; width: 50px;right: 0;top: 0;font-size: 14px;cursor: pointer;background: #20A0FF;color: #fff;border-color: #20A0FF;
  }
  .bing-submit:hover,.bing-submit:focus {
    background: #1D8CE0;border-color: #1D8CE0;
  }
</style>
```

> 以上代码可以在本地测试OK之后再添加到 csdn 博客上。另外，无偿提供服务，不保证永久提供。不过服务器续费了好几年的。放心吧。

这篇博文对于大多数人都没啥用。大多数 `CSDN` 的博主可能都会自己弄。算了，写给我自己看吧。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


