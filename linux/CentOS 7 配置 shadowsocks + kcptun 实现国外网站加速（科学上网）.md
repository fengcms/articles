# CentOS 7 配置 shadowsocks + kcptun 实现国外网站加速（科学上网）

作为互联网开发人员，上网查找资料是一项必备技能。国内资料已经非常丰富，但大多数情况下，都是二手资料。为了获得一手的资料，我们可能必须利用 `google` 这样的搜索引擎来查找英文资料。

但是由于众所周知的原因，我们无法直接连接这些网站，因此，我们需要通过一些手段来实现科学上网。

免费的各种服务倒是常见，但是很不稳定。如果你和我一样需要稳定的科学上网，那么我是不建议使用各种免费的工具的。

所以，我今天来说一下如何利用美国的服务器来配置 `shadowsocks + kcptun` 实现科学上网。

> 阅读本文请确保你拥有 `linux` 服务器的基本操作知识，并且具备一般的互联网协议概念。能够比较熟练的操作命令行，否则，你看逑不懂本文。
> 本文命令均是在 `CentOS 7` 上用 `root` 用户执行的。如果你用普通用户执行，一些命令会没有权限执行。需要在命令前面加上 `sudo`。

## 基础概念

我们无法直接连接我们的目标网站。但是我们可以连接我们在美国的私有服务器，而在美国的私有服务器，可以访问我们想要访问的网站。因此，科学上网的概念就是利用美国的私有服务器，对我们想要访问的网站进行代理中转，我们就间接的可以访问我们需要访问的这些网站了。

`shadowsocks` 工具是用于实现我上述描述的功能的。一般情况下，我们只需要配置这个，就可以实现我们的需求了。但是，由于 `tcp/ip` 的三次握手的原因，导致传输速率比较慢。因此，我们可以使用 `kcptun` 工具，对我们的 `shadowsocks` 进行加速，这样可以让我们更快的访问我们需要访问的网站。

也就是说：

`shadowsocks` 是代理工具

`kcptun` 是加速工具

OK

## 配置 shadowsocks 服务端

**下载 shadowsocks**

首先，我们到 `github` 去下载我们需要的软件。`shadowsocks` 有很多的版本，这里，我们选择比较简单可靠的 `rust` 版本。

其 `github` 版本发布地址是 https://github.com/shadowsocks/shadowsocks-rust/releases

好，由于我们的服务器是 `centos 7` 所以，我们在服务器上下载对应的 `linux` 版本

```#
# 跳转到家目录
cd ~
# 创建下载目录（如果有，则跳过）
mkdir Downloads
# 进入下载目录
cd Downloads
# 下载软件
wget https://github.com/shadowsocks/shadowsocks-rust/releases/download/v1.6.10/shadowsocks-v1.6.10-release.x86_64-unknown-linux-musl.tar.xz
# 解压软件
tar xf shadowsocks-v1.6.10-release.x86_64-unknown-linux-musl.tar.xz
# 查看解压出来的文件
ls
```
好，我们通过 `ls` 命令，可以看到我们解压出来了三个文件 `sslocal\ssurl\ssserver`

我们只需要使用到 `ssserver` 这一个文件即可。

**配置 shadowsocks**

```#
# 将 shadowsocks 服务端复制到系统程序目录
cp ssserver /usr/local/bin/
# 创建配置文件
touch /etc/shadowsocks.json
# 编辑配置文件
vim /etc/shadowsocks.json
```

好，我们已经创建了配置文件并且打开了编辑模式了，下面，我们在配置文件中输入下面的内容：

```json
{
    "server":"0.0.0.0",
    // 这里需要你自行设置一个端口，请确保端口没有被占用
    "server_port":9988,
    "local_address": "127.0.0.1",
    "local_port":1080,
    // 这里设置你的服务密码
    "password":"aaaaaaa",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": false,
    "workers": 1
}
```

以上内容中，除了我注释的两个地方根据需要进行修改，其他可以保持不变。如果你确定要修改，请一定清楚自己在做什么。

编辑完成后，保存退出。

**创建 shadowsocks 服务**

通过上面的配置之后，我们其实已经可以启动我们的代理服务了。但是当我们关闭终端之后，服务就会停止，这很明显不是我们想要的。

我们需要一次配置，终身使用。那么久必须把 `shadowsocks` 添加到系统服务中了。

```#
# 创建服务文件
touch /usr/lib/systemd/system/ss-server.service
# 编辑服务文件
vim /usr/lib/systemd/system/ss-server.service
```

好，我们已经进入这个文件的编辑了。我们写入以下内容：

```#
[Unit]
Description=shadowsocks server daemon
After=syslog.target network.target

[Service]
Type=simple
User=nobody
Group=nobody
# 关键就是这行，确定我们的程序文件，以及配置文件的路径
ExecStart=/usr/local/bin/ssserver -c /etc/shadowsocks.json

[Install]
WantedBy=multi-user.target
```

