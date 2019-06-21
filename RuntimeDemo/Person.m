//
//  Person.m
//  RuntimeDemo
//
//  Created by fanglin on 2019/6/4.
//  Copyright © 2019 fanglin. All rights reserved.
//

#import "Person.h"
#import "SpareWheel.h"
#import <objc/runtime.h>

@implementation Person

void sendMessage(id self, SEL _cmd, NSString *msg){
    NSLog(@"----%@",msg);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    //1.匹配方法
    NSString * methodName = NSStringFromSelector(sel);
    if ([methodName isEqualToString:@"sendMessage:"]) {
        return class_addMethod(self,sel,(IMP)sendMessage,"v@:@");
    }
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSString * methodName = NSStringFromSelector(aSelector);
    if ([methodName isEqualToString:@"sendMessage:"]) {
        return [SpareWheel new];
    }
    return [super forwardingTargetForSelector:aSelector];
}

//慢速转发
//1.方法签名
//2.消息转发r
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSString * methodName = NSStringFromSelector(aSelector);
    if ([methodName isEqualToString:@"sendMessage:"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL sel = [anInvocation selector];
    SpareWheel *tempObj = [SpareWheel new];
    if ([tempObj respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:tempObj];
    }else {
        [super forwardInvocation:anInvocation];
    }
}

- (void)doesNotRecognizeSelector:(SEL)aSelector{
    NSLog(@"找不到方法");
}

@end
