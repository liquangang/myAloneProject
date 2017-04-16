//
//  UIView+Addition.h
//  M-Cut
//
//  Created by 刘海香 on 15/1/21.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "UIView+Addition.h"

@implementation UIView (Addition)

-(UIViewController *)viewController
{
    id vc = [self nextResponder];
    while (vc) {
        if ([vc isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)vc;
        }
        
        vc = [vc nextResponder];
    }
    
    return nil;
}

@end
