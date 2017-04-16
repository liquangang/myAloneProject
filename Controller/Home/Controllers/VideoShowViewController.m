//
//  VideoShowViewController.m
//  M-Cut
//
//  Created by arbin on 16/7/19.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "VideoShowViewController.h"
#import "VKVideoPlayerViewController.h"
#import "Video.h"
#import "APPUserPrefs.h"
#import "UIButton+WebCache.h"
#import "NSString+Date.h"
#import "ISVideoReviewCell.h"
#import "ISPlaceholderTextView.h"
#import "CustomeClass.h"
#import "MJRefresh.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "ISCutProViewController.h"
#import "ISStyleDetailCell.h"
#import "CustomLoginAlertView.h"
#import "HomeVideoReportViewController.h"
#import "MyVideoViewController.h"
#import "MBProgressHUD+MJ.h"
#import "HomeVideoReportCommentViewController.h"
#import "customLoginAlertView.h"
#import "LoginViewController.h"
#import "TelephoneViewController.h"
#import "ServiceTermsViewController.h"
#import "UpDateSql.h"
#import "PerfectPersonalInfoViewController.h"

#define __view_InfoHeight 45
#define __view_InputTextHeight 50
#define __view_PlayFrame__Y (SCREEN_WIDTH*9/16)+__view_InfoHeight

@interface VideoShowViewController ()<VKVideoPlayerDelegate,UITableViewDelegate,UITableViewDataSource,ISVideoReviewCellDelegate,UIActionSheetDelegate,UMSocialUIDelegate,UITextViewDelegate,UIActionSheetDelegate, UIGestureRecognizerDelegate>
{
    CustomLoginAlertView *LoginView;
}
@property (weak, nonatomic) IBOutlet UIButton *ownerAcatarButton;
@property (weak, nonatomic) IBOutlet UILabel *videoCreateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoPlayNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *redo;
@property (weak, nonatomic) IBOutlet UIButton *praiseButton;
@property (weak, nonatomic) IBOutlet UILabel *ownerNameLabel;
@property (weak, nonatomic) IBOutlet UIView *videoInfoView;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailview;
@property (weak, nonatomic) IBOutlet UIView *shareView;
@property (weak, nonatomic) IBOutlet UITableView *commentsView;
@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet ISPlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *reviewCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentInputNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *follow;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;

/**  存放评论 Frame 模型 */
@property (strong, nonatomic) NSMutableArray *comments;
/**  加载评论的开始位置 */
@property (assign, nonatomic) int commentStartPos;
/** 视频模版*/
@property(weak,nonatomic)MovierDCInterfaceSvc_vpVDCHeaderAndTailExC *videoStyle;
@property (nonatomic, assign) BOOL isPushFromOtherVc;
/** 视频播放器*/
@property(nonatomic,retain)VKVideoPlayer *vkplayer;
/**   记录当前点击的评论 id */
@property (strong, nonatomic) NSNumber *currentCommentID;
/**  评论次数 */
@property (assign, nonatomic) int commentCount;
/**  记录当前点击的评论所在的 tableview 的 indexPath */
@property (strong, nonatomic) NSIndexPath *indexPath;
/** 选中的评论的id*/
@property (nonatomic, copy) NSString * selectCommentsId;
/**  回复的用户nickname*/
@property (nonatomic, copy) NSString * currentReplyUserNickName;
/**  前一个长按得userid*/
@property (nonatomic, assign) int longTapUserId;
///**  删除自己评论的弹框 */
//@property (weak, nonatomic) UIActionSheet *deleteCommentSheet;
///**  举报他人评论的弹框 */
//@property (weak, nonatomic) UIActionSheet *reportCommentSheet;
/**  视频点赞状态, 0: 用户没有登录;     1:点赞;   2:没有点赞  */
@property (assign, nonatomic) int videoPraiseState;
/**  从个人界面跳转 */
@property (assign, nonatomic) BOOL isPushFromPersonal;
@property(assign,nonatomic) BOOL initPublicSheet;

@property (nonatomic, strong) UIWindow * secondWindow;

@property (nonatomic, strong) CustomLoginAlertView *customLoginAlertView;

/** 键盘高度*/
@property (nonatomic, assign) CGFloat currentKeyboardHeight;
@end

@implementation VideoShowViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DEBUGLOG(@"dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    [self.navigationController.tabBarController.tabBar setHidden:YES];
    [super.navigationController setToolbarHidden:YES animated:TRUE];
    [self setupNavigation];//设置导航栏
    [self setInfo];//设置头部布局
    [self setupPlayer];
    [self setupComments];
    [self loadComments];
    [self isVideoCollection];// 直接获取用户是否收藏过当前影片
    
    // 获取当前用户的点赞状态
    [self getPraiseState];
    
    [self.view bringSubviewToFront:self.thumbnailview];
    
    //如果该影片是当前登录用户的未观看影片，更新观看状态
    [self updateReadStatus];
    //添加登录界面
    self.secondWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.secondWindow.windowLevel= UIWindowLevelAlert;
    self.secondWindow.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroud_shadow"]];
    self.secondWindow.userInteractionEnabled = YES;
    self.customLoginAlertView = [[[NSBundle mainBundle]loadNibNamed:@"CustomLoginAlertView" owner:nil options:nil] lastObject];
    self.customLoginAlertView.layer.masksToBounds = YES;
    self.customLoginAlertView.layer.cornerRadius = 4;
    [self.customLoginAlertView.iphoneLoginButtonClick addTarget:self action:@selector(UsePhoneLoginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.customLoginAlertView.iphoneRegisterButtonClick addTarget:self action:@selector(RegisterButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.customLoginAlertView.agreementButtton addTarget:self action:@selector(agreementButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 检查手机环境
    [self check];
    
    [self.secondWindow addSubview:self.customLoginAlertView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(processGestureRecongnizer:)];
    [tapGesture setNumberOfTouchesRequired:1];
    [tapGesture setNumberOfTapsRequired:1];
    [self.secondWindow addGestureRecognizer:tapGesture];
    
    //注册键盘高度获取通知
    self.currentKeyboardHeight = 0;
    REGISTEREDNOTI(keyboardChange:, UIKeyboardDidChangeFrameNotification);
}

- (void)keyboardChange:(NSNotification *)noti{
    
    [self.view bringSubviewToFront:self.inputView];
    
    CGSize keyboardSize = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    int changHeight = [[NSString stringWithFormat:@"%f", self.currentKeyboardHeight] intValue] - [[NSString stringWithFormat:@"%f", keyboardSize.height] intValue];
    
    self.currentKeyboardHeight = keyboardSize.height;
    WEAKSELF(weakSelf);
    if (changHeight == 0) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.inputView.frame = CGRectMake(weakSelf.inputView.frame.origin.x, weakSelf.inputView.frame.origin.y + keyboardSize.height, weakSelf.inputView.frame.size.width, weakSelf.inputView.frame.size.height);
        }];
        self.currentKeyboardHeight = 0;
        return;
    }
    
   
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.inputView.frame = CGRectMake(weakSelf.inputView.frame.origin.x, weakSelf.inputView.frame.origin.y + changHeight, weakSelf.inputView.frame.size.width, weakSelf.inputView.frame.size.height);
    }];
}

