//
//  WJRouterReturnStack.h
//  WJUIRoutable-example
//
//  Created by ada on 2018/9/2.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWJReturnNode.h"

/**
 回退节点栈
 */
@interface WJRouterReturnNodeStack : NSObject

/**
 入栈
 @param node 回退节点
 */
- (void)push:(id<IWJReturnNode>)node;

/**
 出栈（返回栈元素，并移除该元素）
 @return 返回栈元素
 */
- (id<IWJReturnNode>)pop;


/**
 出栈
 @param tag 节点标签
 @return 返回该节点
 */
- (NSArray<IWJReturnNode>*)popWithTag:(NSString*)tag;


/**
 出栈

 @param index 元素索引号，索引从栈顶开始
 @return 节点列表
 */
- (NSArray<IWJReturnNode>*)popWithIndex:(NSInteger)index;

/**
 是否为空
 */
- (BOOL)isEmpty;

/**
 清空栈
 */
- (void)clear;

/**
 查看栈顶部的对象，但不从栈中移除
 @return 返回栈元素
 */
- (id<IWJReturnNode>)peek;

/**
 栈长度
 */
- (NSUInteger)length;


/**
 是否包含该tag回退节点
 */
- (BOOL)contains:(NSString*)tag;

@end
