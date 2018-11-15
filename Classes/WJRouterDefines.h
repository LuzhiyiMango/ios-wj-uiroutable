//
//  WJRouterDefines.h
//  WJUIRoutable-example
//
//  Created by ada on 2018/9/2.
//  Copyright © 2018年 WJ. All rights reserved.
//

#ifndef WJRouterDefines_h
#define WJRouterDefines_h

#import <Foundation/Foundation.h>

/**
 路由完成回调Block
 */
typedef void(^WJRouterCompletionBlock)();

/**
 路由打开回调Block
 */
typedef void (^WJRouterOpenCallback)(NSDictionary *params);



#define     WJ_ROUTER_URL_ORIGINAL         @"routingOriginalURL"

#define     WJ_ROUTER_URL_ALIAS            @"routingAliasURL"


#endif
