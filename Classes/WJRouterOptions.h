//
//  WJRouterOptions.h
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

#import <UIKit/UIKit.h>
#import "WJRouterDefines.h"

@interface WJRouterOptions : NSObject

//是否为模态打开
@property (nonatomic, assign, getter=isModal) BOOL modal;

//模态展示样式
@property (nonatomic, assign) UIModalPresentationStyle presentationStyle;

//转场样式
@property (nonatomic, assign) UIModalTransitionStyle transitionStyle;

//默认参数
@property (nonatomic, copy) NSDictionary *defaultParams;


/**
 模态打开ViewController时需要一个导航控制器视图，可在WJConfig中配置一个全局导航控制器
 注意：  1、建议模态打开视图控制器
        2、如果模态打开视图控制器不用需要导航控制器，请使用map block方式实现
 */
@property (nonatomic, readwrite) Class navigationControllerClass;


/**
 映射的视图控制器
 */
@property (nonatomic, readwrite) Class openClass;


/**
 映射的Block
 */
@property (nonatomic, copy) WJRouterOpenCallback callback;


+ (instancetype)routerOptionsWithPresentationStyle: (UIModalPresentationStyle)presentationStyle
                                   transitionStyle: (UIModalTransitionStyle)transitionStyle
                                     defaultParams: (NSDictionary *)defaultParams
                                           isModal: (BOOL)isModal;

+ (instancetype)routerOptions;


+ (instancetype)routerOptionsAsModal;


+ (instancetype)routerOptionsWithPresentationStyle:(UIModalPresentationStyle)style;


+ (instancetype)routerOptionsWithTransitionStyle:(UIModalTransitionStyle)style;


+ (instancetype)routerOptionsForDefaultParams:(NSDictionary *)defaultParams;

@end
