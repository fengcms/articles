title: [转] 主流JS框架中DOMReady事件的实现
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -DOMReady事件
    -javascript
---

在实际应用中，我们经常会遇到这样的场景，当页面加载完成后去做一些事情：绑定事件、DOM操作某些结点等。原来比较常用的是window的onload 事件，而该事件的实际效果是：当页面解析/DOM树建立完成，并完成了诸如图片、脚本、样式表甚至是iframe中所有资源的下载后才触发的。这对于很多 实际的应用而言有点太“迟”了，比较影响用户体验。为了解决这个问题，ff中便增加了一个DOMContentLoaded方法，与onload相比，该 方法触发的时间更早，它是在页面的DOM内容加载完成后即触发，而无需等待其他资源的加载。Webkit引擎从版本525（Webkit nightly 1/2008:525+）开始也引入了该事件，Opera中也包含该方法。到目前为止主流的IE仍然没有要添加的意思。虽然IE下没有，但总是有解决办法 的，下文对比了一下几大主流框架对于该事件的兼容性版本实现方案，涉及的框架包括：

 1. Prototype
 2. jQeury
 3. moontools
 4. dojo
 5. yui
 6. ext

##一、Prototype##

```
(function() {
    /* Support for the DOMContentLoaded event is based on work by Dan Webb,
Matthias Miller, Dean Edwards and John Resig. */
    var timer;
    function fireContentLoadedEvent() {
        if (document.loaded) return;
        if (timer) window.clearInterval(timer);
        document.fire("dom:loaded");
        document.loaded = true;
    }
    if (document.addEventListener) {
        if (Prototype.Browser.WebKit) {
            timer = window.setInterval(function() {
                if (/loaded|complete/.test(document.readyState))
                    fireContentLoadedEvent();
            }, 0);
            Event.observe(window, "load", fireContentLoadedEvent);
        } else {
            document.addEventListener("DOMContentLoaded",
                fireContentLoadedEvent, false);
        }
    } else {
        document.write("<"+"script id=__onDOMContentLoaded defer src=//:><\/script>");
        $("__onDOMContentLoaded").onreadystatechange = function() {
            if (this.readyState == "complete") {
                this.onreadystatechange = null;
                fireContentLoadedEvent();
            }
        };
    }
})();
```

实现思路如下：



 1. 如果是webkit则轮询document的readyState属性，如果该属性的值为loaded或complete则触发DOMContentLoaded事件，为保险起见，将该事件注册到window.onload上。
 2. 如果是FF则直接注册DOMContentLoaded事件。
 3.  如果是IE则使用document.write往页面中加入一个script元素，并设置defer属性，最后是把该脚本的加载完成视作DOMContentLoaded事件来触发。

该实现方式的问题主要有两点：第一、通过document.write写script并设置defer的方法在页面包含iframe的情况下，会等到 iframe内的内容加载完后才触发，这与onload没有太大的区别；第二、Webkit在525以上的版本引入了DOMContentLoaded方 法，因此在这些版本中无需再通过轮询来实现，可以优化。

##二、jQuery##

```
function bindReady(){
    if ( readyBound ) return;
    readyBound = true;
    // Mozilla, Opera and webkit nightlies currently support this event
     if ( document.addEventListener ) {
        // Use the handy event callback
         document.addEventListener( "DOMContentLoaded", function(){
            document.removeEventListener( "DOMContentLoaded", arguments.callee, false );
            jQuery.ready();
        }, false );
    // If IE event model is used
    } else if ( document.attachEvent ) {
        // ensure firing before onload,
        // maybe late but safe also for iframes
        document.attachEvent("onreadystatechange", function(){
            if ( document.readyState === "complete" ) {
                document.detachEvent( "onreadystatechange", arguments.callee );
                jQuery.ready();
            }
        });
        // If IE and not an iframe
        // continually check to see if the document is ready
        if ( document.documentElement.doScroll && typeof window.frameElement === "undefined" ) (function(){
            if ( jQuery.isReady ) return;
            try {
                // If IE is used, use the trick by Diego Perini
                // http://javascript.nwbox.com/IEContentLoaded/
                document.documentElement.doScroll("left");
            } catch( error ) {
                setTimeout( arguments.callee, 0 );
                return;
            }
            // and execute any waiting functions
            jQuery.ready();
        })();
    }
    // A fallback to window.onload, that will always work
    jQuery.event.add( window, "load", jQuery.ready );
}
```
实现思路如下：

 1. 将Webkit与Firefox同等对待，都是直接注册DOMContentLoaded事件，但是由于Webkit是在525以上版本才引入的，因此存在兼容性的隐患。
 2. 对于IE，首先注册document的onreadystatechange事件，经测试，该方式与window.onload相当，依然会等到所有资源下载完毕后才触发。
 3. 之后，判断如果是IE并且页面不在iframe当中，则通过setTiemout来不断的调用documentElement的doScroll方法，直到调用成功则出触发DOMContentLoaded
 
