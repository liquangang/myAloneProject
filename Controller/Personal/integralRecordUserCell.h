//
//  integralRecordUserCell.h
//  M-Cut
//
//  Created by apple on 16/6/12.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface integralRecordUserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImage;
@property (weak, nonatomic) IBOutlet UILabel *userNikeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userIntegralLabel;

/** 设置第二个label*/
- (void)setUserIntegralLabelWithStr:(NSString *)str;
@end
