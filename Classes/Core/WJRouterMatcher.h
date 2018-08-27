//
//  WJRouterMatcher.h
//  WJUIRoutable-example
//
//  Created by ada on 2018/8/26.
//  Copyright © 2018年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWJRouterMatcher.h"

@interface WJRouterMatcher : NSObject<IWJRouterMatcher>


- (instancetype)initWithEnabledLinkParams:(BOOL)enabled defaultNavigationController:(Class<UINavigationControllerDelegate>)navigationController;

@end