jQuery对于IE的解决方案，使用了一种新的方法，该方法源自http://javascript.nwbox.com/IEContentLoaded/。 它的原理是，在IE下，DOM的某些方法只有在DOM解析完成后才可以调用，doScroll就是这样一个方法，反过来当能调用doScroll的时候即 是DOM解析完成之时，与prototype中的document.write相比，该方案可以解决页面有iframe时失效的问题。此外，jQuery 似乎担心当页面处于iframe中时，该方法会失效，因此实现代码中做了判断，如果是在iframe中则通过document的 onreadystatechange来实现，否则通过doScroll来实现。不过经测试，即使是在iframe中，doScroll依然有效。

##三、Moontools##

```
(function(){
    var domready = function(){
        if (Browser.loaded) return;
        Browser.loaded = true;
        window.fireEvent('domready');
        document.fireEvent('domready');
    };
    if (Browser.Engine.trident){
        var temp = document.createElement('div');
        (function(){
            ($try(function(){
                temp.doScroll('left');
                return $(temp).inject(document.body).set('html', 'temp').dispose();
            })) ? domready() : arguments.callee.delay(50);
        })();
    } else if (Browser.Engine.webkit && Browser.Engine.version < 525){
        (function(){
            (['loaded', 'complete'].contains(document.readyState)) ? domready() : arguments.callee.delay(50);
        })();
    } else {
        window.addEvent('load', domready);
        document.addEvent('DOMContentLoaded', domready);
    }
})();
```
实现思路如下：

 1. 如果是IE则使用doScroll方法来实现。
 2. 如果是小于525版本的Webkit则通过轮询document.readyState来实现。
 3. 其他的(FF/Webkit高版/Opera)则直接注册DOMContentLoaded事件

Moontools的实现方案prototype和jQeury中的综合体，对webkit做了版本判断则使得该方案更加的健壮。在doScroll的实现方面，与jQuery相比，这里是新建了一个div元素，并且在使用完毕后进行销毁，而jQuery则直接使用了documentElement的 doScroll来检测，更简单高效一些。

##四、Dojo##

```
// START DOMContentLoaded
// Mozilla and Opera 9 expose the event we could use
if(document.addEventListener){
    // NOTE:
    //  due to a threading issue in Firefox 2.0, we can't enable
    //  DOMContentLoaded on that platform. For more information, see:
    //  http://trac.dojotoolkit.org/ticket/1704
    if(dojo.isOpera || dojo.isFF >= 3 || (dojo.isMoz && dojo.config.enableMozDomContentLoaded === true)){
        document.addEventListener("DOMContentLoaded", dojo._loadInit, null);
    }
    // mainly for Opera 8.5, won't be fired if DOMContentLoaded fired already.
    //  also used for Mozilla because of trac #1640
    window.addEventListener("load", dojo._loadInit, null);
}
if(dojo.isAIR){
    window.addEventListener("load", dojo._loadInit, null);
}else if(/(WebKit|khtml)/i.test(navigator.userAgent)){ // sniff
    dojo._khtmlTimer = setInterval(function(){
        if(/loaded|complete/.test(document.readyState)){
            dojo._loadInit(); // call the onload handler
        }
    }, 10);
}
// END DOMContentLoaded

(function(){
    var _w = window;
    var _handleNodeEvent = function(/*String*/evtName, /*Function*/fp){
        // summary:
        //  non-destructively adds the specified function to the node's
        //  evtName handler.
        // evtName: should be in the form "onclick" for "onclick" handlers.
        // Make sure you pass in the "on" part.
        var oldHandler = _w[evtName] || function(){};
        _w[evtName] = function(){
            fp.apply(_w, arguments);
            oldHandler.apply(_w, arguments);
        };
    };
    if(dojo.isIE){
        //  for Internet Explorer. readyState will not be achieved on init
        //  call, but dojo doesn't need it however, we'll include it
        //  because we don't know if there are other functions added that
        //  might.  Note that this has changed because the build process
        //  strips all comments -- including conditional ones.
        if(!dojo.config.afterOnLoad){
            document.write('<scr'+'ipt defer="" src="//:" +="" onreadystatechange="if(this.readyState==\'complete\'){' + dojo._scopeName + '._loadInit();}">'
                + '</scr'+'ipt>'
                );
        }
        try{
            document.namespaces.add("v","urn:schemas-microsoft-com:vml");
            document.createStyleSheet().addRule("v\\:*", "behavior:url(#default#VML)");
        }catch(e){}
    }
    // FIXME: dojo.unloaded requires dojo scope, so using anon function wrapper.
    _handleNodeEvent("onbeforeunload", function() {
        dojo.unloaded();
    });
    _handleNodeEvent("onunload", function() {
        dojo.windowUnloaded();
    });
})();
```
实现思路如下：

 1. 如果是Opera或FF3以上版本则直接注册DOMContentLoaded<事件，为保险起见，同时也注册了window.onload事件。
 2.  对于webkit则通过轮询document.readyState来实现。
 3.  如果是Air则只注册widnow.onload事件。
 4. 如果是IE则通过往页面写带defer属性的script并注册其onreadystatechange事件来实现。

