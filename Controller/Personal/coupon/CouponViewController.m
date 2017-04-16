//
//  CouponViewController.m
//  M-Cut
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CouponViewController.h"
#import "CouponTableViewCell.h"
#import "ElectrialTableViewCell.h"
#import "OtherPrizeTableViewCell.h"
#import "ExchangeCouponViewController.h"
#import "OnlyOneView.h"
#import "HowGetRewardTableViewCell.h"

@interface CouponViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *couponTable;
//标题数据源
@property (nonatomic, strong) NSMutableArray * titleMuArray;
//是否展开
@property (nonatomic, strong) NSMutableArray * isFoldMuArray;
@property (nonatomic, strong) OnlyOneView *getRewardImage;
@end

@implementation CouponViewController

static NSString * const resuableStr = @"CouponTableViewCell";
static NSString * const resuableStr2 = @"ElectrialTableViewCell";
static NSString * const resuableStr3 = @"OtherPrizeTableViewCell";
static NSString * const resuableStr4 = @"HowGetRewardTableViewCell";

- (void)dealloc{
    DEBUGSUCCESSLOG(@"dealloc")
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置ui
    [self setUI];
}

#pragma mark - table代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        return 1;
    }
    if ([self.isFoldMuArray[section] boolValue]) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CouponTableViewCell * cell = [CouponTableViewCell CouponTableViewCellWithTable:tableView
                                                                           ResubaleStr:resuableStr];
        return cell;
    }else if (indexPath.section == 1){
        ElectrialTableViewCell * cell = [ElectrialTableViewCell ElectrialTableViewCellWithTable:tableView
                                                                                    ResuableStr:resuableStr2];
        return cell;
    }else if (indexPath.section == 2){
        OtherPrizeTableViewCell * cell = [OtherPrizeTableViewCell OtherPrizeTableViewCellWithTable:tableView
                                                                                       ResuableStr:resuableStr3];
        WEAKSELF2
        [cell setExchangeBlock:^(ExchangeType exchangeType, NSInteger shareNum, NSInteger invitedNum) {
            [weakSelf exchangeOperationWithExchangeType:exchangeType
                                           WithShareNum:shareNum
                                             InvitedNum:invitedNum];
        }];
        return cell;
    }else{
        return [HowGetRewardTableViewCell HowGetRewardTableViewCellWithTable:tableView
                                                                 ResuableStr:resuableStr4];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 208 + 60;
    }else if (indexPath.section == 1){
        return 130;
    }else{
        return 108;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return 0;
    }
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return nil;
    }
    UIView * headerButton = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                     0,
                                                                     ISScreen_Width,
                                                                     30)];
    headerButton.tag = section + 10000;
    
    //标题
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,
                                                                     0,
                                                                     ISScreen_Width - 30,
                                                                     30)];
    [headerButton addSubview:titleLabel];
    titleLabel.text = self.titleMuArray[section];
    titleLabel.font = ISFont_13;
    titleLabel.textColor = [UIColor blackColor];
    
    //右侧按钮
    UIButton * unfoldImage = [[UIButton alloc] initWithFrame:CGRectMake(ISScreen_Width - 40,
                                                                              0,
                                                                              30,
                                                                              30)];
    [headerButton addSubview:unfoldImage];
    if ([self.isFoldMuArray[section] boolValue]) {
        [unfoldImage setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
    }else{
        [unfoldImage setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
    }
    unfoldImage.tag = section + 20000;
    [unfoldImage addTarget:self
                    action:@selector(headerButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];
    
    return headerButton;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        [self titleLabelTap:nil];
    }
}

#pragma mark - 功能模块

/**
 *  如何获得奖品？
 */
- (void)titleLabelTap:(UITapGestureRecognizer *)tap{
    static NSInteger num = 0;
    num++;
    [self.getRewardImage showOnlyImageWithImage:[UIImage imageNamed:(num % 2 > 0) ? @"getInviteCouponImage" : @"getShareCouponImage"]];
    self.getRewardImage.frame = self.view.bounds;
    self.getRewardImage.needShowImage.backgroundColor = COLOR(102, 102, 102, 0.6);
}

/**
 *  隐藏
 */
- (void)hiddenImage{
    self.getRewardImage.frame = CGRectMake(0, 0, 0, 0);
    [self.getRewardImage showOnlyImageWithImage:[UIImage new]];
    self.getRewardImage.needShowImage.backgroundColor = [UIColor clearColor];
}

/**
 *  头视图按钮点击方法
 */
- (void)headerButtonAction:(UIButton *)headerBtn
{
    NSInteger section = headerBtn.tag - 20000;
    [self.isFoldMuArray replaceObjectAtIndex:section
                                  withObject:@(![self.isFoldMuArray[section] boolValue])];
    [self.couponTable reloadData];
}

/**
 *  设置ui
 */
- (void)setUI{
    NAVIGATIONBACKBARBUTTONITEM
    NAVIGATIONBARTITLEVIEW(@"我的奖品")
//    NAVIGATIONBARRIGHTBARBUTTONITEMWITHIMAGE(@"little")
    
    //注册cell
    [self.couponTable registerNib:[UINib nibWithNibName:resuableStr bundle:nil]
           forCellReuseIdentifier:resuableStr];
    [self.couponTable registerNib:[UINib nibWithNibName:resuableStr2 bundle:nil]
           forCellReuseIdentifier:resuableStr2];
    [self.couponTable registerNib:[UINib nibWithNibName:resuableStr3 bundle:nil]
           forCellReuseIdentifier:resuableStr3];
    [self.couponTable registerNib:[UINib nibWithNibName:resuableStr4 bundle:nil]
           forCellReuseIdentifier:resuableStr4];
}

/**
 *  返回按钮方法
 */
- (void)backButtonAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  兑换券操作
 */
- (void)exchangeOperationWithExchangeType:(ExchangeType)exchangeType
                             WithShareNum:(NSInteger)shareNum
                               InvitedNum:(NSInteger)invitedNum{
    ExchangeCouponViewController * exchangeVc = [ExchangeCouponViewController new];
    exchangeVc.shareCouponNum = shareNum;
    exchangeVc.invitedCouponNum = invitedNum;
    [self.navigationController pushViewController:exchangeVc animated:YES];
}

#pragma mark - 懒加载
- (NSMutableArray *)titleMuArray{
    if (!_titleMuArray) {
        _titleMuArray = [[NSMutableArray alloc] initWithArray:@[@"万元电器卡牌",
                                                                @"超值代金券",
                                                                @"分享壕礼"]];
    }
    return _titleMuArray;
}

- (NSMutableArray *)isFoldMuArray{
    if (!_isFoldMuArray) {
        _isFoldMuArray = [[NSMutableArray alloc] initWithArray:@[@(1),
                                                                 @(1),
                                                                 @(1)]];
    }
    return _isFoldMuArray;
}

- (OnlyOneView *)getRewardImage{
    if (!_getRewardImage) {
        WEAKSELF2
        _getRewardImage = [[OnlyOneView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_getRewardImage];
        [_getRewardImage setImageTapBlock:^{
            [weakSelf hiddenImage];
        }];
    }
    return _getRewardImage;
}
@end
