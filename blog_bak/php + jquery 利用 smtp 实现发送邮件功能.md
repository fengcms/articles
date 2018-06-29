title: php + jquery 利用 smtp 实现发送邮件功能
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -jquery
    -php
    -smtp
    -php发邮件
---

#php + jquery 利用 smtp 实现发送邮件功能

在做一个企业站的小项目，用户不希望登录到后台查看留言，而是希望留言能直接发送到自己的邮箱里，然后这样他就可以在手机上快速的处理这些用户的留言了。不过这个功能我自己开发的 fengcms 并不支持，而且目前没有了解php的朋友在身边。本着自己动手丰衣足食的精神，自己解决这个问题吧。

##实现设想

我希望通过`ajax`来实现这个功能。因为邮件本质来说，只有两个内容字段，一个是标题，一个是正文。而我们网页上通常有很多表单来让用户填写，因此，如果是用`php`来整合组装这些字段的话，不是不可以，而是比较繁琐，而且不能通用。我是一名前端工程师，因此，当然希望用前端的方法来解决这些问题。我的设想规划如下
|文件|说明|
|-
|msn.html|提交留言表单html文件|
|mail.php|php邮件处理核心文件|
|send_mail.php|html和mail.php的沟通文件|

通过`msn.html`构造表单，并利用`jquery`的`ajax`功能，将信息构造成`json`信息，`post` 到 `send_mail.php` 文件。`send_mail.php`处理邮件逻辑，并调用`mail.php`核心参数，来实现邮件的发送。

##逐步实现
**mail.php的实现**
```php
<?php
// Pear Mail Library
require_once "Mail.php";

const SMTP = 'smtp.163.com';
const PORT = '25';
const USERNAME = 'username@163.com';
const PASSWORD = 'password';


function send_mail($subject, $body) {
    $from = '<username@163.com>';
    $to = '<inbox@163.com.com>';
    $headers = array(
        'From' => $from,
        'To' => $to,
        'Subject' => $subject
    );

    $smtp = Mail::factory('smtp', array(
            'host' => SMTP,
            'port' => PORT,
            'auth' => true,
            'username' => USERNAME,
            'password' => PASSWORD
        ));

    $mail = $smtp->send($to, $headers, $body);

    if (PEAR::isError($mail)) {
        return true;
    } else {
        return false;
    }
}
?>
```
**send_mail.php的实现**
```php
<?php
    require_once 'mail.php';

    $raw = file_get_contents('php://input');
    $json = json_decode($raw);
    if (!send_mail($json->subject, $json->body)) {
        echo('{"code":0, "message":"发送成功。"}');
    } else {
        echo('{"code":1, "message":"发送失败。"}');
    }
?>
```
**msn.html的实现**
```html
	<section class="msn">
		<input type="text" class="title" name="title" value="title">
		<textarea name="content" class="content">content</textarea>
		<input type="button" class="submit_msn" value="提交">
	</section>
	<script>
	$(function(){
		$(".submit_msn").on("click",function(){
			var url = "/send_mail.php";
			var data = {};
			data.subject = $(".title").val();
			data.body = $(".content").val();
			console.log(data)
			ajaxPost(url,JSON.stringify(data))
		})
	})
	function ajaxPost(url,data){
		$.ajax({
			type:'post',
			dataType: "json",
			data: data,
			url:url,
			success: function (data) {
	            if(data.code==0){
	                alert("您的留言已经提交成功，我们将尽快答复您！")
	            }else{
	                alert("好像服务器出问题了呢T_T，您还是直接电话联系我们吧！")
	            }
	        },
			error: function (data) { alert("服务器不支持发送邮件") }
		});
	}
	</script>
```
##小结

核心代码就是这些了。剩下前端需要增加字段，增加验证，send_mail.php也需要增加验证，这个功能才能正式上线。php发送邮件的代码是网上找的。其他都是自己解决的。因此也算是原创吧。

首发地址：http://blog.csdn.net/fungleo/article/details/52995053 允许转载，但转载必须注明首发地址，谢谢。