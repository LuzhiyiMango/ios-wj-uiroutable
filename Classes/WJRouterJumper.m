//
//  SimpleWJRouterJumper.m
//  WJUIRoutable-example
//
//  Created by ada on 2018/9/2.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import "WJRouterJumper.h"
#import "WJRouterConfig.h"
#import "IWJRouterInterceptor.h"
#import "UIViewController+WJRouter.h"
#import "WJLoggingAPI.h"

@interface WJRouterJumper ()

@property(nonatomic, strong) NSArray<IWJRouterInterceptor> *interceptors;

@end

@implementation WJRouterJumper

-(instancetype)init {
    self = [super init];
    if (self) {
        self.interceptors = [WJRouterConfig interceptors];
    }
    return self;
}

- (void) pop:(BOOL)animated {
    UINavigationController *currentNavigationController = [self currentAvailableNavigationController];
    if (currentNavigationController && [[currentNavigationController viewControllers] count] > 1) {
        [currentNavigationController popViewControllerAnimated:animated];
    }
}

- (void) popRoot:(BOOL)animated {
    UINavigationController *currentNavigationController = [self currentAvailableNavigationController];
    if (currentNavigationController) {
        [currentNavigationController popToRootViewControllerAnimated:animated];
    }
}

- (void) popAtIndex:(NSUInteger) index animated:(BOOL)animated {
    UINavigationController *currentNavigationController = [self currentAvailableNavigationController];
    if (currentNavigationController) {
        NSArray *viewControllers = [currentNavigationController viewControllers];
        if (index < [viewControllers count]) {
            [currentNavigationController popToViewController:viewControllers[index] animated:animated];
        }
    }
}

- (void)dismiss:(BOOL)animated completion:(WJRouterCompletionBlock)completionBlock {
    UIViewController *topPresentedViewController = [self topPresentedViewController];
    if (topPresentedViewController.presentingViewController) {
        [topPresentedViewController dismissViewControllerAnimated:animated completion:completionBlock];
    }
}

- (void)dismissAll:(BOOL)animated completion:(WJRouterCompletionBlock)completionBlock {
    UIViewController *rootViewController = [self rootViewController];
    if (rootViewController.presentedViewController) {
        [rootViewController dismissViewControllerAnimated:animated completion:completionBlock];
    }
}

- (void)dismissAtIndex:(NSUInteger)index animated:(BOOL)animated completion:(WJRouterCompletionBlock)completionBlock {
    NSArray *presentedViewControllers = [self presentedViewControllers];
    if (index < [presentedViewControllers count]) {
        [presentedViewControllers[index] dismissViewControllerAnimated:animated completion:completionBlock];
    }
}

- (void) close:(BOOL) animated {
    UIViewController *topPresentedViewController = [self topPresentedViewController];
    if ([topPresentedViewController isKindOfClass:[UINavigationController class]]) {
        if ([[(UINavigationController*)topPresentedViewController viewControllers] count] > 1) {
            [(UINavigationController*)topPresentedViewController popViewControllerAnimated:animated];
        } else {
            [self dismiss:animated completion:NULL];
        }
    } else {
        [self dismiss:animated completion:NULL];
    }
}

- (void) closeAll:(BOOL) animated {
    UINavigationController *nav = [self currentAvailableNavigationController];
    if (nav) {
        if ([[nav viewControllers] count] > 1) {
            [nav popToRootViewControllerAnimated:animated];
        } else {
            [self dismissAll:animated completion:NULL];
        }
    } else {
        [self dismissAll:animated completion:NULL];
    }
}

- (void)callTel:(NSString*)tel {
    if (tel) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",tel]]];
    }
}

- (void)openExternalUrl:(NSString*)url {
    if (url) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}


- (void)doInterceptorsAfterCompletion:(WJRouterParams*)params {
    if ([self.interceptors count] > 0) {
        for (id<IWJRouterInterceptor> interceptor in self.interceptors) {
            [interceptor afterCompletion:[params getRouterParams][WJ_ROUTER_URL_ORIGINAL] params:[params getRouterParams]];
        }
    }
}

