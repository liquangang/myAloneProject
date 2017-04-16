 //
//  HomeVideoDetailViewController.m
//  M-Cut
//
//  Created by 李亚飞 on 15/11/20.
//  Copyright © 2015年 Crab movier. All rights reserved.
//
/**  iPhone4  */
#define iPhone4         CGSizeEqualToSize(CGSizeMake(640, 960), [UIScreen mainScreen].currentMode.size)
/**  iPhone5_5S_5C  */
#define iPhone5_5S_5C   CGSizeEqualToSize(CGSizeMake(640, 1136), [UIScreen mainScreen].currentMode.size)
/**  iPhone6_6S  */
#define iPhone6_6S      CGSizeEqualToSize(CGSizeMake(750, 1334), [UIScreen mainScreen].currentMode.size)
/**  iPhone6_6SPlus  */
#define iPhone6_6SPlus  CGSizeEqualToSize(CGSizeMake(1125, 2001), [UIScreen mainScreen].currentMode.size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [UIScreen mainScreen].currentMode.size) || CGSizeEqualToSize(CGSizeMake(1080, 1920), [UIScreen mainScreen].currentMode.size)

#import "HomeVideoDetailViewController.h"
#import "TelephoneViewController.h"
#import "MovieDetailPreviewViewController.h"
#import "PerfectPersonalInfoViewController.h"
#import "HomeVideoDetailViewController.h"   // 替换 MovieDetailPreviewViewController.h
#import "UpdateSql.h"
#import "ShareViewController.h"
#import "LoginViewController.h"
//#import "UMSocial.h"
#import "APPUserPrefs.h"
// 评论的 cell
#import "ISVideoReviewCell.h"
#import "MJRefresh.h"
#import "ISPlaceholderTextView.h"
#import "SoapOperation.h"
#import "MC_LabelsCtrl.h"

#import "VideoComment.h"
// 计算时间的分类
#import "NSString+Date.h"
#import "HomeVideoReportViewController.h"
#import "HomeVideoReportCommentViewController.h"
#import "UIButton+WebCache.h"
// 点击评论头像, 跳转到其他个人界面
#import "OtherPeopleViewController.h"
#import "MBProgressHUD+MJ.h"
#import "HomeBannerWebViewController.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "ISCutProViewController.h"
#import "ISStyleDetailCell.h"
#import <WebKit/WebKit.h>
#import "CustomeClass.h"
#import "ISConst.h"
#import "MyVideoViewController.h"

#define MaxInputNumber 110

#define First @"带有色情内容或敏感话题"
#define Second @"涉嫌盗用他人作品"
#define Three @"自主描述"
#define Four @"确定举报这段视频吗?"

//隐藏tabbar
#define ISHideTabbar                            @"hide userdefault tabbar"

@interface HomeVideoDetailViewController () <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, ISVideoReviewCellDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *collectNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
/**  评论视图 */
@property (weak, nonatomic) IBOutlet UITableView *reviewTableView;
/**  存放评论 Frame 模型 */
@property (strong, nonatomic) NSMutableArray *comments;
/**  评论时间Label长度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoCreateTimeLabelWidth;
/**  评论 label 所在的 view */
@property (weak, nonatomic) IBOutlet UIView *reView;
// 评论的条数
@property (weak, nonatomic) IBOutlet UILabel *reviewCountLabel;
/**  分享 view */
@property (weak, nonatomic) IBOutlet UIView *shareView;
/**  评论视图 */
@property (weak, nonatomic) IBOutlet UIView *commentView;
/**  评论文本框 */
@property (weak, nonatomic) IBOutlet ISPlaceholderTextView *textView;
/**  用户当前输入的文字个数 */
@property (weak, nonatomic) IBOutlet UILabel *currentInputNumLabel;
/**  点赞数量label */
@property (retain,nonatomic) IBOutlet UILabel *videoNumberOfPraiseLabel;
/**  点赞数量label 的宽度约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoPraiseLabelWidth;

/**  视频点赞状态, 0: 用户没有登录;     1:点赞;   2:没有点赞  */
@property (assign, nonatomic) int videoPraiseState;

@property (weak, nonatomic) IBOutlet UIButton *redo;

/**  评论视图距离底部的约束, 用来设置键盘弹出和消失时, 输入框和底部的距离 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewButtom;

/**  加载评论的开始位置 */
@property (assign, nonatomic) int commentStartPos;
/**  标记当前登录用户是否收藏当前视频 */
@property (assign, nonatomic) BOOL isColletionCurrentVideo;

/**  视频收藏, 举报的弹框 */
@property (weak, nonatomic) UIActionSheet *videoSheet;
/**  删除自己评论的弹框 */
@property (weak, nonatomic) UIActionSheet *deleteCommentSheet;
/**  举报他人评论的弹框 */
@property (weak, nonatomic) UIActionSheet *reportCommentSheet;

/**  确定删除的弹框 */
@property (weak, nonatomic) UIAlertView *deleteCommentAlert;
/**   记录当前点击的评论 id */
@property (strong, nonatomic) NSNumber *currentCommentID;
/**  评论次数 */
@property (assign, nonatomic) int commentCount;
/**  记录当前点击的评论所在的 tableview 的 indexPath */
@property (strong, nonatomic) NSIndexPath *indexPath;
/**  奖券失败的回调次数 */
@property(nonatomic)NSInteger getcoupontime;

/**  视频播放器*/
@property (weak, nonatomic) IBOutlet UIView *videoPlayerView;
/**  前一个长按得userid*/
@property (nonatomic, assign) int longTapUserId;
/**  回复的用户nickname*/
@property (nonatomic, copy) NSString * currentReplyUserNickName;
/**  回复的那个用户的评论id*/
@property (nonatomic, copy) NSString * commentsId;
@property (weak, nonatomic) IBOutlet UIImageView *followImage;

/** 选中的评论的id*/
@property (nonatomic, copy) NSString * selectCommentsId;
@end


@implementation HomeVideoDetailViewController

- (NSMutableArray *)comments {
    if (!_comments) {
        self.comments = [NSMutableArray array];
    }
    return _comments;
}

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"HomeVCPushCollectionIdentifier_segue"]){
    }else if([identifier isEqualToString:@"MyFavouriteIndentifier_segue"]){
    }else if([identifier isEqualToString:@"PersonVCPushDeleteIdentifier_segue"]){
    }
}

-(UIImage *)scaleImage:(UIImage *)img ToSize:(CGSize)itemSize{
    UIImage *i;
    // 创建一个bitmap的context,并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect=CGRectMake(0, 0, itemSize.width, itemSize.height);
    // 绘制改变大小的图片
    [img drawInRect:imageRect];
    // 从当前context中创建一个改变大小后的图片
    i=UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return i;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    clickedable = 0;
    // 初始化开始时加载评论的位置
    self.commentStartPos = 0;
    
    // 设置基本信息
    [self setupInfo];
    [self setupNavigationTitle];
    // 直接获取用户是否收藏过当前影片
    [self isVideoCollection];
    
    // 获取当前用户的点赞状态
    [self getPraiseState];
    // 设置播放器
    [self setupPlayer];
    
    // 加载评论
    [self loadComments];
    
    // 设置评论的数据源和代理
    self.reviewTableView.delegate = self;
    self.reviewTableView.dataSource = self;
    self.reviewTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.reviewTableView addHeaderWithTarget:self action:@selector(addHeader)];
    [self.reviewTableView addFooterWithTarget:self action:@selector(addFooter)];
    
    // 评论输入框
    [self setupTextView];
    
    _getcoupontime = 50;
    
    //判断是否已经关注
    [self followStatus];
    
    //如果该影片是当前登录用户的未观看影片，更新观看状态
    [self updateReadStatus];
}

- (void)updateReadStatus{

    WEAKSELF(weakSelf);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[VideoDBOperation Singleton] updateNewVideoReadStatus:[NSString stringWithFormat:@"%d", weakSelf.videoId]];
    });
}

- (void)followStatus{
    
    //先默认隐藏
    self.followImage.hidden = YES;
    
    if ([[Video Singleton].ownerID isEqualToString:CURRENTUSERID]) {
        self.followImage.hidden = YES;
    }else{
        
        WEAKSELF(weaKself);
        [[SoapOperation Singleton] WS_getfriendrelationWithUserId:[Video Singleton].ownerID Success:^(NSNumber *successInfo) {
            DEBUGSUCCESSLOG(successInfo);
            MAINQUEUEUPDATEUI({
                if ([successInfo intValue] == 1 || [successInfo intValue] == 2) {
                    //隐藏关注按钮
                    weaKself.followImage.hidden = YES;
                }else{
                    weaKself.followImage.hidden = NO;
                }
            })
        } Fail:^(NSError *error) {
            DEBUGLOG(error);
        }];
    }
}

- (void)setupTextView {
    self.textView.delegate = self;
    self.textView.myTextAlignment = NSTextAlignmentCenter;
    self.textView.placeholder = @"快来评论吧";
    self.textView.placeholderColor = ISRGBColor(230, 230, 230);
    self.textView.layer.cornerRadius = 5;
    self.textView.clipsToBounds = YES;
}

