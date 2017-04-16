//
//  VideoDetailViewController.m
//  M-Cut
//
//  Created by apple on 16/9/8.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "VideoPlayerTableViewCell.h"
#import "ZFPlayerView.h"
#import "AppDelegate.h"
#import "integralRecordUserCell.h"
#import "InputView.h"
#import "MyVideoViewController.h"
#import "VideoDetailUserInfoTableViewCell.h"
#import "CommentTableViewCell.h"
#import "OperationTableViewCell.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "ISCutProViewController.h"
#import "ISStyleDetailCell.h"
#import "HomeVideoReportViewController.h"
#import "HomeVideoReportCommentViewController.h"
#import "MJRefresh.h"
#import "DefaultTableViewCell.h"
#import "MapTableViewCell.h"
#import "MessageObj.h"
#import "locationManager.h"
#import "PropmtView.h"

static NSString * const resuableStr = @"MapTableViewCell";

@interface VideoDetailViewController ()<UITableViewDelegate,
                                        UITableViewDataSource,
                                        UMSocialUIDelegate,
                                        UIAlertViewDelegate,
                                        UIActionSheetDelegate>
/** 播放界面*/
@property (nonatomic, strong) ZFPlayerView *playView;
/** 内容table*/
@property (nonatomic, strong) UITableView * videoDetailTable;
/** 输入部分*/
@property (nonatomic, strong) InputView * inputView;
/** 评论或者回复的数组*/
@property (nonatomic, strong) NSMutableArray * commentMuArray;
/** 点击的回复评论的评论对象*/
@property (nonatomic, strong) MovierDCInterfaceSvc_vpVideoComment * commentInfo;
/** 播放器的初始高度*/
@property (nonatomic, assign) CGFloat videoViewHeight;
/** 当前键盘高度*/
@property (nonatomic, assign) CGFloat currentKeyboardHeight;
/** 要删除的评论的对象*/
@property (nonatomic, strong) MovierDCInterfaceSvc_vpVideoComment * deleteCommentInfo;
/** 要删除的评论的位置*/
@property (nonatomic, strong) NSIndexPath * deleteCommentIndexPath;
/** 键盘退出手势*/
@property (nonatomic, strong) UITapGestureRecognizer * keyboardHiddenGesture;
/** 存储评论cell高度的数组*/
@property (nonatomic, strong) NSMutableArray * commentCellHeightMuArray;
//在不在国美附近，不在就显示地图
@property (nonatomic, assign) BOOL isNearby;
@property (nonatomic, strong) PropmtView *propmtView;
//传递视频信息block
@property (nonatomic, copy) void(^getVideoInfoBlock)(NSMutableDictionary *videoInfoDic);
@end

@implementation VideoDetailViewController

- (void)dealloc{
    self.getVideoInfoBlock(self.videoInfo);
    CANNOTSCALE
    [self.playView resetPlayer];
    [self.playView cancelAutoFadeOutControlBar];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DEBUGSUCCESSLOG(@"dealloc")
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NAVIGATIONBARTITLEVIEW(self.videoInfo[@"video_name"])
    NAVIGATIONBACKBARBUTTONITEM
    
    //默认用户在目标区域附近
    self.isNearby = YES;
    
    //从全屏恢复
    REGISTEREDNOTI(restorePlayView:, RESTROE);
    //进入竖屏全屏状态
    REGISTEREDNOTI(porpaitFullScreen:, PORTRAITFULLSCREEN);
    //注册键盘高度获取通知
    REGISTEREDNOTI(keyboardChange:, UIKeyboardDidChangeFrameNotification);
    //注册侧滑返回时又滑回来的通知
    REGISTEREDNOTI(showKB:, @"showKeyBoard");
    //导航栏右侧按钮
    NAVIGATIONBARRIGHTBARBUTTONITEMWITHIMAGE(@"little")
    
    //首次加载评论数据
    [self downloadCommentWithStart:0];
    
    //增加观看次数
    [self addVisitConunt];
    
    //设置分享内容
    [self setShareContent];
    
    //如果是用户的新影片，就修改数据库，去除新消息
    [self updateReadStatus];
    
    //接受地理位置信息的通知
    REGISTEREDNOTI(getLocationInfo:, getLocationInfo);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.playView play];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.playView pause];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.playView pause];
}

