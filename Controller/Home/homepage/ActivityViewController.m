


//
//  ActivityViewController.m
//  M-Cut
//
//  Created by apple on 16/8/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityTableViewCell.h"
#import "SoapOperation.h"
#import "MJRefresh.h"
#import "CustomeClass.h"
#import "VideoLabelDetailViewController.h"
#import "ActivityDetailView.h"
#import "MyVideoViewController.h"
#import "UserEntity.h"
#import "HomeBannerWebViewController.h"
#import "WkWebViewViewController.h"
#import "VideoLabelViewController.h"

@interface ActivityViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *activityTable;
/** 界面数据源*/
@property (nonatomic, strong) NSMutableArray * activityDataMuArray;
/** 活动详情view*/
@property (nonatomic, strong) ActivityDetailView * activityDetailView;
@end

@implementation ActivityViewController

#pragma mark - 懒加载
- (ActivityDetailView *)activityDetailView{
    if (!_activityDetailView) {
        _activityDetailView = [[ActivityDetailView alloc] initWithLabelId:self.activityLabelId ActivityDes:@""];
        WEAKSELF2
        [_activityDetailView setReloadTableBlock:^{
            [weakSelf.activityTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        }];
        [_activityDetailView setClickBannerImageBlock:^(NSInteger bannerPosition, NSMutableArray * bannerInfoMuArray) {
            [weakSelf pushVcWithBannerArray:[bannerInfoMuArray copy] BannerPosition:bannerPosition];
        }];
    }
    return _activityDetailView;
}

- (NSMutableArray *)activityDataMuArray{
    if (!_activityDataMuArray) {
        _activityDataMuArray = [NSMutableArray new];
    }
    return _activityDataMuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NAVIGATIONBARTITLEVIEW(@"活动")
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    WEAKSELF(weakSelf);
    [self.activityTable addFooterWithCallback:^{
        [weakSelf downloadDataWithStart:weakSelf.activityDataMuArray.count];
    }];
    
    [self downloadDataWithStart:0];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"ActivityViewController dealloc");
}

- (void)downloadDataWithStart:(NSInteger)startIndex{
    WEAKSELF(weakSelf);
    [CustomeClass hudShowWithView:weakSelf.view Tag:11];
    
    [[SoapOperation Singleton] WS_getlabelsbyparentidWithLabelId:weakSelf.activityLabelId Offset:startIndex Count:66 Success:^(NSMutableArray *serverDataArray) {
        if (startIndex == 0) {
            [weakSelf.activityDataMuArray removeAllObjects];
        }
        [weakSelf.activityDataMuArray addObjectsFromArray:(NSMutableArray *)[[serverDataArray reverseObjectEnumerator] allObjects]];
        
        MAINQUEUEUPDATEUI({
            [weakSelf.activityTable footerEndRefreshing];
            [weakSelf.activityTable headerEndRefreshing];
            if (serverDataArray.count == 0) {
//                [CustomeClass showMessage:@"没有更多活动了" ShowTime:1.5];
                SHOWALERT(@"没有更多活动了！")
                [weakSelf.activityTable removeFooter];
            }else{
                [weakSelf.activityTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
            }
            [CustomeClass hudHiddenWithView:weakSelf.view Tag:11];
        })
    } Fail:^(NSError *error) {
        [CustomeClass hudHiddenWithView:weakSelf.view Tag:11];
        RELOADSERVERDATA([weakSelf downloadDataWithStart:startIndex];);
    }];
}

#pragma mark - 返回按钮方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - table回调
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.activityDetailView.frame.size.height;
    }
    return 12 + 15 + 8 + 12 + 8 + (ISScreen_Width - 30) / 734 * 228 + 10 + 15 + 12;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.activityDataMuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headerCell"];
        }
        [cell.contentView addSubview:self.activityDetailView];
        cell.contentView.clipsToBounds = YES;
        return cell;
    }
    return [ActivityTableViewCell getActivityCellWithTable:tableView ActivityInfo:self.activityDataMuArray[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return;
    }
    NSDictionary * labelDetailInfo = self.activityDataMuArray[indexPath.row];
    VideoLabelViewController *videoLabelVc = [VideoLabelViewController new];
    videoLabelVc.hidesBottomBarWhenPushed = YES;
    videoLabelVc.labelInfo = [VideoLabelViewController dicToModelWithDic:labelDetailInfo];
    [self.navigationController pushViewController:videoLabelVc animated:YES];
}

#pragma mark - 方法
/** 根据位置跳转banner页面*/
- (void)pushVcWithBannerArray:(NSArray *)bannerInfoArray BannerPosition:(NSInteger)bannerPosition{
    NSMutableDictionary * bannerInfo = bannerInfoArray[bannerPosition];
    NSString * pushTypeStr = bannerInfo[@"type"];
    NSInteger pushInteger = [pushTypeStr integerValue];
    switch (pushInteger) {
        case 1:
        {
            //跳转个人主页
            if (![self showNoLogin]) {
                return;
            }
            MyVideoViewController * videoVc = [MyVideoViewController new];
            if (![bannerInfo[@"para1"] isEqualToString:CURRENTUSERID]) {
                videoVc.isShowOtherUserVideo = YES;
            }
            videoVc.userId = bannerInfo[@"para1"];
            [self.navigationController pushViewController:videoVc animated:YES];
        }
            break;
        case 2:
        {
            //根据标签跳转
            [self pushVcWithLabelId:bannerInfo[@"para1"]];
        }
            break;
        case 3:
        {
            //根据网页跳转
            NSURL * activityURL = [NSURL URLWithString:bannerInfo[@"para3"]];
            [WkWebViewViewController showWebWithURL:activityURL
                                              Title:@"活动详情"
                               NavigationController:self.navigationController];
        }
            break;
        case 4:
        {
            //根据话题跳转
        }
            break;
            
        default:
            break;
    }
    
}

/** 根据标签id跳转页面*/
- (void)pushVcWithLabelId:(NSString *)labelId{
    WEAKSELF2
    [[SoapOperation Singleton] WS_GetLabelDescric:[NSNumber numberWithInt:[labelId intValue]] Success:^(MovierDCInterfaceSvc_VDCVideoLabelEx *labelinfo) {
        dispatch_async(dispatch_get_main_queue(), ^{
            VideoLabelViewController *videoLabelVc = [VideoLabelViewController new];
            videoLabelVc.labelInfo = [VideoLabelViewController modelUpdateWithModel1:labelinfo];
            [weakSelf.navigationController pushViewController:videoLabelVc animated:YES];
        });
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf pushVcWithLabelId:labelId];);
    }];
}

/** 未登录提示*/
- (BOOL)showNoLogin{
    if (![UserEntity sharedSingleton].isAppHasLogin) {
        [CustomeClass showMessage:@"请登录后操作" ShowTime:1.5];
        return NO;
    }
    return YES;
}

@end