- (void)setupNavigationTitle {
    NSString *title = [Video Singleton].videoName;
    if (title.length > 15) {
        title = [title substringToIndex:14];
        title = [NSString stringWithFormat:@"%@...", title];
    }
    self.navigationItem.title = title;
    
    if (self.isPushFromOtherVc == NO) {
        //返回按钮
        UIButton * backBtn = [UIButton new];
        backBtn.frame = CGRectMake(0, 0, 20, 20);
        [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
}

/** 返回按钮点击方法*/
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

//收藏按钮点击方法
- (IBAction)collectButtonAction:(id)sender {
    [self collectCurrentVideo];
}

- (void)enderedFullScreen:(NSNotification *)noti{
    NSLog(@"enderedFullScreen");
}

- (void)exitedFullScreen:(NSNotification *)noti{
    NSLog(@"exitedFullScreen");
    self.navigationController.view.frame = CGRectMake(0, 20, [UIApplication sharedApplication].keyWindow.frame.size.width, [UIApplication sharedApplication].keyWindow.frame.size.height - 20);
    [UIApplication sharedApplication].keyWindow.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_bg"]];
}

/** 头像点击方法*/
- (void)ownerAcatarButtonAction{
    if (self.isPushFromOtherVc == YES) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    // 根据  评论者的 ID(nCustomerID) 跳转到个人详情页
//    OtherPeopleViewController *other = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OthersVCStoryBoardID"];
//    other.customID = [[Video Singleton].ownerID intValue];
//    other.userNickName = [Video Singleton].ownerName;
//    other.iconUrl = [Video Singleton].ownerAcatar;
    MyVideoViewController * videoVc = [MyVideoViewController new];
    if (![[Video Singleton].ownerID isEqualToString:CURRENTUSERID]) {
        videoVc.isShowOtherUserVideo = YES;
        videoVc.userId = [Video Singleton].ownerID;
    }
    [self.navigationController pushViewController:videoVc animated:YES];
}

- (void)setupInfo {
    self.selectCommentsId = @"";
    self.currentReplyUserNickName = @"";
    
    // 头像
    self.ownerAcatarButton.layer.cornerRadius = 15;
    self.ownerAcatarButton.clipsToBounds = YES;
    NSURL *url = [NSURL URLWithString:[Video Singleton].ownerAcatar];
    [self.ownerAcatarButton sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"head"]];
    [self.ownerAcatarButton addTarget:self action:@selector(ownerAcatarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 视频缩略图
    self.videoThumbnailUrlImage.image = [[APPUserPrefs Singleton]APP_getImg:[Video Singleton].videoThumbnailUrl ImageView:self.videoThumbnailUrlImage ImageName:@"huan"];
    self.ownerNameLabel.text = [Video Singleton].ownerName;
    self.videoThumbnailUrlImage.userInteractionEnabled = YES;
    self.videoPlayerView.hidden = YES;
    self.videoPlayerView.backgroundColor = [UIColor redColor];
    
    // 创建时间
    NSString *createTime = [[Video Singleton].videoCreateTime time_isNeedShowYear];
    CGSize timeLabelSize = [createTime sizeWithWidth:MAXFLOAT font:ISFont_13];
    self.videoCreateTimeLabel.text = createTime;
    self.videoCreateTimeLabelWidth.constant = timeLabelSize.width;
    
    // 点赞数量
    NSString *praise = [Video Singleton].videoNumberOfPraise;
    CGSize praiseSize = [praise sizeWithWidth:MAXFLOAT font:ISFont_14];
    if (praiseSize.width > 50) {
        self.videoPraiseLabelWidth.constant = praiseSize.width;
    }
    self.videoNumberOfPraiseLabel.text = praise;
    
    // 播放次数
    NSString *playCount = [Video Singleton].videoPlayCount;
    NSInteger count = [playCount integerValue];
    if (count > 10000) {
        playCount = [NSString stringWithFormat:@"%.1f 万播放", count / 10000.0];
    }
    self.videoPlayNumLabel.text = playCount;
    
    
    self.personalizedSignatureLabel.text = [Video Singleton].videoSignature;
    
    //设置点赞的图片
    [self.praiseButton setImage:[UIImage imageNamed:@"praiseSelectImage"] forState:UIControlStateSelected];
    [self.praiseButton setImage:[UIImage imageNamed:@"赞icon-拷贝-2"] forState:UIControlStateNormal];
    
    
    //设置收藏的图片
    [self.collectButton setImage:[UIImage imageNamed:@"selectCollectImage"] forState:UIControlStateSelected];//选中图片
    [self.collectButton setImage:[UIImage imageNamed:@"collectImage"] forState:UIControlStateNormal];//未选中图片
    
    //给关注添加手势
    ADDTAPGESTURE(self.followImage, followSomeone);
    
    //设置收藏数量
    self.collectNumLabel.text = [Video Singleton].videoNumberOfFavorite;
    
//    if (self.videoPraiseState == 1) {   // 点赞状态
//        self.praiseButton.selected = YES;
//    } else if (self.videoPraiseState == 2 || self.videoPraiseState == 0) {
//        self.praiseButton.selected = NO;
//    }
    
    [[SoapOperation Singleton] WS_GetStylebyVideoId:@([[Video Singleton].videoID integerValue]) Success:^(MovierDCInterfaceSvc_vpVDCHeaderAndTailExC *style) {
        self.videoStyle = style;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.redo setHidden:NO];
        });
    } Fail:^(NSError *error) {
        self.videoStyle = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.redo setHidden:YES];
        });
    }];
    
    
#pragma mark ---- 设置视频点赞按钮和收藏按钮的图片----旧版本
//    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
//        [self.praiseButton setImage:[UIImage imageNamed:@"praise"] forState:UIControlStateNormal];
//        [self.collectionButton setBackgroundImage:[UIImage imageNamed:@"Collection_button_h"] forState:UIControlStateNormal];
//        
//    }else{
//        if ([[APPUserPrefs Singleton] APP_getpraisestatus:[[Video Singleton].videoID intValue]] == 0) {
//            [self.praiseButton setImage:[UIImage imageNamed:@"praise"] forState:UIControlStateNormal];
//        }else{
//            [self.praiseButton setImage:[UIImage imageNamed:@"praise_h"] forState:UIControlStateNormal];
//        }
//        if ([[APPUserPrefs Singleton] APP_getfavouritestatus:[[Video Singleton].videoID intValue]] == 0) {
//            [self.collectionButton setBackgroundImage:[UIImage imageNamed:@"Collection_button_h"] forState:UIControlStateNormal];
//        }else{
//            [self.collectionButton setBackgroundImage:[UIImage imageNamed:@"Collection_button"] forState:UIControlStateNormal];
//        }
//    }
}

/** 关注方法*/
- (void)followSomeone:(UITapGestureRecognizer *)tap{
    WEAKSELF(weakSelf);
    [[SoapOperation Singleton] WS_followWithCustomID:[Video Singleton].ownerID Success:^(NSNumber *num) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomeClass showMessage:@"关注成功" ShowTime:2];
            weakSelf.followImage.hidden = YES;
        });
    } Fail:^(NSError *error) {
        DEBUGLOG(error);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error.code == 42) {
                weakSelf.followImage.hidden = YES;
            }else{
                [CustomeClass showMessage:@"关注失败" ShowTime:1.5];
            }
        });
    }];
}

- (void)setupPlayer {
    [self.player addToSuperview:self.videoView withFrame:self.videoView.bounds];
//    [self.player setURL:[NSURL URLWithString:[Video Singleton].videoReferenceUrl] title:[Video Singleton].videoName];
    if(!self.vkplayer){
        self.vkplayer = [[VKVideoPlayer alloc] init];
        self.vkplayer.delegate = self;
        self.vkplayer.view.playerControlsAutoHideTime = @5;
        [self.videoView addSubview:self.vkplayer.view];
            self.vkplayer.forceRotate = YES;
        self.vkplayer.view.frame = self.videoView.bounds;
        
        [self playStream:[NSURL URLWithString:[Video Singleton].videoReferenceUrl]];
    }
    
}

- (void)playStream:(NSURL*)url {
    VKVideoPlayerTrack *track = [[VKVideoPlayerTrack alloc] initWithStreamURL:url];
    track.hasNext = YES;
    [self.vkplayer loadVideoWithTrack:track];
}

#pragma mark -- 分享
- (IBAction)transportButtonAction:(id)sender {
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
        [UIWindow showMessage:@"用户未登录" withTime:3.0];
        return;
    } else {
        NSString *videoUrl = [[NSString alloc] initWithFormat:shareURL,[Video Singleton].videoID];
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeVideo url:videoUrl];
        NSString *showmes = nil;
        NSLog(@"%@",[Video Singleton].videoName);
        if ([[Video Singleton].videoName isEqualToString:@""]||[Video Singleton].videoName ==nil) {
            showmes = @"映像让记忆更精彩！";
        } else {
            showmes =[Video Singleton].videoName;
        }
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"55f9088b67e58e3dbd000488"
                                          shareText:showmes
                                         shareImage:self.videoThumbnailUrlImage.image
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToSina,UMShareToQQ,UMShareToQzone,nil]
                                           delegate:self];
