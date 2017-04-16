//
//  AleadyBindingWeChatViewController.m
//  M-Cut
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "AleadyBindingWeChatViewController.h"
#import "WXApi.h"
#import <UMSocial.h>
#import "SoapOperation.h"
#import "UserEntity.h"
#import "CustomeClass.h"
#import "TelephoneBindingViewController.h"

@interface AleadyBindingWeChatViewController ()<UMSocialUIDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *bindingWechatlabel;
@property (weak, nonatomic) IBOutlet UIButton *removeBindingButton;
@property (weak, nonatomic) IBOutlet UIButton *updateBindingWeChatButton;
@property (weak, nonatomic) IBOutlet UIImageView *thirdPartyImage;
@property (weak, nonatomic) IBOutlet UIButton *telUpdateBindingButton;
@property (nonatomic, copy) NSString * nicknameStr;
/** 绑定的账号的数量*/
@property (nonatomic, assign) NSInteger bindingNum;
@end

@implementation AleadyBindingWeChatViewController

- (void)dealloc{
    DEBUGSUCCESSLOG(@"dealloc")
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

#pragma mark - initUI
- (void)initUI{
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    //更换绑定方法
    [self.updateBindingWeChatButton addTarget:self action:@selector(bindingThirtParty) forControlEvents:UIControlEventTouchUpInside];
    
    //解除绑定方法
    [self.removeBindingButton addTarget:self action:@selector(removeBindingButtonAction) forControlEvents:UIControlEventTouchUpInside];
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self downloadData];
}

/** 更绑手机*/
- (IBAction)telUpdateButtonAction:(id)sender {
    [self bindingTelNum];
}

#pragma mark - 功能模块
/** 绑定手机*/
- (void)bindingTelNum{
    TelephoneBindingViewController * telBindingVc = [TelephoneBindingViewController new];
    telBindingVc.formWhere = formAlreadyBindingTelNum;
    [self.navigationController pushViewController:telBindingVc animated:YES];
}

- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

/** 绑定方法(（要换绑的账号类型（0-手机、1-微信、2-QQ、3-微博))*/
- (void)bindingThirtParty{
    WEAKSELF2
    NSString * thirdPartyStr;
    if (self.thirdPartyIndex == 1) {
        thirdPartyStr = UMShareToWechatSession;
    }else if (self.thirdPartyIndex == 2){
        thirdPartyStr = UMShareToQQ;
    }else if (self.thirdPartyIndex == 3){
        thirdPartyStr = UMShareToSina;
    }
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:thirdPartyStr];
    snsPlatform.loginClickHandler(self,
                                  [UMSocialControllerService defaultControllerService],
                                  YES,
                                  ^(UMSocialResponseEntity *responseFirst){
                                      if (responseFirst.responseCode == UMSResponseCodeSuccess) {
                                          [[UMSocialDataService defaultDataService] requestSnsInformation:thirdPartyStr
                                                                                               completion:^(UMSocialResponseEntity *response)
                                           {
                                               NSMutableDictionary * userInfo = [[NSMutableDictionary alloc] initWithDictionary:response.data];
                                               
                                               if (![[userInfo allKeys] containsObject:@"openid"]) {
                                                   [userInfo setObject:response.data[@"uid"] forKey:@"openid"];
                                               }
                                               if (weakSelf.thirdPartyIndex == 1) {
                                                   // openid
                                                   NSString *openid = [response.data[@"openid"] length] == 0 ? @"" : response.data[@"openid"];
                                                   NSString *access_token = [response.data[@"access_token"] length] == 0 ? @"" : response.data[@"access_token"];
                                                   
                                                   //https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
                                                   NSString * URLString = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openid];
                                                   NSURLRequest *request1 = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
                                                   NSData *received = [NSURLConnection sendSynchronousRequest:request1 returningResponse:nil error:nil];
                                                   
                                                   NSDictionary *wechatinfo = [NSJSONSerialization JSONObjectWithData:received options:0 error:nil];
                                                   NSString *unionid = [wechatinfo[@"unionid"] length] == 0 ? @"" : wechatinfo[@"unionid"];
                                                   [userInfo setObject:unionid forKey:@"openid"];
                                               }
                                               [weakSelf bindingthirtPartyWithAccountStr:userInfo[@"openid"]
                                                                                Nickname:userInfo[@"screen_name"]];
                                           }];
                                      } else {
                                          [CustomeClass showMessage:@"获取信息失败" ShowTime:1.5];
                                      }
                                  });
}

