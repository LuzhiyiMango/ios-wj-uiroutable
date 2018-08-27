//
//  IWJRouterMatcher.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/12/25.
//  Copyright © 2015年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJRouterParams.h"


//路由匹配器
@protocol IWJRouterMatcher <NSObject>


/**
 添加一个映射项
 @param format 映射key
 @param callback 打开block
 
 注意：
    1：format可为任意字符串，但是建议使用 scheme://domain 格式
    2：format可以支持 :key参数传递，但未来提高性能需要在WJConfig中开启了enabledLinkParams=YES
 */
- (void)map:(NSString *)format toCallback:(WJRouterOpenCallback)callback;

- (void)maps:(NSArray *)formats toCallback:(WJRouterOpenCallback)callback;

- (void)map:(NSString *)format toCallback:(WJRouterOpenCallback)callback withOptions:(WJRouterOptions *)options;

- (void)maps:(NSArray *)formats toCallback:(WJRouterOpenCallback)callback withOptions:(WJRouterOptions *)options;

- (void)map:(NSString *)format toController:(Class)controllerClass;

- (void)maps:(NSArray *)formats toController:(Class)controllerClass;

- (void)map:(NSString *)format toController:(Class)controllerClass withOptions:(WJRouterOptions *)options;

- (void)maps:(NSArray *)formats toController:(Class)controllerClass withOptions:(WJRouterOptions *)options;


/**
 匹配一个WJRouterOptions
 @param url 打开链接
 @return 该链接对应WJRouterOptions
 */
- (WJRouterParams*)match:(NSString*)url;

@end
