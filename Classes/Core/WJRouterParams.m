//
//  WJRouterParams.m
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

#import "WJRouterParams.h"

@implementation WJRouterParams

- (instancetype)initWithRouterOptions:(WJRouterOptions *)routerOptions openParams:(NSDictionary *)openParams extraParams: (NSDictionary *)extraParams{
    self = [super init];
    if (self) {
        [self setRouterOptions:routerOptions];
        [self setExtraParams: extraParams];
        [self setOpenParams:openParams];
    }
    return self;
}

- (instancetype)initWithRouterOptions:(WJRouterOptions *)routerOptions openParams:(NSDictionary *)openParams {
    self = [super init];
    if (self) {
        [self setRouterOptions:routerOptions];
        [self setOpenParams:openParams];
    }
    return self;
}

- (NSDictionary *)getRouterParams {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (self.routerOptions.defaultParams) [params addEntriesFromDictionary:self.routerOptions.defaultParams];
    if (self.extraParams) [params addEntriesFromDictionary:self.extraParams];
    if (self.openParams) [params addEntriesFromDictionary:self.openParams];
    return params;
}

@end
