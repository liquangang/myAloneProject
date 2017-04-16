//
//  OperationTableViewCell.m
//  M-Cut
//
//  Created by liquangang on 16/9/21.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "OperationTableViewCell.h"
#import "SoapOperation.h"
#import "CustomeClass.h"
#import "UserEntity.h"
#import "GlobalVars.h"
#import "UMSocialData.h"
#import "UMSocialSnsService.h"
#import "LoginAndRegister.h"
#import "SDCycleScrollView.h"
#import "VideoDBOperation.h"

static NSString * const cellReusableId = @"OperationTableViewCell";
static NSString *const arRewardInfoKey = @"arRewardInfoKey";

@interface OperationTableViewCell()
@property (nonatomic, strong) NSMutableDictionary * infoDic;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSMutableArray *titleMuarray;
@property (nonatomic, copy) NSString *arRewardInfoPlistPath;
@end

@implementation OperationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.praiseButton setImage:[UIImage imageNamed:@"praiseSelectImage"]
                       forState:UIControlStateSelected];
    [self.praiseButton setImage:[UIImage imageNamed:@"赞icon-拷贝-2"]
                       forState:UIControlStateNormal];
    
    [self.collectButton setImage:[UIImage imageNamed:@"selectCollectImage"]
                        forState:UIControlStateSelected];
    [self.collectButton setImage:[UIImage imageNamed:@"collectImage"]
                        forState:UIControlStateNormal];
//    [self downloadCycleData];
}

//点赞操作
- (IBAction)praiseButtonAction:(id)sender {
    [self praiseVideo];
}

//收藏操作
- (IBAction)collectButtonAction:(id)sender {
    [self collectVideo];
}

//分享操作
- (IBAction)shareButtonAction:(id)sender {
    self.shareBlock();
}

//一键照做
- (IBAction)followMakeButtonAction:(id)sender {
    self.followMakeBlock();
}

+ (id)OperationTableViewCellWithTable:(UITableView *)cellSuperTable
                             CellInfo:(NSMutableDictionary *)infoDic{
    
    OperationTableViewCell * cell =
    [cellSuperTable dequeueReusableCellWithIdentifier:cellReusableId];
    
    if (!cell) {
        cell = XIBCELL(cellReusableId)
    }
    cell.infoDic = infoDic;
    
    //设置点赞数量
    [cell.praiseButton setTitle:[NSString stringWithFormat:@" %@", infoDic[@"video_praise"]]
                       forState:UIControlStateNormal];
    
    //设置评论数量
    [cell downloadCommentsNum];
    
    //设置收藏数量
    [cell.collectButton setTitle:[NSString stringWithFormat:@" %@", infoDic[@"video_favoritesnum"]]
                        forState:UIControlStateNormal];
    
    //判断是否点赞
    [cell judgePraiseStatus];
    
    //判断是否收藏
    [cell judgeCollectStatus];
    
    //设置照做按钮的内容
    [cell setFollowButton];
    
    return cell;
}

/** 下载评论数量*/
- (void)downloadCommentsNum{
    WEAKSELF2
    [[SoapOperation Singleton] WS_GetCommentsNumByVideoid:[NSNumber numberWithInt:[weakSelf.infoDic[@"video_id"] intValue]]
                                                  Success:^(NSNumber *num) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.commentNumLabel.text = [NSString stringWithFormat:@"共%@条评论", num];
        });
    } Fail:^(NSError *error){
        RELOADSERVERDATA([weakSelf downloadCommentsNum];);
    }];
}

/**
 *  下载轮播数据
 */
- (void)downloadCycleData{
    WEAKSELF2
    [CustomeClass backgroundQueue:^{
        [weakSelf downloadDataWithIsReloadCycleView:YES];
    }];
}

/**
 *  下载轮播数据
 */
- (void)downloadDataWithIsReloadCycleView:(BOOL)isReloadView{
    WEAKSELF2
    [[SoapOperation Singleton] getRecentRewardInfoWithCount:66 Success:^(NSMutableArray *serverDataArray) {
        for (NSDictionary *recentRewardInfo in serverDataArray) {
            NSAttributedString *attriStr = [weakSelf setAttriWithStr:recentRewardInfo];
            [weakSelf.titleMuarray addObject:attriStr];
        }
        [weakSelf setCycleView];
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf downloadDataWithIsReloadCycleView:isReloadView];);
    }];
}

/**
 *  设置富文本
 */
