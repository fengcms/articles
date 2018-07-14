# 环球H5与APP接口链接等资料

## 首页跳转链接和接口统计

### 判断用户是否登录

接口 `profile`
参数 `null`

未登录跳转 `/simple/login`
登录跳转 `user`

**特殊**

需要设置给 `webview` 添加本地存储，如果不设置，后面页面会出现问题

```
sessionStorage.setItem('login_mobile', r.data.mobile)
sessionStorage.setItem('login_name', r.data.name)
sessionStorage.setItem('login_id_card', r.data.name)
```

> 这里不清楚如何实现

### 焦点图

接口 `banner`
参数：

```
{
  type: 'h5'
}
```

> 焦点图 需要判断 `banner_link` 字段，区分有无链接

### 大推荐产品

接口 `homepage_product`
参数 `null`

立即投资按钮链接 `'/product/details/' + dat.id`


### 首页产品列表

#### 标题栏

链接 `/product`

#### 玖富产品

接口 `recommend_product`
参数 `null`

链接 `'/product/details/' + dat.id`

#### 天金所产品

首先用 `profile` 判断用户是否登录

**登录状态**

接口 `banner_product`
参数 `null`

跳转事件：登录状态下，不是用链接，而是用接口请求的方式，跳转出去

实在复杂

```
Api.get('product_details', {
  product_code: product_code,
  backurl: Domain('/product/term')
}, r => {
  this.props.history.push('/authorization/dump?' + r.data)
})
```

如上，先请求接口，拿到 `r.data` 数据，拼接 `'/authorization/dump?'` 字符串，然后进行跳转。

> `Domain('/product/term')` 方法，是获取 h5 完整地址，各个环境不一样，所以写成了方法自动获取。最终结果举例 `http://192.168.12.156:3000/h5/product/term`
> 
> `product_code` 是从 `banner_product` 中获取的数据

**未登录状态**

接口 `exlusive_product`
参数 `null`

链接 `/simple/login`

### 首页新闻

接口 `information`
参数：

```
{
  page: 0,
  pagesize: 5,
  sort: 'publish_time'
}
```

新闻详情链接 `'/news/' + dat.id`

## 产品列表

### 安新优选玖富产品列表

接口 `product_cunguan`

参数：

```
{
  page: 0, // 分页数据
  sort: 'rate,timelong'
}
```

产品详情链接： `'/product/details/' + dat.id`

### 定期，天金所产品列表

#### 列表数据

接口 `product`

参数：

```
{
  page: 0, // 分页数据
}
```
#### 判断是否授权

接口 `grant_authorization`
参数 `null`

> 说明: 接口请求成功，表示已授权，请求失败表示未授权

#### 点击产品详情

和首页天金所产品类似，分登录状态和非登录状态。

```
Api.get('product_details', {
  product_code: product_code,
  backurl: Domain('/product/term')
}, r => {
  if (如果授权成功) {
    window.location.href = r.data
  } else {
    this.props.history.push('/authorization/dump?' + r.data)
  }
})
```

我这边在跳转之前还做了一个动画，你看着实现。

## 我的页面

### 用户信息

**用户名、手机**

接口 `profile`
参数 `null`

**问候语**

接口 `person_signature`
参数 `null`

> 问候语在本次打开页面时请求一次，然后保存到缓存，在缓存有数据时，不再请求。关闭APP后，删除该缓存。

**设置链接** 

`/user/setting`


### 资产统计

接口 `total_assets`
参数 `null`

点击总资产数字，跳转链接 `/user/assets`

### 玖富余额

接口 `query_balance`
参数 `null`

充值和提现按钮逻辑过于复杂，中文已经无法表述，代码地址如下：

http://git.yaoyingli.cn/kangruide/huanqiu-licai-h5/src/master/src/coms/user/index/nav_jiufu.jsx

> 理解困难再说，我实在头疼

### 天金所余额

接口 `userinfo`
参数 `null`

充值提现请查看 

http://git/kangruide/huanqiu-licai-h5/src/master/src/coms/user/index/nav_tianjinsuo.jsx

> 这两处实在恶心，如果阅读 js 代码困难，请严墨帮忙或询问杨建信

### 用户导航链接

```
交易记录 to '/user/record'
银行卡 to '/user/bank'
优惠券 to '/user/coupon'
风险测评 to '/user/risk_test'
帮助中心 to '/user/help'
关于我们 to '/user/about'
```

风险评测的结果获取接口 `risk_assessment`
参数 `null`

> 默认为 开始评测



