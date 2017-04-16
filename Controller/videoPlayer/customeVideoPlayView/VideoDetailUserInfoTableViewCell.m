//
//  VideoDetailUserInfoTableViewCell.m
//  M-Cut
//
//  Created by liquangang on 16/9/20.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "VideoDetailUserInfoTableViewCell.h"

#import <UIImageView+WebCache.h>

#import "UserEntity.h"

#import "SoapOperation.h"

#import "CustomeClass.h"

static NSString * const cellReusableId = @"VideoDetailUserInfoTableViewCell";

@interface VideoDetailUserInfoTableViewCell()
@property (nonatomic, strong) NSMutableDictionary * infoDic;
@end

@implementation VideoDetailUserInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//用户头像点击方法
- (IBAction)userImageAction:(id)sender {
    self.clickUserImageBlock();
}

//关注按钮点击方法
- (IBAction)careImageAction:(id)sender {
    self.careButton.hidden = YES;
    self.careButtonBlock();
}

+ (id)VideoDetailUserInfoTableViewCellWithCellSuperTable:(UITableView *)cellSuperTable
                                                 InfoDic:(NSMutableDictionary *)infoDic{
    VideoDetailUserInfoTableViewCell * cell =
    [cellSuperTable dequeueReusableCellWithIdentifier:cellReusableId];
    
    if (!cell) {
        cell = XIBCELL(cellReusableId);
    }
    /*
     Printing description of ((__NSDictionaryM *)0x0000000170644200):
     {
     "customer_avatar" = "http://wx.qlogo.cn/mmopen/pqzkIaqnYzwysUfnRicoAzGTscicdpibnzO3d5qSr3onxjsxNT2htxTw36JUoS0BybWO2dY6oiasQ0SHtOWNlb7k3F7EIlhfficUm/0";
     "customer_nickname" = "\U95eb\U60e0";
     "customer_signature" = "anyType{}";
     "order_id" = 106052;
     resolution = "";
     "video_commentsnum" = 5;
     "video_createtime" = "2016-09-01 12:01:42";
     "video_favoritesnum" = 0;
     "video_id" = 106043;
     "video_name" = "\U5927\U5bb6";
     "video_owner" = 29424;
     "video_praise" = 0;
     "video_reference" = "http://movier-vdctest.oss-cn-beijing.aliyuncs.com/movier-users/294244066ff5d9b10473b7ef6341/\U7cfb\U7edf\U6587\U4ef6\U5939/order-generate/2016-9-1/1472702502354.mp4";
     "video_share" = 1;
     "video_sharenum" = 0;
     "video_status" = 2;
     "video_thumbnail" = "http://movier-vdctest.oss-cn-beijing.aliyuncs.com/movier-users/294244066ff5d9b10473b7ef6341/\U7cfb\U7edf\U6587\U4ef6\U5939/order-generate/2016-9-1/1472702502354.jpg";
     visitcount = 686;
     }
     */
    cell.infoDic = infoDic;
    
    //设置头像图片
    UIImageView * imageView = [UIImageView new];
    [imageView sd_setImageWithURL:[NSURL URLWithString:infoDic[@"customer_avatar"]] placeholderImage:DEFAULTHEADIMAGE options:SDWebImageRetryFailed | SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        MAINQUEUEUPDATEUI({
            [cell.userImage setImage:imageView.image forState:UIControlStateNormal];
        })
    }];
    
    //设置作者名称
    cell.userNameLabel.text = infoDic[@"customer_nickname"];
    
    //设置制作时间
    //计算内容大小
    NSString * createTimeStr = [CustomeClass compareCurrentTime:infoDic[@"video_createtime"]];
    CGSize contentSize = [createTimeStr sizeWithAttributes:@{NSFontAttributeName:ISFont_12}];
    cell.videoCreateTimesLabelWidth.constant = contentSize.width + 16;
    cell.videoCreateTimeLabel.text = createTimeStr;
    
    //设置观看次数
    cell.visitCountLabel.text = infoDic[@"visitcount"];
    
    //判断是否显示关注按钮
    [cell isHiddenFollowButton];
    return cell;
}

/** 判断是否显示关注按钮*/
- (void)isHiddenFollowButton{
    
    if (![UserEntity sharedSingleton].isAppHasLogin) {
        return;
    }
    
    if ([[self.infoDic objectForKey:@"video_owner"] isEqualToString:CURRENTUSERID]) {
        self.careButton.hidden = YES;
    }else{
        WEAKSELF(weaKself);
        [[SoapOperation Singleton] WS_getfriendrelationWithUserId:
         [weaKself.infoDic objectForKey:@"video_owner"]
         Success:^(NSNumber *successInfo) {
             MAINQUEUEUPDATEUI({
                if ([successInfo intValue] == 1 || [successInfo intValue] == 2) {
                        //隐藏关注按钮
                        weaKself.careButton.hidden = YES;
                }else{
                        weaKself.careButton.hidden = NO;
                }
            })
        } Fail:^(NSError *error) {
            RELOADSERVERDATA([weaKself isHiddenFollowButton];);
        }];
    }
}

@end
