//
//  AppDelegate.m
//  M-Cut
//
//  Created by Crab shell on 12/21/14.
//  Copyright (c) 2014 Crab movier. All rights reserved.
//

#import "AppDelegate.h"
#import "GlobalVars.h"
#import "MovierUtils.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"
#import "VideoDBOperation.h"
#import "UpDateSql.h"
#import "SoapOperation.h"
#import "APPUserData.h"
#import "AnalysisMes.h"
#import <Bugly/Bugly.h>
#import "LoginAndRegister.h"
#import <UserNotifications/UserNotifications.h>
#import "locationManager.h"
#import "AFNetWorkManager.h"
#import <UIImage+GIF.h>

NSString *const NotificationCategoryIdent = @"ACTIONABLE";
NSString *const NotificationActionOneIdent = @"ACTION_ONE";
NSString *const NotificationActionTwoIdent = @"ACTION_TWO";

@interface AppDelegate ()<UIAlertViewDelegate>
/** 是否允许横屏*/
@property (nonatomic, assign) BOOL isAllowRotation;
@end

@implementation AppDelegate

+ (void)load
{
    __block id observer =
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        __weak typeof(self) weakSelf = self;
        [weakSelf setup]; // Do whatever you want
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }];
}

+ (void)setup{
    
    //开始执行网络请求
    [AFNetWorkManager shareInstance];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //注册网络监听
    REGISTEREDNOTI(networkUpdate:, networkStatus);
    //
    //    //开始执行网络请求
    //    [AFNetWorkManager shareInstance];
    
    return YES;
}

/**
 *  监听网络状态
 */
- (void)networkUpdate:(NSNotification *)noti{
    NSInteger netStatus = [noti.userInfo[networkStatusDes] integerValue];
    static BOOL isStart = NO;
    
    if (!isStart) {
        isStart = YES;
        
        if ((netStatus == AFNetworkReachabilityStatusReachableViaWWAN || netStatus == AFNetworkReachabilityStatusReachableViaWiFi)) {
            
            //创建数据库
            [[VideoDBOperation Singleton] CreateTable];
            
            //其他代码
            [self otherCode];
            
            //设置sdk
            [self setThirdPartyInfo];
            
            //默认登录一次，防止被踢出
            [LoginAndRegister getSessionWhenUserAlreadyLogin];
            
        }else if (netStatus == AFNetworkReachabilityStatusUnknown || netStatus == AFNetworkReachabilityStatusNotReachable){
            ALERT(@"网络好像断开了（T_T）");
        }
    }
}

/**
 *  设置三方SDK的信息
 */
- (void)setThirdPartyInfo{
    
    //设置友盟appkey
    [UMSocialData setAppKey:umAPPKey];
    
    //设置微信
    [UMSocialWechatHandler setWXAppId:wxAPPKey
                            appSecret:wxSecret
                                  url:inshowURLStr];
    
    //设置新浪
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:sinaAPPKey
                                         RedirectURL:sinaBackURLStr];
    
    //设置qq
    [UMSocialQQHandler setQQWithAppId:qqAPPId
                               appKey:qqAPPKey
                                  url:qqURLStr];
    
    //设置掌淘
    [SMSSDK registerApp:smAPPId
             withSecret:smSecretId];
    
    //设置bugly
    [Bugly startWithAppId:buglyAPPId];
    
    //设置个推
    [GeTuiSdk startSdkWithAppId:gtAPPId
                         appKey:gtAPPKey
                      appSecret:gtAPPSecret
                       delegate:self];
    [GeTuiSdk runBackgroundEnable:YES];
    
    //注册APNS
    [self registerRemoteNotification];
}

/**
 *  其他代码
 */
- (void)otherCode{
    
    //    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //    self.window.rootViewController = [storyBoard instantiateViewControllerWithIdentifier:@"MainTabView"];
    //    [self.window makeKeyAndVisible];
    
    //默认没有跳转任何通知页面
    self.showNoticeVc = withoutVc;
}


-(void)onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                        message:strMsg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        WXAppExtendObject *obj = msg.mediaObject;
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%lu bytes\n\n", msg.title,
                            msg.description,
                            obj.extInfo,
                            (unsigned long)msg.thumbData.length];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                        message:strMsg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                        message:strMsg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        NSLog(@"%@",strMsg);
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // 登录需要编写
    [UMSocialSnsService applicationDidBecomeActive];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    NSLog(@"application Did Enter Back ground!");
    [self beingBackgroundUpdateTask];
    POSTNOTI(APPBACKGROUND, nil);
}

- (void)beingBackgroundUpdateTask
{
    self.backgroundUpdateTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundUpdateTask];
    }];
}

- (void)endBackgroundUpdateTask
{
    [[UIApplication sharedApplication] endBackgroundTask: self.backgroundUpdateTask];
    self.backgroundUpdateTask = UIBackgroundTaskInvalid;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"application Will Enter Foreground!");
    POSTNOTI(APPFOREGROUND, nil);
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark  个推

