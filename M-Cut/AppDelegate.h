//
//  AppDelegate.h
//  M-Cut
//
//  Created by Crab shell on 12/21/14.
//  Copyright (c) 2014 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SMS_SDK/SMSSDK.h>
#import "WXApi.h"
#import "APPUserPrefs.h"
#import "MovierTranslation.h"
#import "GeTuiSdk.h"
#import "CustomeClass.h"

typedef NS_ENUM(NSInteger, ShowNoticeVc){
    withoutVc,
    messageVc,
    friendVc,
    videoVc
};

@interface AppDelegate : UIResponder <UIApplicationDelegate,
                                      GeTuiSdkDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) UIBackgroundTaskIdentifier backgroundUpdateTask;

/** 设备的deviceToken*/
@property (nonatomic, copy) NSString * thisDeviceToken;

/** 应用是否跳转到了展示推送通知的界面，如果已经进入，就不允许再次进入，防止崩溃*/
@property (nonatomic, assign) ShowNoticeVc showNoticeVc;

/** 更新showNoticeVc属性*/
- (void)updateshowNoticeVcWithData:(NSInteger)showNoticeVc;

/** 支持横屏，需要在view消失时设置为不支持，否则其他页面也会支持横屏*/
- (void)setCanAllowRotation;

/** 不支持横屏*/
- (void)setCanNotAllowRotation;

/**
 *  默认hud
 */
@property (nonatomic, strong) MBProgressHUD *HUD;
- (void)showHUD;
- (void)hiddenHUD;
@end

