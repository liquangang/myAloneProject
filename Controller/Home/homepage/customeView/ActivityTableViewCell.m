



//
//  ActivityTableViewCell.m
//  M-Cut
//
//  Created by apple on 16/8/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation ActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

/** 获取复用的cell*/
+ (id)getActivityCellWithTable:(UITableView *)cellTable ActivityInfo:(NSDictionary *)activityInfo{
    ActivityTableViewCell * cell = [cellTable dequeueReusableCellWithIdentifier:@"ActivityTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ActivityTableViewCell" owner:nil options:nil] lastObject];
    }
    
        /*
         activitystatus = "";
         des = "\U597d\U793c\U76f8\U8d60\Uff0c\U6696\U51ac\U72c2\U6b22\Uff01\U201c\U6620\U50cf\U201d\U5149\U5f71\U72c2\U6b22\U8282\U706b\U70ed\U8fdb\U884c\U65f6\U30022015.12.1\U20142016.2.14\U6d3b\U52a8\U671f\U95f4\Uff0c\U53ea\U8981\U4f7f\U7528\U201c\U6620\U50cf\U201dAPP\U5185\U4efb\U610f\U98ce\U683c\U5236\U4f5c\U5f71\U7247\Uff0c\U65e2\U53ef\U51ed\U70b9\U51fb\U91cf\U8d62\U53d6\U65b0\U6b3eMACBOOK\U3001IPAD\U00a0PRO\U7b49\U4e30\U539a\U5927\U793c\Uff01";
         "label_id" = 17;
         "label_name" = "\U5149\U5f71\U72c2\U6b22\U8282";
         parent = 12;
         thumbnail = "http://movier-vdc.oss-cn-beijing.aliyuncs.com/movier/sysres/LabelRes/BannerRes/Movier/Movier-banner-thumbnail.jpg";
         type = 1;
    
         @property (weak, nonatomic) IBOutlet UILabel *activityNameLabel;
         @property (weak, nonatomic) IBOutlet UILabel *avtivityTimeLabel;
         @property (weak, nonatomic) IBOutlet UIImageView *activityThumbnail;
         @property (weak, nonatomic) IBOutlet UILabel *activityDesLabel;
         */
    
    cell.activityNameLabel.text = activityInfo[@"label_name"];
    cell.avtivityTimeLabel.text = activityInfo[@"activitystatus"];
    cell.activityThumbnail.contentMode = UIViewContentModeScaleAspectFill;
    [cell.activityThumbnail sd_setImageWithURL:[NSURL URLWithString:activityInfo[@"thumbnail"]] placeholderImage:DEFAULTVIDEOTHUMAIL options:SDWebImageRetryFailed | SDWebImageRefreshCached];
//    cell.activityDesLabel.text = activityInfo[@"des"];
    return cell;
}

@end