#pragma mark - tableDelegate
- (CGFloat)tableView:(UITableView *)tableView
           heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else if (indexPath.section == 1){
        return self.videoViewHeight;
    }else if (indexPath.section == 3){
        if (self.commentMuArray.count == 0 || !self.isNearby) {
            return ISScreen_Height - self.videoViewHeight - 212 > 0 ?
                   ISScreen_Height - self.videoViewHeight - 212 :
                   88;
        }
        return [self.commentCellHeightMuArray[indexPath.row] floatValue];
    }else{
        return 66;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView
             numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        if (self.commentMuArray.count == 0 || !self.isNearby) {
            return 1;
        }
        return self.commentMuArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
                     cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [self videoOwerCell];
    }else if (indexPath.section == 1){
        return [self videoCell];
    }else if (indexPath.section == 3){
        return [self commentCellWithIndex:indexPath];
    }else{
        return [self operationCell];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3 && self.commentMuArray.count > 0 && self.isNearby) {
        //回复评论
        self.commentInfo = self.commentMuArray[indexPath.row];
        self.inputView.inputTextView.text = [NSString stringWithFormat:@"@ %@ :", self.commentInfo.szNickname];
        [self.inputView.inputTextView becomeFirstResponder];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 10) {
        if (buttonIndex != 0) {
            NewNSOrderDetail *fresh = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
            fresh.nVideoLength =0.0;
            [MC_OrderAndMaterialCtrl UpdateFresh:fresh];
            [MC_OrderAndMaterialCtrl DeleteMaterialsInOrder:[[UserEntity sharedSingleton].customerId intValue]
                                                    Orderid:fresh.order_id];
            [CustomeClass deleteFileWithFileName:[NSString stringWithFormat:@"%@/Documents/orderThumail", NSHomeDirectory()]];
        }
        
        //跳转制作页面
        [self presentCreatePage];
    }else if (alertView.tag == 555555){
        if (buttonIndex == 1) {
            
            //删除评论
            [self deleteCommentAndReloadTable];
        }
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 111111) {
        if (buttonIndex == 0) {
            
            //修改公开状态
            [self changeVideoShareStatus];
        }else if (buttonIndex == 1){
            
            //删除视频
            [self deleteVideo];
        }
    }else if (actionSheet.tag == 222222){
        if (buttonIndex == 0) {
            
            //显示删除评论的alertview
            [self deleteComment];
        }
        
    }else if (actionSheet.tag == 333333){
        if (buttonIndex == 0) {
            
            //举报评论
            [self reportComment];
        }
        
    }else if (actionSheet.tag == 444444){
        if (buttonIndex == 0) {
            
            //举报视频
            [self reportCurrentVideo];
        }
    }
}

#pragma mark - 接口

/**
 *  跳转影片详情页
 */
+ (void)pushVideoDetailWithVideoInfo:(NSMutableDictionary *)videoInfo Nav:(UINavigationController *)pushNav VideoInfoBlock:(void(^)(NSMutableDictionary *videoInfoDic))videoInfoBlock{
    VideoDetailViewController * videoDetailVc = [VideoDetailViewController new];
    videoDetailVc.getVideoInfoBlock = videoInfoBlock;
    videoDetailVc.videoInfo = videoInfo;
    [pushNav pushViewController:videoDetailVc animated:YES];
}

/**
 *  影片作者头像部分cell
 */
- (VideoDetailUserInfoTableViewCell *)videoOwerCell{
    VideoDetailUserInfoTableViewCell * cell = [VideoDetailUserInfoTableViewCell VideoDetailUserInfoTableViewCellWithCellSuperTable:self.videoDetailTable
                                                                                                                           InfoDic:self.videoInfo];
    WEAKSELF2
    
    //关注
    [cell setCareButtonBlock:^{
        [weakSelf followVideoOwer];
    }];
    
    //点击视频作者头像
    [cell setClickUserImageBlock:^{
        [weakSelf clickUserImageWithUserId:weakSelf.videoInfo[@"video_owner"]];
    }];
    
    return cell;
}

/**
 *  videoCell
 */
- (UITableViewCell *)videoCell{
    UITableViewCell * cell = [self.videoDetailTable dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"cell1"];
    }
    cell.opaque = YES;
    cell.contentView.opaque = YES;
    self.playView.frame = CGRectMake(0, 0, ISScreen_Width, self.videoViewHeight);
    self.playView.controlView.fullScreenBtn.selected = NO;
    [cell.contentView addSubview:self.playView];
    return cell;
}

/**
 *  评论cell
 */
- (UITableViewCell *)commentCellWithIndex:(NSIndexPath *)indexPath{
    
    //如果没有数据时显示的cell
    if (self.commentMuArray.count == 0) {
        return [DefaultTableViewCell DefaultTableViewCellWithTable:self.videoDetailTable
                                                             Title:@"暂无评论\n快快抢沙发呦"];
    }
    
    //如果不是在目标区域附近时，显示地图cell
    if (!self.isNearby) {
        return [MapTableViewCell MapTableViewCellWithTable:self.videoDetailTable
                                               ResuableStr:resuableStr];
    }
    
    CommentTableViewCell * cell =
    [CommentTableViewCell CommentTableViewCellWithCellSuperTable:self.videoDetailTable
                                                     CommentInfo:self.commentMuArray[indexPath.row]
                                                           Index:indexPath];
    cell.commentContentLabelHeight.constant = [self.commentCellHeightMuArray[indexPath.row] floatValue] - 40;
    
    //点击评论用户头像
    WEAKSELF2
    [cell setClickUserImage:^(NSString * commentUserId) {
        [weakSelf clickUserImageWithUserId:commentUserId];
    }];
    
    //评论长按手势
    [cell setLongGestureBlock:^(MovierDCInterfaceSvc_vpVideoComment * commentInfo,
                                NSIndexPath * cellIndex) {
        [weakSelf longGestureWithCommentInfo:commentInfo Index:cellIndex];
    }];
    return cell;
}

/**
 *  点赞照做等cell
 */
