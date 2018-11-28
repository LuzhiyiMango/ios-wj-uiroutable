//
//  WJUIRWJRouter.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/8/24.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJRouterDefines.h"
#import "WJRouterParams.h"
#import "UIViewController+WJRouter.h"

/**
 * 路由
 */
@interface WJRouter : NSObject

/**
 针对当前导航控制器pop
 */
- (void)pop:(BOOL)animated;
- (void)popRoot:(BOOL)animated;
- (void)popAtIndex:(NSUInteger) index animated:(BOOL)animated;


- (void)dismiss:(BOOL)animated completion:(WJRouterCompletionBlock)completionBlock;
- (void)dismissAll:(BOOL)animated completion:(WJRouterCompletionBlock)completionBlock;
- (void)dismissAtIndex:(NSUInteger) index animated:(BOOL)animated completion:(WJRouterCompletionBlock)completionBlock;


- (void)close:(BOOL) animated;
- (void)closeAll:(BOOL) animated;


- (void)map:(NSString *)format toCallback:(WJRouterOpenCallback)callback;
- (void)maps:(NSArray *)formats toCallback:(WJRouterOpenCallback)callback;


- (void)recordReturn:(NSString*)returnToken viewController:(UIViewController*)viewController;
- (void)execReturn:(NSString*)returnToken;
- (BOOL)containsReturn:(NSString*)returnToken;

/**
 映射多个路由节点
 
 @param formats 映射urls
 @param callback 回调Block
 @param options 映射节点
 
 注意：
 1、format可为任意字符串，但是建议使用 scheme://domain 格式
 2、format可以支持 :key参数传递，例如：https://www.wj.com/user/:userid  匹配器会将userid当成一个路由参数取出（注意：为了性能考虑，默认此匹配是关闭的，如果有这种需求请在配置中心WJConfig中设置参数：enabledLinkParams=YES 开启）
 */
- (void)map:(NSString *)format toCallback:(WJRouterOpenCallback)callback withOptions:(WJRouterOptions *)options;
- (void)maps:(NSArray *)formats toCallback:(WJRouterOpenCallback)callback withOptions:(WJRouterOptions *)options;

- (void)map:(NSString *)format toController:(Class)controllerClass;
- (void)maps:(NSArray *)formats toController:(Class)controllerClass;
- (void)map:(NSString *)format toController:(Class)controllerClass withOptions:(WJRouterOptions *)options;

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

//拨打电话
- (void)callTel:(NSString*)tel;

//打开外部url
- (void)openExternal:(NSString *)url;

/**
 *  打开url
 */
- (void)open:(NSString *)url;
- (void)open:(NSString *)url animated:(BOOL)animated;
- (void)open:(NSString *)url animated:(BOOL)animated extraParams:(NSDictionary *)extraParams;

/**
 重置RootViewController
 */
- (void)resetRootViewController:(UIViewController*)rootViewController;

/**
 当前有效导航控制器
 */
- (UINavigationController*)currentAvailableNavigationController;

+(instancetype) sharedInstance;

@end
