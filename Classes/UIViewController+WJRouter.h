//
//  UIViewController+WJRouter.h
//  WJUIRoutable-example
//
//  Created by ada on 2018/11/13.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWJRouterViewController.h"


@interface UIViewController (WJRouter)<IWJRouterViewController>

//回调委托
@property (nonatomic, weak) id<IWJRouterViewControllerDelegate> routerDelegate;

//路由参数
@property(nonatomic, copy) NSDictionary *routerParams;

@end
