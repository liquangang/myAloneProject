//
//  WxTabBarItem.h
//  M-Cut
//
//  Created by 刘海香 on 15/4/27.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WxTabBarItem : UIControl{
    UIImageView *imageView;
    BOOL isSelected;
}

- (id)initWithFrame:(CGRect )frame WithImageName:(NSString *)imageName WithTitle:(NSString *)title;

- (void)changeImageImage:(NSString *)selectedImagName ;
@end