Dojo在IE下的实现方案同样无法解决iframe的问题，而由于在FF2 下会有一个非常奇怪的Bug，因此默认只在FF3以上版本上使用DOMContentLoaded事件，同时又给了一个配置 -dojo.config.enableMozDomContentLoaded，如果在FF下将该配置设置为true则依然会使用 DOMContentLoaded来实现，这一点充分考虑到了灵活性。对于webkit的实现，与prototype一样有优化的空间。

##五、YUI

```
(function() {
    /*! DOMReady: based on work by: Dean Edwards/John Resig/Matthias Miller */
    // Internet Explorer: use the readyState of a defered script.
    // This isolates what appears to be a safe moment to manipulate
    // the DOM prior to when the document's readyState suggests
    // it is safe to do so.
    if (EU.isIE) {
        // Process onAvailable/onContentReady items when the
        // DOM is ready.
        YAHOO.util.Event.onDOMReady(
            YAHOO.util.Event._tryPreloadAttach,
            YAHOO.util.Event, true);
        var n = document.createElement('p');
        EU._dri = setInterval(function() {
            try {
                // throws an error if doc is not ready
                n.doScroll('left');
                clearInterval(EU._dri);
                EU._dri = null;
                EU._ready();
                n = null;
            } catch (ex) {
            }
        }, EU.POLL_INTERVAL);
    // The document's readyState in Safari currently will
    // change to loaded/complete before images are loaded.
    } else if (EU.webkit && EU.webkit < 525) {
        EU._dri = setInterval(function() {
            var rs=document.readyState;
            if ("loaded" == rs || "complete" == rs) {
                clearInterval(EU._dri);
                EU._dri = null;
                EU._ready();
            }
        }, EU.POLL_INTERVAL);
    // FireFox and Opera: These browsers provide a event for this
    // moment.  The latest WebKit releases now support this event.
    } else {
        EU._simpleAdd(document, "DOMContentLoaded", EU._ready);
    }
    /////////////////////////////////////////////////////////////
    EU._simpleAdd(window, "load", EU._load);
    EU._simpleAdd(window, "unload", EU._unload);
    EU._tryPreloadAttach();
})();
```
实现思路与Moontools一样

##六、EXT

```
function initDocReady(){
    var COMPLETE = "complete";
    docReadyEvent = new Ext.util.Event();
    if (Ext.isGecko || Ext.isOpera) {
        DOC.addEventListener(DOMCONTENTLOADED, fireDocReady, false);
    } else if (Ext.isIE){
        DOC.write("<script id=" + IEDEFERED + " defer=defer src='/%27+%27/:'></script>");
        DOC.getElementById(IEDEFERED).onreadystatechange = function(){
            if(this.readyState == COMPLETE){
                fireDocReady();
            }
        };
    } else if (Ext.isWebKit){
        docReadyProcId = setInterval(function(){
            if(DOC.readyState == COMPLETE) {
                fireDocReady();
            }
        }, 10);
    }
    // no matter what, make sure it fires on load
    E.on(WINDOW, "load", fireDocReady);
}
```
实现思路与Dojo的一致，不再赘诉。
##总结
总结各大主流框架的做法，写了以下这个版本。主要是尽量的做到优化并考虑到FF2下的Bug，提供一个是否使用DOMContentLoaded的开关配置。

```
/*
* 注册浏览器的DOMContentLoaded事件
* @param { Function } onready [必填]在DOMContentLoaded事件触发时需要执行的函数
* @param { Object } config [可选]配置项
*/
function onDOMContentLoaded(onready,config){
    //浏览器检测相关对象，在此为节省代码未实现，实际使用时需要实现。
    //var Browser = {};
    //设置是否在FF下使用DOMContentLoaded（在FF2下的特定场景有Bug）
    this.conf = {
        enableMozDOMReady:true
    };
    if( config )
        for( var p in config)
            this.conf[p] = config[p];
    var isReady = false;
    function doReady(){
        if( isReady ) return;
        //确保onready只执行一次
        isReady = true;
        onready();
    }
    /*IE*/
    if( Browser.ie ){
        (function(){
            if ( isReady ) return;
            try {
                document.documentElement.doScroll("left");
            } catch( error ) {
                setTimeout( arguments.callee, 0 );
                return;
            }
            doReady();
        })();
        window.attachEvent('onload',doReady);
    }
    /*Webkit*/
    else if (Browser.webkit && Browser.version < 525){
        (function(){
            if( isReady ) return;
            if (/loaded|complete/.test(document.readyState))
                doReady();
            else
                setTimeout( arguments.callee, 0 );
        })();
        window.addEventListener('load',doReady,false);
    }
    /*FF Opera 高版webkit 其他*/
    else{
        if( !Browser.ff || Browser.version != 2 || this.conf.enableMozDOMReady)
            document.addEventListener( "DOMContentLoaded", function(){
                document.removeEventListener( "DOMContentLoaded", arguments.callee, false );
                doReady();
            }, false );
        window.addEventListener('load',doReady,false);
    }
}
```

转自：http://www.cnblogs.com/JulyZhang/archive/2011/02/12/1952484.html

PS：虽然明白是干嘛的，但是完全看不懂！~