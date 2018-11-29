//
//  WJReturnNode.m
//  WJUIRoutable-example
//
//  Created by ada on 2018/8/31.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import "WJReturnNode.h"

@implementation WJReturnNode

-(instancetype)initWithViewController:(UIViewController*)viewController token:(NSString*)token{
    self = [super init];
    if (self) {
        self.viewController = viewController;
        self.returnToken = token;
    }
    return self;
}

+(instancetype)node:(UIViewController *)viewController token:(NSString *)token {
    return [[WJReturnNode alloc] initWithViewController:viewController token:token];
}

#pragma mark IWJNodeElement
-(BOOL)isAvailable {
    return _viewController != nil;
}

-(NSString*)nodeIdentifier {
    return _returnToken;
}

@end
