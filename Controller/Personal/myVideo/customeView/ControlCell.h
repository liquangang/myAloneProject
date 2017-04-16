//
//  ControlCell.h
//  M-Cut
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SHOWVIDEOBLOCK)(NSString * videoType);

@interface ControlCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *selectCollectLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectVideoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *updateTableImage;
@property (weak, nonatomic) IBOutlet UILabel *collectNumLabel;
@property (weak, nonatomic) IBOutlet UIView *collectView;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UIImageView *triangleImage;
@property (weak, nonatomic) IBOutlet UILabel *videoNumLabel;
@property (weak, nonatomic) IBOutlet UIView *videoTypeView;
@property (weak, nonatomic) IBOutlet UIButton *privateVideoButton;

@property (nonatomic, copy) SHOWVIDEOBLOCK showVideoBlock;
- (void)showVideoBlock:(SHOWVIDEOBLOCK)showVideoBlock;

/** 获得复用cell*/
+ (id)getControlCellWithTable:(UITableView *)myTable Showtype:(NSString *)showType UserId:(NSString *)userId;
@end
