//
//  IWJInterceptor.h
//  WJUIRoutable-example
//
//  Created by ada on 2018/8/15.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>


//拦截器
@protocol IWJInterceptor <NSObject>

//开始进入拦截
-(BOOL)preHandle;


//打开之后拦截
-(void)afterCompletion;

@end