- (OperationTableViewCell *)operationCell{
    OperationTableViewCell * cell = [OperationTableViewCell OperationTableViewCellWithTable:self.videoDetailTable
                                                                                   CellInfo:self.videoInfo];
    //分享
    WEAKSELF2
    [cell setShareBlock:^{
        
        [CustomeClass mainQueue:^{
            [weakSelf shareVideo];
        }];
    }];
    
    //一键照做
    [cell setFollowMakeBlock:^{
        
        [CustomeClass mainQueue:^{
            [weakSelf followMakeVideo];
        }];
    }];
    
    //显示登录注册页面
    [cell setNoLoginBlock:^{
        
        [CustomeClass mainQueue:^{
            [weakSelf showLoginAndRegisterWindow];
        }];
    }];
    
    //更新点赞数量
    [cell setUpdatePraiseBlock:^(NSInteger praiseNum) {
        [weakSelf.videoInfo setObject:[NSString stringWithFormat:@"%ld", praiseNum] forKey:@"video_praise"];
    }];
    
    //更新收藏数量
    [cell setUpdateCollectBlock:^(NSInteger collectNum) {
        [weakSelf.videoInfo setObject:[NSString stringWithFormat:@"%ld", collectNum] forKey:@"video_favoritesnum"];
    }];
    
    return cell;
}

/**
 *  如果是当前登录用户的新影片，修改观看状态
 */
- (void)updateReadStatus{
    WEAKSELF(weakSelf);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[VideoDBOperation Singleton] updateNewVideoReadStatus:[NSString stringWithFormat:@"%@", weakSelf.videoInfo[@"video_id"]]];
    });
}

- (void)setShareContent{
    
    WEAKSELF2
    [CustomeClass backgroundAsyncQueue:^{
        
        //shareTitle
        weakSelf.shareTitle = weakSelf.videoInfo[@"video_name"];
        
        //shareUrl
        weakSelf.shareUrl = [[NSString alloc] initWithFormat:@"http://www.inshowtv.com/play/%@", weakSelf.videoInfo[@"video_id"]];
        
        //shareUrlResource
        weakSelf.shareUrlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeVideo
                                                                                 url:weakSelf.shareUrl];
        
        //显示图文分享按钮
        weakSelf.isShowTuwenButton = YES;
        
        //设置videoinfoDictionary
        weakSelf.videoInfoDictionary = weakSelf.videoInfo;
    }];
}

- (void)shareTapMethodWithIndex:(NSInteger)index URL:(NSString *)url Title:(NSString *)title UrlResource:(UMSocialUrlResource *)urlResource ShareImage:(UIImage *)shareImage{
    [super shareTapMethodWithIndex:index
                               URL:url
                             Title:title
                       UrlResource:urlResource
                        ShareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:STRTOUTF8(self.videoInfoDictionary[@"video_thumbnail"])]]]];
}

- (void)hiddenLoginAndRegisterWindow:(NSNotification *)noti{
    [super hiddenLoginAndRegisterWindow:noti];
    [self.playView play];
}

- (void)showLoginAndRegisterWindow{
    [super showLoginAndRegisterWindow];
    [self.playView pause];
}

/** 增加观看次数*/
- (void)addVisitConunt{
    WEAKSELF2
    [[SoapOperation Singleton] WS_IncreaseVisit:[NSNumber numberWithInt:[self.videoInfo[@"video_id"] intValue]]
                                        Success:^(NSNumber *num) {
        [Video Singleton].videoPlayCount = [NSString stringWithFormat:@"%@", num];
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf addVisitConunt];);
    }];
}

/** 防止侧滑时键盘遮挡view的通知*/
- (void)showKB:(NSNotification *)noti{
    [UIView animateWithDuration:0.36 animations:^{
        self.videoDetailTable.frame = CGRectMake(0,
                                                 0,
                                                 ISScreen_Width,
                                                 ISScreen_Height - 64 - 44 - self.currentKeyboardHeight);
        self.inputView.frame = CGRectMake(0,
                                          self.videoDetailTable.frame.size.height,
                                          ISScreen_Width,
                                          44);
    }];
}

/** 播放*/
- (void)playVideo{
    if (!self.playView.controlView.startBtn.selected) {
        //此时是暂停状态，需要播放
        [self.playView startAction:self.playView.controlView.startBtn];
    }
}

/** 暂停*/
- (void)pauseVideo{
    if (self.playView.controlView.startBtn.selected) {
        [self.playView startAction:self.playView.controlView.startBtn];
    }
}

/** 从全屏返回到在cell上播放的通知方法*/
- (void)restorePlayView:(NSNotification *)noti{
    [[UIApplication sharedApplication] setStatusBarHidden:NO
                                            withAnimation:UIStatusBarAnimationFade];
    [self restore];
}

/** 首次点击全屏按钮时判断需要竖屏播放时执行该方法*/
- (void)porpaitFullScreen:(NSNotification *)noti{
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
    self.playView.frame = CGRectMake(0, 0, ISScreen_Width, ISScreen_Height);
    [self.view addSubview:self.playView];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = [UIColor blackColor];
    self.videoDetailTable.hidden = YES;
    self.inputView.hidden = YES;
}

/** 屏幕旋转的回调*/
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        
        //正常
        self.playView.frame = CGRectMake(0 , 0, ISScreen_Height, ISScreen_Width);
    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        
        [self setFullScreen];
    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft){
        [self setFullScreen];
    }
}