#pragma mark - 登录部分
- (void)processGestureRecongnizer:(UIGestureRecognizer *)gesture
{
    if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
        [self popBackViewAnimation];
        [self performSelector:@selector(windowHidden) withObject:self afterDelay:0.2];
    }
}

- (void)windowHidden{
    [self.secondWindow setHidden:YES];
}

- (void)UsePhoneLoginButtonClick{
    UIStoryboard *mainStroyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginVC =[mainStroyBoard instantiateViewControllerWithIdentifier:@"Login"] ;
    [self.navigationController pushViewController:loginVC animated:YES];
    [self popBackViewAnimation];
    [self performSelector:@selector(windowHidden) withObject:self afterDelay:.5];
}

- (void)RegisterButtonClick{
    UIStoryboard *mainStroyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TelephoneViewController *telephoneVC =[mainStroyBoard instantiateViewControllerWithIdentifier:@"telephone"] ;
    [self.navigationController pushViewController:telephoneVC animated:YES];
    [self popBackViewAnimation];
    [self performSelector:@selector(windowHidden) withObject:self afterDelay:.5];
}

- (void)agreementButtonAction{
    [self windowHidden];
    UIStoryboard *setStroyBoard = [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
    ServiceTermsViewController *serviceTermsVC =[setStroyBoard instantiateViewControllerWithIdentifier:@"ServiceTermsVCStoryBoardID"];
    serviceTermsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:serviceTermsVC animated:YES];
}