//        [[UMSocialControllerService defaultControllerService] setShareText:showmes shareImage:self.videoThumbnailUrlImage.image socialUIDelegate:self];        //设置分享内容和回调对象
//        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
}
- (IBAction)copyvideo:(id)sender {
    
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
        [UIWindow showMessage:@"用户未登录" withTime:3.0];
        return;
    }
    //照做，video已获得headandtailid
    //正在制作订单的素材数量为空  或 不为空
    int customer = [[UserEntity sharedSingleton].customerId intValue];
    NewNSOrderDetail *freshOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:customer];
    NSMutableArray *materials = [MC_OrderAndMaterialCtrl GetMaterial:customer Orderid:freshOrder.order_id];
    if ([materials count]>0) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否使用原有素材？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        myAlertView.tag = 10;
        [myAlertView show];
    }else{
        [self presentCreatePage];
    }
    
}
//跳转制作页面
-(void)presentCreatePage{
    
    //数据库订单数据填充
    NewNSOrderDetail *fresh = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    fresh.nHeaderAndTailID = [self.videoStyle.nID intValue];
    [MC_OrderAndMaterialCtrl UpdateFresh:fresh];
    
    ISCutProViewController *cut = [[UIStoryboard storyboardWithName:@"Preview" bundle:nil] instantiateViewControllerWithIdentifier:@"ISCutProRechoose_ID"];
    cut.isTransFromPreview = YES;//使用返回键
    cut.next2Preview = YES;//下一步直接跳转preview界面
//    cut.showTabbar = NO;//隐藏tabbar
    ISStyleDetail *style = [[ISStyleDetail alloc] init];
    style.nID = self.videoStyle.nID;
    style.nHeaderAndTailStyle = self.videoStyle.nHeaderAndTailStyle;
    style.videoUrl = self.videoStyle.szReference;
    style.title = self.videoStyle.szName;
    style.visitCount = self.videoStyle.nHotIndex;
    style.thumbnail = self.videoStyle.szThumbnail;
    style.intro = self.videoStyle.szDesc;
    style.sence = self.videoStyle.szFit;
    style.szCreateTime = self.videoStyle.szCreateTime;
    cut.styleDetail = style;
//    [[NSNotificationCenter defaultCenter] postNotificationName:ISHideTabbar object:nil userInfo:nil];
    cut.HideTabbar  =  YES;//storyboard加载时默认值是NO
    [self.navigationController pushViewController:cut animated:YES];

}

#pragma mark -- UMSocialUIDelegate
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
    if (response.responseCode == UMSResponseCodeSuccess) {      // 分享成功
        int videoID = [[Video Singleton].videoID intValue];
#pragma mark --- 奖券
        [self GetCouponmanytime:@(videoID)];
#pragma mark ---- 分享数
        [[SoapOperation Singleton] WS_IncreaseVideoShareNum:@(videoID) Success:^(NSNumber *num) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.videoNumberOfShareLabel.text = [NSString stringWithFormat:@"%@", num];
            });
        } Fail:^(NSError *error) {
            NSLog(@"-----%s----%@", __func__, error);
        }];
    }
}

-(void)GetCouponmanytime:(NSNumber*)vid{
    
    _getcoupontime--;
    [[SoapOperation Singleton] WS_GetCoupon:vid Success:^(NSString *coponURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 跳转网页
            HomeBannerWebViewController *web = [[HomeBannerWebViewController alloc] init];
            web.url = coponURL;
//            web.url = @"www.baidu.com";
            web.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:web animated:YES];
        });
    } Fail:^(NSError *error) {
        if(_getcoupontime<0){
            NSLog(@"-----%s----%@", __func__, error);
        }else
            [self GetCouponmanytime:vid];
//        NSLog(@"-----%s----%@", __func__, error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
    [self setupPlayer];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.isHiddenTabbar == YES) {
        self.navigationController.tabBarController.tabBar.hidden = YES;
    }
    [self.player setURL:nil];
    [self.player pause];
    self.player = nil;
}

- (void)moviePlayer:(NGMoviePlayer *)moviePlayer didChangeControlStyle:(NGMoviePlayerControlStyle)controlStyle {
    if (controlStyle == NGMoviePlayerControlStyleInline) {
        [self updateToOrientation:UIDeviceOrientationPortrait];
        [self.navigationController setNavigationBarHidden:NO];
    } else {
        [self.navigationController setNavigationBarHidden:YES];
        [self updateToOrientation:UIDeviceOrientationLandscapeLeft];
    }
}

- (void)updateToOrientation:(UIDeviceOrientation)orientation
{
    CGRect bounds = [[ UIScreen mainScreen ] bounds ];
    CGRect videoBounds = [[ UIScreen mainScreen ] bounds ];
    CGAffineTransform t;
    CGFloat r = 0;
    switch (orientation ) {
        case UIDeviceOrientationLandscapeRight:
            r = -(M_PI / 2);
            break;
        case UIDeviceOrientationLandscapeLeft:
            r  = M_PI / 2;
            break;
        default :
            break;
    }
    if( r != 0 ){
        CGSize sz = bounds.size;
        bounds.size.width = sz.height;
        bounds.size.height = sz.width;
        videoBounds = bounds;
        t = CGAffineTransformMakeRotation( r );
        
        self.reviewTableView.hidden = YES;
        self.commentView.hidden = YES;
        self.reView.hidden = YES;
        self.shareView.hidden = YES;
        
        UIApplication *application = [ UIApplication sharedApplication ];
        [UIView animateWithDuration:[ application statusBarOrientationAnimationDuration ] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
            self.videoView.transform = t;
        }completion:^(BOOL finish){
            self.videoView.bounds = videoBounds;
            self.videoView.center = CGPointMake(CGRectGetHeight(bounds)/2, CGRectGetWidth(bounds)/2-25);
        }];
        [application setStatusBarOrientation:(UIInterfaceOrientation)orientation animated: YES ];
    }else{
        CGSize sz = bounds.size;
        sz.width = bounds.size.width>bounds.size.height?bounds.size.height:bounds.size.width;
        sz.height = bounds.size.width<bounds.size.height?bounds.size.height:bounds.size.width;
        
        self.reviewTableView.hidden = NO;
        self.commentView.hidden = NO;
        self.reView.hidden = NO;
        self.shareView.hidden = NO;
        
        // y 是播放器的纵坐标, 5是和顶部的间距, 45/375是用户信息 View 的比例, 69 / 125 是播放器的尺寸比例
        CGFloat y = 5 + 45.0 / 375 * ISScreen_Height;
        CGFloat h = 69.0 / 125 * ISScreen_Height;
        videoBounds = CGRectMake(0, y, ISScreen_Width, h);
        
        t = CGAffineTransformMakeRotation( r );
        UIApplication *application = [ UIApplication sharedApplication ];
        [UIView animateWithDuration:[ application statusBarOrientationAnimationDuration ] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
            self.videoView.transform = t;
            self.videoView.frame = videoBounds;
        }completion:^(BOOL finish){
            
        }];
        [application setStatusBarOrientation:(UIInterfaceOrientation)orientation animated: YES ];
    }
}

#pragma mark --- 点赞
- (IBAction)clickPraise:(id)sender
{
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
        [UIWindow showMessage:@"用户未登录" withTime:3.0];
        return;
    }
    // 点赞数量
    BOOL state = NO;    // 记录按钮当前状态
    int praise = [[Video Singleton].videoNumberOfPraise intValue];
    if (self.videoPraiseState == 1) {   // 已经点赞,再执行这个方法是取消点赞
        praise -= 1;
        self.videoPraiseState = 2;
        state = YES;
    } else if (self.videoPraiseState == 2) {    // 没有点赞，执行这个方法是点赞
        praise += 1;
        self.videoPraiseState = 1;
        state = NO;
    }
    
    self.praiseButton.selected = !self.praiseButton.selected;
    if (praise <= 0) {
        praise = 0;
        self.praiseButton.selected = NO;
    }
    NSString *praiseNum = [NSString stringWithFormat:@"%d", praise];
    self.videoNumberOfPraiseLabel.text = praiseNum;
    [Video Singleton].videoNumberOfPraise = praiseNum;
    [[SoapOperation Singleton] WS_SetPraise:@([[Video Singleton].videoID intValue]) Status:!state Success:^(NSNumber *num) {
        NSLog(@"---WS_SetPraise  success---------");
    } Fail:^(NSError *error) {
        NSLog(@"fail--------%s-----%@", __func__, error);
    }];
    NSLog(@"点赞操作后共有%@个", [Video Singleton].videoNumberOfPraise);
}

/**  获得当前用户 对 当前视频的点赞状态
 *      0:用户未登录,    1:用户登录, 没有对当前视频点赞,  2:用户登录, 对当前视频点赞
 */
