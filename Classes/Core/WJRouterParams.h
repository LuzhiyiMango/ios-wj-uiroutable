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
@property (readwrite, nonatomic, strong) WJRouterOptions *routerOptions;


//打开参数
@property (readwrite, nonatomic, strong) NSDictionary *openParams;


//额外参数
@property (readwrite, nonatomic, strong) NSDictionary *extraParams;


//得到路由参数
- (NSDictionary *)getRouterParams;

//初始化方法
- (id)initWithRouterOptions: (WJRouterOptions *)routerOptions openParams: (NSDictionary *)openParams;

//初始化方法
- (id)initWithRouterOptions: (WJRouterOptions *)routerOptions openParams: (NSDictionary *)openParams extraParams: (NSDictionary *)extraParams;

@end