- (void)check {
    // 1. 判断是手机还是模拟器
    UIDevice *device =[UIDevice currentDevice];
    NSLog(@"%@",[device model]);
    // 如果是模拟器, 提示在真机上运行
    if (([[device model] isEqualToString:@"iPad Simulator"]||[[device model]isEqualToString:@"iPhone Simulator"])) {
        // 模拟器环境
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请在真机上运行" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    } else {    // 真机环境
        if( ![WXApi isWXAppInstalled]) {    // 如果没有安装微信
            self.customLoginAlertView.WeChatLoginButton.hidden = YES;
        } else {    // 执行登陆操作
            self.customLoginAlertView.WeChatLoginButton.hidden = NO;
            [self.customLoginAlertView.WeChatLoginButton addTarget:self action:@selector(weChatLoginButtonClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

#pragma mark -- 从下往上弹出动画
-(void)popViewAnimation{
    [UIView beginAnimations:@"popViewAnimation" context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [self.secondWindow makeKeyAndVisible];
    self.customLoginAlertView.frame = CGRectMake((self.view.width - 240)/2, (self.view.height - 200)/2, 240, 200);
    [UIView commitAnimations];
}

#pragma mark -- 由上往下弹回动画
-(void)popBackViewAnimation{
    [UIView beginAnimations:@"popBackViewAnimation" context:NULL];
    [UIView setAnimationDuration:.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.customLoginAlertView.frame = CGRectMake((self.view.width - 240)/2, SCREEN_HEIGHT, 240, 200);
    [UIView commitAnimations];
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
            WEAKSELF(weakSelf);
            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
                NSLog(@"SnsInformation is %@",response.data);
                NSLog(@"profile_image_url ---- %@", response.data[@"profile_image_url"]);
                // 1. 给映像服务器发送请求, 注册账号/或者登陆
                [weakSelf registerFromServer:response.data];
                
            }];
#pragma mark -- 原有代码
            // 1. 退出登陆界面
            [self popBackViewAnimation];
            [self performSelector:@selector(windowHidden) withObject:self afterDelay:.5];
            
        } else {
            [CustomeClass showMessage:@"从微信获取信息失败" ShowTime:1.5];
        }
    });
}

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
    
    //    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    /*
     NSURL * URL = [NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
     NSURLRequest * request = [[NSURLRequest alloc]initWithURL:URL];
     NSURLResponse * response = nil;
     NSError * error = nil;
     NSDictionary *abc = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
     if (error) {
     NSLog(@"error: %@",[error localizedDescription]);
     }else{
     NSLog(@"response : %@",response);
     NSLog(@"backData : %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
     }*/
    
    // 用户名
    NSString *screen_name = [wechatinfo[@"nickname"] length] == 0 ? @"" : wechatinfo[@"nickname"];
    // 头像
    NSString *Profile = [wechatinfo[@"headimgurl"] length] == 0 ? @"" : wechatinfo[@"headimgurl"];
    //此处未使用
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
    
    WEAKSELF(weakSelf);
    [[SoapOperation Singleton] WS_Login:account.szAccount ThirdPartyType:@"1" Token:account.szPwd Openid:account.szAccount APPVersion:[UpDateSql getAPPVersion] SubVersion:[UpDateSql getAPPVersion] Success:^(MovierDCInterfaceSvc_VDCSession* ws_session) {
        //初始化userentity
        [[UserEntity sharedSingleton] Applogin:account.szAccount appPwd:account.szPwd LoginType:LoginTypeWeChat];
        [UserEntity sharedSingleton].sessionId = [[NSString alloc] initWithFormat:@"%@",ws_session.nSessionID];
        [UserEntity sharedSingleton].customerId = [NSString stringWithFormat:@"%@",ws_session.nCustomerID];
        [UserEntity sharedSingleton].ossDir = ws_session.szRootDir;
        [UserEntity sharedSingleton].ossKey = ws_session.szKey;
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //            [avatar sd_setImageWithURL:[NSURL URLWithString:account.szAcatar] placeholderImage:[UIImage imageNamed:@"head"] options:SDWebImageRetryFailed | SDWebImageRefreshCached];
        //            _UserName.text = account.szNickName;
        //            _UserSingature.text = @"";
        //        });
        
        [weakSelf fillUseEntity:ws_session];
        [[SoapOperation Singleton] WS_GetossConfig:ws_session Success:^(MovierDCInterfaceSvc_VDCOSSConfig *ossconfig) {
            [UserEntity sharedSingleton].ossBucket = ossconfig.szBucket;
            [UserEntity sharedSingleton].ossID = ossconfig.szID;
            [UserEntity sharedSingleton].ossKey = ossconfig.szKey;
            [UserEntity sharedSingleton].ossEndpoint = ossconfig.szEndpoint;
            [[APPUserPrefs Singleton] StartOrderT];
            
            //传输cid和devicetoken给后台
            [[SoapOperation Singleton] WS_operatedevicelistWithOperationType:1 Success:^(NSNumber *num) {
                NSLog(@"向后台发送cid和deviceToken成功");
            } Fail:^(NSError *error) {
                NSLog(@"向后台发送cid和deviceToken失败---%@", error);
            }];
            
        } Fail:^(NSError *error) {
            NSLog(@"get oss config error!");
            NSLog(@"%@",[error localizedDescription]);
        }];
    } Fail:^(NSNumber *LoginStatus,NSError *error) {
        if ([LoginStatus isEqualToNumber:@(MOVIERDC_SERVER_INVALIDUSERORPWD)]) {
            //跳转注册页面
            [weakSelf userRegister:data andDetail:wechatinfo];
        };
    }];
    
    //    [self WeChatRegister];//手机号码填充页，把用户信息传递过去后，再注册，注册完成后回到根目录
    
    //    [[SoapOperation Singleton] WS_Register:account ThirdType:@(1) Success:^(NSNumber *retvalue) {
    //        ;[self loadingUseInfo:retvalue withinfo:data];
    //    } Fail:^(NSError *error,NSNumber *retstatus) {
    //        [self showMessage:@"微信注册失败"];
    //    }];
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
            [UserEntity sharedSingleton].szNickname = info.szNickname;
            [UserEntity sharedSingleton].szSignature = info.szSignature;
            [UserEntity sharedSingleton].szAcatar = info.szAcatar;
            
        });
    } Fail:^(NSError *error) {
        DEBUGLOG(error)
    }];
}


- (void)updateReadStatus{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[VideoDBOperation Singleton] updateNewVideoReadStatus:[NSString stringWithFormat:@"%@", [Video Singleton].videoID]];
    });
}

/**  判断是否收藏  YES: 收藏,  NO: 没有收藏  */
- (void)isVideoCollection {
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
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
                vc.collectButton.selected = YES;
            }else{
                vc.collectButton.selected = NO;
            }
//            [vc.collectButton setEnabled:true];
        })
        
    } Fail:^(NSError *error) {
        DEBUGLOG(error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)comments {
    if (!_comments) {
        self.comments = [NSMutableArray array];
    }
    return _comments;
}

-(void)setupComments{
    self.commentStartPos = 0;
    CGRect frame = self.shareView.frame = CGRectMake(0, __view_PlayFrame__Y, SCREEN_WIDTH, 65);
    self.commentsView.frame = CGRectMake(0, frame.origin.y+frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-20-NavigationBar_HEIGHT - frame.origin.y-frame.size.height-__view_InputTextHeight);

    // 设置评论的数据源和代理
    self.commentsView.delegate = self;
    self.commentsView.dataSource = self;
    self.commentsView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.commentsView addHeaderWithTarget:self action:@selector(addHeader)];
    [self.commentsView addFooterWithTarget:self action:@selector(addFooter)];
    
    self.inputView.frame = CGRectMake(0, self.commentsView.frame.origin.y+self.commentsView.frame.size.height, SCREEN_WIDTH, __view_InputTextHeight);
    UIView *textview = (UIView*)[self.inputView viewWithTag:10];
    textview.frame = CGRectMake(textview.origin.x, textview.origin.y, SCREEN_WIDTH - 60, textview.size.height);
    UIView *sendcomment = (UIView*)[self.inputView viewWithTag:11];
    sendcomment.frame = CGRectMake(textview.size.width+6, sendcomment.origin.y, sendcomment.size.width, sendcomment.size.height);
    self.textView.delegate = self;
    
    //  监听键盘的出现和消失
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
//    REGISTEREDNOTI(keyboardChange:, UIKeyboardDidChangeFrameNotification);
//    self.currentkeyboardHeight = 0;
    
}

