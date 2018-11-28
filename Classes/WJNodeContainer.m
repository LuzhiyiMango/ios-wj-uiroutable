//
//  WJNodeContainer.m
//  WJUIRoutable-example
//
//  Created by ada on 2018/9/2.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import "WJNodeContainer.h"

@interface WJNodeContainer()

@property(nonatomic, strong) NSMutableDictionary *mapNodes;

@end

@implementation WJNodeContainer

-(instancetype)init {
    self = [super init];
    if (self) {
        self.mapNodes = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)checkNodes {
    NSArray *values = [_mapNodes allValues];
    if ([values count] > 0) {
        for (id<IWJNodeElement> node in values) {
            if (![node isAvailable]) {
                [_mapNodes removeObjectForKey:[node nodeIdentifier]];
            }
        }
    }
}

- (void)addNode:(id<IWJNodeElement>)node {
    if ([node nodeIdentifier]) {
        [_mapNodes setObject:node forKey:[node nodeIdentifier]];
    }
}

- (id<IWJNodeElement>)getNodeAndDel:(NSString*)nodeIdentifier {
    [self checkNodes];
    id<IWJNodeElement> node = _mapNodes[nodeIdentifier];
    if (node) {
        if (![node isAvailable]) {
            [_mapNodes removeObjectForKey:nodeIdentifier];
            node = nil;
        }
    }
    return node;
}


- (BOOL)contains:(NSString*)nodeIdentifier {
    return [[_mapNodes allKeys] containsObject:nodeIdentifier];
}

@end
