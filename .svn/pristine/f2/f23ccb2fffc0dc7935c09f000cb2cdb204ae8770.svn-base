//
//  longleadPage.m
//  M-Cut
//
//  Created by CoderLEE on 15/12/28.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "longleadPage.h"
@interface longleadPage()
{
    UIImageView *_imageView;
}

@end
@implementation longleadPage

-(instancetype)init
{
    self = [super init];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self addSubview:_imageView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        CGRect Imageframe = CGRectMake(5, 65, 293, 130);
        _imageView.image = [UIImage imageNamed:@"establish_2"];
        _imageView.frame = Imageframe;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self addSubview:_imageView];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
@end
