//
//  IWJRouterViewController.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/8/21.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWJRouterViewControllerDelegate.h"

//路由参数中包含的路由url
extern NSString * const WJRouterUrl;

/**
 路由视图控制器接口
 */
@protocol IWJRouterViewController <IWJRouterViewControllerDelegate>

/**
 *  回调委托
 */
@property (nonatomic, weak) id<IWJRouterViewControllerDelegate> routerDelegate;

/**
 *  路由参数
 */
@property(nonatomic, strong) NSDictionary *routerParams;


@property(nonatomic, copy) NSString *returnKey;

/**
 *  路由视图控制器初始化方法
 *
 *  @param params   参数
 *  @return 视图控制器
 */
-(instancetype) initWithURL:(NSString*) url routerParams:(NSDictionary*) params;

//实例化一个路由试图控制器
+(instancetype)wjInstanceRouterViewController:(NSString*)url routerParams:(NSDictionary*) params;

@end