- (NSAttributedString *)setAttriWithStr:(NSDictionary *)recentRewardInfo{
    NSString *timeStr = [CustomeClass compareCurrentTime:recentRewardInfo[@"time"]];
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"好消息：恭喜 %@ 获得 %@  %@", recentRewardInfo[@"customer_nickname"], recentRewardInfo[@"awardname"], timeStr]];
    NSRange range1 = [attriStr.string rangeOfString:recentRewardInfo[@"customer_nickname"]];
    [attriStr addAttribute:NSForegroundColorAttributeName
                     value:ISRedColor
                     range:range1];
    [attriStr addAttribute:NSFontAttributeName
                     value:ISFont_12
                     range:range1];
    NSRange range2 = [attriStr.string rangeOfString:@"好消息："];
    [attriStr addAttribute:NSForegroundColorAttributeName
                     value:ISRedColor
                     range:range2];
    [attriStr addAttribute:NSFontAttributeName
                     value:ISFont_12
                     range:range2];
    NSRange range3 = [attriStr.string rangeOfString:@"恭喜"];
    [attriStr addAttribute:NSForegroundColorAttributeName
                     value:ISLIKEGRAYCOLOR
                     range:range3];
    [attriStr addAttribute:NSFontAttributeName
                     value:ISFont_12
                     range:range3];
    NSRange range4 = [attriStr.string rangeOfString:@"获得"];
    [attriStr addAttribute:NSForegroundColorAttributeName
                     value:ISLIKEGRAYCOLOR
                     range:range4];
    [attriStr addAttribute:NSFontAttributeName
                     value:ISFont_12
                     range:range4];
    NSRange range5 = [attriStr.string rangeOfString:timeStr];
    [attriStr addAttribute:NSForegroundColorAttributeName
                     value:ISGRAYCOLOR2
                     range:range5];
    [attriStr addAttribute:NSFontAttributeName
                     value:ISFont_10
                     range:range5];
    NSRange range6 = [attriStr.string rangeOfString:recentRewardInfo[@"awardname"]];
    [attriStr addAttribute:NSForegroundColorAttributeName
                     value:ISRedColor
                     range:range6];
    [attriStr addAttribute:NSFontAttributeName
                     value:ISFont_12
                     range:range6];
    return [attriStr copy];
}

/**
 *  设置轮播view
 */
- (void)setCycleView{
    WEAKSELF2
    MAINQUEUEUPDATEUI({
        weakSelf.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 54, ISScreen_Width, 44) delegate:nil placeholderImage:nil];
        weakSelf.cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
        weakSelf.cycleScrollView.onlyDisplayText = YES;
        weakSelf.cycleScrollView.isAddIcon = YES;
        weakSelf.cycleScrollView.titleLabelBackgroundColor = [UIColor whiteColor];
        weakSelf.cycleScrollView.titleLabelTextFont = ISFont_12;
        weakSelf.cycleScrollView.titlesGroup = [weakSelf.titleMuarray copy];
        [weakSelf.contentView addSubview:weakSelf.cycleScrollView];
        weakSelf.cycleScrollView.backgroundColor = [UIColor whiteColor];
    })
}

/** 判断是否点赞*/
- (void)judgePraiseStatus{
    self.praiseButton.enabled = NO;
    WEAKSELF2
    if ([[UserEntity sharedSingleton] isAppHasLogin]) {
        
        // 1. 已登录
        // 1. 获取当前用户对当前视频的点赞状态
        MovierDCInterfaceSvc_IDArray *IDs = [[MovierDCInterfaceSvc_IDArray alloc]init];
        [IDs addItem:@([weakSelf.infoDic[@"video_id"] intValue])];
        [[SoapOperation Singleton] WS_QueryPraiseStatus:IDs Success:^(MovierDCInterfaceSvc_IDArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (array.item.count > 0) {
                    
                    // 已点赞
                    weakSelf.praiseButton.selected = YES;
                    if ([weakSelf.praiseButton.titleLabel.text integerValue] == 0) {
                        
                        [CustomeClass mainQueue:^{
                            [weakSelf.praiseButton setTitle:@"1" forState:UIControlStateNormal];
                        }];
                    }
                    
                } else {
                    
                    // 没有点赞
                    weakSelf.praiseButton.selected = NO;
                }
                weakSelf.praiseButton.enabled = YES;
            });
        } Fail:^(NSError *error) {
            if (error.code == 12) {
                [LoginAndRegister getSessionWhenUserAlreadyLogin];
                [weakSelf judgePraiseStatus];
            }else{
                RELOADSERVERDATA([weakSelf judgePraiseStatus];);
            }
        }];
    } else {
        weakSelf.praiseButton.selected = NO;
        weakSelf.praiseButton.enabled = YES;
    }
}

