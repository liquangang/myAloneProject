//
//  RewardTableViewCell.h
//  M-Cut
//
//  Created by liquangang on 2017/1/22.
//  Copyright © 2017年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RewardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *rewardImage;
@property (weak, nonatomic) IBOutlet UILabel *rewardNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rewardDesLabel;
@property (weak, nonatomic) IBOutlet UIButton *getButton;
@end
