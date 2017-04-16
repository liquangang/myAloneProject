//
//  MyMusicCell.m
//  M-Cut
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "MyMusicCell.h"

@implementation MyMusicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.musicImage.layer.masksToBounds = YES;
    self.musicImage.layer.cornerRadius = self.musicImage.frame.size.width / 2;
    self.musicImage.userInteractionEnabled = YES;
    [self.musicImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playAction:)]];
}

- (void)playAction:(UITapGestureRecognizer *)gesture{
    if([self.delegate respondsToSelector:@selector(playButtonAction:andMusicUrl:)]){
        [self.delegate playButtonAction:self.myIndexPath andMusicUrl:self.myMusicUrl];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
