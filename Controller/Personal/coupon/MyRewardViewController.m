//
//  MyRewardViewController.m
//  M-Cut
//
//  Created by liquangang on 2017/1/22.
//  Copyright © 2017年 Crab movier. All rights reserved.
//

#import "MyRewardViewController.h"
#import "RewardTableViewCell.h"
#import "RewardModel.h"
#import "GetRewardViewController.h"

static NSString *const cellResuableStr = @"RewardTableViewCell";

@interface MyRewardViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *rewardTable;
@property (nonatomic, strong) NSMutableArray *rewardMuArray;
@end

@implementation MyRewardViewController

DEALLOCMETHOD

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUI];
    [self downloadData];
}

#pragma mark - table代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rewardMuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RewardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellResuableStr];
    cell.rewardImage.image = DEFAULTVIDEOTHUMAIL;
    cell.rewardDesLabel.text = @"待领取";
    cell.rewardNameLabel.text = @"金子";
    [cell.getButton setTitle:@"领取" forState:UIControlStateNormal];
    cell.getButton.backgroundColor = ColorFromRGB(0xF4413F, 1);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RewardModel *rewardModel = self.rewardMuArray[indexPath.row];
   
    if (!rewardModel.isReceive) {
        
        //跳转到填写信息界面
        GetRewardViewController *getRewardVc = [GetRewardViewController new];
        [self.navigationController pushViewController:getRewardVc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}


#pragma mark - interface

- (void)setUI{
    [self.rewardTable registerNib:[UINib nibWithNibName:cellResuableStr bundle:nil] forCellReuseIdentifier:cellResuableStr];
    NAVIGATIONBACKBARBUTTONITEM
}

NAVIGATIONBACKITEMMETHOD

- (void)downloadData{
    for (int i = 0; i < 6; i++) {
        [self.rewardMuArray addObject:[RewardModel new]];
    }
    [self.rewardTable reloadData];
}

#pragma mark - getter

- (NSMutableArray *)rewardMuArray{
    LAZYINITMUARRAY(_rewardMuArray)
}

@end
