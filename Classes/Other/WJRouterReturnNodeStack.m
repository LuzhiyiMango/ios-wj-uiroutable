//
//  WJRouterReturnStack.m
//  WJUIRoutable-example
//
//  Created by ada on 2018/9/2.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import "WJRouterReturnNodeStack.h"

@interface WJRouterReturnNodeStack()

@property(nonatomic, strong) NSMutableArray *nodes;

@property(nonatomic, strong) NSMutableDictionary *mapNodes;

@end

@implementation WJRouterReturnNodeStack

-(void)dealloc {
    [self.nodes removeAllObjects];
    [self.mapNodes removeAllObjects];
}

-(instancetype)init {
    self = [super init];
    if (self) {
        self.nodes = [[NSMutableArray alloc] init];
        self.mapNodes = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)checkNodes {
    
    
}

- (void)push:(id<IWJReturnNode>)node {
    [self checkNodes];
    if (node) {
        [_nodes insertObject:node atIndex:0];
        [_mapNodes setObject:node forKey:[node nodeTag]];
    }
}

- (id)pop {
//    id<IWJReturnNode> node = [self peek];
//    if (node) {
//        [_nodes removeObject:node];
//        [_mapNodes removeObjectForKey:[node tag]];
//        if (![node isAvailable]) {
//            return [self pop];
//        }
//    }
//    return node;
    return nil;
}

- (NSArray*)popWithTag:(NSString *)tag {
    return nil;
}

- (NSArray *)popWithIndex:(NSInteger)index {
    return nil;
}

- (BOOL)isEmpty {
    return [self length] == 0;
}

- (void)clear {
    [_nodes removeAllObjects];
}

- (id)peek {
    if ([_nodes count] > 0) return [_nodes firstObject];
    return nil;
}

-(NSUInteger)length {
    [self checkNodes];
    return [_nodes count];
}

-(BOOL)contains:(NSString *)tag {
    if (tag) {
        [self checkNodes];
        return [[_mapNodes allKeys] containsObject:tag];
    }
    return NO;
}

@end