/** 恢复原来在cell上播放视频的状态*/
- (void)restore{
    [[UIApplication sharedApplication] setStatusBarHidden:NO
                                            withAnimation:UIStatusBarAnimationFade];
    self.inputView.frame = CGRectMake(0, ISScreen_Height - 64 - 44, ISScreen_Width, 44);
    [self.playView removeOperationGesture];
    CANNOTSCALE
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.playView removeFromSuperview];
    self.videoDetailTable.hidden = NO;
    self.inputView.hidden = NO;
    [self.videoDetailTable reloadData];
}

/** 设置播放器全屏*/
- (void)setFullScreen{
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
    [self.view endEditing:YES];
    [self.playView addOperationGesture];
    self.playView.controlView.backBtn.hidden = NO;
    self.playView.controlView.fullScreenBtn.selected = YES;
    self.view.backgroundColor = [UIColor blackColor];
    self.playView.frame = CGRectMake(0,
                                     0,
                                     ISScreen_Height > ISScreen_Width ? ISScreen_Height : ISScreen_Width,
                                     ISScreen_Height > ISScreen_Width ? ISScreen_Width : ISScreen_Height);
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.videoDetailTable.hidden = YES;
    self.inputView.hidden = YES;
    [self.view addSubview:self.playView];
}

/** 返回按钮点击方法*/
- (void)backButtonAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

/** 评论长按手势*/
- (void)longGestureWithCommentInfo:(MovierDCInterfaceSvc_vpVideoComment *)commentInfo
                             Index:(NSIndexPath *)commentIndex{
    self.deleteCommentInfo = commentInfo;
    self.deleteCommentIndexPath = commentIndex;
    
    //自己的是删除，他人是举报
    if ([[NSString stringWithFormat:@"%@", commentInfo.nCustomerID] isEqualToString:CURRENTUSERID]) {
        
        //删除评论
        [self showAcitonSheetWithTitle:@"删除" Title2:nil Tag:222222];
    }else{
        
        //举报评论
        [self showAcitonSheetWithTitle:@"举报" Title2:nil Tag:333333];
    }
}

/** 删除评论*/
- (void)deleteComment{
    [self showAlertWithTag:555555 Message:@"确定删除吗？"];
}

/** 隐藏键盘*/
- (void)hiddenKeyboard:(UITapGestureRecognizer *)tap{
    [self removeKeyBoardGesture];
    [self.view endEditing:YES];
}

/** 添加隐藏键盘手势*/
- (void)addHiddenKeyBoardGesture{
    if (self.keyboardHiddenGesture && (self.keyboardHiddenGesture.view == self.view)) {
        return;
    }
    
    //键盘退出手势
    self.keyboardHiddenGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(hiddenKeyboard:)];
    self.videoDetailTable.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:self.keyboardHiddenGesture];
}

/** 移除键盘退出手势*/
- (void)removeKeyBoardGesture{
    [self.view removeGestureRecognizer:self.keyboardHiddenGesture];
}

/** 导航栏右侧按钮点击方法*/
- (void)rightBarItemAction{
    
    //如果键盘出来了，就隐藏
    [self.view endEditing:YES];
    
    //判断是显示收藏还是取消收藏或者公开还是仅自己可见
    if ([self.videoInfo[@"video_owner"] isEqualToString:CURRENTUSERID]) {
        
        //是当前登录用户的影片
        //判断显示是仅自己可见还是公开（0 --- 私有，1 --- 公有）
        NSString * actionSheetTitle = @"";
        if ([self.videoInfo[@"video_share"] boolValue]) {
            
            //当前是公开状态
            actionSheetTitle = @"仅自己可见";
        }else{
            actionSheetTitle = @"公开";
        }
        [self showAcitonSheetWithTitle:actionSheetTitle Title2:@"删除" Tag:111111];
    }else{
        [self showAcitonSheetWithTitle:@"举报" Title2:nil Tag:444444];
    }
}

/** 弹出actionsheet*/
- (void)showAcitonSheetWithTitle:(NSString *)actionTitle
                          Title2:(NSString *)actionTitle2
                             Tag:(NSInteger)actionSheetTag{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择"
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:actionTitle
                                                     otherButtonTitles: [actionTitle2 length] > 0 ?
                                                                        actionTitle2 : nil, nil];
    actionSheet.tag = actionSheetTag;
    [actionSheet showInView:self.view];
}
/** 弹出alertView*/
- (void)showAlertWithTag:(NSInteger)alertTag Message:(NSString *)messageStr{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                         message:messageStr
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:@"确定", nil];
    alertView.tag = alertTag;
    [alertView show];
}

/** 点击头像方法*/
- (void)clickUserImageWithUserId:(NSString *)userId{
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
        [self showLoginAndRegisterWindow];
        return;
    }
    
    MyVideoViewController * videoVc = [MyVideoViewController new];
    if (![userId isEqualToString:CURRENTUSERID]) {
        videoVc.isShowOtherUserVideo = YES;
        videoVc.userId = userId;
    }
    [self.navigationController pushViewController:videoVc animated:YES];
}