- (void)open:(WJRouterParams*)params animated:(BOOL)animated {
    if (params) {
        if ([[params options] callback] != NULL) {
            [params options].callback([params getRouterParams]);
            [self doInterceptorsAfterCompletion:params];
        } else {
            UIViewController *viewController = [[[[params options] openClass] alloc] initWithRouterParams:[params getRouterParams]];
            if ([[params options] isModal]) {
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
                UIViewController *topPresentedViewController = [self topPresentedViewController];
                if ([topPresentedViewController isKindOfClass:[UINavigationController class]]) {
                    [viewController setRouterDelegate:[[(UINavigationController*)topPresentedViewController viewControllers] lastObject]];
                } else if ([topPresentedViewController isKindOfClass:[UITabBarController class]]) {
                    UIViewController *selectedViewController = [(UITabBarController*)topPresentedViewController selectedViewController];
                    if ([selectedViewController isKindOfClass:[UINavigationController class]]) {
                        [viewController setRouterDelegate:[(UINavigationController*)selectedViewController viewControllers].lastObject];
                    } else {
                        [viewController setRouterDelegate:selectedViewController];
                    }
                } else {
                    [viewController setRouterDelegate:topPresentedViewController];
                }
                __weak typeof(self) weakSelf = self;
                [topPresentedViewController presentViewController:nav animated:animated completion:^{
                    [weakSelf doInterceptorsAfterCompletion:params];
                }];
            } else {
                UINavigationController *navigationController = [self currentAvailableNavigationController];
                if (navigationController) {
                    UIViewController *topVC = [[navigationController viewControllers] lastObject];
                    [viewController setRouterDelegate:topVC];
                    [navigationController pushViewController:viewController animated:animated];
                } else {
                    WJLogError(@"无法代开置顶页面~");
                }
            }
        }
    }
}

-(void)resetRootViewController:(UIViewController *)rootViewController {
    if (rootViewController && !rootViewController.view.window) {
        if ([[self rootViewController] presentedViewController]) {
            [[self rootViewController] dismissViewControllerAnimated:NO completion:NULL];
        }
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:rootViewController];
    }
}

- (NSArray*)presentedViewControllers {
    UIViewController *presentingViewController = [self rootViewController];
    NSMutableArray *presenteds = [[NSMutableArray alloc] initWithObjects:presentingViewController, nil];
    while (true) {
        if (presentingViewController.presentedViewController) {
            [presenteds addObject:presentingViewController.presentedViewController];
            presentingViewController = presentingViewController.presentedViewController;
        } else {
            break;
        }
    }
    return presenteds;
}

-(UIViewController*) topPresentedViewController {
    return [[self presentedViewControllers] lastObject];
}

- (UINavigationController*)currentAvailableNavigationController {
    UINavigationController *navigationController = nil;
    NSArray *presentedViewControllers = [self presentedViewControllers];
    if ([presentedViewControllers count] > 0) {
        for (NSUInteger i = presentedViewControllers.count - 1; i >= 0; i--) {
            UIViewController *presentingViewController = presentedViewControllers[i];
            if ([presentingViewController isKindOfClass:[UINavigationController class]]) {
                navigationController = (UINavigationController*)presentingViewController;
                break;
            } else if (presentingViewController == [self rootViewController]) {
                if ([presentingViewController isKindOfClass:[UITabBarController class]]) {
                    UIViewController *selectedVC = [(UITabBarController*)presentingViewController selectedViewController];
                    if ([selectedVC isKindOfClass:[UINavigationController class]]) {
                        navigationController = (UINavigationController*)selectedVC;
                        break;
                    }
                } else if ([presentingViewController isKindOfClass:[UINavigationController class]]) {
                    navigationController = (UINavigationController*)presentingViewController;
                    break;
                }
            }
        }
    }
    return navigationController;
}

- (UIViewController*)rootViewController {
    return [[[[UIApplication sharedApplication] delegate] window] rootViewController];
}

-(void)execReturnNode:(WJReturnNode *)returnNode {
    if ([returnNode isAvailable]) {
        UIViewController *vc = [returnNode viewController];
        
        if ([vc presentedViewController]) {
            [vc dismissViewControllerAnimated:NO completion:NULL];
        } else if ([[vc parentViewController] presentedViewController]) {
            [[vc parentViewController] dismissViewControllerAnimated:NO completion:NULL];
        }
        
        if ([[vc parentViewController] isKindOfClass:[UINavigationController class]]) {
            if ([[(UINavigationController*)[vc parentViewController] viewControllers] lastObject] != vc) {
                [(UINavigationController*)[vc parentViewController] popToViewController:vc animated:NO];
            }
        }
    }
}

@end
