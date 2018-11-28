//
//  WJReturnNode.h
//  WJUIRoutable-example
//
//  Created by ada on 2018/8/31.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWJNodeElement.h"

/**
 回退节点
 */
@interface WJReturnNode : NSObject<IWJNodeElement>

/**
 路由视图控制器
 */
@property(nonatomic, weak) UIViewController *viewController;

/**
 回退标记
 */
@property(nonatomic, copy) NSString *returnToken;

/**
 实例化一个节点
 */
+ (instancetype)node:(UIViewController*)viewController token:(NSString*)returnToken;


@end