- (void)getPraiseState {
    __weak typeof(self) vc = self;
    if ([[UserEntity sharedSingleton] isAppHasLogin]) {    // 1. 已登录
        // 1. 获取当前用户对当前视频的点赞状态
        MovierDCInterfaceSvc_IDArray *IDs = [[MovierDCInterfaceSvc_IDArray alloc]init];
        [IDs addItem:@([[Video Singleton].videoID intValue])];
        [[SoapOperation Singleton] WS_QueryPraiseStatus:IDs Success:^(MovierDCInterfaceSvc_IDArray *array) {
            if (array.item.count > 0) {     // 已点赞
                vc.videoPraiseState = 1;
                dispatch_async(dispatch_get_main_queue(), ^{
                    vc.praiseButton.selected = YES;
                });
            } else {    // 没有点赞
                vc.videoPraiseState = 2;
                dispatch_async(dispatch_get_main_queue(), ^{
                    vc.praiseButton.selected = NO;
                });
            }
            NSLog(@"----%s----%d", __func__, vc.videoPraiseState);
        } Fail:^(NSError *error) {
            NSLog(@"----%s-----%@", __func__, error);
        }];
    } else {
        vc.videoPraiseState = 0;
        vc.praiseButton.selected = NO;
    }
}

//  以前的点赞方法
- (void)praiseOld {
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
        [UIWindow showMessage:@"用户未登录" withTime:3.0];
        return;
    }else{
        if ([[APPUserPrefs Singleton] APP_getpraisestatus:[[Video Singleton].videoID intValue]] == 0) {
            //            [self.praiseButton setBackgroundImage:[UIImage imageNamed:@"press_praise_h"] forState:UIControlStateNormal];
            [self.praiseButton setImage:[UIImage imageNamed:@"praise_h"] forState:UIControlStateNormal];
            int ret = -1;
            ret = [APPUserPrefs APP_praisevideobyid:[[Video Singleton].videoID intValue]];
            if (ret == 0) {
                int tmp = [[Video Singleton].videoNumberOfPraise intValue] + 1;
                [Video Singleton].videoNumberOfPraise = [NSString stringWithFormat:@"%d",tmp];
                self.videoNumberOfPraiseLabel.text = [NSString stringWithFormat:@"%d",tmp];
                VideoInformationObject *videoInformationObject = [[VideoInformationObject alloc] init];
                videoInformationObject = [Video Singleton];
                [[APPUserPrefs Singleton] APP_HomePageVideoCacheInformationDBChange:videoInformationObject];
            }
        }else{
            //            [self.praiseButton setBackgroundImage:[UIImage imageNamed:@"press_praise"] forState:UIControlStateNormal];
            [self.praiseButton setImage:[UIImage imageNamed:@"praise"] forState:UIControlStateNormal];
            int ret = -1;
            ret = [APPUserPrefs APP_unpraisevideobyid:[[Video Singleton].videoID intValue]];
            if (ret == 0) {
                int tmp = [[Video Singleton].videoNumberOfPraise intValue] - 1;
                [Video Singleton].videoNumberOfPraise = [NSString stringWithFormat:@"%d",tmp];
                self.videoNumberOfPraiseLabel.text = [NSString stringWithFormat:@"%d",tmp];
                VideoInformationObject *videoInformationObject = [[VideoInformationObject alloc] init];
                videoInformationObject = [Video Singleton];
                [[APPUserPrefs Singleton] APP_HomePageVideoCacheInformationDBChange:videoInformationObject];
            }
        }
    }

}

#pragma mark -- 保存
- (IBAction)clickSave:(id)sender
{
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
        [UIWindow showMessage:@"用户未登录" withTime:3.0];
        return;
    }else{
        if ([[APPUserPrefs Singleton] APP_getfavouritestatus:[[Video Singleton].videoID intValue]] == 0) {
            int ret = -1;
            ret = [[APPUserPrefs Singleton] APP_markfavoritebyid:[[Video Singleton].videoID intValue] Status:YES];
            if (ret == 0) {
                [self.collectionButton setBackgroundImage:[UIImage imageNamed:@"Collection_button"] forState:UIControlStateNormal];
            }
        }else{
            int ret = -1;
            ret = [[APPUserPrefs Singleton] APP_markfavoritebyid:[[Video Singleton].videoID intValue] Status:NO];
            if (ret == 0) {
                [self.collectionButton setBackgroundImage:[UIImage imageNamed:@"Collection_button_h"] forState:UIControlStateNormal];
            }
        }
    }
}

//手机登录按钮方法
- (void)iphoneButtonClick{
    LoginViewController *loginVC =[self.storyboard instantiateViewControllerWithIdentifier:@"Login"] ;
    [self.navigationController pushViewController:loginVC animated:YES];
    [self popBackViewAnimation];
    [self performSelector:@selector(windowHidden) withObject:self afterDelay:.2];
}

//
- (void)processGestureRecongnizer:(UIGestureRecognizer *)gesture
{
    if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
        [self popBackViewAnimation];
        [self performSelector:@selector(windowHidden) withObject:self afterDelay:0.2];
    }
}

