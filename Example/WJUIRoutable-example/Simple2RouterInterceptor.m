//
//  Simple2RouterInterceptor.m
//  WJUIRoutable-example
//
//  Created by ada on 2018/12/12.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import "Simple2RouterInterceptor.h"

@implementation Simple2RouterInterceptor

-(BOOL)preHandle:(NSString*)routerUrl formattedUrl:(NSString**)formattedUrl {
    NSLog(@"router interceptor2 pre: %@", routerUrl);
    return YES;
}

-(void)afterCompletion:(NSString*)routerUrl params:(NSDictionary*)params {
    NSLog(@"router interceptor2 completion: %@", routerUrl);
}

@end
