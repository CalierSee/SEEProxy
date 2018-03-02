//
//  SEEProxy.m
//  SEEDot
//
//  Created by 三只鸟 on 2018/3/2.
//  Copyright © 2018年 景彦铭. All rights reserved.
//

#import "SEEProxy.h"

@implementation SEEProxy {
    NSArray * _objs;
}

+ (instancetype)proxyWithObjs:(id)obj, ... NS_REQUIRES_NIL_TERMINATION {
    NSMutableArray * objs = [NSMutableArray arrayWithObject:obj];
    if (obj) {
        va_list args;
        va_start(args, obj);
        id obj;
        while ((obj = va_arg(args, id))) {
            [objs addObject:obj];
        }
        va_end(args);
    }
    SEEProxy * instance = [SEEProxy alloc];
    instance -> _objs = objs.copy;
    return instance;
}

//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    __block id target;
//    [_objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        //判断对象是否能够响应方法
//        if ([obj respondsToSelector:aSelector]) {
//            target = obj;
//            *stop = YES;
//        }
//    }];
//    return target;
//}

- (BOOL)respondsToSelector:(SEL)aSelector {
    __block BOOL flag = [super respondsToSelector:aSelector];
    if (flag) return flag;
    [_objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        flag = [obj respondsToSelector:aSelector];
        *stop = flag;
    }];
    return flag;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    __block NSMethodSignature * signature;
    [_objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //判断对象是否能够响应方法
        if ([obj respondsToSelector:sel]) {
            signature = [obj methodSignatureForSelector:sel];
            *stop = YES;
        }
    }];
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [_objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //判断对象是否能够响应方法
        if ([obj respondsToSelector:invocation.selector]) {
            [invocation invokeWithTarget:obj];
            *stop = YES;
        }
    }];
}

@end