#pragma mark -- window 隐藏
- (void)windowHidden{
    [secondWindow setHidden:YES];
}
#pragma mark -- 从下往上弹出动画
-(void)popViewAnimation{
    [UIView beginAnimations:@"popViewAnimation" context:NULL];
    [UIView setAnimationDuration:.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [secondWindow makeKeyAndVisible];
    customLoginAlertView.frame = CGRectMake((self.view.width - 240)/2, (self.view.height - 200)/2, 240, 200);
    [UIView commitAnimations];
}
#pragma mark -- 由上往下弹回动画
-(void)popBackViewAnimation{
    [UIView beginAnimations:@"popBackViewAnimation" context:NULL];
    [UIView setAnimationDuration:.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    customLoginAlertView.frame = CGRectMake((self.view.width - 240)/2, SCREEN_HEIGHT, 240, 200);
    [UIView commitAnimations];
}

-(void)Notloggedin
{
    secondWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    secondWindow.windowLevel= UIWindowLevelAlert;
    secondWindow.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroud_shadow"]];
    secondWindow.userInteractionEnabled = YES;
    customLoginAlertView = [[[NSBundle mainBundle]loadNibNamed:@"CustomLoginAlertView" owner:nil options:nil] lastObject];
    [customLoginAlertView.iphoneLoginButtonClick addTarget:self action:@selector(iphoneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    customLoginAlertView.frame = CGRectMake((self.view.width - 240)/2, self.view.height, 240, 200);
    [secondWindow addSubview:customLoginAlertView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(processGestureRecongnizer:)];
    [tapGesture setNumberOfTouchesRequired:1];
    [tapGesture setNumberOfTapsRequired:1];
    [secondWindow addGestureRecognizer:tapGesture];
    [customLoginAlertView.WeChatLoginButton addTarget:self action:@selector(weChatLoginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [customLoginAlertView.iphoneRegisterButtonClick addTarget:self action:@selector(RegisterButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self popViewAnimation];
}

- (void)RegisterButtonClick{
    TelephoneViewController *telephoneVC =[self.storyboard instantiateViewControllerWithIdentifier:@"telephone"] ;
    [self.navigationController pushViewController:telephoneVC animated:YES];
    [self popBackViewAnimation];
    [self performSelector:@selector(windowHidden) withObject:self afterDelay:.5];
}

/**
 *  微信登陆按钮点击, 能执行这个方法, 手机一定安装了微信
 */
- (void)weChatLoginButtonClick {
    // 从微信获取数据
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //        NSLog(@"%@----response-----%d", response.data, response.responseType);
        if (response.responseCode == UMSResponseCodeSuccess) {
#pragma mark -- 测试
            //            NSLog(@"%@-------------", [UMSocialAccountManager socialAccountDictionary]);
            //            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToWechatSession];
            //            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
#pragma mark -- 原有代码
            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
                NSLog(@"SnsInformation is %@",response.data);
                NSLog(@"profile_image_url ---- %@", response.data[@"profile_image_url"]);
                // 1. 给映像服务器发送请求, 注册账号/或者登陆
                [self registerFromServer:response.data];
                
            }];
#pragma mark -- 原有代码
            // 1. 退出登陆界面
            [self popBackViewAnimation];
            [self performSelector:@selector(windowHidden) withObject:self afterDelay:.5];
            
        } else {
            [self showMessage:@"从微信获取信息失败"];
        }
    });
}

#pragma mark -- 拿到微信的数据到服务器注册
/**
 *  @return 返回注册结果, 0成功, 其他失败
 */
- (void)registerFromServer:(NSDictionary *)data {
    // openid
    NSString *openid = [data[@"openid"] length] == 0 ? @"" : data[@"openid"];
    // 测试账号, openid 随便写一个字符串, 就可以注册新账号
    //    NSString *openid = @"dldkhgfvhnvjsdafhkjnhsanfhnhjhgfyhghvk";
    NSString *access_token = [data[@"access_token"] length] == 0 ? @"" : data[@"access_token"];
    
    //https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
    NSString * URLString = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openid];
    NSURLRequest *request1 = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *received = [NSURLConnection sendSynchronousRequest:request1 returningResponse:nil error:nil];
    
    NSDictionary *wechatinfo = [NSJSONSerialization JSONObjectWithData:received options:0 error:nil];
    
    NSLog(@"%@",wechatinfo);
    
    // 用户名
    NSString *screen_name = [wechatinfo[@"nickname"] length] == 0 ? @"" : wechatinfo[@"nickname"];
    // 头像
    NSString *Profile = [wechatinfo[@"headimgurl"] length] == 0 ? @"" : wechatinfo[@"headimgurl"];
    //暂时不使用
//    NSString *Country = [wechatinfo[@"country"] length] == 0 ? @"" : wechatinfo[@"country"];
    NSString *City = [wechatinfo[@"city"] length] == 0 ? @"" : wechatinfo[@"city"];
    NSString *Province = [wechatinfo[@"province"] length] == 0 ? @"" : wechatinfo[@"province"];
    int gender = [wechatinfo[@"sex"] intValue];
    if (gender == 0) {
        gender = 1;
    } else if (gender == 1) {
        gender = 2;
    }
    NSString *unionid = [wechatinfo[@"unionid"] length] == 0 ? @"" : wechatinfo[@"unionid"];
    
    MovierDCInterfaceSvc_VDCThirdPartyAccount *account = [[MovierDCInterfaceSvc_VDCThirdPartyAccount alloc]init];
    account.szNickName = screen_name;//[screen_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    account.szAcatar = [Profile stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    account.szAccount = unionid;//[unionid stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    account.szLocationProvince = Province;//[Province stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    account.szLocationCity = City;//[City stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    account.szSignature = @"";
    account.szPwd = [access_token stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    account.nGender = [NSNumber numberWithInt:gender];
    account.nThirdPartyType = [NSNumber numberWithInt:1];//微信定义为1
    
    [[SoapOperation Singleton] WS_Login:account.szAccount ThirdPartyType:@"1" Token:account.szPwd Openid:account.szAccount APPVersion:[UpDateSql getAPPVersion] SubVersion:[UpDateSql getAPPVersion] Success:^(MovierDCInterfaceSvc_VDCSession* ws_session) {
        //初始化userentity
        [[UserEntity sharedSingleton] Applogin:account.szAccount appPwd:account.szPwd LoginType:LoginTypeWeChat];
        [UserEntity sharedSingleton].sessionId = [[NSString alloc] initWithFormat:@"%@",ws_session.nSessionID];
        [UserEntity sharedSingleton].customerId = [NSString stringWithFormat:@"%@",ws_session.nCustomerID];
        [UserEntity sharedSingleton].ossDir = ws_session.szRootDir;
        [UserEntity sharedSingleton].ossKey = ws_session.szKey;
        [self fillUseEntity:ws_session];
        [[SoapOperation Singleton] WS_GetossConfig:ws_session Success:^(MovierDCInterfaceSvc_VDCOSSConfig *ossconfig) {
            [UserEntity sharedSingleton].ossBucket = ossconfig.szBucket;
            [UserEntity sharedSingleton].ossID = ossconfig.szID;
            [UserEntity sharedSingleton].ossKey = ossconfig.szKey;
            [UserEntity sharedSingleton].ossEndpoint = ossconfig.szEndpoint;
            [[APPUserPrefs Singleton] StartOrderT];
            
        } Fail:^(NSError *error) {
            NSLog(@"get oss config error!");
            NSLog(@"%@",[error localizedDescription]);
        }];
    } Fail:^(NSNumber *LoginStatus,NSError *error) {
        if ([LoginStatus isEqualToNumber:@(MOVIERDC_SERVER_INVALIDUSERORPWD)]) {
            //跳转注册页面
            [self userRegister:data andDetail:wechatinfo];
            ;
        };
    }];
}

- (void)userRegister:(NSDictionary *)data andDetail:wechatinfo{
    
    // 跳转到个人信息完善界面
    UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
    PerfectPersonalInfoViewController *infoVC = [stroyboard instantiateViewControllerWithIdentifier:@"PerfectPersonalInfoVCStoryBoardID"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:infoVC];
    
    // 把从微信获取到得信息传递到个人信息(字典数据)设置界面
    infoVC.info = data;
    infoVC.detail = wechatinfo;
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)fillUseEntity:(MovierDCInterfaceSvc_VDCSession*)ws_session{
    [UserEntity sharedSingleton].customerId = [NSString stringWithFormat:@"%@",ws_session.nCustomerID ];
    [[SoapOperation Singleton]WS_QueryUserInfo:^(MovierDCInterfaceSvc_VDCCustomerInfo *info) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            [avatar sd_setImageWithURL:[NSURL URLWithString:info.szAcatar] placeholderImage:[UIImage imageNamed:@"head"] options:SDWebImageRetryFailed | SDWebImageRefreshCached];
//            _UserName.text = info.szNickname;
//            _UserSingature.text = info.szSignature;
            //此处通知logout页面填充相应信息
            [[NSNotificationCenter defaultCenter] postNotification:[[NSNotification alloc] initWithName:@"appuserregistersuccess" object:nil userInfo:nil]];
            [UserEntity sharedSingleton].szNickname = info.szNickname;
            [UserEntity sharedSingleton].szSignature = info.szSignature;
            [UserEntity sharedSingleton].szAcatar = info.szAcatar;
            
        });
    } Fail:^(NSError *error) {
        NSLog(@"Login view WS_QueryUserInfo error= %@ ! ",[error localizedDescription]);
    }];
}

- (void)showMessage:(NSString *)message
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(290, 9000)];
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake((SCREEN_WIDTH - LabelSize.width - 20)/2, SCREEN_HEIGHT - 100, LabelSize.width+20, LabelSize.height+10);
    [UIView animateWithDuration:5.0 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}

- (void)firsttosecond
{
    DescriptionViewController *descriptionViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"descriptionViewController"] ;
    [self.navigationController pushViewController:descriptionViewController animated:true];
}

#pragma mark ---- 更多操作  弹出 UIActionSheet
- (IBAction)showSheet:(id)sender
{
    // 1. 判断用户是否登录
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
        [UIWindow showMessage:@"用户未登录" withTime:3.0];
        return;
    } else {
#pragma mark ---- 是否是从个人界面跳转回来
        UIActionSheet *videoSheet = nil;
        if (self.isTransFromPersonal == YES) {
            NSString *isPublic = nil;
            if ([self.isVideoPublic isEqualToString:@"1"]) {    // 当前视频是公开状态
                isPublic = @"仅自己可见";
            } else {    //  当前视频是私有状态
                isPublic = @"公开";
            }
            videoSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:isPublic otherButtonTitles:@"删除", nil];
            videoSheet.destructiveButtonIndex = 1;
            [videoSheet showInView:self.view];
            self.videoSheet = videoSheet;
            
        } else {
            // 2. 判断当前视频是否已经被当前用户收藏, 当前用户已经收藏, 显示"取消收藏"; 当前用户没有收藏, 显示 "收藏"
            NSString *collect = nil;
            if (self.isColletionCurrentVideo == YES) {
                collect = @"取消收藏";
            } else {
                collect = @"收藏";
            }
            videoSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"举报" otherButtonTitles:nil];
            videoSheet.destructiveButtonIndex = 1;
            [videoSheet showInView:self.view];
            self.videoSheet = videoSheet;
        }
    }
}

#pragma mark ---- UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet == self.videoSheet) {
        if (self.isTransFromPersonal == YES) {  // 从个人界面返回, 显示是否公开个人视频
            switch (buttonIndex) {
                case 0:     // 是否公开视频
                    [self changePersonalVideoPublicState];
                    break;
                case 1:     // 删除视频
                    [self deleteCurrentVideo];
                    break;
                    
                default:
                    break;
            }
        } else {    // 其他位置进入视频详情页, 显示是否收藏该视频
            switch (buttonIndex) {      // 0: 收藏  1:举报  2:取消
                case 0:    // 举报
                    [self reportCurrentVideo];
                    break;
                case 1:
                    break;
                case 2:
                default:
                    break;
            }
        }
    } else if (actionSheet == self.deleteCommentSheet) {
        switch (buttonIndex) {
            case 0:     // 删除自己的评论
                [self deleteMyComment];
                break;
            default:
                break;
        }
    } else if (actionSheet == self.reportCommentSheet) {
        switch (buttonIndex) {
            case 0:     // 举报
                [self reportComment];
                break;
            default:
                break;
        }
    }
}

/**  设置个人  是否公开视频  的状态 */
- (void)changePersonalVideoPublicState {
    BOOL state = NO;
    if ([self.isVideoPublic isEqualToString:@"1"]) {   // 公开状态
        state = NO;
    } else {    // 私有状态
        state = YES;
    }
    
    int videoID = [[Video Singleton].videoID intValue];
    [[SoapOperation Singleton] WS_ChangeVideoStatus:@(videoID) Status:state Success:^(NSNumber *num) {
        self.isVideoPublic = [NSString stringWithFormat:@"%d", state];
        [Video Singleton].videoShare = self.isVideoPublic;
    } Fail:^(NSError *error) {
        NSLog(@"---------%s-------%@", __func__, error);
    }];
}