- (void)registerRemoteNotification {
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        //IOS8 新的通知机制category注册
        UIMutableUserNotificationAction *action1;
        action1 = [[UIMutableUserNotificationAction alloc] init];
        [action1 setActivationMode:UIUserNotificationActivationModeBackground];
        [action1 setTitle:@"取消"];
        [action1 setIdentifier:NotificationActionOneIdent];
        [action1 setDestructive:NO];
        [action1 setAuthenticationRequired:NO];
        
        UIMutableUserNotificationAction *action2;
        action2 = [[UIMutableUserNotificationAction alloc] init];
        [action2 setActivationMode:UIUserNotificationActivationModeBackground];
        [action2 setTitle:@"回复"];
        [action2 setIdentifier:NotificationActionTwoIdent];
        [action2 setDestructive:NO];
        [action2 setAuthenticationRequired:NO];
        
        
        UIMutableUserNotificationCategory *actionCategory;
        actionCategory = [[UIMutableUserNotificationCategory alloc] init];
        [actionCategory setIdentifier:NotificationCategoryIdent];
        [actionCategory setActions:@[ action1, action2 ]
                        forContext:UIUserNotificationActionContextDefault];
        
        NSSet *categories = [NSSet setWithObject:actionCategory];
        UIUserNotificationType types = (UIUserNotificationTypeAlert |
                                        UIUserNotificationTypeSound |
                                        UIUserNotificationTypeBadge);
        
        UIUserNotificationSettings *settings;
        settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                   UIRemoteNotificationTypeSound |
                                                                   UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
}

/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSCharacterSet * characterSet = [NSCharacterSet characterSetWithCharactersInString:@"<>"];
    NSString *myToken = [[deviceToken description] stringByTrimmingCharactersInSet:characterSet];
    myToken = [myToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    [GeTuiSdk registerDeviceToken:myToken];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n",myToken);
    self.thisDeviceToken = myToken;
}

/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    // [3-EXT]:如果APNS注册失败，通知个推服务器
    [GeTuiSdk registerDeviceToken:@""];
    NSLog(@"%@",[NSString stringWithFormat:@"didFailToRegisterForRemoteNotificationsWithError:%@", [error localizedDescription]]);
}

- (void)application:(UIApplication *)application
performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    //Background Fetch 恢复SDK 运行
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
}

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    
    // [4-EXT-1]: 个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}

/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData
                            andTaskId:(NSString *)taskId
                             andMsgId:(NSString *)msgId
                           andOffLine:(BOOL)offLine
                          fromGtAppId:(NSString *)appId{
    
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes
                                              length:payloadData.length
                                            encoding:NSUTF8StringEncoding];
    }
    
    //解析json形式的数据
    [AnalysisMes analysisMes:payloadMsg];
    NSLog(@"Payload Msg:%@", payloadMsg);
    
    // 汇报个推自定义事件
    [GeTuiSdk sendFeedbackMessage:90001 andTaskId:taskId andMsgId:msgId];
}

/** APP已经接收到“远程”通知(推送) - 透传推送消息  */
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    //该方法在个推第一次推送时会调用，同时在用户点击外部消息时也调用
    // 处理APNs 代码，通过userInfo可以取到推送的信息（包括内容，角标，自定义参数等）。如果需要弹窗等其他操作，则需要自行编码。
    NSLog(@"\n>>>APP已经接收到“远程”通知(推送) - 透传推送消息 - [Receive RemoteNotification - Background Fetch]:%@\n\n",userInfo);
    
    if (application.applicationState != UIApplicationStateBackground &&
        application.applicationState != UIApplicationStateActive) {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        //进入前台时处理跳转，只要运行进入这里就有消息，并且是用户点击app外部消息进入
        //解析消息类根据信息跳转到相应的页面
        [AnalysisMes pushVcWithDic:userInfo];
    }else{
        [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
    }
    completionHandler(UIBackgroundFetchResultNewData);
}

/** 更新showNoticeVc属性*/
- (void)updateshowNoticeVcWithData:(NSInteger)showNoticeVc{
    self.showNoticeVc = showNoticeVc;
}

/** 是否允许横屏*/
- (UIInterfaceOrientationMask)application:(UIApplication *)application
  supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    if (self.isAllowRotation) {
        return UIInterfaceOrientationMaskPortrait |
        UIInterfaceOrientationMaskLandscapeLeft |
        UIInterfaceOrientationMaskLandscapeRight;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (void)setCanAllowRotation{
    self.isAllowRotation = YES;
}

- (void)setCanNotAllowRotation{
    self.isAllowRotation = NO;
}

- (void)showHUD{
    WEAKSELF2
    [CustomeClass mainQueue:^{
        [weakSelf.HUD show:YES];
    }];
}

- (void)hiddenHUD{
    WEAKSELF2
    [CustomeClass mainQueue:^{
        [weakSelf.HUD hide:YES];
    }];
}

#pragma mark - getter
- (MBProgressHUD *)HUD{
    if (!_HUD) {
        _HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
        [[UIApplication sharedApplication].keyWindow addSubview:_HUD];
        _HUD.minShowTime = 0.06;
        _HUD.userInteractionEnabled = NO;
    }
    return _HUD;
}
@end
