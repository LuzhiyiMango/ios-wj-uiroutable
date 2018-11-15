//
//  WJRouterConfig.h
//  WJUIRoutable-example
//
//  Created by ada on 2018/11/13.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWJRouterInterceptor.h"

/**
 路由配置
 */
@interface WJRouterConfig : NSObject

/**
 默认导航控制器
 */
+(Class)defaultNavigationControllerClass;

/**
 拦截器列表
 */
+(NSArray<IWJRouterInterceptor>*)interceptors;


@end