- (void)setupPlayer {
    if(!self.vkplayer){
        self.vkplayer = [[VKVideoPlayer alloc] init];
        self.vkplayer.delegate = self;
        self.vkplayer.view.playerControlsAutoHideTime = @5;
        [self.view addSubview:self.vkplayer.view];
        self.vkplayer.forceRotate = YES;//打开旋转代理。
//        self.vkplayer.supportedOrientations = UIInterfaceOrientationMaskAllButUpsideDown;
        [self playStream:[NSURL URLWithString:[Video Singleton].videoReferenceUrl]];
    }
    CGRect frameRect = CGRectMake(0, __view_InfoHeight, SCREEN_WIDTH, SCREEN_WIDTH*9/16);
    frameRect.size.height = frameRect.size.width*9/16;
    self.vkplayer.view.frame = frameRect;
    [self.vkplayer.view.doneButton setHidden:YES];
}

- (void)playStream:(NSURL*)url {
    VKVideoPlayerTrack *track = [[VKVideoPlayerTrack alloc] initWithStreamURL:url];
    track.hasNext = YES;
    [self.vkplayer loadVideoWithTrack:track];
}

- (IBAction)clickPraise:(id)sender
{
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
//        [self.collectButton setEnabled:false];
        [self popViewAnimation];
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
//    [self.praiseButton setTitle:praiseNum forState:self.praiseButton.selected?UIControlStateSelected:UIControlStateNormal];
    [self.praiseButton setTitle:praiseNum forState:UIControlStateNormal];
    [Video Singleton].videoNumberOfPraise = praiseNum;
    [[SoapOperation Singleton] WS_SetPraise:@([[Video Singleton].videoID intValue]) Status:!state Success:^(NSNumber *num) {
        NSLog(@"---WS_SetPraise  success---------");
    } Fail:^(NSError *error) {
        NSLog(@"fail--------%s-----%@", __func__, error);
    }];
}
//收藏按钮点击方法
- (IBAction)collectButtonAction:(id)sender {
//    [self.collectButton setEnabled:false];
    [self collectCurrentVideo];
}
/**  收藏\取消收藏 评论 */
- (void)collectCurrentVideo {
    if (![UserEntity sharedSingleton].isAppHasLogin) {
        [self popViewAnimation];
        return;
    }
    SoapOperation *soap = [SoapOperation Singleton];
    WEAKSELF(vc);
    int videoID = [[Video Singleton].videoID intValue];
    [soap WS_SetCollectVideo:nil ChangeStatus:!vc.collectButton.selected VideoId:@(videoID) Success:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *collnum;
            if (!vc.collectButton.selected == YES)
            {
                [UIWindow showMessage:@"收藏成功" withTime:2.0];
                collnum = [NSString stringWithFormat:@"%d", [[Video Singleton].videoNumberOfFavorite intValue]+1];
            }else{
                collnum = [NSString stringWithFormat:@"%d", [[Video Singleton].videoNumberOfFavorite intValue]];
            }
            [vc.collectButton setTitle:collnum forState:UIControlStateNormal];
            vc.collectButton.selected =!vc.collectButton.selected;
//            [vc.collectButton setEnabled:true];
        });
    } Fail:^(NSError *error) {
        DEBUGLOG(error)
    }];
}

- (void)setInfo {
    self.selectCommentsId = @"";
    self.currentReplyUserNickName = @"";
    [self followStatus];//
    self.videoInfoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, __view_InfoHeight);
    // 头像
    self.ownerAcatarButton.layer.cornerRadius = 15;
    self.ownerAcatarButton.clipsToBounds = YES;
    NSURL *url = [NSURL URLWithString:[Video Singleton].ownerAcatar];
    [self.ownerAcatarButton sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"head"]];
//    [self.ownerAcatarButton addTarget:self action:@selector(ownerAcatarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 视频缩略图
    self.thumbnailview.image = [[APPUserPrefs Singleton]APP_getImg:[Video Singleton].videoThumbnailUrl ImageView:self.thumbnailview ImageName:@"huan"];
    self.ownerNameLabel.text = [Video Singleton].ownerName;
    
    // 创建时间
    NSString *createTime = [[Video Singleton].videoCreateTime time_isNeedShowYear];
//    CGSize timeLabelSize = [createTime sizeWithWidth:MAXFLOAT font:ISFont_13];
    self.videoCreateTimeLabel.text = createTime;
    
    UIView *view_follow = (UIView*)[self.videoInfoView viewWithTag:10];
    view_follow.frame = CGRectMake(self.videoInfoView.width-70, view_follow.origin.y, view_follow.size.width, view_follow.size.height);
    UIView *view2_copy = (UIView*)[self.shareView viewWithTag:11];
    view2_copy.frame = CGRectMake(self.videoInfoView.width-70, view2_copy.origin.y, view2_copy.size.width, view2_copy.size.height);
    UIView *view_line = (UIView*)[self.shareView viewWithTag:12];
    view_line.frame = CGRectMake(view_line.origin.x, view_line.origin.y, self.videoInfoView.width-20, view_line.size.height);
    
    // 点赞数量
    NSString *praise = [Video Singleton].videoNumberOfPraise;
//    CGSize praiseSize = [praise sizeWithWidth:MAXFLOAT font:ISFont_14];
//    if (praiseSize.width > 50) {
//        self.videoPraiseLabelWidth.constant = praiseSize.width;
//    }
    [self.praiseButton setTitle:praise forState:UIControlStateNormal];
    

    
    
    [self.praiseButton setImage:[UIImage imageNamed:@"praiseSelectImage"] forState:UIControlStateSelected];
    [self.praiseButton setImage:[UIImage imageNamed:@"赞icon-拷贝-2"] forState:UIControlStateNormal];
    
    [self increaseVisitCount];
    
    //设置收藏的图片
    [self.collectButton setImage:[UIImage imageNamed:@"selectCollectImage"] forState:UIControlStateSelected];//选中图片
    [self.collectButton setImage:[UIImage imageNamed:@"collectImage"] forState:UIControlStateNormal];//未选中图片
    [self.collectButton setTitle:[NSString stringWithFormat:@"%d", [[Video Singleton].videoNumberOfFavorite intValue]] forState:UIControlStateNormal];
    
    WEAKSELF(weakSelf);
    [[SoapOperation Singleton] WS_GetStylebyVideoId:@([[Video Singleton].videoID integerValue]) Success:^(MovierDCInterfaceSvc_vpVDCHeaderAndTailExC *style) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.redo setHidden:NO];
        });
    } Fail:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.redo setHidden:YES];
        });
    }];
}

