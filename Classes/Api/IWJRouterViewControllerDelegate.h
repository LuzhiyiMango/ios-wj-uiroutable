//
//  IWJRouterViewControllerDelegate.h
//  WJUIRoutable-example
//
//  Created by ada on 2018/8/24.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

//路由委托
@protocol IWJRouterViewControllerDelegate <NSObject>

/**
 *  试图控制器间回调委托
 *  回调委托
 */
-(void) viewController:(UIViewController*) viewController routerParams:(NSDictionary*) params;

@end
