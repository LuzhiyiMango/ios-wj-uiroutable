//
//  WJNodeContainer.h
//  WJUIRoutable-example
//
//  Created by ada on 2018/9/2.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWJNodeElement.h"

/**
 回退节点栈
 */
@interface WJNodeContainer : NSObject

/**
 添加节点
 */
- (void)addNode:(id<IWJNodeElement>)node;

/**
 获取节点并删除
 */
- (id<IWJNodeElement>)getNodeAndDel:(NSString*)nodeIdentifier;


/**
 是否存在节点
 */
- (BOOL)contains:(NSString*)nodeIdentifier;

@end