- (void)increaseVisitCount{
    //增加点赞数量
    WEAKSELF(weakSelf);
    [[SoapOperation Singleton] WS_IncreaseVisit:[NSNumber numberWithInt:[[Video Singleton].videoID intValue]] Success:^(NSNumber *num) {
        DEBUGSUCCESSLOG(num)
        dispatch_async(dispatch_get_main_queue(), ^{
            // 播放次数
            NSString *playCount = [num stringValue];
            NSInteger count = [playCount integerValue];
            if (count > 10000) {
                playCount = [NSString stringWithFormat:@"%.1f 万播放", count / 10000.0];
            }
            weakSelf.videoPlayNumLabel.text = playCount;
        });
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf increaseVisitCount];)
    }];
}

- (void)followStatus{
    
    //先默认隐藏
    self.follow.hidden = YES;
    
    if ([[Video Singleton].ownerID isEqualToString:CURRENTUSERID]) {
        self.follow.hidden = YES;
    }else{
        WEAKSELF(weaKself);
        [[SoapOperation Singleton] WS_getfriendrelationWithUserId:[Video Singleton].ownerID Success:^(NSNumber *successInfo) {
            DEBUGSUCCESSLOG(successInfo);
            MAINQUEUEUPDATEUI({
                if ([successInfo intValue] == 1 || [successInfo intValue] == 2) {
                    //隐藏关注按钮
                    weaKself.follow.hidden = YES;
                }else{
                    weaKself.follow.hidden = NO;
                }
            })
        } Fail:^(NSError *error) {
            DEBUGLOG(error);
        }];
    }
}
- (IBAction)followSomeone:(id)sender {
    WEAKSELF(weakSelf);
    [[SoapOperation Singleton] WS_followWithCustomID:[Video Singleton].ownerID Success:^(NSNumber *num) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomeClass showMessage:@"关注成功" ShowTime:2];
            weakSelf.follow.hidden = YES;
        });
    } Fail:^(NSError *error) {
        DEBUGLOG(error);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error.code == 42) {
                weakSelf.follow.hidden = YES;
            }else{
                [CustomeClass showMessage:@"关注失败" ShowTime:1.5];
            }
        });
    }];
}
- (void)setupNavigation {
    NSString *title = [Video Singleton].videoName;
    if (title.length > 15) {
        title = [title substringToIndex:14];
        title = [NSString stringWithFormat:@"%@...", title];
    }
    self.navigationItem.title = title;
    UIButton *moreCtrlBtn = [UIButton new];
    moreCtrlBtn.frame = CGRectMake(0, 0, 20, 20);
    [moreCtrlBtn setImage:[UIImage imageNamed:@"little"] forState:UIControlStateNormal];
    [moreCtrlBtn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreCtrlBtn];
    if (self.isPushFromOtherVc == NO) {
        //返回按钮
        UIButton * backBtn = [UIButton new];
        backBtn.frame = CGRectMake(0, 0, 20, 20);
        [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
    if([[Video Singleton].ownerID isEqualToString:[UserEntity sharedSingleton].customerId] ){
        self.isPushFromPersonal = YES;
    }else{
        self.isPushFromPersonal = NO;
    }
    if([[Video Singleton].videoShare isEqualToString:@"0"]){
        self.initPublicSheet = false;
    }else{
        self.initPublicSheet = true;
    }
}

/** 返回按钮点击方法*/
- (void)backButtonAction{
    [self.vkplayer.avPlayer.currentItem cancelPendingSeeks];
    [self.vkplayer.avPlayer.currentItem.asset cancelLoading];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)moreAction{
    //如果键盘出来了，就隐藏
    [self.view endEditing:YES];
    
    UIActionSheet *videoSheet = nil;
    if (self.isPushFromPersonal == YES) {
        NSString *isPublic = nil;
        if (self.initPublicSheet) {    // 当前视频是公开状态
            isPublic = @"仅自己可见";
        } else {    //  当前视频是私有状态
            isPublic = @"公开";
        }
        videoSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:isPublic otherButtonTitles:@"删除", nil];
        videoSheet.destructiveButtonIndex = 1;
        videoSheet.tag = 1;//tag ＝ 1 表示公开 私有视频
        [videoSheet showInView:self.view];
    } else {
        // 2. 判断当前视频是否已经被当前用户收藏, 当前用户已经收藏, 显示"取消收藏"; 当前用户没有收藏, 显示 "收藏"
        NSString *collect = nil;
        if (self.collectButton.selected == YES) {
            collect = @"取消收藏";
        } else {
            collect = @"收藏";
        }
        videoSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"举报" otherButtonTitles:nil];
        videoSheet.destructiveButtonIndex = 1;
        videoSheet.tag = 2;//tag ＝ 1 表示举报该视频
        [videoSheet showInView:self.view];
    }
}

/**  下拉更新评论 */
- (void)addHeader {
    [self loadComments];
    [self.commentsView headerEndRefreshing];
}

/**  上拉加载更多评论 */
- (void)addFooter {
    // 更新评论的开始位置, 每次加载20个评论
    self.commentStartPos = (int)self.comments.count;
    [self loadComments];
    [self.commentsView footerEndRefreshing];
}

