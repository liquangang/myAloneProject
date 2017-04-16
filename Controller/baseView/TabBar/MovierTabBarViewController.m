//
//  MovierViewController.m
//  M-Cut
//
//  Created by Crab shell on 12/26/14.
//  Copyright (c) 2014 Crab movier. All rights reserved.
//
#import "MovierTabBarViewController.h"
//#import "MyFavourateViewController.h"
//#import "LogoutFavourateViewController.h"
#import "LogOutPersonViewController.h"
#import "WxTabBarItem.h"
//#import "UserLoginViewController.h"
//#import "MWICloudViewController.h"
#import "VideoDBOperation.h"
#import "ISCutPreViewController.h"
#import "VideoDBOperation.h"
#import "VideoDetailViewController.h"
#import "ZFPlayer.h"

// 影片详情返回制作首页, 使用通知传递参数
#define ISStyleDetailBacktoCutProParams         @"ISStyleDetailBacktoCutProParams"
#define ISStyleDetailBacktoCutProNotification   @"ISStyleDetailBacktoCutProNotification"

@interface MovierTabBarViewController ()
@end


@implementation MovierTabBarViewController

- (void)changePromptLabel:(NSNotification *)notice{
    //接到通知请求服务器数据判断还有多少未观看
    UITabBarItem * tabbarItem = self.tabBar.items[self.tabBar.items.count - 1];
    [tabbarItem setBadgeValue:[NSString stringWithFormat:@"%ld", (long)[UIApplication sharedApplication].applicationIconBadgeNumber]];
    if ([tabbarItem.badgeValue intValue] <= 0) {
        [tabbarItem setBadgeValue:nil];
    }
}

/** 跳转到消息通知界面*/
- (void)pushToMessageVc:(NSNotification *)noti{
    [self setSelectedIndex:2];
    POSTNOTI(PUSHTOMESSAGEVC, nil);
}

/** 跳转到好友界面的通知*/
- (void)pushToFriendVc:(NSNotification *)noti{
    [self setSelectedIndex:2];
    POSTNOTI(PUSHTOFRIENDVC, nil);
}

/** 跳转到我的视频界面的通知*/
- (void)pushToMyVideoVc:(NSNotification *)noti{
    [self setSelectedIndex:2];
    POSTNOTI(PUSHTOVIDEOVC, nil);
}

- (void)backFromPreView:(NSNotification *)noti {// 从风格详情界面  跳转到 制作界面, 然后再跳转到  pre 预览界面
    NSDictionary *info = noti.userInfo;
    UINavigationController *preview = [[UIStoryboard storyboardWithName:@"Preview"
                                                                 bundle:nil]
                                       instantiateViewControllerWithIdentifier:@"ISCutPreView_ID"];
    ISCutPreViewController *pre = [preview.childViewControllers firstObject];
    pre.Direct2Main = YES;
    pre.isFromDraftBox = YES;
    pre.orderid = [info[@"orderID"] intValue];
    [self presentViewController:preview animated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册接受消息通知跳转的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pushToMessageVc:)
                                                 name:PUSHTOMESSAGE
                                               object:nil];
    //注册接受跳转到好友界面的通知
    REGISTEREDNOTI(pushToFriendVc:, PUSHTOFRIEND);
    //注册跳转到我的视频页面
    REGISTEREDNOTI(pushToMyVideoVc:, PUSHTOVIDEO);
    
    //先设置一次
    [self changePromptLabel:nil];
    
    //注册标签变化通知
    REGISTEREDNOTI(changePromptLabel:, UPDATEPROPMTLABELTEXT);
    
    //如果从草稿箱跳转时接受此通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(backFromPreView:)
                                                 name:@"pushToISCutPreViewController"
                                               object:nil];
    
    //去除tabbar顶部黑线
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setShadowImage:img];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.selectedIndex = 0;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (UIViewController *)childViewControllerForStatusBarHidden{
    UINavigationController * naVC = self.viewControllers[self.selectedIndex];
    return naVC.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    UINavigationController * naVC = self.viewControllers[self.selectedIndex];
    return naVC.topViewController;
}
@end
