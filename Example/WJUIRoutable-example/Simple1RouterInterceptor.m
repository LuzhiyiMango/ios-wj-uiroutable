//
//  Simple1RouterInterceptor.m
//  WJUIRoutable-example
//
//  Created by ada on 2018/12/12.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import "Simple1RouterInterceptor.h"

@implementation Simple1RouterInterceptor

-(BOOL)preHandle:(NSString*)routerUrl formattedUrl:(NSString**)formattedUrl {
    NSLog(@"router interceptor1 pre: %@", routerUrl);
    return YES;
}

-(void)afterCompletion:(NSString*)routerUrl params:(NSDictionary*)params {
    NSLog(@"router interceptor1 completion: %@", routerUrl);
}

@end
