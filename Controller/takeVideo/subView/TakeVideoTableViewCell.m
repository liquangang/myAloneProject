//
//  TakeVideoTableViewCell.m
//  M-Cut
//
//  Created by apple on 16/10/28.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "TakeVideoTableViewCell.h"

@interface TakeVideoTableViewCell()
@property (nonatomic, strong) NSIndexPath * index;
@end

@implementation TakeVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

/**
 *  删除视频
 */
- (IBAction)deleteButtonAction:(id)sender {
    self.deleteBlock(self.index);
}

/**
 *  播放视频
 */
- (IBAction)playButtonAction:(id)sender {
    self.playBlock(self.index);
}

/**
 *  获得cell
 */
+ (id)TakeVideoTableViewCellWithTableView:(UITableView *)tableView
                              ResuableStr:(NSString *)resuableStr
                             VideoThumail:(UIImage *)videoThumailImage
                                IndexPath:(NSIndexPath *)index{
    TakeVideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:resuableStr];
    if (!cell) {
        cell = XIBCELL(@"TakeVideoTableViewCell")
    }
    
    cell.index = index;
    
    if (videoThumailImage) {
        cell.videoBackView.hidden = NO;
        cell.videoImageView.image = videoThumailImage;
    }else{
        cell.videoBackView.hidden = YES;
    }
    
    return cell;
}

@end
