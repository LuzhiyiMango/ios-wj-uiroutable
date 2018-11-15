//
//  WJReturnNode.h
//  WJUIRoutable-example
//
//  Created by ada on 2018/8/31.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 回退节点
 */
@interface WJReturnNode : NSObject

/**
 路由视图控制器
 */
@property(nonatomic, weak) UIViewController *viewController;

/**
 回退标记
 */
@property(nonatomic, copy) NSString *nodeTag;

/**
 检查是否可用
 */
-(BOOL)isAvailable;

/**
 实例化一个节点
 */
+(instancetype)node:(UIViewController*)viewController tag:(NSString*)tag;


@end
