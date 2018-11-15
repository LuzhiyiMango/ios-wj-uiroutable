//
//  WJRouterParams.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/8/24.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJRouterOptions.h"

//路由属性
@interface WJRouterParams : NSObject

//路由选项参数
@property (nonatomic, strong) WJRouterOptions *options;


//打开参数
@property (nonatomic, copy) NSDictionary *openParams;

//额外参数
@property (nonatomic, copy) NSDictionary *extraParams;

/**
 得到完整路由参数
 @return 链接参数 + options默认参数 + open参数
 */
- (NSDictionary *)getRouterParams;


//初始化方法
- (id)initWithRouterOptions:(WJRouterOptions *)options;
- (id)initWithRouterOptions:(WJRouterOptions *)options openParams:(NSDictionary *)openParams;
- (id)initWithRouterOptions:(WJRouterOptions *)options openParams:(NSDictionary *)openParams extraParams:(NSDictionary *)extraParams;

@end
