//
//  WJRouterConfig.m
//  WJUIRoutable-example
//
//  Created by ada on 2018/11/13.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import "WJRouterConfig.h"
#import "WJConfig.h"
#import <UIKit/UIKit.h>

#define WJ_UI_ROUTER_CONFIG_KEY                         @"WJRouter"
#define WJ_UI_ROUTER_CONFIG_DEFAULT_NAV_CONTROLLER      @"defaultNavigationController"
#define WJ_UI_ROUTER_CONFIG_INTERCEPTORS                @"interceptors"

@interface WJRouterConfig ()

@property(nonatomic, readwrite) Class defaultNavigationControllerClass;

@property(nonatomic, copy) NSArray<IWJRouterInterceptor> *interceptors;

@end

@implementation WJRouterConfig

static WJRouterConfig *sharedObject = nil;

+(instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[WJRouterConfig alloc] init];
    });
    return sharedObject;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        NSDictionary *config = [WJConfig dictionaryForKey:WJ_UI_ROUTER_CONFIG_KEY];
        if ([[config objectForKey:WJ_UI_ROUTER_CONFIG_DEFAULT_NAV_CONTROLLER] isKindOfClass:[NSString class]]) {
            Class clazz = NSClassFromString([config objectForKey:WJ_UI_ROUTER_CONFIG_DEFAULT_NAV_CONTROLLER]);
            if (clazz != Nil && [clazz isKindOfClass:[UINavigationController class]]) {
                self.defaultNavigationControllerClass = clazz;
            }
        }
        if (_defaultNavigationControllerClass == Nil) {
            self.defaultNavigationControllerClass = [UINavigationController class];
        }
        if ([[config objectForKey:WJ_UI_ROUTER_CONFIG_INTERCEPTORS] isKindOfClass:[NSArray class]]) {
            NSArray *interceptorClassNames = config[WJ_UI_ROUTER_CONFIG_INTERCEPTORS];
            NSMutableArray<IWJRouterInterceptor> *interceptorList = [[NSMutableArray<IWJRouterInterceptor> alloc] init];
            for (id obj in interceptorClassNames) {
                if ([obj isKindOfClass:[NSString class]]) {
                    Class clazz = NSClassFromString((NSString*)obj);
                    if ([clazz conformsToProtocol:@protocol(IWJRouterInterceptor)]) {
                        [interceptorList addObject:[[clazz alloc] init]];
                    }
                }
            }
            self.interceptors = interceptorList;
        }
    }
    return self;
}

-(id)copy {
    return self;
}

-(id)mutableCopy {
    return self;
}

+(Class)defaultNavigationControllerClass {
    return [[WJRouterConfig sharedInstance] defaultNavigationControllerClass];
}

+(NSArray<IWJRouterInterceptor>*)interceptors {
    return [[WJRouterConfig sharedInstance] interceptors];
}

@end
