//
//  SimpleWJRouterJumper.h
//  WJUIRoutable-example
//
//  Created by ada on 2018/9/2.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJRouterParams.h"
#import "WJRouterDefines.h"

@interface WJRouterJumper : NSObject

- (void)pop:(BOOL)animated;

- (void)popRoot:(BOOL)animated;

- (void)popAtIndex:(NSUInteger) index animated:(BOOL)animated;

- (void)dismiss:(BOOL)animated completion:(WJRouterCompletionBlock)completionBlock;

- (void)dismissAll:(BOOL)animated completion:(WJRouterCompletionBlock)completionBlock;

- (void)dismissAtIndex:(NSUInteger)index animated:(BOOL)animated completion:(WJRouterCompletionBlock)completionBlock;

- (void)close:(BOOL) animated;

- (void)closeAll:(BOOL) animated;

- (void)callTel:(NSString*)tel;

- (void)openExternalUrl:(NSString*)url;

- (void)open:(WJRouterParams*)params animated:(BOOL)animated;

- (void)resetRootViewController:(UIViewController*)rootViewController;

- (UINavigationController*)currentAvailableNavigationController;

- (UIViewController*)rootViewController;

@end