/** 绑定三方账户*/
- (void)bindingthirtPartyWithAccountStr:(NSString *)accountStr
                               Nickname:(NSString *)nicknameStr
{
    WEAKSELF2
    [[SoapOperation Singleton] bindaccountWithAccount:accountStr
                                             Nickname:nicknameStr
                                          AccountType:weakSelf.thirdPartyIndex
                                             Password:nil
                                              Success:^(NSNumber *successInfo) {
                                                  MAINQUEUEUPDATEUI({
                                                      [CustomeClass showMessage:@"绑定成功" ShowTime:1.5];
                                                      
                                                  })
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      weakSelf.bindingWechatlabel.text = [NSString stringWithFormat:@"已绑定%@号：%@", weakSelf.title, nicknameStr];
                                                  });
                                                  
                                              } Fail:^(NSError *error) {
                                                  if (error.code == 34) {
                                                      [CustomeClass showMessage:@"该账号已存在" ShowTime:3.0];
                                                  }else{
                                                      RELOADSERVERDATA([weakSelf bindingthirtPartyWithAccountStr:accountStr
                                                                                                        Nickname:nicknameStr
                                                                        ];);
                                                  }
                                              }];
}

/** 解除绑定*/
- (void)removeBindingButtonAction{
    
    if (![self isRemoveBinding]) {
        [CustomeClass showMessage:@"当前只绑定了一个账户，无法解绑！" ShowTime:1.5];
        return;
    }
    
    if ([UserEntity sharedSingleton].appLoginType == self.thirdPartyIndex) {
        [CustomeClass showMessage:@"这是您当前的登录账户，无法解绑" ShowTime:3];
        return;
    }
    
    WEAKSELF2
    [[SoapOperation Singleton] bindaccountWithAccount:@""
                                             Nickname:@""
                                          AccountType:weakSelf.thirdPartyIndex
                                             Password:nil
                                              Success:^(NSNumber *successInfo) {
                                                  MAINQUEUEUPDATEUI({
                                                      [CustomeClass showMessage:@"解绑成功" ShowTime:1.5];
                                                      
                                                  })
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      weakSelf.bindingWechatlabel.text = [NSString stringWithFormat:@"未绑定微信号"];
                                                  });
                                                  
                                              } Fail:^(NSError *error) {
                                                  RELOADSERVERDATA([weakSelf removeBindingButtonAction];);
                                              }];
}

/** 判断是否可以解绑*/
- (BOOL)isRemoveBinding{
    if (self.bindingNum > 1) {
        return YES;
    }
    return NO;
}

/** 下载数据*/
- (void)downloadData{
    WEAKSELF2
    [[SoapOperation Singleton] getAccountBindStatusSuccess:^(NSMutableDictionary *serverDataDic) {
        /*
         Printing description of topicInfoDic:
         {
         "customer_id" = 29518;
         "customer_tel" = 15901312778;
         qqnickname = "";
         thirdpartyqq = "";
         thirdpartywechat = "";
         thirdpartyweibo = "";
         wechatnickname = "";
         weibonickname = "";
         }
         */
        /*
         weChatLoginImage
         weiboLoginImage
         qqloginImage
         0-手机、1-微信、2-QQ、3-微博
         */
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.telUpdateBindingButton.hidden = YES;
            NSString * thirdPartyImageStr;
            if (weakSelf.thirdPartyIndex == 1) {
                thirdPartyImageStr = @"weChatLoginImage";
                weakSelf.nicknameStr = serverDataDic[@"wechatnickname"];
                weakSelf.title = @"微信";
            }else if (weakSelf.thirdPartyIndex == 2){
                thirdPartyImageStr = @"qqloginImage";
                weakSelf.nicknameStr = serverDataDic[@"qqnickname"];
                weakSelf.title = @"QQ";
            }else if (weakSelf.thirdPartyIndex == 3){
                thirdPartyImageStr = @"weiboLoginImage";
                weakSelf.nicknameStr = serverDataDic[@"weibonickname"];
                weakSelf.title = @"微博";
            }else if (weakSelf.thirdPartyIndex == 0){
                weakSelf.telUpdateBindingButton.hidden = NO;
                thirdPartyImageStr = @"telBindingImage";
                weakSelf.nicknameStr = serverDataDic[@"customer_tel"];
                weakSelf.title = @"手机";
            }
            self.thirdPartyImage.image = [UIImage imageNamed:thirdPartyImageStr];
            
            weakSelf.bindingWechatlabel.text = [NSString stringWithFormat:@"%@：%@",
                                                weakSelf.title,
                                                weakSelf.nicknameStr];
            
            //设置已绑定账户数量
            weakSelf.bindingNum = 0;
            if ([serverDataDic[@"customer_tel"] length] > 0) {
                weakSelf.bindingNum++;
            }
            if ([serverDataDic[@"thirdpartyqq"] length] > 0) {
                weakSelf.bindingNum++;
            }
            if ([serverDataDic[@"thirdpartywechat"] length] > 0) {
                weakSelf.bindingNum++;
            }
            if ([serverDataDic[@"thirdpartyweibo"] length] > 0) {
                weakSelf.bindingNum++;
            }
        });
    
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf downloadData];);
    }];
}

@end