/** 关注点击方法*/
- (void)followVideoOwer{
    WEAKSELF(weakSelf);
    [[SoapOperation Singleton] WS_followWithCustomID:[weakSelf.videoInfo objectForKey:@"video_owner"]
                                             Success:^(NSNumber *num) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomeClass showMessage:@"关注成功" ShowTime:2];
        });
    } Fail:^(NSError *error) {
        DEBUGLOG(error);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error.code == 42) {
                [CustomeClass showMessage:@"关注成功" ShowTime:1.5];
            }else{
                [CustomeClass showMessage:@"关注失败" ShowTime:1.5];
            }
        });
    }];
}

/** 检测输入内容是否合法*/
- (void)sendManageWithContent:(NSString *)content{
    
    if (![UserEntity sharedSingleton].isAppHasLogin) {
        [self showLoginAndRegisterWindow];
        return;
    }
    
    NSMutableString * muContent = [[NSMutableString alloc] initWithString:content];
    
    NSString * noSpaceStr = [muContent stringByReplacingOccurrencesOfString:@" "
                                                                 withString:@""];
    
    //过滤特殊字符
    NSString * filterStr = [CustomeClass filterStringWithStr:noSpaceStr];
    
    if (filterStr.length == 0) {
        [CustomeClass showMessage:@"输入内容不合法" ShowTime:1.5];
    }else{
        [self sendCommentWithContent:content];
    }
}

/** 向后台发送回复或者评论*/
- (void)sendCommentWithContent:(NSString *)content{
    
    NSString * commentId = @"0";
    
    if (self.commentInfo && [content containsString:self.commentInfo.szNickname]) {
        commentId = [NSString stringWithFormat:@"%@", self.commentInfo.nCustomerID];
    }
    
    WEAKSELF(weakSelf);
    SoapOperation *ws = [SoapOperation Singleton];
    [ws WS_SubmitCommentByid:[NSNumber numberWithInteger:[self.videoInfo[@"video_id"] intValue]]
                     Session:nil
                       Reply:[NSNumber numberWithInt:[commentId intValue]]
                     Content:content
                     Success:^{
                         
        // 更新数据----全部刷新, 从0开始
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([commentId intValue] != 0) {
                
                //回复
                [CustomeClass showMessage:@"回复成功" ShowTime:1.5];
                
            }else{
                [CustomeClass showMessage:@"评论成功" ShowTime:1.5];
            }
            [weakSelf downloadCommentWithStart:0];
        });
    } Fail:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([commentId intValue] != 0) {
                
                //回复
                [CustomeClass showMessage:[NSString stringWithFormat:@"回复失败（%lu）", error.code] ShowTime:1.5];
                
            }else{
                [CustomeClass showMessage:[NSString stringWithFormat:@"评论失败（%lu）", error.code] ShowTime:1.5];
            }
            
        });
        DEBUGLOG(error);
        
    }];
}

/** 下载评论*/
- (void)downloadCommentWithStart:(NSInteger)dataStart{
    WEAKSELF2
    [CustomeClass HUDshow:self.view Tag:123456789];
    
    // 根据视频 id, 加载对应的评论
    [[SoapOperation Singleton] WS_GetCommentsByVideoid:[NSNumber numberWithInt:
                                                        [self.videoInfo[@"video_id"] intValue]]
                                                 Start:@(dataStart)
                                                 Count:@(66)
                                               Success:^(MovierDCInterfaceSvc_vpVideoCommentArr* comments) {
                                                   [CustomeClass HUDhidden:weakSelf.view Tag:123456789];
                                                   
        if (dataStart == 0) {
            [weakSelf.commentMuArray removeAllObjects];
            [weakSelf.commentCellHeightMuArray removeAllObjects];
        }
        for (MovierDCInterfaceSvc_vpVideoComment * commentInfo in comments.item) {
            CGSize contentSize =
            [commentInfo.szContent boundingRectWithSize:CGSizeMake(ISScreen_Width / 2, MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:ISFont_12}
                                                context:nil].size;
            [weakSelf.commentCellHeightMuArray addObject:@(44 + contentSize.height)];
        }
        [weakSelf.commentMuArray addObjectsFromArray:[comments.item copy]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.videoDetailTable footerEndRefreshing];
            if (comments.item.count == 0) {
                [weakSelf.videoDetailTable removeFooter];
                [CustomeClass showMessage:@"没有更多数据了" ShowTime:1.5];
            }
            if (comments.item.count < 66) {
                [weakSelf.videoDetailTable removeFooter];
            }
            [weakSelf.videoDetailTable reloadSections:[NSIndexSet indexSetWithIndex:3]
                                     withRowAnimation:UITableViewRowAnimationNone];
        });
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf downloadCommentWithStart:dataStart];);
    }];
}

/** 分享视频*/
- (void)shareVideo{
    
    [self.view endEditing:YES];
    
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
        [self showLoginAndRegisterWindow];
        return;
    }
    
    //展示自定义界面
    [self showShareView];
}

/**
 *  重写图文分享
 */
- (void)tuwenShare{
    if (self.isFormTuwenVc) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [super tuwenShare];
    }
}

#pragma mark - 照做

/** 一键照做*/
- (void)followMakeVideo{
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
        [self showLoginAndRegisterWindow];
        return;
    }
    
//    if ([self.videoInfo[@"arid"] boolValue]) {
//        
//        //是带ar的影片
//        //执行ar照做
//        //如果不在规定位置，就显示地图
//        //先启动地理位置进行判断
//        [SINGLETON(locationManager) startGetLocationInfo];
//        
//    }else{
        [self followAction];
