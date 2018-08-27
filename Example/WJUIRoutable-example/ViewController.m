//
//  ViewController.m
//  WJUIRoutable-example
//
//  Created by Yunhai.Wu on 15/11/2.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "ViewController.h"
#import "WJUIRoutable.h"
#import "A1ViewController.h"
#import "A2ViewController.h"
#import "A3ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) NSHashTable *table;

@end

@implementation ViewController

-(void) btnOnClicked:(id) sender {
    [[WJUIRoutable sharedInstance] open:@"a1viewcontroller" animated:YES];
//    NSLog(@"btnOnClicked: %i", (int)[self.table count]);
//    NSLog(@"btnOnClicked: %i", (int)[[self.table allObjects] count]);
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear: %i", (int)[self.table count]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ViewController";
    
    
    [[WJUIRoutable sharedInstance] map:@"a1viewcontroller" toController:[A1ViewController class]];
    [[WJUIRoutable sharedInstance] map:@"a2viewcontroller" toController:[A2ViewController class]];
    [[WJUIRoutable sharedInstance] map:@"a3viewcontroller" toController:[A3ViewController class]];
    
    self.table = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory capacity:0];
    
    for (int i=0; i<100; i++) {
        [self.table addObject:[ViewController new]];
        NSLog(@"i:%i  %i", i, (int)[self.table count]);
    }
    NSLog(@"%i", (int)[self.table count]);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setTitle:@"a1" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake((self.view.bounds.size.width-80)/2, (self.view.bounds.size.height-50)/2, 80, 50)];
    [btn addTarget:self action:@selector(btnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin];
}

@end
