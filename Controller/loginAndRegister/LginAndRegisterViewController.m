



//
//  LginAndRegisterViewController.m
//  M-Cut
//
//  Created by liquangang on 16/9/26.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "LginAndRegisterViewController.h"
//#import "LoginViewController.h"
#import "ServiceTermsViewController.h"
#import "TelephoneViewController.h"
#import "TelNumLoginViewController.h"
#import "PerfectPersonalInfoViewController.h"
#import "LoginAndRegister.h"
#import "EditPersonalInfoViewController.h"

@interface LginAndRegisterViewController ()<UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UIView *loginAndRegisterView;
/** 从微信获取的数据*/
@property (nonatomic, strong) NSDictionary * thirtyPartyInfo;
@end

@implementation LginAndRegisterViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DEBUGSUCCESSLOG(@"dealloc")
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //注册跳转到完善用户信息页面
    REGISTEREDNOTI(pushToPerfectUserInfoVc:, @"pushToPerfectUserInfoVc");
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

/** 手机登录按钮点击方法*/
- (IBAction)phoneNumLoginButtonAction:(id)sender {
    [self pushToTelLogin];
}

/** 微信登录按钮点击方法*/
- (IBAction)wechatLoginButtonAction:(id)sender {
    [self loginWithThirtyPartyType:UMShareToWechatSession AccountType:1];
}

/** 微博登录按钮点击方法*/
- (IBAction)weiboLoginButtonAction:(id)sender {
    [self loginWithThirtyPartyType:UMShareToSina AccountType:3];
}

/** qq登录按钮点击方法*/
- (IBAction)qqLoginButtonAction:(id)sender {
    [self loginWithThirtyPartyType:UMShareToQQ AccountType:2];
}

/** 协议按钮点击方法*/
- (IBAction)agreementButtonAction:(id)sender {
    [self pushToAgreement];
}

/** 立即注册按钮点击方法*/
- (IBAction)atOnceRegisterButtonAction:(id)sender {
    [self pushToTelRegister];
}

/** 隐藏window*/
- (IBAction)hiddenButtonAction:(id)sender {
    [UIView animateWithDuration:0.4 animations:^{
        self.loginAndRegisterView.frame = CGRectMake(ISScreen_Width / 2 - 270 / 2,
                                                     ISScreen_Height,
                                                     self.loginAndRegisterView.frame.size.width,
                                                     self.loginAndRegisterView.frame.size.height);
    } completion:^(BOOL finished) {
        
        [CustomeClass mainQueue:^{
            POSTNOTI(HIDDENLOGINANDREGISTERWINDOW, nil);
        }];
    }];
}

#pragma mark - 接口
/** 跳转手机登录界面*/
- (void)pushToTelLogin{
    TelNumLoginViewController * telNumLoginVc = [TelNumLoginViewController new];
    [self.navigationController pushViewController:telNumLoginVc animated:YES];
}

/** 跳转协议界面*/
- (void)pushToAgreement{
    UIStoryboard *setStroyBoard = [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
    ServiceTermsViewController *serviceTermsVC =[setStroyBoard instantiateViewControllerWithIdentifier:@"ServiceTermsVCStoryBoardID"];
    [self.navigationController pushViewController:serviceTermsVC animated:YES];
}

/** 跳转手机注册界面*/
- (void)pushToTelRegister{
    UIStoryboard *mainStroyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TelephoneViewController *telephoneVC = [mainStroyBoard instantiateViewControllerWithIdentifier:@"telephone"] ;
    [self.navigationController pushViewController:telephoneVC animated:YES];
}

/** 三方登录调用这个方法(thirtpartyType:三方账户类型（根据友盟提供的填写）accountType:三方账户类型（根据映像的填（0-手机、1-微信、2-QQ、3-微博)）) */
- (void)loginWithThirtyPartyType:(NSString *)thirtpartyType AccountType:(NSInteger)accountType{
    WEAKSELF2
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:thirtpartyType];
    
    snsPlatform.loginClickHandler(self, [UMSocialControllerService defaultControllerService], YES, ^(UMSocialResponseEntity *responseFirst){
        [CustomeClass HUDshow:weakSelf.view];
        
        if (responseFirst.responseCode == UMSResponseCodeSuccess) {
            [[UMSocialDataService defaultDataService] requestSnsInformation:thirtpartyType completion:^(UMSocialResponseEntity *response){
                
                if (response.data.count <= 1) {
                    [CustomeClass HUDhidden:weakSelf.view];
                    [CustomeClass mainQueue:^{
                        ALERT(@"获取信息失败!");
                    }];
                    return;
                }
                
                NSMutableDictionary * userInfo = [[NSMutableDictionary alloc] initWithDictionary:response.data];
                
                if (![[userInfo allKeys] containsObject:@"openid"]) {
                    [userInfo setObject:response.data[@"uid"] forKey:@"openid"];
                }
                
                if (accountType == 1) {
                    
                    // openid
                    NSString *openid = [response.data[@"openid"] length] == 0 ? @"" : response.data[@"openid"];
                    NSString *access_token = [response.data[@"access_token"] length] == 0 ? @"" : response.data[@"access_token"];
                    NSString * URLString = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openid];
                    NSURLRequest *request1 = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
                    NSData *received = [NSURLConnection sendSynchronousRequest:request1 returningResponse:nil error:nil];
                    
                    NSDictionary *wechatinfo = [NSJSONSerialization JSONObjectWithData:received options:0 error:nil];
                    NSString *unionid = [wechatinfo[@"unionid"] length] == 0 ? @"" : wechatinfo[@"unionid"];
                    [userInfo setObject:unionid forKey:@"openid"];
                }
                
                [CustomeClass HUDhidden:weakSelf.view];
                [LoginAndRegister loginWithAccountInfo:[userInfo copy] AccountType:accountType];
            }];
        } else {
            [CustomeClass HUDhidden:weakSelf.view];
            [CustomeClass showMessage:@"获取信息失败" ShowTime:1.5];
        }
    });
}

/** 跳转个人信息完善界面*/
- (void)pushToPerfectUserInfoVc:(NSNotification *)noti{
    EditPersonalInfoViewController * editUserInfoVc = [EditPersonalInfoViewController new];
    editUserInfoVc.fromVc = fromLoginVc;
    [self.navigationController pushViewController:editUserInfoVc animated:YES];
}

#pragma mark - 懒加载
- (NSDictionary *)thirtyPartyInfo{
    if (!_thirtyPartyInfo) {
        _thirtyPartyInfo = [NSDictionary new];
    }
    return _thirtyPartyInfo;
}
@end
