//
//  HeaderCell.m
//  M-Cut
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "HeaderCell.h"
#import <UIImageView+WebCache.h>
#import "UserEntity.h"
#import "CustomeClass.h"

static NSString * headerCellId = @"userCell";

@implementation HeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initUI];
}

#pragma mark - initUI
- (void)initUI{
    self.backImage = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView insertSubview:self.backImage belowSubview:self.backButton];
    self.backImage.contentMode = UIViewContentModeScaleAspectFill;
}

#pragma mark - downloadDataAndUpdateUI
- (void)downloadDataAndUpdateUIWithUserID:(NSString *)userId{
    
    WEAKSELF(weakSelf);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[SoapOperation Singleton] WS_getuserinfoWithUserID:userId Success:^(NSMutableDictionary *serverDataDic) {
            
            weakSelf.userDataDic = serverDataDic;
            
            /*
             数组中的对象名称
            MovierDCInterfaceSvc_VDCKeyValue
             */
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //用户名
                weakSelf.userNameLabel.text = [serverDataDic objectForKey:@"customer_nickname"];
                if (weakSelf.userNameLabel.text.length <= 5) {
                    weakSelf.userNameLabelWidth.constant = weakSelf.userNameLabel.text.length * 14 ;
                }else{
                    weakSelf.userNameLabelWidth.constant = 70;
                }
                
                //签名
                weakSelf.userSignatureLabel.text = [serverDataDic objectForKey:@"customer_signature"];
                
                //点赞数量
                weakSelf.userPraiseNumLabel.text = [serverDataDic objectForKey:@"videopraiseamount"];
                
                //性别图片
                if ([[serverDataDic objectForKey:@"customer_gender"] intValue] == 1) {
                    weakSelf.userGenderImage.image = [UIImage imageNamed:@"male"];
                }else if ([[serverDataDic objectForKey:@"customer_gender"] intValue] == 2){
                    weakSelf.userGenderImage.image = [UIImage imageNamed:@"female"];
                }else{
                    weakSelf.userGenderImage.image = nil;
                }
                
                //用户头像
                [weakSelf.userHeaderImage sd_setImageWithURL:[NSURL URLWithString:[serverDataDic objectForKey:@"customer_avatar"]] placeholderImage:[UIImage imageNamed:@"head"] options:SDWebImageRetryFailed | SDWebImageRefreshCached];
                
                //影片热度
                weakSelf.videoHeatLabel.text = [serverDataDic objectForKey:@"videoviewamount"];
                
                //背景图片
                [weakSelf.backImage sd_setImageWithURL:[NSURL URLWithString:[serverDataDic objectForKey:@"background"]] placeholderImage:DEFAULTVIDEOTHUMAIL options:SDWebImageRetryFailed | SDWebImageRefreshCached];;
                weakSelf.backImage.frame = weakSelf.contentView.bounds;
                
                //等级
                weakSelf.userLevelImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"userLevelImage%@", [serverDataDic objectForKey:@"customer_privilege"]]];
            });
        } Fail:^(NSError *error) {
            RELOADSERVERDATA([weakSelf downloadDataAndUpdateUIWithUserID:userId];)
        }];
    });
}

+ (id)getHeaderCellWithTable:(UITableView *)myTable WithUserId:(NSString *)userID{
    HeaderCell * cell = [myTable dequeueReusableCellWithIdentifier:headerCellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HeaderCell" owner:nil options:nil] lastObject];
    }
     [cell downloadDataAndUpdateUIWithUserID:userID];
    return cell;
}

- (IBAction)updateBackImage:(id)sender {
    self.updateBackImage(self.backImage, self.userDataDic);
}

- (void)UpdateBackImage:(UPDATEBACKIMAGE)updateBackImage{
    self.updateBackImage = updateBackImage;
}
@end
