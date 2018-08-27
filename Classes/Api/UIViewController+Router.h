//
//  UIViewController+Router.h
//  WJUIRoutable-example
//
//  Created by ada on 2018/8/24.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWJRouterViewController.h"

@interface UIViewController (Router)<IWJRouterViewController>

/**
 *  回调委托
 */
@property (nonatomic, weak) id<IWJRouterViewControllerDelegate> routerDelegate;

/**
 *  路由参数
 */
@property(nonatomic, strong) NSDictionary *routerParams;


@end
