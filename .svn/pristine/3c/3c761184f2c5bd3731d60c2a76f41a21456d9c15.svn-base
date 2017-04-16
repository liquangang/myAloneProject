//
//  ControlCell.m
//  M-Cut
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "ControlCell.h"
#import "SoapOperation.h"
#import "UserEntity.h"
#import "CustomeClass.h"

static NSString * controlCellId = @"controlCell";

@implementation ControlCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //暂时不添加影片不同类型选择的功能
    ADDTAPGESTURE(self.triangleImage, openVideoTypeView)
    ADDTAPGESTURE(self.updateTableImage, updateTable)
    ADDTAPGESTURE(self.videoNumLabel, showUserVideo)
    ADDTAPGESTURE(self.collectNumLabel, showCollectVideo)
    self.videoTypeView.hidden = YES;
}

- (void)updateTable:(UITapGestureRecognizer *)tap{
    if ([self.updateTableImage.image isEqual:[UIImage imageNamed:@"列表状态"]]) {
        self.updateTableImage.image = [UIImage imageNamed:@"viewShowImage"];
    }else{
        self.updateTableImage.image = [UIImage imageNamed:@"列表状态"];
    }
    //更换cell的形式
    self.showVideoBlock(@"更换cell");
}

- (void)showUserVideo:(UITapGestureRecognizer *)tap{
    //展示用户自己的影片
    [self setColorWithType:@"影片"];
    self.showVideoBlock(@"影片");
}

- (void)showCollectVideo:(UITapGestureRecognizer *)tap{
    //展示用户的收藏
    [self setColorWithType:@"收藏"];
    self.showVideoBlock(@"收藏");
}

- (void)openVideoTypeView:(UITapGestureRecognizer *)tap{
    if (self.videoTypeView.hidden) {
        self.videoTypeView.hidden = NO;
    }else{
        self.videoTypeView.hidden = YES;
    }
    
}

- (void)setColorWithType:(NSString *)showType{
    if ([showType isEqualToString:@"影片"]) {
        self.videoNumLabel.textColor = ISRedColor;
        self.selectVideoLabel.backgroundColor = ISRedColor;
        self.collectNumLabel.textColor = ISGrayColor;
        self.selectCollectLabel.backgroundColor = [UIColor whiteColor];
    }else{
        self.videoNumLabel.textColor = ISGrayColor;
        self.selectVideoLabel.backgroundColor = [UIColor whiteColor];
        self.collectNumLabel.textColor = ISRedColor;
        self.selectCollectLabel.backgroundColor = ISRedColor;
    }
}

+ (id)getControlCellWithTable:(UITableView *)myTable Showtype:(NSString *)showType UserId:(NSString *)userId{
    ControlCell * cell = [myTable dequeueReusableCellWithIdentifier:controlCellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ControlCell" owner:nil options:nil] lastObject];
    }
    [cell setColorWithType:showType];
    [cell setVideoNumWithUserId:userId];
    return cell;
}

- (void)setVideoNumWithUserId:(NSString *)userId{
    
    WEAKSELF(weakSelf);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[SoapOperation Singleton] WS_getuserinfoWithUserID:userId Success:^(NSMutableDictionary *serverDataDic) {
            
            /*
             po serverDataDic
             {
             background = "";
             bucketname = "movier-vdctest";
             collectamount = 12;
             "customer_avatar" = "http://movier-vdctest.oss-cn-beijing.aliyuncs.com/movier/sysres/9846.jpg";
             "customer_birthdayd" = 26;
             "customer_birthdaym" = 1;
             "customer_birthdayy" = 2016;
             "customer_city" = "\U6d77\U6dc0";
             "customer_email" = "";
             "customer_gender" = 2;
             "customer_id" = 9846;
             "customer_inshiancoin" = 271;
             "customer_name" = 01390000006;
             "customer_nickname" = "\U6d4b\U8bd5003";
             "customer_province" = "\U5317\U4eac";
             "customer_qq" = "";
             "customer_rootdir" = "movier-users/9846de9e3122c83cf00a8b2e70/";
             "customer_score" = 238;
             "customer_signature" = "";
             "customer_status" = 497;
             "customer_tel" = 01390000006;
             "customerinfo_status" = 1820;
             registertime = "2016-05-03 18:21:52";
             videoamount = 18;
             videopraiseamount = 0;
             videoviewamount = 0;
             }
             */
            /*
             数组中的对象名称
             MovierDCInterfaceSvc_VDCKeyValue
             */
            
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.collectNumLabel.text = [NSString stringWithFormat:@"收藏(%@)", serverDataDic[@"collectamount"]];
                weakSelf.videoNumLabel.text = [NSString stringWithFormat:@"影片(%@)", serverDataDic[@"videoamount"]];
                if (![userId isEqualToString:CURRENTUSERID]) {
                    weakSelf.triangleImage.hidden = YES;
                }else{
                    weakSelf.triangleImage.hidden = NO;
                }
            });
        } Fail:^(NSError *error) {
//            DEBUGLOG(error)
//            [weakSelf setVideoNumWithUserId:userId];
            RELOADSERVERDATA([weakSelf setVideoNumWithUserId:userId];)
            
        }];
    });

}

- (IBAction)allVideoButtonAction:(id)sender {
    self.videoTypeView.hidden = YES;
    //展示全部视频
    UIButton * btn = (id)sender;
    [self setColorWithType:@"影片"];
    self.showVideoBlock(btn.titleLabel.text);
}
- (IBAction)publicVideoButtonActioin:(id)sender {
    self.videoTypeView.hidden = YES;
    //展示公有视频
    UIButton * btn = (id)sender;
    [self setColorWithType:@"影片"];
    self.showVideoBlock(btn.titleLabel.text);

}
- (IBAction)privateVideoButtonAction:(id)sender {
    self.videoTypeView.hidden = YES;
    //展示私有视频
    UIButton * btn = (id)sender;
    [self setColorWithType:@"影片"];
    self.showVideoBlock(btn.titleLabel.text);

}

- (void)showVideoBlock:(SHOWVIDEOBLOCK)showVideoBlock{
    self.showVideoBlock = showVideoBlock;
}
@end
