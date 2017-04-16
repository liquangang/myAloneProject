//
//  PropmtView.m
//  M-Cut
//
//  Created by apple on 16/11/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "PropmtView.h"

@implementation PropmtView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"PropmtView"owner:self options:nil];
        UIView *backView = [nibView objectAtIndex:0];
        backView.frame = frame;
        [self addSubview:backView];
    }
    return self;
}

- (IBAction)propmtButtonAction:(id)sender {
    
}

@end
