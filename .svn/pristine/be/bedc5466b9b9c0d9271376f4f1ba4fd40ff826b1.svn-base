//
//  PraiseCell.h
//  M-Cut
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageObj.h"

typedef void(^PUSHTOVIDEOPLAYVC)();
typedef void(^PUSHTOPERSONALVC)();

@interface NoticeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *praiseUserHeadImage;
@property (weak, nonatomic) IBOutlet UILabel *userActionLabel;
@property (weak, nonatomic) IBOutlet UILabel *praiseUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *praiseTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *praiseVideolabel;
@property (weak, nonatomic) IBOutlet UILabel *praiseVideoNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *praiseVideoImage;

@property (nonatomic, copy) NSString * pushVideoId;
@property (nonatomic, copy) NSString * pushPersonId;
@property (nonatomic, copy) PUSHTOVIDEOPLAYVC pushToVideoPlayVc;
@property (nonatomic, copy) PUSHTOPERSONALVC pushToPersonalVc;

/** 调用pushblock的接口*/
- (void)pushToVideoPlayVc:(PUSHTOVIDEOPLAYVC)pushBlock;
/** 跳转到个人页面*/
- (void)pushToPersonalVc:(PUSHTOPERSONALVC)pushPersonalVcBlock;

/** 获得服用的noticecell*/
+ (id)getNoticeCellWithMes:(MessageObj *)mesObj Table:(UITableView *)myTable;
@end
