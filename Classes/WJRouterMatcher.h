//
//  WJRouterMatcher.h
//  WJUIRoutable-example
//
//  Created by ada on 2018/8/26.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJRouterParams.h"

@interface WJRouterMatcher : NSObject

/**
 映射多个路由节点
 
 @param formats 映射urls
 @param callback 回调Block
 @param options 映射节点
 
 注意：
 1、format可为任意字符串，但是建议使用 scheme://domain 格式
 2、format可以支持 :key参数传递，例如：https://www.wj.com/user/:userid  匹配器会将userid当成一个路由参数取出（注意：为了性能考虑，默认此匹配是关闭的，如果有这种需求请在配置中心WJConfig中设置参数：enabledLinkParams=YES 开启）
 */
- (void)maps:(NSArray *)formats toCallback:(WJRouterOpenCallback)callback withOptions:(WJRouterOptions *)options;

/**
 映射多个路由节点
 
 @param formats 映射urls
 @param controllerClass 打开的视图控制器Class
 @param options 映射节点
 
 注意：
 1、format可为任意字符串，但是建议使用 scheme://domain 格式
 2、format可以支持 :key参数传递，例如：https://www.wj.com/user/:userid  匹配器会将userid当成一个路由参数取出（注意：为了性能考虑，默认此匹配是关闭的，如果有这种需求请在配置中心WJConfig中设置参数：enabledLinkParams=YES 开启）
 */
- (void)maps:(NSArray *)formats toController:(Class)controllerClass withOptions:(WJRouterOptions *)options;


/**
 匹配一个WJRouterOptions
 @param url 打开链接
 @return 该链接对应WJRouterOptions
 */
- (WJRouterParams*)match:(NSString*)url;


@end