/**  删除个人当前视频 */
- (void)deleteCurrentVideo {
    int videoID = [[Video Singleton].videoID intValue];
    [[SoapOperation Singleton] WS_DeleteVideo:@(videoID) Success:^(NSNumber *num) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showSuccess:@"删除视频成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        });
    } Fail:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showError:@"请检查网络!"];
        });
    }];
}

/**  判断是否收藏  YES: 收藏,  NO: 没有收藏  */
- (void)isVideoCollection {
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
        [UIWindow showMessage:@"用户未登录" withTime:3.0];
        return;
    }
    SoapOperation *soap = [SoapOperation Singleton];
    MovierDCInterfaceSvc_IDArray *array = [[MovierDCInterfaceSvc_IDArray alloc] init];
    if ([Video Singleton].videoID) {
        [array.item addObject:[Video Singleton].videoID];
    }
    __weak typeof(self) vc = self;
    [soap WS_GetVideoColletionStatus:nil VideoIds:array Success:^(MovierDCInterfaceSvc_IDArray *IDs) {
        MAINQUEUEUPDATEUI({
            if ([IDs.item count]>0) {
                vc.isColletionCurrentVideo = YES;
                vc.collectButton.selected = YES;
            }else{
                vc.isColletionCurrentVideo = NO;
            vc.collectButton.selected = NO;
            }
        })
        
    } Fail:^(NSError *error) {
        DEBUGLOG(error);
    }];
}

/**  收藏\取消收藏 评论 */
- (void)collectCurrentVideo {
    SoapOperation *soap = [SoapOperation Singleton];
    // self.isColletionCurrentVideo == YES 当前用户已收藏该视频
    int videoID = [[Video Singleton].videoID intValue];
    [soap WS_SetCollectVideo:nil ChangeStatus:!self.isColletionCurrentVideo VideoId:@(videoID) Success:^{
        if (!self.isColletionCurrentVideo == YES) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIWindow showMessage:@"收藏成功" withTime:2.0];
                self.collectButton.selected = YES;
                self.isColletionCurrentVideo = !self.isColletionCurrentVideo;
                self.collectNumLabel.text = [NSString stringWithFormat:@"%d", [[Video Singleton].videoNumberOfFavorite intValue] + 1];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.collectButton.selected = NO;
                self.isColletionCurrentVideo = !self.isColletionCurrentVideo;
                [UIWindow showMessage:@"取消收藏" withTime:2.0];
            });
        }
    } Fail:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
    //        [MBProgressHUD showError:@"请检查网络!"];
        });
    }];
}

/**  举报评论 （点击举报进入的不是这个页面）*/
- (void)reportCurrentVideo {
    // 进入举报界面
    HomeVideoReportViewController *report = [[HomeVideoReportViewController alloc] initWithNibName:@"HomeVideoReportViewController" bundle:nil];
    [self.navigationController pushViewController:report animated:YES];
}

/**  删除自己的评论 */
- (void)deleteMyComment {
    UIAlertView *deleteCommentAlert = [[UIAlertView alloc] initWithTitle:nil message:@"确定删除吗?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [deleteCommentAlert show];
}

- (void)reportComment {
    HomeVideoReportCommentViewController *reportComment = [[HomeVideoReportCommentViewController alloc] initWithNibName:@"HomeVideoReportCommentViewController" bundle:nil];
    reportComment.commentID = self.currentCommentID;
    [self.navigationController pushViewController:reportComment animated:YES];
}

#pragma mark ---  UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10) {
        if (buttonIndex != 0) {
            NewNSOrderDetail *fresh = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
            fresh.nVideoLength =0.0;
            [MC_OrderAndMaterialCtrl UpdateFresh:fresh];
            [MC_OrderAndMaterialCtrl DeleteMaterialsInOrder:[[UserEntity sharedSingleton].customerId intValue] Orderid:fresh.order_id];
        }
        //跳转制作页面
        [self presentCreatePage];
    }else if (buttonIndex == 0) {     // 删除
        SoapOperation *soap = [SoapOperation Singleton];
        [soap WS_RemoveCommentByid:self.currentCommentID Session:nil Success:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                // 删除表格中的数据, 刷新表格
                [self.comments removeObjectAtIndex:self.indexPath.item];
                [self.reviewTableView reloadData];
                self.commentCount = self.commentCount - 1;
                self.reviewCountLabel.text = [NSString stringWithFormat:@"共%d条评论", self.commentCount];
//                [MBProgressHUD showSuccess:@"删除成功"];
                [UIWindow showMessage:@"删除成功" withTime:2.0];
            });
        } Fail:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:@"请检查网络"];
                NSLog(@"-----%s-----%@", __func__, error);
            });
        }];
    }
}

#pragma mark  ------评论----- <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BACKPROPMTVIEW(self.comments.count == 0, 1000000, @"暂无评论\n快快抢沙发呦", reviewTableView)
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ISVideoReviewCell *cell = [ISVideoReviewCell reviewCellWithTableView:tableView];
    cell.commentF = self.comments[indexPath.row];
    cell.delegate = self;
    cell.commentUserId = cell.commentF.comment.nCustomerID;
    cell.commentId = cell.commentF.comment.nCommentID;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCommentFrame *commentF = self.comments[indexPath.row];
    VideoComment *comment = commentF.comment;
    // 获得当前评论的id
    self.currentCommentID = @(comment.nCommentID);
    self.indexPath = indexPath;
    self.selectCommentsId = [NSString stringWithFormat:@"%d", comment.nCommentID];
    
   //点击回复某个用户
    [self.textView becomeFirstResponder];
    self.textView.text = [NSString stringWithFormat:@"@%@：", comment.szNickname];
    self.currentReplyUserNickName = comment.szNickname;
}

- (void)cellTap:(int)commmentUserId CommentId:(int)commentId{
    self.currentCommentID = @(commentId);
    if (self.longTapUserId == commmentUserId) {
        return;
    }
    self.longTapUserId = commmentUserId;
    int commentCustomID = commmentUserId;
    int loginedCustomID = [[UserEntity sharedSingleton].customerId intValue];
    if (commentCustomID == loginedCustomID) {
        UIActionSheet *deleteCommentSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles: nil, nil];
        [deleteCommentSheet showInView:self.view];
        self.deleteCommentSheet = deleteCommentSheet;
    } else {
        UIActionSheet *reportCommentSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"举报" otherButtonTitles: nil, nil];
        [reportCommentSheet showInView:self.view];
        self.reportCommentSheet = reportCommentSheet;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.comments[indexPath.row] cellHeight];
}

#pragma mark ---- ISVideoReviewCellDelegate
- (void)reviewCell:(ISVideoReviewCell *)reviewCell didClickIconButton:(UIButton *)button {
    // 根据  评论者的 ID(nCustomerID) 跳转到个人详情页
//    OtherPeopleViewController *other = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OthersVCStoryBoardID"];
//    other.isTransFromCommentList = YES;
//    other.customID = reviewCell.commentF.comment.nCustomerID;
//    other.userNickName = reviewCell.commentF.comment.szNickname;
//    other.iconUrl = reviewCell.commentF.comment.szAvatar;
    MyVideoViewController * videoVc = [MyVideoViewController new];
    if (![[Video Singleton].ownerID isEqualToString:CURRENTUSERID]) {
        videoVc.isShowOtherUserVideo = YES;
        videoVc.userId = [NSString stringWithFormat:@"%d", reviewCell.commentF.comment.nCustomerID];
    }
    [self.navigationController pushViewController:videoVc animated:YES];
}

/**  下拉更新评论 */
- (void)addHeader {
    [self loadComments];
    [self.reviewTableView headerEndRefreshing];
}

/**  上拉加载更多评论 */
- (void)addFooter {
    // 更新评论的开始位置, 每次加载20个评论
    self.commentStartPos = (int)self.comments.count;
    [self loadComments];
    [self.reviewTableView footerEndRefreshing];
}

- (void)loadComments {
        // 根据视频 id, 加载评论的总数
    [self arbinTest];
    SoapOperation *ws = [SoapOperation Singleton];
    int videoId = [[Video Singleton].videoID intValue];
    [ws WS_GetCommentsNumByVideoid:@(videoId) Success:^(NSNumber *num) {
        self.commentCount = [num intValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.reviewCountLabel.text = [NSString stringWithFormat:@"共%@条评论", num];
        });
    } Fail:^(NSError *error){
        NSLog(@"----%s-----%@", __func__, [error localizedDescription]);
    }];
    
    // 根据视频 id, 加载对应的评论
    [ws WS_GetCommentsByVideoid:@(videoId) Start:@(self.commentStartPos) Count:@(20) Success:^(MovierDCInterfaceSvc_vpVideoCommentArr* comments) {
        if (self.commentStartPos == 0) {
            [self.comments removeAllObjects];
        }
        for (NSInteger i = 0; i < comments.item.count; i++) {
            MovierDCInterfaceSvc_vpVideoComment *videoComm = comments.item[i];
            VideoCommentFrame *commF    = [[VideoCommentFrame alloc] init];
            VideoComment *comm          = [[VideoComment alloc] init];
            comm.nCommentID             = [videoComm.nCommentID intValue];
            comm.nCustomerID            = [videoComm.nCustomerID intValue];
            comm.nVideoID               = [videoComm.nVideoID intValue];
            comm.nreplyComment          = [videoComm.nreplyComment intValue];
            comm.szAvatar               = videoComm.szAvatar;
            comm.szNickname             = videoComm.szNickname;
            comm.szCreateTime           = videoComm.szCreateTime;
            comm.szContent              = videoComm.szContent;
            commF.comment               = comm;
            [self.comments addObject:commF];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.reviewTableView reloadData];
        });
    } Fail:^(NSError *error) {
        NSLog(@"----%s-------%@", __func__, [error localizedDescription]);
    }];

}