编辑好之后，我们保存退出。

添加到服务之后，服务并没有立即启动，因此，我们需要启动服务。

```#
# 启动服务
systemctl start ss-server
# 将服务设置为开机启动
systemctl enable ss-server
```

好，到这里，我们的 `shadowsocks` 代理就已经配置完成了。我们可以在自己的电脑上配置纸飞机进行科学上网了。

**客户端下载**

`windows` 用户下载：https://github.com/shadowsocks/shadowsocks-windows/releases
`mac` 用户下载：https://github.com/shadowsocks/shadowsocks-iOS/releases
`linux` 用户下载：https://github.com/shadowsocks/shadowsocks-qt5/releases

> linux 用户可以在自己的包管理里面搜索 `shadowsocks-qt5` ，用命令行安装会比较爽。
> MAC 用户不推荐使用这个版本。接着往下看教程。

## 配置 kcptun 加速服务

虽然上面配置完 `shadowsocks` 之后，就可以进行科学上网了，但是速度还是可以更加快的。这里我们再进行 `kcptun` 加速服务的配置。

**下载 kcptun**

首先一样，我们到 `github` 进行软件的下载。下载地址是：https://github.com/xtaci/kcptun/releases

版本比较多，`centos 7` 需要的是 `amd64` 版本。

```#
# 跳转到家目录
cd ~
# 创建下载目录（如果有，则跳过）
mkdir Downloads
# 进入下载目录
cd Downloads
# 下载 kcptun
wget https://github.com/xtaci/kcptun/releases/download/v20171201/kcptun-linux-amd64-20171201.tar.gz
# 解压压缩文件
tar xf kcptun-linux-amd64-20171201.tar.gz
# 查看解压文件
ls
```

好，我们可以看到解压出来俩文件 `client_linux_amd64\server_linux_amd64`，我们只需要用到 `server_linux_amd64` 这个文件。


```#
# 将服务文件复制到系统目录并重命名为 kcptun
cp ./server_linux_amd64 /usr/local/bin/kcptun
```

然后就好了。

**配置 kcptun 服务**

安装好之后，我们需要进行配置，将 `kcptun` 配置为系统服务，这样可以更加方便的便于我们的使用。

```#
# 创建 kcptun 服务文件
touch /usr/lib/systemd/system/kcptun.service
# 编辑 kcptun 服务文件
vim /usr/lib/systemd/system/kcptun.service
```

进入编辑模式之后，我们输入以下内容

```#
[Unit]
Description=kcptun-server Service
After=network.target
Wants=network.target

[Service]
Type=simple
PIDFile=/var/run/kcp-server.pid
# 重要的就是下面的这句话
ExecStart=/usr/local/bin/kcptun -t "127.0.0.1:9988" -l ":9999" -mode fast2 -key 11122233
Restart=on-abnormal

[Install]
WantedBy=multi-user.target
```

如上，其他代码一律复制，需要配置的就是 `/usr/local/bin/kcptun -t "127.0.0.1:9988" -l ":9999" -mode fast2 -key 11122233` 这段内容。

`"127.0.0.1:9988"` 这是你的 `shadowsocks` 的服务地址。后面的端口号需要改成你上面配置 `shadowsocks` 时设置的。

`":9999"` 是你设置的 `kcptun` 的服务端口，请确保端口没有被占用。

`-mode fast2` 这个是规定了模式为 `fast2` 保持默认即可。

`-key 11122233` 是确定你的 `kcptun` 的密码。请尽量复杂一些。

编辑完成之后，保存退出。

然后执行下面两条命令：

```#
# 启动服务
systemctl start kcptun
# 将服务设置为开机启动
systemctl enable kcptun
```

OK，到此为止，我们的 `kcptun` 加速配置就已经完成了。

但是我们的客户端需要使用支持 `kcptun` 的客户端才可以实现对应的支持。`linux` 下面可以用命令行工具来进行支持，不过设置比较复杂，我没有深入研究。由于我手上没有 `windows` 系统，所以，我也不清楚具体怎么设置。

这里我就只说一下 `mac` 是如何设置的。其他系统请自行搜索解决方案。

**下载支持 `kcptun` 的 `shadowsocks` 客户端**

`mac` 版本的下载地址： https://github.com/shadowsocks/ShadowsocksX-NG/releases

下载安装完成之后运行，菜单栏右侧应该出现一个纸飞机。

![shadowsocks-NG](http://img.blog.csdn.net/20171213160256610?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvRnVuZ0xlbw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

如上图所示，我们点击纸飞机，就会出现这个菜单，由于最近 `mac` 升级之后中文变得比较怪，为了不吓着自己，就把系统设置为英文的了。。。就这个位置，就这么设置即可。

![shadowsocks-NG server](http://img.blog.csdn.net/20171213160533854?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvRnVuZ0xlbw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

进入服务器配置页面，在里面填写上你自己设置的各项参数，最后点击 OK ，就可以科学上网了。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


