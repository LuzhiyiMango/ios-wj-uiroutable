//
//  A2ViewController.m
//  WJUIRoutable-example
//
//  Created by Yunhai.Wu on 15/11/2.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "A2ViewController.h"
#import "WJRouter.h"

@implementation A2ViewController

-(void) btnOnClicked:(id) sender {
    [[WJRouter sharedInstance] open:@"a3viewcontroller" animated:YES extraParams:@{@"a2":@"a2"}];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.title = [NSString stringWithFormat:@"A2-%i",(int)[[self.navigationController viewControllers] indexOfObject:self]];;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setTitle:@"a3" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake((self.view.bounds.size.width-80)/2, (self.view.bounds.size.height-50)/2, 80, 50)];
    [btn addTarget:self action:@selector(btnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin];
}

@end