//    }
}

/**
 *  照做
 */
- (void)followAction{
    //照做，video已获得headandtailid
    //正在制作订单的素材数量为空  或 不为空
    NewNSOrderDetail *orderDetail = [MC_OrderAndMaterialCtrl GetFreshOrder:[CURRENTUSERID intValue]];
    
    //获取素材数组
    NSMutableArray * materialArray = [MC_OrderAndMaterialCtrl GetMaterial:[CURRENTUSERID intValue] Orderid:orderDetail.order_id];
    
    if ([materialArray count] > 0) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                              message:@"是否使用原有素材？"
                                                             delegate:self
                                                    cancelButtonTitle:@"确定"
                                                    otherButtonTitles:@"取消", nil];
        myAlertView.tag = 10;
        [myAlertView show];
    }else{
        [self presentCreatePage];
    }
}

/**
 *  位置通知
 */
- (void)getLocationInfo:(NSNotification *)noti{
    if ([self.navigationController.topViewController isEqual:self]) {
        CLLocationDegrees latitude = [noti.userInfo[locationLatitudeInfo] doubleValue];
        CLLocationDegrees longitude = [noti.userInfo[locationLongitudeInfo] doubleValue];
        CLLocationCoordinate2D locationCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
        [self judgeLocation:locationCoordinate];
    }
}

/**
 *  展示用户不在区域内的提示
 */
- (void)showPropmt{
    WEAKSELF2
    MAINQUEUEUPDATEUI({
        weakSelf.propmtView.hidden = NO;
    })
}

- (void)hiddenPropmt{
    WEAKSELF2
    MAINQUEUEUPDATEUI({
        weakSelf.propmtView.hidden = YES;
    })
}

/**
 *  判断用户的位置
 */
- (void)judgeLocation:(CLLocationCoordinate2D)locationCoor{
    //test 此时使用的是测试经纬度
    WEAKSELF2
    
    //116.332289，39.978503
    [[SoapOperation Singleton] getARWhenTakeVideoWithType:3 Longitude:116.332289 Latitude:39.978503 Radius:100 Success:^(NSMutableDictionary *serverDataDictionary) {
        
        //关闭定位
        [[locationManager shareInstance] stopGetLocationInfo];
        
        //在区域内
        DEBUGSUCCESSLOG(@"在规定区域内")
        MAINQUEUEUPDATEUI({
            [weakSelf followAction];
        })
        
    } Fail:^(NSError *error) {
        if (error.code == 51) {
            DEBUGSUCCESSLOG(@"不在规定区域内")
            weakSelf.isNearby = NO;
            MAINQUEUEUPDATEUI({
                [weakSelf.videoDetailTable reloadSections:[NSIndexSet indexSetWithIndex:3]
                                         withRowAnimation:UITableViewRowAnimationFade];
            })
        }else {
            RELOADSERVERDATA([weakSelf judgeLocation:locationCoor];);
        }
    }];
}

/** 跳转创建页面*/
- (void)presentCreatePage{
    WEAKSELF(weakSelf);
    [[SoapOperation Singleton]
     WS_GetStylebyVideoId:@([self.videoInfo[@"video_id"] intValue])
                  Success:^(MovierDCInterfaceSvc_vpVDCHeaderAndTailExC *headerAndTail) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //数据库订单数据填充
                            NewNSOrderDetail *fresh = [MC_OrderAndMaterialCtrl
                            GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
                            fresh.nHeaderAndTailID = [headerAndTail.nID intValue];
                            fresh.orderType = generalFollowOrder;
                            fresh.followVideoId = weakSelf.videoInfo[@"video_id"];
                            [MC_OrderAndMaterialCtrl updateFollowVideoIdWithOrder:fresh];
                            [MC_OrderAndMaterialCtrl UpdateFresh:fresh];
                            ISCutProViewController *cut =
                            [[UIStoryboard storyboardWithName:@"Preview"
                                                       bundle:nil]
                      instantiateViewControllerWithIdentifier:@"ISCutProRechoose_ID"];
                            //使用返回键
                            cut.isTransFromPreview = YES;
                            //下一步直接跳转preview界面
                            cut.next2Preview = YES;
                            
                            //是一键照做
                            cut.isFollowOrder = YES;
                            ISStyleDetail *style = [[ISStyleDetail alloc] init];
                            style.nID = headerAndTail.nID;
                            style.nHeaderAndTailStyle = headerAndTail.nHeaderAndTailStyle;
                            style.videoUrl = headerAndTail.szReference;
                            style.title = headerAndTail.szName;
                            style.visitCount = headerAndTail.nHotIndex;
                            style.thumbnail = headerAndTail.szThumbnail;
                            style.intro = headerAndTail.szDesc;
                            style.sence = headerAndTail.szFit;
                            style.szCreateTime = headerAndTail.szCreateTime;
                            cut.styleDetail = style;
                            //storyboard加载时默认值是NO
                            cut.HideTabbar = YES;
                            [weakSelf.navigationController pushViewController:cut
                                                                     animated:YES];
                            });
                        } Fail:^(NSError *error) {
                            RELOADSERVERDATA([weakSelf presentCreatePage];);
                        }];
}

