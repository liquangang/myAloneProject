//
//  CareCell.h
//  M-Cut
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageObj;

typedef void(^COMMENTPUSHPERSONALVC)();

@interface CareCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *careUserHeadImage;
@property (weak, nonatomic) IBOutlet UILabel *careUserNIckNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *caretimeLabel;

@property (nonatomic, copy) COMMENTPUSHPERSONALVC pushTopersonalVcBlock;
@property (nonatomic, copy) NSString * pushPersonId;

/** 跳转到个人页面*/
- (void)pushtoPersonalVc:(COMMENTPUSHPERSONALVC)pushBlock;

/** 获得复用cell*/
+ (id)getCareCellWithTable:(UITableView *)myTable MessageObj:(MessageObj *)mesObj;
@end