/** 举报视频*/
- (void)reportCurrentVideo {
    
    if (![UserEntity sharedSingleton].isAppHasLogin) {
        [self popViewAnimation];
        return;
    }
    
    // 进入举报界面
    HomeVideoReportViewController *report = [[HomeVideoReportViewController alloc] initWithNibName:@"HomeVideoReportViewController" bundle:nil];
    [self.navigationController pushViewController:report animated:YES];
}
/**  删除自己的评论 */
- (void)deleteMyComment {
    UIAlertView *deleteCommentAlert = [[UIAlertView alloc] initWithTitle:nil message:@"确定删除吗?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [deleteCommentAlert show];
}

/**  举报评论 */
- (void)reportComment {
    if (![UserEntity sharedSingleton].isAppHasLogin) {
        [self popViewAnimation];
        return;
    }
    
    HomeVideoReportCommentViewController *reportComment = [[HomeVideoReportCommentViewController alloc] initWithNibName:@"HomeVideoReportCommentViewController" bundle:nil];
    reportComment.commentID = self.currentCommentID;
    [self.navigationController pushViewController:reportComment animated:YES];
}

/**  设置个人  是否公开视频  的状态 */
- (void)changePersonalVideoPublicState {
    WEAKSELF(weakSelf);
    int videoID = [[Video Singleton].videoID intValue];
    [[SoapOperation Singleton] WS_ChangeVideoStatus:@(videoID) Status:!weakSelf.initPublicSheet Success:^(NSNumber *num) {
        weakSelf.initPublicSheet = !weakSelf.initPublicSheet;
        [Video Singleton].videoShare = weakSelf.initPublicSheet?@"1":@"0";//视频公开状态。0:视频私有、未公开。1:视频公开。2:未公开,但是朋友可以访问。
    } Fail:^(NSError *error) {
        NSLog(@"---------%s-------%@", __func__, error);
    }];
}

/**  删除个人当前视频 */
- (void)deleteCurrentVideo {
    WEAKSELF(weakSelf);
    int videoID = [[Video Singleton].videoID intValue];
    [[SoapOperation Singleton] WS_DeleteVideo:@(videoID) Success:^(NSNumber *num) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    } Fail:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showError:@"请检查网络!"];
        });
    }];
}

- (void)loadComments {
    // 根据视频 id, 加载评论的总数
    WEAKSELF(weakSelf);
    SoapOperation *ws = [SoapOperation Singleton];
    int videoId = [[Video Singleton].videoID intValue];
    [ws WS_GetCommentsNumByVideoid:@(videoId) Success:^(NSNumber *num) {
        weakSelf.commentCount = [num intValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.reviewCountLabel.text = [NSString stringWithFormat:@"共%@条评论", num];
        });
    } Fail:^(NSError *error){
        NSLog(@"----%s-----%@", __func__, [error localizedDescription]);
    }];
    
    // 根据视频 id, 加载对应的评论
    [ws WS_GetCommentsByVideoid:@(videoId) Start:@(weakSelf.commentStartPos) Count:@(20) Success:^(MovierDCInterfaceSvc_vpVideoCommentArr* comments) {
        if (weakSelf.commentStartPos == 0) {
            [weakSelf.comments removeAllObjects];
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
            [weakSelf.comments addObject:commF];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.commentsView reloadData];
        });
    } Fail:^(NSError *error) {
        NSLog(@"----%s-------%@", __func__, [error localizedDescription]);
    }];
    
}

/**  获得当前用户 对 当前视频的点赞状态
 *      0:用户未登录,    1:用户登录, 没有对当前视频点赞,  2:用户登录, 对当前视频点赞
 */
- (void)getPraiseState {
//    [self.praiseButton setEnabled:false];//未获取点赞状态前禁用点赞按钮
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
//            [vc.praiseButton setEnabled:true];
            NSLog(@"----%s----%d", __func__, vc.videoPraiseState);
        } Fail:^(NSError *error) {
            NSLog(@"----%s-----%@", __func__, error);
        }];
    } else {
        vc.videoPraiseState = 0;
        vc.praiseButton.selected = NO;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [self.vkplayer playContent];
    self.vkplayer.forceRotate = YES;
    [self.vkplayer.player play];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.vkplayer pauseContent];
    self.vkplayer.forceRotate = NO;
    [self.vkplayer.player pause];
