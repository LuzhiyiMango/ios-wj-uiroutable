//
//  IWJReturnNode.h
//  WJUIRoutable-example
//
//  Created by ada on 2018/9/2.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IWJReturnNode <NSObject>

/**
 节点tag（唯一标识）
 */
- (NSString*)nodeTag;

/**
 对应节点视图控制器
 */
- (UIViewController*)viewController;

/**
 该节点是否有效
 */
- (BOOL)isAvailable;


@end
