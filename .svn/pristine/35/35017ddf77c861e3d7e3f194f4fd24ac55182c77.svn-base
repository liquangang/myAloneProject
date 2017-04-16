//
//  CaptionEditeCollectionViewCell.m
//  M-Cut
//
//  Created by zhangxiaotian on 15/6/9.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "CaptionEditeCollectionViewCell.h"

@interface CaptionEditeCollectionViewCell()<UITextViewDelegate>

@end

@implementation CaptionEditeCollectionViewCell

-(instancetype)init
{
    if (self = [super init]) {
        _textTV.delegate = self;
        _textTV.layer.cornerRadius=8.0f;
        _textTV.layer.masksToBounds=YES;
        _textTV.layer.borderColor=[[UIColor colorWithRed:(CGFloat)44.0/256 green:(CGFloat)168/256 blue:(CGFloat)151/256 alpha:0.7]CGColor];
        _textTV.layer.borderWidth= 1.0f;
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (NSIndexPath *)findIndexPath
{
    UICollectionView *collectView =  (UICollectionView *)self.superview;
    NSIndexPath *index = [collectView indexPathForCell:self];
    return index;
}




@end
