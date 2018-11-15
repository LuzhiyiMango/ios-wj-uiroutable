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
@property(nonatomic, copy) NSDictionary *routerParams;

/**
    路由视图控制器初始化方法
    @param
        url:路由url
        params:路由参数
    @return 视图控制器
 */
- (instancetype)initWithRouterParams:(NSDictionary*) params;


@optional

/**
  在此方法中可获取到 routerParams、routerDelegate参数
 */
- (void)routerInitializedCompletion;

@end
