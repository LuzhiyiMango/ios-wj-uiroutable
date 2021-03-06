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
#import "WJRouterConfig.h"

@interface WJRouterMatcher()

@property(nonatomic, strong) NSMutableDictionary<NSString*, WJRouterOptions*> *routes;

//拦截器列表
@property(nonatomic, strong) NSArray *interceptors;

@end

@implementation WJRouterMatcher

-(instancetype)init {
    self = [super init];
    if (self) {
        self.routes = [[NSMutableDictionary alloc] init];
        self.interceptors = [WJRouterConfig interceptors];
    }
    return self;
}

- (void)maps:(NSArray *)formats toCallback:(WJRouterOpenCallback)callback withOptions:(WJRouterOptions *)options {
    if (formats && formats.count > 0) {
        if (!options) {
            options = [WJRouterOptions routerOptions];
            [options setNavigationControllerClass:[WJRouterConfig defaultNavigationControllerClass]];
        }
        options.callback = callback;
        for (NSString *format in formats) {
            [self.routes setObject:options forKey:format];
        }
    } else {
        WJLogError(@"WJRouterMatcher: #formats is not nil");
    }
}

- (void)maps:(NSArray *)formats toController:(Class)controllerClass withOptions:(WJRouterOptions *)options {
    if (formats.count > 0) {
        if (!options) {
            options = [WJRouterOptions routerOptions];
            [options setNavigationControllerClass:[WJRouterConfig defaultNavigationControllerClass]];
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

- (NSDictionary*)extractUrlParams:(NSString*)url {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if (url) {
        NSArray *segments = [url componentsSeparatedByString:@"?"];
        [result setObject:segments[0] forKey:WJ_ROUTER_URL_ALIAS];
        [result setObject:url forKey:WJ_ROUTER_URL_ORIGINAL];
        NSString *paramsSegment = [segments count] == 2 ? paramsSegment = segments[1] : nil;
        if (paramsSegment) {
            NSArray *paramItems = [paramsSegment componentsSeparatedByString:@"&"];
            for (NSString *kvp in paramItems) {
                if ([kvp length] == 0) continue;
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
        }
    }
    return result;
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

- (WJRouterParams*)match:(NSString*)url {
    if (url) {
        NSDictionary *urlParams = [self extractUrlParams:url];
        NSString *path = urlParams[WJ_ROUTER_URL_ALIAS];
        if ([self.interceptors count] > 0) {
            NSMutableDictionary *p = [[NSMutableDictionary alloc] initWithDictionary:urlParams];
            for (id<IWJRouterInterceptor> interceptor in self.interceptors) {
                NSString *formatterUrl = nil;
                if ([interceptor preHandle:path formattedUrl:&formatterUrl]) {
                    if (formatterUrl) {
                        [p setObject:formatterUrl forKey:WJ_ROUTER_URL_ALIAS];
                        path = formatterUrl;
                    }
                } else {
                    return nil;
                }
            }
            urlParams = [p copy];
        }
        __block WJRouterParams *openRouterParams = nil;
        WJRouterOptions *options = self.routes[path];
        if (options) {
            openRouterParams = [[WJRouterParams alloc] initWithRouterOptions:options openParams:urlParams];
        } else {
            NSArray *givenParts = path.pathComponents;
            NSArray *legacyParts = [path componentsSeparatedByString:@"/"];
            if (legacyParts.count != givenParts.count) givenParts = legacyParts;
            [self.routes enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, WJRouterOptions * _Nonnull obj, BOOL * _Nonnull stop) {
                NSArray *routerParts = [key componentsSeparatedByString:@"/"];
                if ([routerParts count] == [givenParts count]) {
                    NSDictionary *givenParams = [self paramsForUrlComponents:givenParts routerUrlComponents:routerParts];
                    if (givenParams) {
                        NSMutableDictionary *openParams = [[NSMutableDictionary alloc] initWithDictionary:givenParams];
                        NSDictionary *urlParams = [self extractUrlParams:url];
                        if ([urlParams count] > 0) [openParams addEntriesFromDictionary:urlParams];
                        openRouterParams = [[WJRouterParams alloc] initWithRouterOptions:obj openParams:openParams];
                        *stop = YES;
                    }
                }
            }];
        }
        if (!openRouterParams && [[self.routes allKeys] containsObject:@"*"]) {
            openRouterParams = [[WJRouterParams alloc] initWithRouterOptions:_routes[@"*"] openParams:urlParams];;
        }
        return openRouterParams;
    }
    return nil;
}

@end