//    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:UIKeyboardDidShowNotification];
//    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:UIKeyboardDidHideNotification];
}
- (IBAction)ownerAcatarButtonAction:(id)sender {
    // 根据  评论者的 ID(nCustomerID) 跳转到个人详情页
    //    OtherPeopleViewController *other = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OthersVCStoryBoardID"];
    //    other.customID = [[Video Singleton].ownerID intValue];
    //    other.userNickName = [Video Singleton].ownerName;
    //    other.iconUrl = [Video Singleton].ownerAcatar;
    if (![UserEntity sharedSingleton].isAppHasLogin) {
        MAINQUEUEUPDATEUI({
            [self popViewAnimation];
        })
        return;
    }
    MyVideoViewController * videoVc = [MyVideoViewController new];
    if (![[Video Singleton].ownerID isEqualToString:CURRENTUSERID]) {
        videoVc.isShowOtherUserVideo = YES;
        videoVc.userId = [Video Singleton].ownerID;
    }
    [self.navigationController pushViewController:videoVc animated:YES];
}
-(void)Notloggedin
{
    //    secondWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    //    secondWindow.windowLevel= UIWindowLevelAlert;
    //    secondWindow.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroud_shadow"]];
    //    secondWindow.userInteractionEnabled = YES;
    //    customLoginAlertView = [[[NSBundle mainBundle]loadNibNamed:@"CustomLoginAlertView" owner:nil options:nil] lastObject];
    //    [customLoginAlertView.iphoneLoginButtonClick addTarget:self action:@selector(iphoneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //    customLoginAlertView.frame = CGRectMake((self.view.width - 240)/2, self.view.height, 240, 200);
    //    [secondWindow addSubview:customLoginAlertView];
    //    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(processGestureRecongnizer:)];
    //    [tapGesture setNumberOfTouchesRequired:1];
    //    [tapGesture setNumberOfTapsRequired:1];
    //    [secondWindow addGestureRecognizer:tapGesture];
    //    [customLoginAlertView.WeChatLoginButton addTarget:self action:@selector(weChatLoginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //    [customLoginAlertView.iphoneRegisterButtonClick addTarget:self action:@selector(RegisterButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //    [self popViewAnimation];
}
//跳转制作页面
-(void)presentCreatePage{
    
    WEAKSELF(weakSelf);
    [[SoapOperation Singleton] WS_GetStylebyVideoId:@([[Video Singleton].videoID integerValue])
                                            Success:^(MovierDCInterfaceSvc_vpVDCHeaderAndTailExC *headerAndTail) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //数据库订单数据填充
            NewNSOrderDetail *fresh = [MC_OrderAndMaterialCtrl
                                       GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
            fresh.nHeaderAndTailID = [headerAndTail.nID intValue];
            [MC_OrderAndMaterialCtrl UpdateFresh:fresh];
            ISCutProViewController *cut = [[UIStoryboard storyboardWithName:@"Preview" bundle:nil] instantiateViewControllerWithIdentifier:@"ISCutProRechoose_ID"];
            cut.isTransFromPreview = YES;//使用返回键
            cut.next2Preview = YES;//下一步直接跳转preview界面
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
            cut.HideTabbar = YES;//storyboard加载时默认值是NO
            [weakSelf.navigationController pushViewController:cut animated:YES];
        });
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf presentCreatePage];);
    }];
}
#pragma mark ---- UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag==1){
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
    }else if(actionSheet.tag == 2){//举报该视频
        switch (buttonIndex) {      // 0: 收藏  1:举报  2:取消
            case 0:    // 举报
                [self reportCurrentVideo];
                break;
            case 1:
            case 2:
            default:
                break;
        }
    }else if(actionSheet.tag == 3){//删除个人评论
        switch (buttonIndex) {
            case 0:     // 删除自己的评论
                [self deleteMyComment];
                break;
            default:
                break;
        }
    }else if(actionSheet.tag == 4){//举报个人评论
        switch (buttonIndex) {
            case 0:     // 举报
                [self reportComment];
                break;
            default:
                break;
        }
    }
}
#pragma mark -- 分享
- (IBAction)transportButtonAction:(id)sender {
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
        [self popViewAnimation];
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
                                         shareImage:self.thumbnailview.image
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToSina,UMShareToQQ,UMShareToQzone,nil]
                                           delegate:self];
    }
}
- (IBAction)copyvideo:(id)sender {
    
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
        [self popViewAnimation];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark ----VKVideoPlayerDelegate
- (void)videoPlayer:(VKVideoPlayer*)videoPlayer didControlByEvent:(VKVideoPlayerControlEvent)event{
    if(event == VKVideoPlayerControlEventTapDone&&videoPlayer.visibleInterfaceOrientation==UIDeviceOrientationPortrait){
        videoPlayer.isFullScreen = false;
        self.vkplayer.view.frame = CGRectMake(0, __view_InfoHeight, SCREEN_WIDTH, SCREEN_WIDTH*9/16);
//        [videoPlayer.view.doneButton setHidden:YES];
        [super.navigationController setNavigationBarHidden:NO animated:TRUE];
        [self.textView setEditable:true];
        self.commentsView.userInteractionEnabled = true;//影响播放器的interaction
//        CGRect frame = self.shareView.frame;
//        self.commentsView.frame = CGRectMake(0, frame.origin.y+frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-20-NavigationBar_HEIGHT - frame.origin.y-frame.size.height-__view_InputTextHeight);
    }
    if(event == VKVideoPlayerControlEventTapPlay&&[videoPlayer.track isPlayedToEnd]){
        [videoPlayer reloadCurrentVideoTrack];
    }
}

- (void)videoPlayer:(VKVideoPlayer*)videoPlayer willChangeOrientationTo:(UIInterfaceOrientation)orientation{
    
    [super.navigationController setNavigationBarHidden:YES animated:TRUE];
    [super.navigationController setToolbarHidden:YES animated:TRUE];
    [self.view bringSubviewToFront:self.vkplayer.view];
//    CGRect rt = self.commentsView.frame;
//    rt.size.height = 0;
//    self.commentsView.frame = rt;
//    self.commentsView.userInteractionEnabled = false;//影响播放器的interaction
//    [self.textView setEditable:false];

//    if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight){
//        self.thumbnailview.frame = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_HEIGHT);
//
//    }else{
//        self.thumbnailview.frame = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_HEIGHT);
//    }
    //    self.thumbnailview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    [self.view bringSubviewToFront:self.thumbnailview];
//    [self.thumbnailview bringSubviewToFront:self.vkplayer.view];
}

- (void)updateNotPop{
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)updateCanPop{
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark  ------评论----- <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BACKPROPMTVIEW(self.comments.count == 0, 1000000, @"暂无评论\n快快抢沙发呦", commentsView)
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ISVideoReviewCell *cell = [ISVideoReviewCell reviewCellWithTableView:tableView];
    cell.commentF = self.comments[indexPath.row];
    cell.delegate = self;
    cell.commentUserId = cell.commentF.comment.nCustomerID;
    WEAKSELF(weakSelf);
    [cell longTapOperation:^(int commentUserId, int commentId) {
        [weakSelf cellLongTapOperationWithCommentUserId:commentUserId CommentId:commentId];
    }];
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

- (void)cellLongTapOperationWithCommentUserId:(int)commentUserId CommentId:(int)commentId{
        if (commentUserId == [CURRENTUSERID intValue]) {
            UIActionSheet *deleteCommentSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles: nil, nil];
            deleteCommentSheet.tag = 3;//删除自己评论sheet tag
            [deleteCommentSheet showInView:self.view];
        } else {
            UIActionSheet *reportCommentSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"举报" otherButtonTitles: nil, nil];
            [reportCommentSheet showInView:self.view];
            reportCommentSheet.tag = 4;//删除自己评论sheet tag
        }
}

