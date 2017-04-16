//
//  AlertsCell.m
//  M-Cut
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "AlertsCell.h"
#import "VideoDBOperation.h"

static NSString * alertCellId = @"AlertsCell";

@implementation AlertsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNoReadMesNumLabel{
    
    if ([self.alertsTypeLabel.text isEqualToString:@"点赞"]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSInteger noReadPraiseMesNum = [[VideoDBOperation Singleton] getAllNoReadDataWithDataTerm:PRAISETERM];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.noReadMesNumLabel.text = [NSString stringWithFormat:@"%ld", (long)noReadPraiseMesNum];
                self.noReadMesNumLabel.hidden = NO;
                if ([self.noReadMesNumLabel.text intValue] <= 0) {
                    self.noReadMesNumLabel.hidden = YES;
                }
                if ([self.noReadMesNumLabel.text integerValue] > 0) {
                    self.alertsDesLabel.text = [NSString stringWithFormat:@"您收到了%@颗赞", self.noReadMesNumLabel.text];
                }
            });});
        
    }else if([self.alertsTypeLabel.text isEqualToString:@"评论"]){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSInteger noReadCommentsMesNum = [[VideoDBOperation Singleton] getAllNoReadDataWithDataTerm:COMMENTSTERM];
            NSInteger noReadReplyMesNum = [[VideoDBOperation Singleton] getAllNoReadDataWithDataTerm:REPLYTERM];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.noReadMesNumLabel.text = [NSString stringWithFormat:@"%ld", (long)(noReadCommentsMesNum + noReadReplyMesNum)];
                self.noReadMesNumLabel.hidden = NO;
                if ([self.noReadMesNumLabel.text intValue] <= 0) {
                    self.noReadMesNumLabel.hidden = YES;
                }
                if ([self.noReadMesNumLabel.text integerValue] > 0) {
                    self.alertsDesLabel.text = [NSString stringWithFormat:@"您有%@条未读评论", self.noReadMesNumLabel.text];
                }
            });});
        
    }else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSInteger careNum = [[VideoDBOperation Singleton] getAllNoReadDataWithDataTerm:CARETERM];
            NSInteger collectNum = [[VideoDBOperation Singleton] getAllNoReadDataWithDataTerm:COLLECTTERM];

            dispatch_async(dispatch_get_main_queue(), ^{
                self.noReadMesNumLabel.text = [NSString stringWithFormat:@"%ld", (long)(careNum + collectNum)];
                self.noReadMesNumLabel.hidden = NO;
                if ([self.noReadMesNumLabel.text intValue] <= 0) {
                    self.noReadMesNumLabel.hidden = YES;
                }
                if ([self.noReadMesNumLabel.text integerValue] > 0) {
                    self.alertsDesLabel.text = [NSString stringWithFormat:@"您有%@条未读消息", self.noReadMesNumLabel.text];
                }
            });});
        
    }
}

- (void)setAlertCellWithDic:(NSDictionary *)myDic{
    self.alertsImage.image = [UIImage imageNamed:[myDic objectForKey:@"icon"]];
    self.alertsTypeLabel.text = [myDic objectForKey:@"title"];
    self.alertsDesLabel.text = [myDic objectForKey:@"des"];
    [self setNoReadMesNumLabel];
}

+ (id)getAlertCellWithDic:(NSDictionary *)dataDic Table:(UITableView *)myTable{
    AlertsCell * cell = [myTable dequeueReusableCellWithIdentifier:alertCellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:alertCellId owner:nil options:nil] lastObject];
    }
    [cell setAlertCellWithDic:dataDic];
    return cell;
}

@end