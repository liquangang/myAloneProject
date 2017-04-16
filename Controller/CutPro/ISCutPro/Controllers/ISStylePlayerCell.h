//
//  ISStylePlayerCell.h
//  M-Cut
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ISStyleDetailCell.h"

@interface ISStylePlayerCell : UITableViewCell
@property (nonatomic, strong) MPMoviePlayerViewController * mpMovierPlayerVc;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImage;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (nonatomic, strong) ISStyleDetailFrame * myStyle;
//显示样片缩略图
- (void)showVideoImageWithStyle:(ISStyleDetailFrame *)myStyle;
//隐藏样片缩略图
- (void)hiddenVideoImage;

@end
