//
//  WJRouter.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/8/24.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "WJRouter.h"
#import "WJRouterParams.h"
#import "WJRouterMatcher.h"
#import "WJRouterJumper.h"
#import "WJReturnNode.h"
#import "WJNodeContainer.h"

static WJRouter *sharedObject;

@interface WJRouter ()

//路由匹配
@property(nonatomic, strong) WJRouterMatcher *matcher;

@property(nonatomic, strong) WJRouterJumper *jumper;

@property(nonatomic, strong) WJNodeContainer *returnNodeContainer;

@end

@implementation WJRouter

- (void)pop:(BOOL)animated {
    [_jumper pop:animated];
}

- (void)popRoot:(BOOL)animated {
    [_jumper popRoot:animated];
}

- (void)popAtIndex:(NSUInteger) index animated:(BOOL)animated {
    [_jumper popAtIndex:index animated:animated];
}

- (void)dismiss:(BOOL)animated completion:(WJRouterCompletionBlock)completionBlock {
    [_jumper dismiss:animated completion:completionBlock];
}

- (void)dismissAll:(BOOL)animated completion:(WJRouterCompletionBlock)completionBlock {
    [_jumper dismissAll:animated completion:completionBlock];
}

- (void)dismissAtIndex:(NSUInteger) index animated:(BOOL)animated completion:(WJRouterCompletionBlock)completionBlock {
    [_jumper dismissAtIndex:index animated:animated completion:completionBlock];
}

- (void)close:(BOOL) animated {
    [_jumper close:animated];
}

- (void)closeAll:(BOOL) animated {
    [_jumper closeAll:animated];
}

- (void)map:(NSString *)format toCallback:(WJRouterOpenCallback)callback {
    [self map:format toCallback:callback withOptions:nil];
}

- (void)maps:(NSArray *)formats toCallback:(WJRouterOpenCallback)callback {
    [self maps:formats toCallback:callback withOptions:nil];
}

- (void)map:(NSString *)format toCallback:(WJRouterOpenCallback)callback withOptions:(WJRouterOptions *)options {
    [self maps:@[format] toCallback:callback withOptions:options];
}

- (void)maps:(NSArray *)formats toCallback:(WJRouterOpenCallback)callback withOptions:(WJRouterOptions *)options {
    [_matcher maps:formats toCallback:callback withOptions:options];
}

- (void)map:(NSString *)format toController:(Class)controllerClass {
    [self map:format toController:controllerClass withOptions:nil];
}

- (void)maps:(NSArray *)formats toController:(Class)controllerClass {
    [self maps:formats toController:controllerClass withOptions:nil];
}

- (void)map:(NSString *)format toController:(Class)controllerClass withOptions:(WJRouterOptions *)options {
    [self maps:@[format] toController:controllerClass withOptions:options];
}

- (void)maps:(NSArray *)formats toController:(Class)controllerClass withOptions:(WJRouterOptions *)options {
    [_matcher maps:formats toController:controllerClass withOptions:options];
}

- (void)callTel:(NSString*)tel {
    [_jumper callTel:tel];
}

- (void)openExternal:(NSString *)url {
    [_jumper openExternalUrl:url];
}

- (void)open:(NSString *)url {
    [self open:url animated:NO];
}

- (void)open:(NSString *)url animated:(BOOL)animated {
    [self open:url animated:animated extraParams:nil];
}

- (void)open:(NSString *)url animated:(BOOL)animated extraParams:(NSDictionary *)extraParams {
    WJRouterParams *params = [_matcher match:url];
    if (params) {
        [params setExtraParams:extraParams];
        [_jumper open:params animated:animated];
    }
}

- (void)resetRootViewController:(UIViewController*)rootViewController {
    [_jumper resetRootViewController:rootViewController];
}

- (UINavigationController*)currentAvailableNavigationController {
    return [_jumper currentAvailableNavigationController];
}

- (void)performInitialize {
    self.matcher = [[WJRouterMatcher alloc] init];
    self.jumper = [[WJRouterJumper alloc] init];
    self.returnNodeContainer = [[WJNodeContainer alloc] init];
}

+(instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[WJRouter alloc] init];
        [sharedObject performInitialize];
    });
    return sharedObject;
}

-(id)mutableCopy {
    return self;
}

-(id)copy {
    return self;
}

+(id)allocWithZone:(NSZone *)zone {
    @synchronized (self) {
        if (sharedObject == nil) {
            sharedObject = [super allocWithZone:zone];
        }
    }
    return sharedObject;
}

- (void)recordReturn:(NSString*)returnToken viewController:(UIViewController*)viewController {
    if (viewController && returnToken) {
        WJReturnNode *node = [WJReturnNode node:viewController token:returnToken];
        [_returnNodeContainer addNode:node];
    }
}

- (void)execReturn:(NSString*)returnToken {
    WJReturnNode *node = [_returnNodeContainer getNodeAndDel:returnToken];
    if (node) [_jumper execReturnNode:node];
}

- (BOOL)containsReturn:(NSString*)returnToken {
    return [_returnNodeContainer contains:returnToken];
}

@end