/** 判断是否已经收藏*/
- (void)judgeCollectStatus{
    WEAKSELF2
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
        return;
    }
    self.collectButton.enabled = NO;
    MovierDCInterfaceSvc_IDArray *array = [[MovierDCInterfaceSvc_IDArray alloc] init];
    if ([weakSelf.infoDic[@"video_id"] intValue]) {
        [array.item addObject:weakSelf.infoDic[@"video_id"]];
    }
    [[SoapOperation Singleton] WS_GetVideoColletionStatus:nil
                                                 VideoIds:array
                                                  Success:^(MovierDCInterfaceSvc_IDArray *IDs) {
        MAINQUEUEUPDATEUI({
            if ([IDs.item count]>0) {
                weakSelf.collectButton.selected = YES;
            }else{
                weakSelf.collectButton.selected = NO;
            }
            weakSelf.collectButton.enabled = YES;
        })
    } Fail:^(NSError *error) {
        if (error.code == 12) {
            [LoginAndRegister getSessionWhenUserAlreadyLogin];
            [weakSelf judgeCollectStatus];
        }else{
            RELOADSERVERDATA([weakSelf judgeCollectStatus];);
        }
    }];
}

/** 点赞*/
- (void)praiseVideo{
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
        self.noLoginBlock();
        return;
    }
    
    WEAKSELF2
    [[SoapOperation Singleton] WS_SetPraise:@([weakSelf.infoDic[@"video_id"] intValue])
                                     Status:!self.praiseButton.selected
                                    Success:^(NSNumber *num) {
                                        NSString * praiseText;
                                        
                                        //点赞数量
                                        if (weakSelf.praiseButton.selected) {
                                            
                                            //点赞状态
                                            praiseText = [NSString stringWithFormat:@" %ld", (long)([weakSelf.praiseButton.titleLabel.text integerValue] - 1)];
                                            [CustomeClass showMessage:@"取消点赞" ShowTime:3];
                                        }else{
                                            
                                            //未点赞状态
                                            praiseText = [NSString stringWithFormat:@" %ld", (long)([weakSelf.praiseButton.titleLabel.text integerValue] + 1)];
                                            [CustomeClass showMessage:@"点赞成功" ShowTime:3];
                                        }
                                        MAINQUEUEUPDATEUI({
                                            [weakSelf.praiseButton setTitle:praiseText
                                                                   forState:UIControlStateNormal];
                                            weakSelf.praiseButton.selected = !weakSelf.praiseButton.selected;
                                            weakSelf.updatePraiseBlock([praiseText integerValue]);
                                        })
                                    } Fail:^(NSError *error) {
                                        DEBUGLOG(error)
                                    }];
    
    
}

/** 收藏操作*/
- (void)collectVideo{
    if (![UserEntity sharedSingleton].isAppHasLogin) {
        self.noLoginBlock();
        return;
    }
    WEAKSELF2
    [[SoapOperation Singleton] WS_SetCollectVideo:nil
                                     ChangeStatus:!weakSelf.collectButton.selected
                                          VideoId:@([weakSelf.infoDic[@"video_id"] intValue])
                                          Success:^{
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  NSString * collectNum;
                                                  if (weakSelf.collectButton.selected) {
                                                      collectNum = [NSString stringWithFormat:@" %ld", (long)([weakSelf.collectButton.titleLabel.text integerValue] - 1)];
                                                  }else{
                                                      collectNum = [NSString stringWithFormat:@" %ld", (long)([weakSelf.collectButton.titleLabel.text integerValue] + 1)];
                                                  }
                                                  [weakSelf.collectButton setTitle:collectNum
                                                                          forState:UIControlStateNormal];
                                                  weakSelf.collectButton.selected =!weakSelf.collectButton.selected;
                                                  if (weakSelf.collectButton.selected) {
                                                      [CustomeClass showMessage:@"收藏成功" ShowTime:3];
                                                  }else{
                                                      [CustomeClass showMessage:@"取消收藏" ShowTime:3];
                                                  }
                                                  weakSelf.updateCollectBlock([collectNum integerValue]);
                                              });
                                          } Fail:^(NSError *error) {
                                              DEBUGLOG(error)
                                          }];
}

/**
 *  设置照做按钮显示内容
 */
- (void)setFollowButton{
//    if ([self.infoDic[@"activity"] boolValue]) {
//        self.grayLabel1.hidden = NO;
//        [self.followButton setImage:[UIImage imageNamed:@"makeARImage"]
//                           forState:UIControlStateNormal];
//    }else{
        self.grayLabel1.hidden = YES;
//    }
}

#pragma mark - 懒加载

- (NSMutableArray *)titleMuarray{
    LAZYINITMUARRAY(_titleMuarray)
}

- (NSString *)arRewardInfoPlistPath{
    if (!_arRewardInfoPlistPath) {
        _arRewardInfoPlistPath = [NSString stringWithFormat:@"%@/Documents/%@.plist", NSHomeDirectory(), arRewardInfo];
    }
    return _arRewardInfoPlistPath;
}
@end
