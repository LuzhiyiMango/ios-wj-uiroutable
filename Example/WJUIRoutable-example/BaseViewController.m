//
//  BaseViewController.m
//  WJUIRoutable-example
//
//  Created by Yunhai.Wu on 15/11/2.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

#pragma mark IWJRouterViewController
-(id) initWithURL:(NSString*) URL routerParams:(NSDictionary*) params {
    self = [super init];
    if (self) {
        self.routerParams = params;
        NSLog(@"%@ routerParams:%@",NSStringFromClass(self.class),params);
    }
    return self;
}

#pragma mark IWJRouterViewControllerDelegate
-(void) viewController:(UIViewController*) viewController routerParams:(NSDictionary*) params {
    [_routerDelegate viewController:viewController routerParams:params];
}

@end
