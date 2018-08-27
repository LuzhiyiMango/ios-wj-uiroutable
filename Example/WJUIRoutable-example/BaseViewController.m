//
//  BaseViewController.m
//  WJUIRoutable-example
//
//  Created by Yunhai.Wu on 15/11/2.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

-(void)routerInitFinished {
    NSLog(@"%@", self.routerParams);
}

@end