/** 键盘变化*/
- (void)keyboardChange:(NSNotification *)noti{
    CGSize keyboardSize = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    if (self.inputView.editStatus == beginEdit && keyboardSize.height > 0) {
        self.currentKeyboardHeight = keyboardSize.height;
    }
    
    [self changeFrameWithKBSize];
}

/** 根据键盘高度改变frame*/
- (void)changeFrameWithKBSize{
    [UIView animateWithDuration:0.3 animations:^{
        if (self.inputView.editStatus == beginEdit) {
            [self addHiddenKeyBoardGesture];
            self.videoDetailTable.frame = CGRectMake(0,
                                                     0,
                                                     ISScreen_Width,
                                                     ISScreen_Height - 64 - 44 - self.currentKeyboardHeight);
            self.inputView.frame = CGRectMake(0,
                                              self.videoDetailTable.frame.size.height,
                                              ISScreen_Width,
                                              44);
        }else{
            self.videoDetailTable.frame = CGRectMake(0,
                                                     0,
                                                     ISScreen_Width,
                                                     ISScreen_Height - 64 - 44);
            self.inputView.frame = CGRectMake(0,
                                              self.videoDetailTable.frame.size.height,
                                              ISScreen_Width,
                                              44);
        }
    }];
}

/** 滑动到底部*/
- (void)scroToBottom{
    NSIndexPath * scrollIndexPath;
    if (self.commentMuArray.count > 0) {
        scrollIndexPath = [NSIndexPath indexPathForRow:self.commentMuArray.count - 1 inSection:3];
    }else{
        scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    }
    [self.videoDetailTable scrollToRowAtIndexPath:scrollIndexPath
                                 atScrollPosition:UITableViewScrollPositionBottom
                                         animated:YES];
}

/** 删除视频*/
- (void)deleteVideo{
    
    //如果这是新影片，但是还未收到消息，用户就删除了，需要调用这个方法，防止消息提示出错
    [MessageObj saveUserDeleteNewVideoWithVideoID:self.videoInfo[@"video_id"]
                                   VideoLabelName:self.videoInfo[@"video_name"]
                                       CreateTime:self.videoInfo[@"video_createtime"]
                                     VideoThumail:self.videoInfo[@"video_thumbnail"]
                                         VideoURL:self.videoInfo[@"video_reference"]];
    
    WEAKSELF(weakSelf);
    int videoID = [self.videoInfo[@"video_id"] intValue];
    [[SoapOperation Singleton] WS_DeleteVideo:@(videoID) Success:^(NSNumber *num) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf deleteVideo];);
    }];
}

/** 删除评论*/
- (void)deleteCommentAndReloadTable{
    WEAKSELF(weakSelf);
    
    // 删除
    SoapOperation *soap = [SoapOperation Singleton];
    [soap WS_RemoveCommentByid:self.deleteCommentInfo.nCommentID Session:nil Success:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 删除表格中的数据, 刷新表格
            [weakSelf.commentMuArray removeObjectAtIndex:self.deleteCommentIndexPath.row];
            [weakSelf.videoDetailTable reloadSections:[NSIndexSet indexSetWithIndex:3]
                                     withRowAnimation:UITableViewRowAnimationNone];
            [weakSelf.videoDetailTable reloadSections:[NSIndexSet indexSetWithIndex:2]
                                     withRowAnimation:UITableViewRowAnimationNone];
            [CustomeClass showMessage:@"删除成功" ShowTime:1.5];
        });
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf deleteCommentAndReloadTable];);
    }];
}

/**  举报评论 */
- (void)reportComment{
    if (![UserEntity sharedSingleton].isAppHasLogin) {
        [self showLoginAndRegisterWindow];
        return;
    }
    
    HomeVideoReportCommentViewController *reportComment = [[HomeVideoReportCommentViewController alloc] initWithNibName:@"HomeVideoReportCommentViewController"
                                                                                                                 bundle:nil];
    reportComment.commentID = [NSNumber numberWithInt:[self.deleteCommentInfo.nCommentID intValue]];
    [self.navigationController pushViewController:reportComment animated:YES];
}

/** 举报视频*/
- (void)reportCurrentVideo {
    
    if (![UserEntity sharedSingleton].isAppHasLogin) {
        [self showLoginAndRegisterWindow];
        return;
    }
    
    // 进入举报界面
    HomeVideoReportViewController *report =
    [[HomeVideoReportViewController alloc] initWithNibName:@"HomeVideoReportViewController"
                                                    bundle:nil];
    [self.navigationController pushViewController:report animated:YES];
}

/** 改变视频公开状态*/
- (void)changeVideoShareStatus{
    WEAKSELF(weakSelf);
    BOOL shareStatus = [self.videoInfo[@"video_share"] boolValue];
    [self.videoInfo setObject:[NSString stringWithFormat:@"%d", !shareStatus]
                       forKey:@"video_share"];
    [[SoapOperation Singleton] WS_ChangeVideoStatus:@([self.videoInfo[@"video_id"] intValue])
                                             Status:!shareStatus
                                            Success:^(NSNumber *num) {
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf changeVideoShareStatus];);
    }];
}

