//
//  WJReturnNode.m
//  WJUIRoutable-example
//
//  Created by ada on 2018/8/31.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import "WJReturnNode.h"

@implementation WJReturnNode

-(BOOL)isAvailable {
    return _viewController != nil;
}

-(instancetype)initWithViewController:(UIViewController*)viewController tag:(NSString*)tag{
    self = [super init];
    if (self) {
        self.viewController = viewController;
        self.nodeTag = tag;
    }
    return self;
}

+(instancetype)node:(UIViewController *)viewController tag:(NSString *)tag {
    return [[WJReturnNode alloc] initWithViewController:viewController tag:tag];
}

@end
