//
//  CloudHeaderView.m
//  M-Cut
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CloudHeaderView.h"

@implementation CloudHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"CloudHeaderView" owner:self options:nil];
        UIView *backView = [nibView objectAtIndex:0];
        backView.frame = frame;
        [self addSubview:backView];
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    ADDTAPGESTURE(self.CloudDiskImage, uploadImage)
}

- (void)uploadImage:(UITapGestureRecognizer *)tap{
    self.uploadBlock();
}

- (IBAction)deleteButtonAction:(id)sender {
    self.deleteBlock();
}

- (IBAction)searchButtonAction:(id)sender {
    self.searchBlock();
}

- (IBAction)addButtonAction:(id)sender {
    self.addBlock();
}


@end
