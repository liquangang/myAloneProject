//
//  SubtitleViewController.m
//  M-Cut
//
//  Created by apple on 16/11/30.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "SubtitleViewController.h"
#import "SubtitleCell.h"
#import "SoapOperation.h"
#import "MJRefresh.h"
#import "CustomeClass.h"
#import "CaptionEditeNewViewController.h"
#import "TimerManager.h"

static NSString *const resuableStr = @"SubtitleCell";

@interface SubtitleViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *defaultView;
@property (weak, nonatomic) IBOutlet UITableView *subtitleTable;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UIImageView *videoBackImage;
@property (weak, nonatomic) IBOutlet UILabel *showSubtitleLabel;
@property (nonatomic, strong) NSMutableArray *subtitleMuArray;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;
@property (nonatomic, strong) NSArray *subtitleArray;
@property (nonatomic, assign) NSInteger startIndex;
@end

@implementation SubtitleViewController

- (void)dealloc{
    [SINGLETON(TimerManager) stop];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DEBUGSUCCESSLOG(@"dealloc")
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self downloadDataWithStart:0];
}

#pragma mark - tableDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.subtitleMuArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF2
    SubtitleCell *cell = [SubtitleCell SubtitleCellWithTable:tableView ResuableStr:resuableStr ModelInfo:self.subtitleMuArray[indexPath.row]];
    
    [cell setEditButtonBlock:^{
        weakSelf.selectIndexPath = indexPath;
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        [weakSelf pushEditVc];
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndexPath = indexPath;
    
    //开始计时器，展示预览
    self.startIndex = 0;
    [SINGLETON(TimerManager) startWithTimeInterval:2];
}

#pragma mark - 接口

- (void)setUI{
    WEAKSELF2
    
    //注册cell
    [self.subtitleTable registerNib:[UINib nibWithNibName:resuableStr bundle:nil] forCellReuseIdentifier:resuableStr];
    
    //添加footer
    [self.subtitleTable addFooterWithCallback:^{
        [weakSelf downloadDataWithStart:weakSelf.subtitleMuArray.count];
    }];
    
    //默认隐藏播放字幕的view
    self.videoView.hidden = YES;
    
    //注册计时器通知
    REGISTEREDNOTI(timeStart:, timerIntervalMethod);
    
    NAVIGATIONBACKBARBUTTONITEM
    NAVIGATIONBARTITLEVIEW(@"选择字幕")
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 50, 30);
    rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    rightButton.titleLabel.font = ISFont_15;[rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)backButtonAction:(UIButton *)backBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarButtonItemAction:(UIButton *)btn{
    
    if (self.selectIndexPath) {
        self.getSubtitleBlock(self.subtitleMuArray[self.selectIndexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)downloadDataWithStart:(NSInteger)startNum{
    WEAKSELF2
    [CustomeClass HUDshow:self.view Tag:123456789];
    [[SoapOperation Singleton] WS_GetSubtitleList:nil Start:@(startNum) Count:@(18) Success:^(MovierDCInterfaceSvc_vpVDCSubtitleArray *SList) {
        [CustomeClass HUDhidden:weakSelf.view Tag:123456789];
        
        if (SList.item.count < 18) {
            MAINQUEUEUPDATEUI({
                [CustomeClass showMessage:noMoreData ShowTime:2];
                [weakSelf.subtitleTable footerEndRefreshing];
                [weakSelf.subtitleTable removeFooter];
            })
        }
        
        [weakSelf.subtitleMuArray addObjectsFromArray:[SList.item copy]];
        
        MAINQUEUEUPDATEUI({
            [weakSelf.subtitleTable reloadData];
        })
        
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf downloadDataWithStart:startNum];);
    }];
}

/**
 *  跳转字幕编辑页面
 */
- (void)pushEditVc{
    WEAKSELF2
    MAINQUEUEUPDATEUI({
        MovierDCInterfaceSvc_vpVDCSubtitleC *subtitleInfo = weakSelf.subtitleMuArray[weakSelf.selectIndexPath.row];
        CaptionEditeNewViewController *editSubtitleVc = [CaptionEditeNewViewController new];
        editSubtitleVc.editText = subtitleInfo.szRecommend;
        [editSubtitleVc setGetEditFinishSubtitleBlock:^(NSString *editFinishText) {
            subtitleInfo.szRecommend = editFinishText;
            MAINQUEUEUPDATEUI({
                [weakSelf.subtitleTable reloadData];
                [weakSelf.subtitleTable selectRowAtIndexPath:weakSelf.selectIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            })
        }];
        [weakSelf.navigationController pushViewController:editSubtitleVc animated:YES];
    })
}

/**
 *  timeStart
 */
- (void)timeStart:(NSNotification *)noti{
    WEAKSELF2
    
    if (self.startIndex == 0) {
        MovierDCInterfaceSvc_vpVDCSubtitleC *subtitleInfo = self.subtitleMuArray[self.selectIndexPath.row];
        self.subtitleArray = [subtitleInfo.szRecommend componentsSeparatedByString:@"\r\n"];
    }
    
    if (self.startIndex == self.subtitleArray.count) {
        [SINGLETON(TimerManager) stop];
        self.startIndex = 0;
        return;
    }
    
    if (self.videoView.hidden) {
        self.videoView.hidden = NO;
    }
    
    NSString *oneSubtitle = self.subtitleArray[self.startIndex];
    weakSelf.showSubtitleLabel.alpha = 0;
    
    [UIView animateWithDuration:2 animations:^{
        [CustomeClass mainQueue:^{
            weakSelf.showSubtitleLabel.alpha = 1;
            weakSelf.showSubtitleLabel.text = oneSubtitle;
        }];
    }];
    
    self.startIndex++;
}

#pragma mark - 懒加载

- (NSMutableArray *)subtitleMuArray{
    LAZYINITMUARRAY(_subtitleMuArray)
}

- (NSArray *)subtitleArray{
    LAZYINITARRAY(_subtitleArray)
}

@end
