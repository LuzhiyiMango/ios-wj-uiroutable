//
//  ViewController.m
//  WJUIRoutable-example
//
//  Created by Yunhai.Wu on 15/11/2.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "ViewController.h"
#import "WJUIRoutable.h"

@interface ViewController ()

@end

@implementation ViewController

-(void) btnOnClicked:(id) sender {
    [[WJUIRoutable sharedInstance] open:@"a1viewcontroller" animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ViewController";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setTitle:@"a1" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake((self.view.bounds.size.width-80)/2, (self.view.bounds.size.height-50)/2, 80, 50)];
    [btn addTarget:self action:@selector(btnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin];
}

@end