/** cell上点击头像的回调方法*/
- (void)reviewCell:(ISVideoReviewCell *)reviewCell didClickIconButton:(UIButton *)button{
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
        [self popViewAnimation];
        return;
    }

    MyVideoViewController * videoVc = [MyVideoViewController new];
    if (![[NSString stringWithFormat:@"%d", reviewCell.commentUserId] isEqualToString:CURRENTUSERID]) {
        videoVc.isShowOtherUserVideo = YES;
        videoVc.userId = [NSString stringWithFormat:@"%d", reviewCell.commentUserId];
    }
    [self.navigationController pushViewController:videoVc animated:YES];
}

//- (void)cellTap:(int)commmentUserId{
//    if (self.longTapUserId == commmentUserId) {
//        return;
//    }
//    self.longTapUserId = commmentUserId;
//    int commentCustomID = commmentUserId;
//    int loginedCustomID = [[UserEntity sharedSingleton].customerId intValue];
//    if (commentCustomID == loginedCustomID) {
//        UIActionSheet *deleteCommentSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles: nil, nil];
//        deleteCommentSheet.tag = 3;//删除自己评论sheet tag
//        [deleteCommentSheet showInView:self.view];
//    } else {
//        UIActionSheet *reportCommentSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"举报" otherButtonTitles: nil, nil];
//        [reportCommentSheet showInView:self.view];
//        reportCommentSheet.tag = 4;//删除自己评论sheet tag
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.comments[indexPath.row] cellHeight];
}

#pragma mark --- -UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (![UserEntity sharedSingleton].isAppHasLogin) {
        [self popViewAnimation];
        [self.view endEditing:YES];
        return;
    }
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
        [self popViewAnimation];
        [self endEditing];
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
 //键盘显示和消失时, 底部视图的动画显示
- (void)keyboardShow:(NSNotification *)noti {
    // 动画执行时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // 键盘的尺寸
    CGRect keyboardF = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 设置输入框的偏移量
    [UIView animateWithDuration:duration animations:^{
        CGRect rt = self.inputView.frame;
        rt.origin.y -= keyboardF.size.height;
        self.inputView.frame = rt;
        [self.view bringSubviewToFront:self.inputView];
    }];
}

- (void)keyboardHide:(NSNotification *)noti {
    // 动画执行时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // 键盘的尺寸
    CGRect keyboardF = [noti.userInfo[UIKeyboardBoundsUserInfoKey] CGRectValue];
    
    // 设置输入框的偏移量
    WEAKSELF(weakSelf);
    [UIView animateWithDuration:duration animations:^{
//        self.commentViewButtom.constant = keyboardF.origin.y;
        CGRect rt = weakSelf.inputView.frame;
        rt.origin.y += keyboardF.size.height;
        weakSelf.inputView.frame = rt;
        [weakSelf.view bringSubviewToFront:weakSelf.thumbnailview];
    }];
}

- (void)sendComment:(NSString *)comment {
    
    NSNumber * commentsId = [NSNumber numberWithInt:[self.selectCommentsId intValue]];
    NSRange myRange = [comment rangeOfString:self.currentReplyUserNickName];
    if (myRange.length == 0) {
        //认为是评论
        commentsId = @(0);
    }
    WEAKSELF(weakSelf);
    SoapOperation *ws = [SoapOperation Singleton];
    [ws WS_SubmitCommentByid:[NSNumber numberWithInteger:[[Video Singleton].videoID integerValue]] Session:nil Reply:commentsId Content:comment Success:^{
        // 更新数据----全部刷新, 从0开始
        [weakSelf.comments removeAllObjects];
        weakSelf.commentStartPos = 0;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([commentsId intValue] != 0) {
                //回复
                [CustomeClass showMessage:@"回复成功" ShowTime:1.5];
                
            }else{
                [CustomeClass showMessage:@"评论成功" ShowTime:1.5];
            }
            [weakSelf loadComments];
        });
    } Fail:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomeClass showMessage:@"评论失败" ShowTime:1.5];
        });
        DEBUGLOG(error);
        
    }];
}
#pragma mark -- UMSocialUIDelegate
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
    if (response.responseCode == UMSResponseCodeSuccess) {      // 分享成功
//        int videoID = [[Video Singleton].videoID intValue];
//#pragma mark --- 奖券
//        [self GetCouponmanytime:@(videoID)];
//#pragma mark ---- 分享数
//        [[SoapOperation Singleton] WS_IncreaseVideoShareNum:@(videoID) Success:^(NSNumber *num) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.videoNumberOfShareLabel.text = [NSString stringWithFormat:@"%@", num];
//            });
//        } Fail:^(NSError *error) {
//            NSLog(@"-----%s----%@", __func__, error);
//        }];
    }
}
#pragma mark ---  UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10) {
        if (buttonIndex != 0) {
            NewNSOrderDetail *fresh = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
            fresh.nVideoLength =0.0;
            [MC_OrderAndMaterialCtrl UpdateFresh:fresh];
            [MC_OrderAndMaterialCtrl DeleteMaterialsInOrder:[[UserEntity sharedSingleton].customerId intValue] Orderid:fresh.order_id];
            
            [CustomeClass deleteFileWithFileName:[NSString stringWithFormat:@"%@/Documents/orderThumail", NSHomeDirectory()]];
        }
        //跳转制作页面
        [self presentCreatePage];
    }else if (buttonIndex == 0) {
        WEAKSELF(weakSelf);
        // 删除
        SoapOperation *soap = [SoapOperation Singleton];
        [soap WS_RemoveCommentByid:weakSelf.currentCommentID Session:nil Success:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                // 删除表格中的数据, 刷新表格
                [weakSelf.comments removeObjectAtIndex:weakSelf.indexPath.item];
                [weakSelf.commentsView reloadData];
                weakSelf.commentCount = weakSelf.commentCount - 1;
                weakSelf.reviewCountLabel.text = [NSString stringWithFormat:@"共%d条评论", weakSelf.commentCount];
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

@end