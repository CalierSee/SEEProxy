//
//  SEEProxy.h
//  SEEDot
//
//  Created by 三只鸟 on 2018/3/2.
//  Copyright © 2018年 景彦铭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SEEProxy : NSProxy

+ (instancetype)proxyWithObjs:obj,... NS_REQUIRES_NIL_TERMINATION;

@end

NS_ASSUME_NONNULL_END
