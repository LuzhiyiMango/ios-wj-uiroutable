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

- (instancetype)initWithRouterOptions:(WJRouterOptions *)options openParams:(NSDictionary *)openParams extraParams: (NSDictionary *)extraParams{
    self = [super init];
    if (self) {
        [self setOptions:options];
        [self setExtraParams: extraParams];
        [self setOpenParams:openParams];
    }
    return self;
}

- (instancetype)initWithRouterOptions:(WJRouterOptions *)options openParams:(NSDictionary *)openParams {
    self = [super init];
    if (self) {
        [self setOptions:options];
        [self setOpenParams:openParams];
    }
    return self;
}

-(id)initWithRouterOptions:(WJRouterOptions *)options {
    self = [super init];
    if (self) {
        self.options = options;
    }
    return self;
}

- (NSDictionary *)getRouterParams {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if ([self.options.defaultParams count] > 0) [params addEntriesFromDictionary:self.options.defaultParams];
    if ([self.extraParams count] > 0) [params addEntriesFromDictionary:self.extraParams];
    if ([self.openParams count] > 0) [params addEntriesFromDictionary:self.openParams];
    return params;
}

@end
