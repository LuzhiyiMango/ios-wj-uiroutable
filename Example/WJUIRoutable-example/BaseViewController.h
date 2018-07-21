//
//  BaseViewController.h
//  WJUIRoutable-example
//
//  Created by Yunhai.Wu on 15/11/2.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWJRouterViewController.h"

@interface BaseViewController : UIViewController<IWJRouterViewController>

@property (nonatomic, copy) NSDictionary *routerParams;

#pragma mark IWJRouterViewController
@property (nonatomic, weak) id<IWJRouterViewControllerDelegate> routerDelegate;

@end
