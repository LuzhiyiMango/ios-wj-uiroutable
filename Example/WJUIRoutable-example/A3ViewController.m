//
//  A3ViewController.m
//  WJUIRoutable-example
//
//  Created by 吴云海 on 16/9/4.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "A3ViewController.h"
#import "WJUIRoutable.h"

@interface A3ViewController ()

@end

@implementation A3ViewController

-(void) btnOnClicked:(id) sender {
//    [[WJUIRoutable sharedInstance] openReturnNode:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setTitle:@"openReturnNode" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake((self.view.bounds.size.width-80)/2, (self.view.bounds.size.height-50)/2, 80, 50)];
    [btn addTarget:self action:@selector(btnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin];
}


@end
