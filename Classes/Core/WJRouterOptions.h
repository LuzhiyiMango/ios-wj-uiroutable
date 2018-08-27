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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^WJRouterOpenCallback)(NSDictionary *params);

@interface WJRouterOptions : NSObject
@property (nonatomic, assign, getter=isModal) BOOL modal;//是否为模态打开
@property (nonatomic, assign) UIModalPresentationStyle presentationStyle;
@property (nonatomic, assign) UIModalTransitionStyle transitionStyle;
@property (nonatomic, copy) NSDictionary *defaultParams;
@property (nonatomic, readwrite) Class navigationControllerClass;//导航控制器Class（当需要用到时会使用）
@property (nonatomic, readwrite) Class openClass;
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

+ (instancetype)routerOptionsAsRoot;

+ (instancetype)modal;

+ (instancetype)withPresentationStyle:(UIModalPresentationStyle)style;

+ (instancetype)withTransitionStyle:(UIModalTransitionStyle)style;

+ (instancetype)forDefaultParams:(NSDictionary *)defaultParams;

@end
