//
//  UIViewController+Router.m
//  WJUIRoutable-example
//
//  Created by ada on 2018/8/24.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import "UIViewController+Router.h"
#import <objc/runtime.h>

NSString * const WJRouterUrl = @"routerUrl";

@implementation UIViewController (Router)


-(void)setRouterParams:(NSDictionary *)routerParams {
    [self willChangeValueForKey:@"routerParams"];
    objc_setAssociatedObject(self, @selector(routerParams), routerParams, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"routerParams"];
}

-(NSDictionary *)routerParams {
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setRouterDelegate:(id<IWJRouterViewControllerDelegate>)routerDelegate {
    [self willChangeValueForKey:@"routerDelegate"];
    objc_setAssociatedObject(self, @selector(routerDelegate), routerDelegate, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"routerDelegate"];
}

-(id<IWJRouterViewControllerDelegate>)routerDelegate {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark IWJRouterViewController
-(instancetype) initWithURL:(NSString*) url routerParams:(NSDictionary*) params {
    self = [self init];
    if (self) {
        self.routerParams = params;
    }
    return self;
}

//默认实现
-(void)viewController:(UIViewController *)viewController routerParams:(NSDictionary *)params {
    if (self.routerDelegate) [self.routerDelegate viewController:viewController routerParams:params];
}

@end
