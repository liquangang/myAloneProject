//
//  CloudUploadCollectionViewCell.m
//  M-Cut
//
//  Created by apple on 16/12/13.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CloudUploadCollectionViewCell.h"

@implementation CloudUploadCollectionViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    // Initialization code
    [self.contentView addSubview:self.hud];
    [self.contentView bringSubviewToFront:self.hud];
}

- (void)uploadStyle{
    [self.uploadControlButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
}

- (void)pauseStyle{
    [self.uploadControlButton setImage:[UIImage imageNamed:@"继续icon-拷贝-4"] forState:UIControlStateNormal];
}

- (void)startStyle{
    [self.uploadControlButton setImage:[UIImage imageNamed:@"暂停icon"] forState:UIControlStateNormal];
}

- (void)lineStyle{
    [self.uploadControlButton setTitle:@"排队中" forState:UIControlStateNormal];
}

#pragma mark - getter

- (MBProgressHUD *)hud{
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.backView];
        _hud.mode = MBProgressHUDModeAnnularDeterminate;
    }
    return _hud;
}

@end
