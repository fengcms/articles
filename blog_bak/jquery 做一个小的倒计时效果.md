title: jquery 做一个小的倒计时效果
date: 2015-10-27 13:08:05 +0800
update: 2015-10-27 13:08:05 +0800
author: fungleo
tags:
    -jquery
    -倒计时
---

##html
```
<div id="shop_rec">
	<ul class="cf">
		<li>
			<img src="image/goods.jpg" alt="小米 Note 顶配版" />
			<div>
				<h5>小米 Note 顶配版</h5>
				<p>全网通 香槟金 移动联通<br />双4G手机 双卡双待</p>
				<em>¥2998<i>起</i></em>
				<span class="time" data-starttime="1445982375" data-endtime="1446350400"></span>
			</div>
		</li>
		<li>
			<img src="image/goods.jpg" alt="小米 Note 顶配版" />
			<div>
				<h5>小米 Note 顶配版</h5>
				<p>全网通 香槟金 移动联通<br />双4G手机 双卡双待</p>
				<em>¥2998<i>起</i></em>
				<span class="time" data-starttime="1445912375" data-endtime="1436350400"></span>
			</div>
		</li>
	</ul>
</div>
```
##jquery
```
$(function(){
	var abj = $("#shop_rec"),
		timeObj = abj.find('.time');
	var starttime = timeObj.data('starttime');

	// 定时器函数
	function actionDo(){
		return setInterval(function(){
			timeObj.each(function(index, el) {
				var t = $(this),
					surplusTime = t.data('endtime') -starttime;
				if (surplusTime <= 0) {
					t.html("活动已经开始");
				} else{
					var year = surplusTime/(24*60*60*365),
						showYear = parseInt(year),
						month = (year-showYear)*12,
						showMonth = parseInt(month),
						day = (month-showMonth)*30,
						showDay = parseInt(day),
						hour = (day-showDay)*24,
						showHour = parseInt(hour),
						minute = (hour-showHour)*60,
						showMinute = parseInt(minute),
						seconds = (minute-showMinute)*60,
						showSeconds = parseInt(seconds);
					t.html("");
					if (showYear>0) {
						t.append("<span>"+showYear+"年</span>")
					};
					if (showMonth>0) {
						t.append("<span>"+showMonth+"月</span>")
					};
					if (showDay>0) {
						t.append("<span>"+showDay+"天</span>")
					};
					if (showHour>=0) {
						t.append("<span>"+showHour+"小时</span>")
					};
					if (showMinute>=0) {
						t.append("<span>"+showMinute+"分钟</span>")
					};
					if (showSeconds>=0) {
						t.append("<span>"+showSeconds+"秒</span>")
					};
				};
			});
			starttime++;
		},1000); // 设定执行或延时时间
	};
	// 执行它
	actionDo();
});
```
##总结
不是特别优秀，但是小的应用完全没有问题。