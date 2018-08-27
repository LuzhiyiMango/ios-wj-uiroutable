//
//  WJRouterMatcher.m
//  WJUIRoutable-example
//
//  Created by ada on 2018/8/26.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import "WJRouterMatcher.h"
#import "WJLoggingAPI.h"
#import "IWJRouterViewController.h"

@interface WJRouterMatcher()

@property(nonatomic, strong) NSMutableDictionary<NSString*, WJRouterOptions*> *routes;

//是否启用链接内部参数传递 default NO
@property(nonatomic, assign) BOOL enabledLinkParams;

@property(nonatomic) Class defaultNavController;

@end

@implementation WJRouterMatcher

-(instancetype)init {
    self = [super init];
    if (self) {
        self.routes = [[NSMutableDictionary alloc] init];
        self.defaultNavController = [UINavigationController class];
    }
    return self;
}

-(instancetype)initWithEnabledLinkParams:(BOOL)enabled defaultNavigationController:(Class)navigationController {
    self = [super init];
    if (self) {
        self.routes = [[NSMutableDictionary alloc] init];
        self.enabledLinkParams = enabled;
        if (navigationController) {
            self.defaultNavController = navigationController;
        } else {
            self.defaultNavController = [UINavigationController class];
        }
    }
    return self;
}

- (void)map:(NSString *)format toCallback:(WJRouterOpenCallback)callback {
    if (format) {
        [self maps:@[format] toCallback:callback];
    } else {
        WJLogError(@"WJRouterMatcher: #format is not nil");
    }
}

- (void)maps:(NSArray *)formats toCallback:(WJRouterOpenCallback)callback {
    [self maps:formats toCallback:callback withOptions:nil];
}

- (void)map:(NSString *)format toCallback:(WJRouterOpenCallback)callback withOptions:(WJRouterOptions *)options {
    if (format) {
        [self maps:@[format] toCallback:callback withOptions:options];
    } else {
        WJLogError(@"WJRouterMatcher: #format is not nil");
    }
}

- (void)maps:(NSArray *)formats toCallback:(WJRouterOpenCallback)callback withOptions:(WJRouterOptions *)options {
    if (formats && formats.count > 0) {
        if (!options) {
            options = [WJRouterOptions routerOptions];
            [options setNavigationControllerClass:_defaultNavController];
        }
        options.callback = callback;
        for (NSString *format in formats) {
            [self.routes setObject:options forKey:format];
        }
    } else {
        WJLogError(@"WJRouterMatcher: #formats is not nil");
    }
}

- (void)map:(NSString *)format toController:(Class)controllerClass {
    if (format) {
        [self maps:@[format] toController:controllerClass];
    } else {
        WJLogError(@"WJRouterMatcher: #format is not nil");
    }
}

- (void)maps:(NSArray *)formats toController:(Class)controllerClass {
    [self maps:formats toController:controllerClass withOptions:nil];
}

- (void)map:(NSString *)format toController:(Class)controllerClass withOptions:(WJRouterOptions *)options {
    if (format) {
        [self maps:@[format] toController:controllerClass withOptions:options];
    } else {
        WJLogError(@"WJRouterMatcher: #format is not nil");
    }
}

- (void)maps:(NSArray *)formats toController:(Class)controllerClass withOptions:(WJRouterOptions *)options {
    if (formats.count > 0) {
        if (!options) {
            options = [WJRouterOptions routerOptions];
            [options setNavigationControllerClass:_defaultNavController];
        }
        if ([controllerClass conformsToProtocol:@protocol(IWJRouterViewController)]) {
            options.openClass = controllerClass;
            for (NSString *format in formats) {
                [self.routes setObject:options forKey:format];
            }
        } else {
            WJLogError(@"WJRouterMatcher: #controller need impl IWJRouterViewController");
        }
    } else {
        WJLogError(@"WJRouterMatcher: #formats is not nil");
    }
}

-(NSDictionary*)fetchUrlParams:(NSString*)url {
    if (!url) return nil;
    NSArray *segments = [url componentsSeparatedByString:@"?"];
    NSString *paramsString = [segments count] == 2 ? paramsString = segments[1] : nil;
    if (paramsString) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        NSArray *pairs = [paramsString componentsSeparatedByString:@"&"];
        for (NSString *kvp in pairs) {
            if ([kvp length] == 0) {
                continue;
            }
            NSRange pos = [kvp rangeOfString:@"="];
            NSString *key;
            NSString *val;
            
            if (pos.location == NSNotFound) {
                key = [kvp stringByRemovingPercentEncoding];
                val = @"";
            } else {
                key = [[kvp substringToIndex:pos.location] stringByRemovingPercentEncoding];
                val = [[kvp substringFromIndex:pos.location + pos.length] stringByRemovingPercentEncoding];
            }
            if (!key || !val) {
                continue;
            }
            [result setObject:val forKey:key];
        }
        return result;
    }
    return nil;
}

- (WJRouterParams*)match:(NSString*)url {
    if (url) {
        NSString *path = [url componentsSeparatedByString:@"?"][0];
        __block WJRouterParams *openRouterParams = nil;
        WJRouterOptions *options = self.routes[path];
        if (options) {
            NSDictionary *urlParams = [self fetchUrlParams:url];
            openRouterParams = [[WJRouterParams alloc] initWithRouterOptions:options openParams:urlParams];
        } else {
            if (_enabledLinkParams) {
                NSArray *givenParts = path.pathComponents;
                NSArray *legacyParts = [path componentsSeparatedByString:@"/"];
                if (legacyParts.count != givenParts.count) givenParts = legacyParts;
                [self.routes enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, WJRouterOptions * _Nonnull obj, BOOL * _Nonnull stop) {
                    NSArray *routerParts = [key componentsSeparatedByString:@"/"];
                    if ([routerParts count] == [givenParts count]) {
                        NSDictionary *givenParams = [self paramsForUrlComponents:givenParts routerUrlComponents:routerParts];
                        if (givenParams) {
                            NSMutableDictionary *openParams = [[NSMutableDictionary alloc] initWithDictionary:givenParams];
                            NSDictionary *urlParams = [self fetchUrlParams:url];
                            if ([urlParams count] > 0) [openParams addEntriesFromDictionary:urlParams];
                            openRouterParams = [[WJRouterParams alloc] initWithRouterOptions:obj openParams:openParams];
                            *stop = YES;
                        }
                    }
                }];
            }
        }
        if (!openRouterParams && [[self.routes allKeys] containsObject:@"*"]) {
            openRouterParams = [[WJRouterParams alloc] initWithRouterOptions:_routes[@"*"] openParams:nil];;
        }
        return openRouterParams;
    }
    return nil;
}

-(NSDictionary *)paramsForUrlComponents:(NSArray *)givenUrlComponents
                    routerUrlComponents:(NSArray *)routerUrlComponents {
    __block NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [routerUrlComponents enumerateObjectsUsingBlock:
     ^(NSString *routerComponent, NSUInteger idx, BOOL *stop) {
         
         NSString *givenComponent = givenUrlComponents[idx];
         if ([routerComponent hasPrefix:@":"]) {
             NSString *key = [routerComponent substringFromIndex:1];
             [params setObject:givenComponent forKey:key];
         } else if (![routerComponent isEqualToString:givenComponent]) {
             params = nil;
             *stop = YES;
         }
     }];
    return [params copy];
}

@end
