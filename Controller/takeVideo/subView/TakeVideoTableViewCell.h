//
//  TakeVideoTableViewCell.h
//  M-Cut
//
//  Created by apple on 16/10/28.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakeVideoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *videoBackView;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rewardImage;

/**
 *  删除block
 */
@property (nonatomic, copy) void(^deleteBlock)(NSIndexPath * deleteIndex);

/**
 *  播放block
 */
@property (nonatomic, copy) void(^playBlock)(NSIndexPath * playIndex);

/**
 *  获得cell
 */
+ (id)TakeVideoTableViewCellWithTableView:(UITableView *)tableView
                              ResuableStr:(NSString *)resuableStr
                             VideoThumail:(UIImage *)videoThumailImage
                                IndexPath:(NSIndexPath *)index;
@end
