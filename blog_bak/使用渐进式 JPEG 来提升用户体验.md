title: 使用渐进式 JPEG 来提升用户体验
date: 2016-08-17 11:03:25 +0800
update: 2016-08-17 11:03:25 +0800
author: fungleo
tags:
    -渐进式JPG
    -JPG图片优化
    -图片优化
---

今天才认识到原来JPEG文件有两种保存方式，分别是Baseline JPEG（标准型）和Progressive JPEG（渐进式）。两种格式有相同尺寸以及图像数据，扩展名也是相同的，唯一的区别是二者显示的方式不同。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/d7/466f9732b032f93c6a1c1d2bad6cea.gif)
##Baseline JPEG

这种类型的JPEG文件存储方式是按从上到下的扫描方式，把每一行顺序的保存在JPEG文件中。打开这个文件显示它的内容时，数据将按照存储时的顺序从上到下一行一行的被显示出来，直到所有的数据都被读完，就完成了整张图片的显示。如果文件较大或者网络下载速度较慢，那么就会看到图片被一行行加载的效果，这种格式的JPEG没有什么优点，因此，一般都推荐使用Progressive JPEG。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/5e/991a649f4184c1e7e5206f7c0f4167.gif)
##Progressive JPEG

和Baseline一遍扫描不同，Progressive JPEG文件包含多次扫描，这些扫描顺寻的存储在JPEG文件中。打开文件过程中，会先显示整个图片的模糊轮廓，随着扫描次数的增加，图片变得越来越清晰。这种格式的主要优点是在网络较慢的情况下，可以看到图片的轮廓知道正在加载的图片大概是什么。在一些网站打开较大图片时，你就会注意到这种技术。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/19/ee41555b7c973a6c567aa7f37c47e5.jpg)
渐进式图片带来的好处是可以让用户在没有下载完图片就可以看到最终图像的大致轮廓，一定程度上可以提升用户体验。（瀑布留的网站建议还是使用标准型的）



另外渐进式的图片的大小并不会和基本的图片大小相差很多，有时候可能会比基本图片更小。渐进式的图片的缺点就是吃用户的CPU和内存，不过对于现在的电脑来说这点图片的计算并不算什么。

说了这边多下面就改讲讲怎么讲图片保存为或者转化为Progressive JPEG了。

###1、PhotoShop

在photoshop中有“存储为web所用格式”，打开后选择“连续”就是渐进式JPEG。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/fd/28d712a210897b8b9cd4afc4444ca9.jpg)
###2、Linux

检测是否为progressive jpeg ： identify -verbose filename.jpg | grep Interlace（如果输出 None 说明不是progressive jpeg；如果输出 Plane 说明是 progressive jpeg。）

将basic jpeg转换成progressive jpeg：> convert infile.jpg -interlace Plane outfile.jpg

###3、PHP

使用imageinterlace和imagejpeg函数我们可以轻松解决转换问题。

```php
<?php
    $im = imagecreatefromjpeg('pic.jpg');
    imageinterlace($im, 1);
    imagejpeg($im, './php_interlaced.jpg', 100);
    imagedestroy($im);
?>
```

###4、Python

```python
import PIL
from exceptions import IOError
 
img = PIL.Image.open("c:\\users\\biaodianfu\\pictures\\in.jpg")
destination = "c:\\users\\biaodianfu\\pictures\\test.jpeg"
try:
    img.save(destination, "JPEG", quality=80, optimize=True, progressive=True)
except IOError:
    PIL.ImageFile.MAXBLOCK = img.size[0] * img.size[1]
    img.save(destination, "JPEG", quality=80, optimize=True, progressive=True)
```

###5、jpegtran

jpegtran -copy none -progressive <inputfile> <outputfile>

###6、C#

```c#
using (Image source = Image.FromFile(@"D:\temp\test2.jpg")) { 
    ImageCodecInfo codec = ImageCodecInfo.GetImageEncoders().First(c => c.MimeType == "image/jpeg"); 
    EncoderParameters parameters = new EncoderParameters(3);
    parameters.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
    parameters.Param[1] = new EncoderParameter(System.Drawing.Imaging.Encoder.ScanMethod, (int)EncoderValue.ScanMethodInterlaced);
    parameters.Param[2] = new EncoderParameter(System.Drawing.Imaging.Encoder.RenderMethod, (int)EncoderValue.RenderProgressive); 
    source.Save(@"D:\temp\saved.jpg", codec, parameters);
}
```

>转载附言
>在存储为PNG的时候，选择“交错”就可以得到和渐进式JPG图片一样的PNG效果了。

原文地址：http://www.biaodianfu.com/progressive-jpeg.html