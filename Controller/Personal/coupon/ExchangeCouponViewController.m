





//
//  ExchangeCouponViewController.m
//  M-Cut
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "ExchangeCouponViewController.h"
#import "ExchangeCouponTableViewCell.h"
#import "ExchangeCouponTableViewCell2.h"
#import "SoapOperation.h"
#import "OnlyOneView.h"
#import "CustomeClass.h"

@interface ExchangeCouponViewController ()<UITableViewDelegate,
                                           UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *exchangeCouponTable;
//奖品兑换数据源
@property (nonatomic, strong) NSMutableArray * exchangeCouponMuArray;
//当前选中的可以兑换的券类型
@property (nonatomic, copy) NSString *couponTypeName;
//数量
@property (nonatomic, assign) NSInteger canUseNum;
//还需要的数量
@property (nonatomic, assign) NSInteger missNum;
@property (nonatomic, strong) OnlyOneView *getRewardImage;
//选中的那一项
@property (nonatomic, strong) NSIndexPath *selectIndex;
@end

@implementation ExchangeCouponViewController

static NSString * const resuableStr = @"ExchangeCouponTableViewCell";
static NSString * const resuableStr2 = @"ExchangeCouponTableViewCell2";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self unSelect];
}

#pragma mark - 代理

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 70;
    }
    return 188;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 1;
    }
    return self.exchangeCouponMuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        WEAKSELF2
        ExchangeCouponTableViewCell2 * cell = [ExchangeCouponTableViewCell2 ExchangeCouponTableViewCell2WithTable:tableView
                                                                                                        CanUseNum:self.canUseNum
                                                                                                          MissNum:self.missNum
                                                                                                   CouponTypeName:self.couponTypeName
                                                                                                      ResuableStr:resuableStr2];
        [cell setShowGetStyleblock:^{
            MAINQUEUEUPDATEUI({
                [weakSelf showPropmt];
            })
        }];
        [cell setExchangeBlock:^(UIButton *exchangeButton) {
            if (exchangeButton.selected) {
                [weakSelf exchangeReward];
            }
        }];
        return cell;
    }
    WEAKSELF2
    ExchangeCouponTableViewCell * cell = [ExchangeCouponTableViewCell ExchangeCouponTableViewCellWithTable:tableView
                                                                                                  CellInfo:self.exchangeCouponMuArray[indexPath.row]
                                                                                                 IndexPath:indexPath
                                                                                               ResuableStr:resuableStr];
    [cell setSelectButtonBlock:^(NSIndexPath *index, UIButton *selectButton) {
        if (selectButton.selected) {
            weakSelf.selectIndex = index;
            [weakSelf judgeExchangeWithDic:weakSelf.exchangeCouponMuArray[index.row]];
        }else{
            weakSelf.selectIndex = nil;
            [weakSelf unSelect];
        }
    }];
    if (weakSelf.selectIndex == indexPath) {
        cell.selectButton.selected = YES;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return nil;
    }
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   ISScreen_Width,
                                                                   30)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,
                                                                     0,
                                                                     ISScreen_Width - 12,
                                                                     30)];
    [headerView addSubview:titleLabel];
    titleLabel.text = @"代金券兑换";
    titleLabel.font = ISFont_13;
    titleLabel.backgroundColor = [UIColor whiteColor];
    return headerView;
}

#pragma mark - 功能模块

/**
 *  兑换
 */
- (void)exchangeReward{
    NSDictionary *exchangeRewardInfo = self.exchangeCouponMuArray[self.selectIndex.row];
    [[SoapOperation Singleton] couponExchangeRewardWithTokenType:[exchangeRewardInfo[@"type"] integerValue] RewareID:exchangeRewardInfo[@"awardid"] Success:^(NSMutableDictionary *serverDataDictionary) {
        [CustomeClass showMessage:@"兑换成功" ShowTime:3];
    } Fail:^(NSError *error) {
        DEBUGLOG(error)
        [CustomeClass showMessage:@"抱歉，达不到兑换条件！" ShowTime:3];
    }];
}

/**
 *  取消选中
 */
- (void)unSelect{
    WEAKSELF2
    self.canUseNum = self.shareCouponNum + self.invitedCouponNum;
    self.couponTypeName = @"优惠券";
    self.missNum = 0;
    [CustomeClass mainQueue:^{
        [weakSelf.exchangeCouponTable reloadData];
    }];
}

/**
 *  展示获取券提示
 */
- (void)showPropmt{
    static NSInteger openNum = 0;
    [self.getRewardImage showOnlyImageWithImage:[UIImage imageNamed:(openNum % 2 > 0) ? @"getInviteCouponImage" : @"getShareCouponImage"]];
    self.getRewardImage.frame = self.view.bounds;
    self.getRewardImage.needShowImage.backgroundColor = COLOR(102, 102, 102, 0.6);
    openNum++;
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
 *  设置第二组cell内容
 */
- (void)judgeExchangeWithDic:(NSDictionary *)couponExchangeInfo{
    WEAKSELF2
    self.couponTypeName = [couponExchangeInfo[@"type"] integerValue] == 1 ? @"分享券" : @"邀请券";
    self.canUseNum = [couponExchangeInfo[@"type"] integerValue] == 1 ? self.shareCouponNum : self.invitedCouponNum;
    self.missNum = [couponExchangeInfo[@"expendamount"] integerValue] - self.canUseNum;
    [CustomeClass mainQueue:^{
        [weakSelf.exchangeCouponTable reloadData];
        [weakSelf.exchangeCouponTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]
                                            atScrollPosition:UITableViewScrollPositionBottom
                                                    animated:YES];
    }];
}

/**
 *  下载数据
 */
- (void)downloadData{
    [CustomeClass hudShowWithView:self.view Tag:12345678];
    WEAKSELF2
    [[SoapOperation Singleton] getCouponExchangeRuleWithSuccess:^(NSMutableArray *serverDataArray) {
        [CustomeClass hudHiddenWithView:weakSelf.view Tag:12345678];
        /*
         Printing description of ((__NSDictionaryM *)0x0000000174646cf0):
         {
         awardid = 9;
         desc = "";
         expendamount = 10;
         expireddate = "2016-12-12";
         name = "50\U5143";
         type = 1;1-分享券 2-邀请券
         }
         */
        
        //处理数据
        [weakSelf.exchangeCouponMuArray addObjectsFromArray:[serverDataArray copy]];
        MAINQUEUEUPDATEUI({
            
            //刷新table
            [weakSelf.exchangeCouponTable reloadData];
        })
    } Fail:^(NSError *error) {
        
    }];
}

/**
 *  设置ui
 */
- (void)setUI{
    
    NAVIGATIONBARTITLEVIEW(@"兑换优惠券")
    NAVIGATIONBACKBARBUTTONITEM
    
    //默认值
    self.canUseNum = 0;
    self.missNum = 0;
    self.couponTypeName = @"分享券";
    
    
    //注册cell
    [self.exchangeCouponTable registerNib:[UINib nibWithNibName:resuableStr bundle:nil]
                   forCellReuseIdentifier:resuableStr];
    [self.exchangeCouponTable registerNib:[UINib nibWithNibName:resuableStr2 bundle:nil]
                   forCellReuseIdentifier:resuableStr2];
    [self downloadData];
}

NAVIGATIONBACKITEMMETHOD

#pragma mark - 懒加载
- (NSMutableArray *)exchangeCouponMuArray{
    if (!_exchangeCouponMuArray) {
        _exchangeCouponMuArray = [NSMutableArray new];
    }
    return _exchangeCouponMuArray;
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
