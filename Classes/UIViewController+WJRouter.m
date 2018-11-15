//
//  UIViewController+WJRouter.m
//  WJUIRoutable-example
//
//  Created by ada on 2018/11/13.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import "UIViewController+WJRouter.h"
#import <objc/runtime.h>

@implementation UIViewController (WJRouter)

-(void)setRouterParams:(NSDictionary *)routerParams {
    [self willChangeValueForKey:@"routerParams"];
    objc_setAssociatedObject(self, @selector(routerParams), routerParams, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"routerParams"];
}

-(NSDictionary *)routerParams {
    return objc_getAssociatedObject(self, @selector(routerParams));
}

-(void)setRouterDelegate:(id<IWJRouterViewControllerDelegate>)routerDelegate {
    [self willChangeValueForKey:@"routerDelegate"];
    objc_setAssociatedObject(self, @selector(routerDelegate), routerDelegate, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"routerDelegate"];
}

-(id<IWJRouterViewControllerDelegate>)routerDelegate {
    return objc_getAssociatedObject(self, @selector(routerDelegate));
}

#pragma mark IWJRouterViewController
- (instancetype)initWithRouterParams:(NSDictionary*) params {
    self = [self init];
    if (self) {
        self.routerParams = params;
        if ([self respondsToSelector:@selector(routerInitializedCompletion)]) {
            [self routerInitializedCompletion];
        }
    }
    return self;
}

#pragma mark IWJRouterViewControllerDelegate
-(void)viewController:(UIViewController *)viewController routerParams:(NSDictionary *)params {
    if (self.routerDelegate) [self.routerDelegate viewController:viewController routerParams:params];
}

@end
