//
//  A1ViewController.m
//  WJUIRoutable-example
//
//  Created by Yunhai.Wu on 15/11/2.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "A1ViewController.h"
#import "WJRouter.h"

@implementation A1ViewController


-(void) btnOnClicked:(id) sender {
    [[WJRouter sharedInstance] recordReturn:@"a1token" viewController:self];
    [[WJRouter sharedInstance] open:@"a2viewcontroller" animated:YES extraParams:@{@"a1":@"a1"}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"A1-%i",(int)[[self.navigationController viewControllers] indexOfObject:self]];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setTitle:@"a2" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake((self.view.bounds.size.width-80)/2, (self.view.bounds.size.height-50)/2, 80, 50)];
    [btn addTarget:self action:@selector(btnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin];
}

@end