#pragma mark - 懒加载
/** 播放器高度*/
- (CGFloat)videoViewHeight{
    if (!_videoViewHeight) {
        NSString * resolution = self.videoInfo[@"resolution"];
        if (resolution.length == 0) {
            _videoViewHeight = ISScreen_Width / 30 * 17;
        }else{
            NSArray * resolutionArray = [resolution componentsSeparatedByString:@":"];
            float width = [resolutionArray[0] floatValue];
            float height = [resolutionArray[1] floatValue];
            
            CGFloat videoViewW = ISScreen_Width;
            CGFloat videoViewH = videoViewW / width * height;
            if (videoViewH >= ISScreen_Height - 108) {
                videoViewH = ISScreen_Height - 108 - 88;
            }
            _videoViewHeight = videoViewH;
        }
    }
    return _videoViewHeight;
}

/** 评论数据源*/
- (NSMutableArray *)commentMuArray{
    if (!_commentMuArray) {
        _commentMuArray = [NSMutableArray new];
    }
    return _commentMuArray;
}

/** 输入框部分*/
- (InputView *)inputView{
    if (!_inputView) {
        _inputView = [[InputView alloc] init];
        _inputView.frame = CGRectMake(0, ISScreen_Height - 64 - 44, ISScreen_Width, 44);
        WEAKSELF2
        [_inputView setSendInputContentBlock:^(NSString * content) {
            [weakSelf sendManageWithContent:content];
        }];
    }
    return _inputView;
}

/** 播放器*/
- (ZFPlayerView *)playView{
    if (!_playView) {
        _playView = [[ZFPlayerView alloc]
                     initWithFrame:CGRectMake(0,
                                              0,
                                              ISScreen_Width,
                                              self.videoViewHeight)];
        
        _playView.videoURL = [NSURL
                              URLWithString:STRTOUTF8(self.videoInfo[@"video_reference"])];
        _playView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
        _playView.hasDownload = NO;
        _playView.controlView.backBtn.hidden = YES;
        _playView.isLocked = YES;
        ZFPlayerShared.isLockScreen = YES;
        _playView.controlView.fullScreenBtn.selected = NO;
        NSString *str1 = [NSString stringWithFormat:@"%.0f", self.videoViewHeight];
        NSString *str2 = [NSString stringWithFormat:@"%.0f", ISScreen_Width];
        
        if (!([str1 integerValue] < [str2 integerValue])) {
            _playView.isPorPrait = YES;
        }
        
        [_playView autoPlayTheVideo];
//        if ([self.videoInfo[@"activity"] boolValue]) {
//            [_playView.controlView.arView showARWithVideoId:self.videoInfo[@"video_id"]];
//        }else{
            [_playView.controlView.arView.arRewardView.arPropertyImage removeFromSuperview];
            [_playView.controlView.arView.arRewardView.chestImage removeFromSuperview];
            [_playView.controlView.arView.arRewardView.virtualElectricImage removeFromSuperview];
            [_playView.controlView.arView.arRewardView.propmtImage removeFromSuperview];
            [_playView.controlView.arView.arRewardView.couponImage removeFromSuperview];
//        }
    }
    return _playView;
}

/** 界面table*/
- (UITableView *)videoDetailTable{
    if (!_videoDetailTable) {
        _videoDetailTable = [[UITableView alloc]
                             initWithFrame:CGRectMake(0,
                                                      0,
                                                      ISScreen_Width,
                                                      ISScreen_Height - 64 - 44)
                             style:UITableViewStylePlain];
        _videoDetailTable.delegate = self;
        _videoDetailTable.dataSource = self;
        _videoDetailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_videoDetailTable];
        _videoDetailTable.showsVerticalScrollIndicator = NO;
        _videoDetailTable.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _videoDetailTable.opaque = YES;
        
        //注册cell
        [_videoDetailTable registerNib:[UINib nibWithNibName:@"CommentTableViewCell"
                                                      bundle:[NSBundle mainBundle]]
                forCellReuseIdentifier:@"CommentTableViewCell"];
        [_videoDetailTable registerNib:[UINib nibWithNibName:@"OperationTableViewCell"
                                                      bundle:[NSBundle mainBundle]]
                forCellReuseIdentifier:@"OperationTableViewCell"];
        [_videoDetailTable registerNib:[UINib nibWithNibName:@"VideoDetailUserInfoTableViewCell"
                                                      bundle:[NSBundle mainBundle]]
                forCellReuseIdentifier:@"VideoDetailUserInfoTableViewCell"];
        [_videoDetailTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
        [_videoDetailTable registerNib:[UINib nibWithNibName:resuableStr bundle:nil]
                forCellReuseIdentifier:resuableStr];
        _videoDetailTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        WEAKSELF2
        [_videoDetailTable addFooterWithCallback:^{
            [weakSelf downloadCommentWithStart:weakSelf.commentMuArray.count];
        }];
        [self.view addSubview:self.inputView];
    }
    return _videoDetailTable;
}

/** 评论cell高度数据源*/
- (NSMutableArray *)commentCellHeightMuArray{
    if (!_commentCellHeightMuArray) {
        _commentCellHeightMuArray = [NSMutableArray new];
    }
    return _commentCellHeightMuArray;
}

- (PropmtView *)propmtView{
    if (!_propmtView) {
        WEAKSELF2
        _propmtView = [[PropmtView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_propmtView];
        [_propmtView setTouchBlock:^{
            [weakSelf hiddenPropmt];
        }];
    }
    return _propmtView;
}
@end
