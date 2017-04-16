//
//  UIViewController+MemoryHandle.m
//  M-Cut
//
//  Created by liquangang on 2017/3/20.
//  Copyright © 2017年 Crab movier. All rights reserved.
//

#import "UIViewController+MemoryHandle.h"
#import <objc/message.h>

@implementation UIViewController (MemoryHandle)

+ (void)load{
    /**
     *  交换方法的IMP指针只需要执行一次，为了避免load的多次调用
     */
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /**
         *  步骤如下:
         */
        // 0.获取本类的类对象
        Class cls = [self class];
        // 1.获取交换方法的SEL
        SEL originalSelector = @selector(myDidReceiveMemoryWarning);
        SEL swizzledSelector = @selector(didReceiveMemoryWarning);
        
        // 2.获取交换方法
        Method originalMethod = class_getInstanceMethod(cls, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
        
        // 3.如果需要被交换的方法不存在，那么我们需要手动添加一个方法
        // 把originalSelector指向swizzledMethod的IMP
        // 如果方法存在，那么添加方法会失败
        BOOL success = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            // 证明添加成功，方法不存在
            // 把swizzledSelector指向originalMethod的IMP
            class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else{
            // 方法不存在, 直接交换方法的
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)myDidReceiveMemoryWarning{
    [self myDidReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory]; 
}

@end