- (void)sendComment:(NSString *)comment {
    
    NSNumber * commentsId = [NSNumber numberWithInt:[self.selectCommentsId intValue]];
    NSRange myRange = [comment rangeOfString:self.currentReplyUserNickName];
    if (myRange.length == 0) {
        //认为是评论
        commentsId = @(0);
    }
    
    SoapOperation *ws = [SoapOperation Singleton];
    [ws WS_SubmitCommentByid:[NSNumber numberWithInteger:[[Video Singleton].videoID integerValue]] Session:nil Reply:commentsId Content:comment Success:^{
        // 更新数据----全部刷新, 从0开始
        [self.comments removeAllObjects];
        self.commentStartPos = 0;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([commentsId intValue] != 0) {
                //回复
                [CustomeClass showMessage:@"回复成功" ShowTime:1.5];
                
            }else{
                [CustomeClass showMessage:@"评论成功" ShowTime:1.5];
            }
            [self loadComments];
        });
    } Fail:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomeClass showMessage:@"评论失败" ShowTime:1.5];
        });
        DEBUGLOG(error);
        
    }];
}

// 键盘显示和消失时, 底部视图的动画显示
- (void)keyboardShow:(NSNotification *)noti {
    // 动画执行时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // 键盘的尺寸
    CGRect keyboardF = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 设置输入框的偏移量
    [UIView animateWithDuration:duration animations:^{
        self.commentViewButtom.constant = keyboardF.size.height;
    }];
}

- (void)keyboardHide:(NSNotification *)noti {
    // 动画执行时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // 键盘的尺寸
    CGRect keyboardF = [noti.userInfo[UIKeyboardBoundsUserInfoKey] CGRectValue];
    
    // 设置输入框的偏移量
    [UIView animateWithDuration:duration animations:^{
        self.commentViewButtom.constant = keyboardF.origin.y;
    }];
}

#pragma mark --- -UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    //  监听键盘的出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)textViewDidChange:(UITextView *)textView {
    NSString *content = textView.text;
    // 如果文字长度大于110, 不能继续输入
    if (content.length > MaxInputNumber) {
        content = [content substringToIndex:MaxInputNumber];
        textView.text = content;
    }
    // 设置用户输入文字的个数
    NSInteger currentLength = content.length;
    NSString *currentContent = [NSString stringWithFormat:@"%zd", currentLength];
    self.currentInputNumLabel.text = currentContent;
    
    // 根据字数设置颜色
    if (currentLength == MaxInputNumber) {
        self.currentInputNumLabel.textColor = [UIColor redColor];
    } else {
        self.currentInputNumLabel.textColor = ISRGBColor(64, 74, 88);
    }
}

