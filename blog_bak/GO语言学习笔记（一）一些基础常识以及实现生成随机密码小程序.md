title: GO语言学习笔记（一）一些基础常识以及实现生成随机密码小程序
date: 2017-08-17 11:52:39 +0800
update: 2017-08-17 11:52:39 +0800
author: fungleo
tags:
    -shell
    -go语言
    -密码
    -golang
    -生成随机密码
---

# GO语言学习笔记（一）一些基础常识以及实现生成随机密码小程序

之前用 `nodejs` 和 `shell` 分别实现过生成随机密码的小程序。最近，准备入门一下 `golang` 在粗粗的看了一些资料之后，决定再实现一个这个语言，以方便我更加好的入门这一个语言。

由于我之前完全没有后端语言的经验，所以，全是坑。。。

## go 程序的程序基本构架

```golang
// 申明主包
package main
// 引用需要的库
import "fmt"
// 主函数
func main () {
  // do something
}
```

如上，一个最简单的程序，也需要这三个对应的内容。如果引用多个库，还可以简写

```golang
import (
  "os"
  "fmt"
  "strconv"
  "math/rand"
  "time"
)
```

你的程序需要用到什么库，一定要先在这里引入。但是，我是初学，所以我不知道要用到啥，只能依赖搜索引擎了。

## golang 的判断写法

`go` 语言的判断和 `js` 类似，但是是可以省略判断条件的括号的。

```golang
  if len(args) == 1 {
    // do something
  }
```
或者

```golang
  if ( len(args) == 1 ) {
    // do something
  }
```
都是可以正确执行的。因为 `js` 写习惯了，所以我习惯加上括号便于我自己查看层级。但确实不需要这个括号

## golang 申明变量的几种方法

```golang
// 并指定类型，并赋值
var name string = "fungleo"
// 自动判断类型
var name = "fungleo"
// 省略 var 写法
name := "fungleo"
```
由于 `golang` 是强类型语言，所以，我感觉，还是采用指定类型并赋值的方法好一点。

当然，我在写的时候，会更多的采用省略写法。。。

声明多个变量的简写写法

```golang
var (
  name string = "fungleo"
  sex string = "man"
)
```
我个人很喜欢这种多个变量的简写写法。比 `js` 的写法更加清楚。

## golang 函数的写法

因为 `golang` 是强类型语言，所以函数的写法，还是比 `js` 要复杂一点点。

** 一个返回数据函数例子 **
```golang
package main

import (
  "fmt"
  "strconv"
)

func main () {
  fmt.Println(showAge(18))
}

func showAge(age int) string {
  a := strconv.Itoa(age)
  return "Your are " + a + " old"
}
```

如上面这个简单的小程序，我们的主函数 `main()` 调用了 `showAge()` 这个函数的结果，并且打印出来。

这里有几个关键的点：

1. 传入的参数是 `int` 整数，要返回的参数是 `string` 字符串，这是需要分别指定的。
2. 当要把整数和字符串拼接的时候，需要先把数字转换为字符串。这里使用的是 `strconv` 库来实现的。
3. 在 `main` 里调用 `showAge()` 入参的时候，类型一定是要是整数，是其他的类型一定会报错。


** 一个直接执行函数例子 **

同样是上面这个例子，我们将代码稍微调整一下

```golang
package main

import (
  "fmt"
  "strconv"
)

func main () {
  showAge(18)
}

func showAge(age int) {
  a := strconv.Itoa(age)
  fmt.Println( "Your are " + a + " old" )
}
```

在这个函数的构建里，我们没有 `return` 任何内容，也就不需要指定返回数据的类型。

## golang 常见的数据转换方法

因为 `golang` 是一个强类型语言，所以，数据的转换就成了一个很普遍的问题，至少我在写第一个程序的时候，就涉及到了很多这样的情况。

```golang
// 字符串转数字，因为字符串很可能不是数字，所以要做错误处理
num , err := strconv.Atoi("18")
if err != nil {
	fmt.Println("参数不是数字")
	return
}
// 数字转字符串，这个都能转
str := strconv.Itoa(18)
// 整数转浮点数
fnum := float64(18)
// 浮点数转整数 浮点数，要先声明为浮点数，另外，转整数后会向下取整
var fnum float64 = 18.111
num := int(fnum)
```
这是我目前遇到的一些，以后遇到了更多，我会丰富这里的内容。

## golang 获取终端输入参数

例如，我们在终端内输入这样一个命令：
```#
go run age.go 18
```
我如何获得我传入的参数 `18` 呢？

这里需要使用到一个库 `os` ，目前我只用到了接收参数的功能。


```golang
import "os"

func main () {
  // os.Args 是我们输入的所有内容，它是一个数组，会把我们的命令切割
  args := os.Args
  
  // 获得我们输入命令得到的数组的长度，如果长度为1 则说明没有附加参数
  len(args)
  
  // 取得我们的第一个参数，这个为 `go run age.go` 本身
  // 在 `go run` 这种命令运行下，输出的是一个临时的玩意儿
  // 编译后 则我们输入的是什么，就是什么
  args[0]
  
  // 取得我们的第二个参数
  // 默认取出来，全是字符串，无论你输入的是啥
  args[1]
}
```

如上面那个例子，我们用 `args[1]` 会得到 `18` 这个参数，但是这个参数，是字符串，如果要当成 `int` 类型适用，必须先转换类型。

## 实现生成随机密码的小程序

```golang
package main

import (
  "os"
  "fmt"
  "strconv"
  "math/rand"
  "time"
)

func Usage() {
  fmt.Println("USAGE: getpw [int]")
}

func main () {
  args := os.Args
  if (len(args) > 2) {
    Usage()
    return
  }
  if len(args) == 1 {
    makepw(8)
  }
  if len(args) == 2 {
    pwl , err := strconv.Atoi(args[1])
    if err != nil {
      fmt.Println("参数不是数字")
      return
    }
    makepw(pwl)
  }
}


func makepw(pwl int) {
  chars := "abcdefghijkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ23456789"
  clen := float64(len(chars))
  res := ""
  rand.Seed(time.Now().Unix())
  for i := 0; i < pwl; i++ {
    rfi := int(clen * rand.Float64())
    res += fmt.Sprintf("%c", chars[rfi])
  }
  fmt.Println(res)
}
```

在踩了很多坑之后，终于完成了上面的这段程序。

## 小结

1. 强类型就是强类型，数据的转换是一个非常严谨的问题，非常头疼
2. GO的随机数真心不随机，我还没搞明白为什么`rand.Seed(time.Now().Unix())` 这一句放在了 `for` 里面为什么就不随机了。
3. 虽然是我写的，但没太明白

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


