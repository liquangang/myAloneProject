//
//  OnlyOneView.m
//  M-Cut
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "OnlyOneView.h"

@interface OnlyOneView()
@end

@implementation OnlyOneView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"OnlyOneView"
                                                          owner:self
                                                        options:nil];
        UIView *backView = [nibView objectAtIndex:0];
        backView.frame = frame;
        [self addSubview:backView];
        ADDTAPGESTURE(self.needShowImage, imageTap);
    }
    return self;
}

/**
 *  imageTap
 */
- (void)imageTap:(UITapGestureRecognizer *)tap{
    self.imageTapBlock();
}

/**
 *  展示
 */
- (void)showOnlyImageWithImage:(UIImage *)showImage{
    self.needShowImage.image = showImage;
}

/**
 *  隐藏
 */
- (void)hiddenImage{
    self.hidden = YES;
}

@end
