//
//  IWJRouterInterceptor.h
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


//路由拦截器
@protocol IWJRouterInterceptor <NSObject>

/**
 打开前拦截
 @param routerUrl 路由链接
 @param params 属性
 @param formatterUrl 如果需要替换url，
 @return 只有YES，才会跳转。如果NO，则放弃跳转
 */
-(BOOL)preHandle:(NSString*)routerUrl params:(NSDictionary*)params formattedUrl:(NSString**)formattedUrl;

/**
 路由完成后
 @param routerUrl 路由链接 注意：formatterdUrl如果存在，此值在params中，获取key为：WJRouterUrl
 @param params 属性集合
 */
-(void)afterCompletion:(NSString*)routerUrl params:(NSDictionary*)params;

@end
