
//
//  AddFriendViewController.m
//  M-Cut
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "AddFriendViewController.h"
//添加好友cell
#import "AddFriendCell.h"
#import "AddAddressBookPersonViewController.h"
#import "SoapOperation.h"
#import "CustomeClass.h"
//好友cell
#import "FriendCell.h"
#import "ChatViewController.h"
#import <UMSocial.h>
#import "MyVideoViewController.h"
#import "MJRefresh.h"


@interface AddFriendViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *friendTable;
/** 默认显示的数据源*/
@property (nonatomic, strong) NSMutableArray * friendTypeMuArray;
/** 搜索数据源*/
@property (nonatomic, strong) NSMutableArray * friendSearchMuArray;

/** 搜索对象*/
@property (nonatomic, strong) UISearchController * friendSearchController;

/** 记录table开始滑动时的位置*/
@property (nonatomic, assign) CGFloat startPosition;
@end


@implementation AddFriendViewController

#pragma mark - 数据源懒加载
- (NSMutableArray *)friendTypeMuArray{
    if (!_friendTypeMuArray) {
        _friendTypeMuArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FriendTypeData.plist" ofType:nil]];
    }
    return _friendTypeMuArray;
}



- (NSMutableArray *)friendSearchMuArray{
    if (!_friendSearchMuArray) {
        _friendSearchMuArray = [NSMutableArray new];
    }
    return _friendSearchMuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - initUI
- (void)initUI{
    self.title = @"添加好友";
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    //添加搜索框
    self.friendSearchController = [[UISearchController new] initWithSearchResultsController:nil];
    self.friendSearchController.searchResultsUpdater = self;
    self.friendSearchController.searchBar.barTintColor = [UIColor groupTableViewBackgroundColor];
    self.friendSearchController.searchBar.tintColor = ISRedColor;
    self.friendSearchController.searchBar.delegate = self;
    [self.friendSearchController.searchBar sizeToFit];
    self.friendSearchController.searchBar.placeholder = @"搜索";
    self.friendSearchController.dimsBackgroundDuringPresentation = NO;
    self.friendSearchController.searchBar.layer.cornerRadius = 0;
    self.friendTable.tableHeaderView = self.friendSearchController.searchBar;
    self.definesPresentationContext = YES;
    self.friendSearchController.searchBar.searchBarStyle = UISearchBarStyleProminent;
    self.friendSearchController.searchBar.returnKeyType = UIReturnKeySearch;
    
    //添加上拉加载
    [self.friendTable addFooterWithTarget:self action:@selector(footerRefresh)];
}

- (void)footerRefresh{
    [self downloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.friendSearchController.searchBar.hidden = NO;
}

#pragma mark - searchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.friendSearchController.active = YES;
    [self.friendTypeMuArray removeAllObjects];
    [self.friendSearchMuArray removeAllObjects];
    [self.friendTable reloadData];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self downloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.friendSearchController.active = NO;
    [self.friendTypeMuArray addObjectsFromArray:[[NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FriendTypeData.plist" ofType:nil]] copy]];
    [self.friendTable reloadData];
}

- (UIImage *)createImageWithColor:(UIColor *)color Rect:(CGRect)myRect
{
    CGRect rect = CGRectMake(0.0f, 0.0f, ISScreen_Width - 16, 34.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (void)downloadData{
    
    NSString * searchText = [self.friendSearchController.searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (searchText.length == 0) {
        [self.friendTable footerEndRefreshing];
        return;
    }
    
    [CustomeClass hudShowWithView:self.view Tag:10];
    WEAKSELF(weakSelf);
    [[SoapOperation Singleton] WS_searchfriendWithSearchContent:self.friendSearchController.searchBar.text Offset:weakSelf.friendSearchMuArray.count Count:36 Success:^(NSMutableArray *serverDataArray) {
        /*
         MovierDCInterfaceSvc_VDCFriendInfo
         @interface MovierDCInterfaceSvc_VDCFriendInfo : NSObject {
         
         NSNumber * nFriendFlag;
         NSNumber * nCustomerID;
         NSNumber * nVideoAmount;
         NSNumber * nCollectAmount;
         NSString * szAvatar;
         NSString * szNickName;
         NSString * szSignature;
         
         }
         */
        [weakSelf.friendSearchMuArray addObjectsFromArray:[serverDataArray copy]];
        MAINQUEUEUPDATEUI({
            [weakSelf.friendTable reloadData];
            [CustomeClass hudHiddenWithView:weakSelf.view Tag:10];
            [weakSelf.friendTable footerEndRefreshing];
            if (serverDataArray.count < 36) {
                [CustomeClass showMessage:@"没有更多结果了" ShowTime:1.5];
            }
        })
    } Fail:^(NSError *error) {
        DEBUGLOG(error);
    }];
}

#pragma mark - 返回按钮方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - uiscrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //已经滑动
    if (scrollView.contentOffset.y > self.startPosition) {
        //向下滑动，搜索栏隐藏
        self.friendSearchController.searchBar.hidden = YES;
    }else{
        //向上滑动，搜索栏不隐藏
        self.friendSearchController.searchBar.hidden = NO;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.startPosition = scrollView.contentOffset.y;
}


#pragma mark - searchDelegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
//    [self downloadData];
}

#pragma mark - tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.friendSearchController.active) {
        BACKPROPMTVIEW(self.friendSearchMuArray.count == 0, 100, @"无结果", self.friendTable);
        return self.friendSearchMuArray.count;
    }
    return self.friendTypeMuArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.friendSearchController.active) {
        MovierDCInterfaceSvc_VDCFriendInfo * friendInfo = self.friendSearchMuArray[indexPath.row];
        FriendCell * cell = [FriendCell getFriendCellWithIconUrl:friendInfo.szAvatar NickName:friendInfo.szNickName VideoNam:[friendInfo.nVideoAmount integerValue] CollectNum:[friendInfo.nCollectAmount integerValue] Signature:friendInfo.szSignature FriendType:[friendInfo.nFriendFlag integerValue] Table:tableView FriendInfo:friendInfo Index:indexPath];
        WEAKSELF(weakSelf);
        [cell rightAction:^(NSString *actionTypeStr, FriendModel *friendInfo, NSIndexPath *cellIndex) {
            [weakSelf rightAction:actionTypeStr FriendModel:friendInfo Index:cellIndex];
        }];
        return cell;
    }
    return [AddFriendCell getAddFriendCellWithTabel:tableView Dic:self.friendTypeMuArray[indexPath.row]];
}

- (void)rightAction:(NSString *)btnStr FriendModel:(FriendModel *)friendModel Index:(NSIndexPath *)cellIndex{
    if ([btnStr isEqualToString:@"私信"]) {
        //进入私信界面
        //跳转到私信页面
        ChatViewController * chatVc = [ChatViewController new];
        chatVc.friendInfo = friendModel;
        [self.navigationController pushViewController:chatVc animated:YES];

    }else if ([btnStr isEqualToString:@"+关注"]){
        //关注
        [self followSomeone:friendModel Index:cellIndex];
    }
}

/** 关注方法*/
- (void)followSomeone:(FriendModel *)friendModel Index:(NSIndexPath *)cellIndex{
    WEAKSELF(weakSelf);
    [[SoapOperation Singleton] WS_followWithCustomID:friendModel.userId Success:^(NSNumber *num) {
        DEBUGSUCCESSLOG(@"关注成功")
        MovierDCInterfaceSvc_VDCFriendInfo * friendInfo = weakSelf.friendSearchMuArray[cellIndex.row];
        friendInfo.nFriendFlag = @(1);
        [weakSelf.friendSearchMuArray replaceObjectAtIndex:cellIndex.row withObject:friendInfo];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.friendTable reloadData];
            [CustomeClass showMessage:@"关注成功" ShowTime:2];
        });
        
    } Fail:^(NSError *error) {
        DEBUGLOG(@"关注失败");
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [CustomeClass showMessage:@"关注失败" ShowTime:1.5];
        });
        NSLog(@"error---%@", error);
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.friendSearchController.active) {
        MovierDCInterfaceSvc_VDCFriendInfo * friendInfo = self.friendSearchMuArray[indexPath.row];
        
        //新页面
        MyVideoViewController * other = [MyVideoViewController new];
        other.isShowOtherUserVideo = YES;
        other.userId = [NSString stringWithFormat:@"%@", friendInfo.nCustomerID];
        [self.navigationController pushViewController:other animated:YES];

    }else{
        AddFriendCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        if ([cell.friendTypeLabel.text isEqualToString:@"手机联系人"]) {
            AddAddressBookPersonViewController * addPhonePersonVc = [AddAddressBookPersonViewController new];
            [self.navigationController pushViewController:addPhonePersonVc animated:YES];
        }
        
        if ([cell.friendTypeLabel.text isEqualToString:@"微信联系人"]) {
            [UMSocialData defaultData].extConfig.wechatSessionData.url = @"https://itunes.apple.com/cn/app/ying-xiang/id1013565760?mt=8";
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"一起来玩映像吧！" image:[UIImage imageNamed:@"默认封面"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
        }
        
        if ([cell.friendTypeLabel.text isEqualToString:@"QQ联系人"]) {
            [UMSocialData defaultData].extConfig.qqData.url = @"https://itunes.apple.com/cn/app/ying-xiang/id1013565760?mt=8";
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"一起来玩映像吧！" image:[UIImage imageNamed:@"默认封面"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
        }
        
    }
    
}

@end
