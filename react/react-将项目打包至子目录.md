# react 项目配置 - 打包至子目录

1. 在 `package.json` 中添加一项 `"homepage": "/marketing/"`
2. 在路由配置文件中，添加 `basename`，示例：`<Router basename="/marketing/">`
3. `sass` 中配置图片资源前缀为 `/marketing/image/`
4. 组件中引用图片前缀为 `/marketing/image/`


## nginx 配置

```
 location /marketing {
            index index.html;
            alias /srv/apps/huanqiu-marketing-h5-dist/build/;
            proxy_set_header X-Real-IP  $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $http_host;
            proxy_redirect off;
            if (!-e $request_filename) {
                      rewrite ^/(.*) /marketing/index.html last;
                      break;
                  }
      }      
```


## 

