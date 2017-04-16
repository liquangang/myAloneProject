//
//  WxTabBarItem.m
//  M-Cut
//
//  Created by 刘海香 on 15/4/27.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "WxTabBarItem.h"

@implementation WxTabBarItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame WithImageName:(NSString *)imageName WithTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.width,self.height)] ;
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:imageName];
        [self addSubview:imageView];
        
        
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,imageView.bottom,self.width ,18)] ;
        //[self addSubview:titleLabel];
        
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:11];
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];
    }
    return self;
}
- (void)changeImageImage:(NSString *)selectedImagName {

     imageView.image = [UIImage imageNamed:selectedImagName];
    
}
@end