/**  结束编辑 */
- (void)endEditing {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    [self.textView endEditing:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    // 结束编辑
    [self endEditing];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

/**  增加评论 */
- (IBAction)comment:(id)sender {
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {    // 判断用户是否登录, 没有登录弹出登录界面
        // 结束编辑
        [self endEditing];
        [self Notloggedin];
    } else {
        NSString * regex = @"[^a-zA-Z0-9\u4E00-\u9FA5]";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        NSString *comment = self.textView.text;
        NSString * removeSpaceStr = [comment stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (comment.length == 0 || removeSpaceStr.length == 0) {
            [UIAlertView alertViewshowMessage:@"请输入评论内容" cancleButton:nil confirmButton:@"确定"];
            return;
        }
        if ([pred evaluateWithObject:comment]) {    // 不支持特殊字符
            [UIAlertView alertViewshowMessage:@"暂不支持特殊字符" cancleButton:nil confirmButton:@"确定"];
            return;
        }
        // 结束编辑
        [self endEditing];
        [self sendComment:comment];
        // 清空编辑内容
        self.textView.text = nil;
        self.currentInputNumLabel.text = @"0";
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 结束编辑
    [self endEditing];
}
#pragma mark - Orientation
- (void)videoPlayer:(VKVideoPlayer*)videoPlayer willChangeOrientationTo:(UIInterfaceOrientation)orientation{
    if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight){
        [super.navigationController setNavigationBarHidden:YES animated:TRUE];
        [super.navigationController setToolbarHidden:YES animated:TRUE];
        [self.videoView.superview setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)];
//        [self.view bringSubviewToFront:self.videoView];
    }else{
        [super.navigationController setNavigationBarHidden:NO animated:TRUE];
        [super.navigationController setToolbarHidden:NO animated:TRUE];
    }
}

#pragma mark 谢斌测试
-(void)arbinTest{
    //    [[SoapOperation Singleton] WS_GetLaunchPage:@(1) Success:^(MovierDCInterfaceSvc_StringArr *launchinfos) {
    //        NSLog(@"%@",launchinfos);
    //    } Fail:^(NSError *error) {
    //        NSLog(@"%@",[error localizedDescription]);;
    //    }];
    
    
    //    [[SoapOperation Singleton] WS_GetCoupon:@([[Video Singleton].videoID intValue]) Success:^(NSString *coponURL) {
    //        NSLog(@"感谢惠顾 国美");
    //    } Fail:^(NSError *error) {
    //        NSLog(@"再来一次");
    //    }];
    
    
    
    //    SoapOperation *ws = [SoapOperation Singleton];
    //测试搜索用户
    //    [ws WS_SearchUser:@"arbin" Start:@(0) Count:@(100) Success:^(MovierDCInterfaceSvc_VDCCustomerBaseInfoExArr* result){
    //        ;
    //    } Fail:^(NSError *error) {
    //        ;
    //    }];
    //测试搜索视频
    //    for(int i = 0 ; i <5; i++) {
    //    [ws WS_SearchVideo:@"div" Start:@(0) Count:@(100) Success:^(MovierDCInterfaceSvc_VDCVideoInfoExArray* result){
    //        NSLog(@"the %d search = %@",i,result.item);
    //    } Fail:^(NSError *error) {
    //        ;
    //    }];
    //    }
    
    //    [ws WS_GetBannerNum:@(0) Success:^(NSNumber *num) {
    //        ;
    //    } Fail:^(NSError *error) {
    //        ;
    //    }];
    
    //    for(int i = 0 ; i <5 ; i++) {
    //        [ws WS_GetBanner:@(i) Start:@(0) Count:@(9) Success:^(MovierDCInterfaceSvc_VDCBannerInfoArray* array){
    //            for (MovierDCInterfaceSvc_VDCBannerInfo* item in array.item) {
    ////                NSLog(@"bannner = %d url = %@",i,item.szThumbnail);
    //            };
    //        } Fail:^(NSError *error) {
    //            ;
    //        }];
    //    };
    //    [ws WS_ReportVideo:Soap_session ReportType:@(1) VideoId:@([[Video Singleton].videoID intValue]) Reason:@"就是不爽" Success:^() {
    //        ;
    //    } Fail:^(NSError *error) {
    //        ;
    //    }];
    //    [ws WS_GetPersonalCollectionNum:Soap_session Success:^(NSNumber* num){
    //        NSLog(@"WS_GetPersonalCollectionNum = %@",num);
    //    } Fail:^(NSError *error) {
    //        NSLog(@"WS_GetPersonalCollectionNum %@",[error localizedDescription]);
    //    }];
    //    MovierDCInterfaceSvc_IDArray *abc = [[MovierDCInterfaceSvc_IDArray alloc]init];
    //    for (int i = 775; i<800; i++) {
    //        NSNumber* aaaa = [NSNumber numberWithInt:i];
    //        [abc.item addObject:aaaa];
    //    }
    //    [ws WS_GetVideoColletionStatus:Soap_session VideoIds:abc Success:^(MovierDCInterfaceSvc_IDArray *array) {
    //        ;
    //    } Fail:^(NSError *error) {
    //        ;
    //    }];
    
    //    [ws WS_GetPersonalCollection:Soap_session Start:@(0) Count:@(10) Success:^(MovierDCInterfaceSvc_VDCVideoInfoExArray *array) {
    //        NSLog(@"aaaaaa");
    //    } Fail:^(NSError *error) {
    //        ;
    //    }];
    
    //    for(int i = 0 ; i <5 ; i++) {
    //        [ws WS_GetBanner:@(i) Start:@(0) Count:@(9) Success:^(MovierDCInterfaceSvc_VDCBannerInfoArray* array){
    ////            for (MovierDCInterfaceSvc_VDCBannerInfo* item in array.item) {
    //////                NSLog(@"bannner = %d url = %@",i,item.szThumbnail);
    ////            };
    //        } Fail:^(NSError *error) {
    //            ;
    //        }];
    //    };
    
    //    [ws WS_GetPersonalVideos:Soap_session Customer:@([[UserEntity sharedSingleton].customerId integerValue]) Start:@(0) Count:@(5) Success:^(MovierDCInterfaceSvc_VDCVideoInfoExArray *registerret) {
    //        ;
    //    } Fail:^(NSError *error) {
    //        ;
    //    }];
    
    //    [ws WS_GetVideosbyLabel:Soap_session Label:@(0) Start:@(0) Count:@(100) Success:^(MovierDCInterfaceSvc_VDCVideoInfoExArray *array) {
    //        ;
    //    } Fail:^(NSError *error) {
    //        ;
    //    }];
    //    [ws WS_GetTemplateNum:nil Success:^(NSNumber *num) {
    //        ;
    //    } Fail:^(NSError *error) {
    //        ;
    //    }];
    
    //    [ws WS_GetVideosbyLabel:Soap_session Label:@(0) Start:@(0) Count:@(100) Success:^(MovierDCInterfaceSvc_VDCVideoInfoExArray *array) {
    //        ;
    //    } Fail:^(NSError *error) {
    //        ;
    //    }];
    
    //    [ws WS_GetTemplateCat:Soap_session Start:@(0) Count:@(99) Success:^(MovierDCInterfaceSvc_VDCTemplateCatArr *array) {
    //        for(MovierDCInterfaceSvc_TemplateCat* item in array.item) {
    //            [ws WS_GetStylebyCat:Soap_session CatType:item.nID Start:@(0) Count:@(9) Success:^(MovierDCInterfaceSvc_vpVDCHeaderAndTailArray *array) {
    //                for (MovierDCInterfaceSvc_vpVDCHeaderAndTailC* item in array.item) {
    //                    NSLog(@"url = %@",item.szThumbnail);
    //                };
    //            } Fail:^(NSError *error) {
    //                NSLog(@" GetHeaderbyCat %@",[error localizedDescription]);;
    //            }];
    //            NSLog(@"aaaaaa______%@",item.szThumbnail);
    //        };
    //    } Fail:^(NSError *error) {
    //        NSLog(@"GetTemplate %@",[error localizedDescription]);
    //    }];
    //    [ws WS_GetTemplateCat:Soap_session Start:@(0) Count:@(99) Success:^(MovierDCInterfaceSvc_VDCTemplateCatArr *array1) {
    //        for(MovierDCInterfaceSvc_TemplateCat* item in array1.item) {
    //            [ws WS_GetStylebyCat:Soap_session CatType:item.nID Start:@(0) Count:@(9) Success:^(MovierDCInterfaceSvc_vpVDCHeaderAndTailArray *array2) {
    //                for (MovierDCInterfaceSvc_vpVDCHeaderAndTailC* item in array2.item) {
    //                    [ws WS_GetDefaultInfoUseStyle:Soap_session StyleID:item.nID Success:^(MovierDCInterfaceSvc_vpVDCMusicC *music,MovierDCInterfaceSvc_vpVDCSubtitleC *subtitle){
    //                        NSLog(@"Style id = %@ url = %@ ,Default music = %@ subtitle = %@",item.nID,item.szThumbnail,music.szName,subtitle.szName);
    //                    } Fail:^(NSError *error) {
    //                        NSLog(@"GetDefaultInfoUseStyle: %@",[error localizedDescription]);
    //                    }];
    //                };
    //            } Fail:^(NSError *error) {
    //                NSLog(@"GetStylebyCat: %@",[error localizedDescription]);
    //            }];
    ////            NSLog(@"GetTemplateCat:%@",item.szThumbnail);
    //        };
    //    } Fail:^(NSError *error) {
    //        NSLog(@"----%s-----%@", __func__, error);
    //    }];
    
    //    for(int i = 0 ; i <5 ; i++) {
    //        [ws WS_GetHeaderNumbyCat:Soap_session CatType:@(i) Success:^(NSNumber *num) {
    //            NSLog(@"Category %d has %@ Template",i,num);
    //        } Fail:^(NSError *error) {
    //            NSLog(@"Category %d error = %@",i,[error localizedDescription]);
    //        }];
    //    };
    
    //    for(int i = 0 ; i <5 ; i++) {
    //        [ws WS_GetHeaderbyCat:Soap_session CatType:@(2) Start:@(0) Count:@(9) Success:^(MovierDCInterfaceSvc_vpVDCHeaderAndTailArray *array) {
    //            NSLog(@"Category %d has %lu Template",i,(unsigned long)[array.item count]);;
    //        } Fail:^(NSError *error) {
    //            ;
    //
    //        }];
    //    };
    
    //    MovierDCInterfaceSvc_IDArray *in = [[MovierDCInterfaceSvc_IDArray alloc]init];
    //    [in.item addObject:@(1478)];
    //    [in.item addObject:@(1476)];
    //
    //    [ws WS_GetVideosInfo:Soap_session IDarray:in Success:^(MovierDCInterfaceSvc_VDCVideoInfoExArray *array) {
    //        ;
    //    } Fail:^(NSError *error) {
    //        ;
    //    }];
    
    //    [ws WS_GetVideoLabel:Soap_session Start:@(0) Count:@(20) Parent:@(0) Success:^(MovierDCInterfaceSvc_VDCVideoLabelExArray *ws_ret) {
    //        [MC_LabelsCtrl RefreshLabels:ws_ret.item];//arbin 20151128测试
    ////        [MC_LabelsCtrl ]
    //    } Fail:^(NSError *error) {
    //        ;
    //    }];
    
    /*    [ws WS_Login:@"www" Password:@"www" withVersion:@"1.0.0" Encrypt:FALSE Success:^(MovierDCInterfaceSvc_VDCSession *ws_session) {
     NSLog(@"%@",ws_session.nSessionID);
     //        [ws WS_GetCommentsNumByVideoid:[[Video Singleton].videoID intValue] Success:^(int num) {
     //            ;
     //        } Fail:^(NSError *error) {
     //            ;
     //        }];
     [ws WS_getossConfig:ws_session Success:^(MovierDCInterfaceSvc_VDCOSSConfig* ossconfig){
     ;
     } Fail:^(NSError *error) {
     ;
     }];
     [ws WS_GetCommentsByVideoid:[[Video Singleton].videoID intValue] Start:0 Count:99 Success:^(MovierDCInterfaceSvc_vpVideoCommentArr* comments) {
     //            MovierDCInterfaceSvc_vpVideoComment *first = [comments.item objectAtIndex:0];
     ////            [ws WS_RemoveCommentByid:[first.nCommentID intValue] Session:ws_session Success:^() {
     ////                ;
     ////            } Fail:^(NSError *error) {
     ////                ;
     ////            }];
     //            [ws WS_ReportCommentByid:[first.nCommentID intValue] Session:ws_session ReportType:1 Reason:@"就是不爽你呀！" Success:^{
     //                ;
     //            } Fail:^(NSError *error) {
     //                ;
     //            }];
     } Fail:^(NSError *error) {
     ;
     }];
     //        [ws WS_SubmitCommentByid:[[Video Singleton].videoID intValue] Session:ws_session Reply:0 Content:@"arbintest" Success:^() {
     //            ;
     //        } Fail:^(NSError *error) {
     //            ;
     //        }];
     } Fail:^(NSNumber *ret,NSError *error) {
     NSLog(@"login ret=%@ %@",ret,[error localizedDescription]);
     }];*/
    //    shoucang = !shoucang;
    //    [ws WS_SetCollectVideo:nil ChangeStatus:shoucang VideoId:@([[Video Singleton].videoID intValue]) Success:^{
    //        ;
    //    } Fail:^(NSError *error) {
    //        ;
    //    }];
    
    //视频访问数
    //    [ws WS_IncreaseVideoShareNum:@([[Video Singleton].videoID intValue]) Success:^(NSNumber *num) {
    //        NSLog(@"increse num %@",num);
    //    } Fail:^(NSError *error) {
    //        ;
    //    }];
    //    MovierDCInterfaceSvc_IDArray *in11 = [[MovierDCInterfaceSvc_IDArray alloc]init];
    //    [in11 addItem:@([[Video Singleton].videoID intValue])];
    //    [ws WS_QueryPraiseStatus:in11 Success:^(MovierDCInterfaceSvc_IDArray *items) {
    //        NSLog(@"query ret = %lu",(unsigned long)[items.item count]);
    //    } Fail:^(NSError *error) {
    //        ;
    //    }];
    //    [ws WS_SetPraise:@([[Video Singleton].videoID intValue]) Status:TRUE Success:^(NSNumber *num) {
    //        NSLog(@"num 代表什么呢？ %@",num);
    //    } Fail:^(NSError *error) {
    //        ;
    //    }];
    
    //    -(void)WS_SetPraise:(NSNumber*)videoID Status:(BOOL)status  Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail;
}


@end
