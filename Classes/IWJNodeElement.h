//
//  IWJStackElement.h
//  WJUIRoutable-example
//
//  Created by ada on 2018/11/28.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IWJNodeElement <NSObject>

/**
 是否为有效节点
 */
-(BOOL)isAvailable;

/**
 节点标识
 */
-(NSString*)nodeIdentifier;

@end
