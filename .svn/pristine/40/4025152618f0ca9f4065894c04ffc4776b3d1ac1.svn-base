//
//  MorePraiseViewController.m
//  M-Cut
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "MorePraiseViewController.h"
//自定义视频cell
#import "CustomTaskVideoTableViewCell.h"
//自定义用户信息cell
#import "integralRecordUserCell.h"

#import "SoapOperation.h"

#import "CustomeClass.h"

#import "MJRefresh.h"

@interface MorePraiseViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MorePraiseViewController

#pragma mark - 数据源懒加载
- (NSMutableArray *)videoMuArray{
    if (!_videoMuArray) {
        _videoMuArray = [NSMutableArray new];
    }
    return _videoMuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self downloadDataWithStart:0];
}

#pragma mark - 下载数据
- (void)downloadDataWithStart:(NSInteger)needStart{
    DEFAULTQUEUEANALYSISANDMAINQUEUEUPDATEUI({
        WEAKSELF(weakSelf);
        [CustomeClass hudShowWithView:weakSelf.view Tag:1234];
        [[SoapOperation Singleton] WS_getchallengetaskpraiseWithoffset:needStart Count:16 Success:^(NSMutableArray *serverDataArray) {
            [CustomeClass hudHiddenWithView:weakSelf.view Tag:1234];
            if (needStart == 0) {
                [weakSelf.videoMuArray removeAllObjects];
            }
            [weakSelf.videoMuArray addObjectsFromArray:[serverDataArray copy]];
            if (serverDataArray.count == 0) {
                [CustomeClass showMessage:@"没有更多影片了" ShowTime:1.5];
            }
            
            MAINQUEUEUPDATEUI({
                [weakSelf.videoTable reloadData];
            })
            
        } Fail:^(NSError *error) {
           [CustomeClass hudHiddenWithView:weakSelf.view Tag:1234];
        }];
    }, {})
}

#pragma mark - initUI
- (void)initUI{
    self.title = @"海量获赞";
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    //头像旁边那句话
    self.praiseStr = @"被点赞的数量";
    
    //添加加载
    WEAKSELF(weakSelf);
    [self.videoTable addHeaderWithCallback:^{
        [weakSelf downloadDataWithStart:0];
    }];
    
    [self.videoTable addFooterWithCallback:^{
        [weakSelf downloadDataWithStart:weakSelf.videoMuArray.count];
    }];
}

#pragma mark - 返回按钮方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableDelegate/tableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    BACKPROPMTVIEW(self.videoMuArray.count == 0, 12345, @"您还没有海量获赞的影片，快去做片吧！", self.videoTable);
    return self.videoMuArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 8;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 88;
    }
    return 116;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return [CustomTaskVideoTableViewCell getCustomTaskVideoTableViewCellWithTable:tableView InfoDic:nil];
    }else{
        integralRecordUserCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell0"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"integralRecordUserCell" owner:nil options:nil] lastObject];
        }
        [cell setUserIntegralLabelWithStr:self.praiseStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
@end
