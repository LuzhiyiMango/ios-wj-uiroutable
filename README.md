# WJRouter

路由组件

### CocoaPods 安装

```
'pod WJRouter'
```

### 要求
* ARC支持
* iOS 6.0+


### 使用方法

* 在WJConfig配置中心：

```
//WJRouter在配置中心名称
WJRouter : {
    defaultNavigationController:(String)默认导航控制器名称（可为空）
    interceptors:(String)拦截器
}

```

```
//映射
[[WJRouter sharedInstance] map:xxxx toController:xxxx];
[[WJRouter sharedInstance] maps:xxxx toController:xxxx];
[[WJRouter sharedInstance] map:xxxx toController:xxxx withOptions:xxxx];
[[WJRouter sharedInstance] maps:xxxx toController:xxxx withOptions:xxxx];
[[WJRouter sharedInstance] map:xxxx toCallback:xxxx];
[[WJRouter sharedInstance] maps:xxxx toCallback:xxxx];
[[WJRouter sharedInstance] map:xxxx toCallback:xxxx withOptions:xxxx];
[[WJRouter sharedInstance] maps:xxxx toCallback:xxxx withOptions:xxxx];

//打开页面
[[WJRouter sharedInstance] open:xxxx];
[[WJRouter sharedInstance] open:xxxx animated:xxxx];
[[WJRouter sharedInstance] open:xxxx animated:xxxx extraParams:xxxx];

//打开外部链接
[[WJRouter sharedInstance] openExternal:xxxx];

```
