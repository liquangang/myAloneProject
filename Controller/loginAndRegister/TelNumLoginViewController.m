//
//  TelNumLoginViewController.m
//  M-Cut
//
//  Created by liquangang on 16/9/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "TelNumLoginViewController.h"
#import "TelephoneViewController.h"
#import "ReinstallPasswordViewController.h"
#import "SoapOperation.h"
#import "LoginAndRegister.h"
#import "UserEntity.h"

@interface TelNumLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *telTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation TelNumLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NAVIGATIONBARTITLEVIEW(@"手机登录")
    NAVIGATIONBACKBARBUTTONITEM
}

//返回按钮方法法
NAVIGATIONBACKITEMMETHOD

- (IBAction)registerButtonAction:(id)sender {
    [self pushToRegister];
}

- (IBAction)forgetPasswordButtonAction:(id)sender {
    UIStoryboard *mainStroyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ReinstallPasswordViewController *reinstallVC =[mainStroyBoard instantiateViewControllerWithIdentifier:@"reinstall"] ;
    [self.navigationController pushViewController:reinstallVC animated:YES];
}

- (IBAction)loginButtonAction:(id)sender {
    [self.view endEditing:YES];
    [self userLogin];
}

#pragma mark - 接口

/**
 *  跳转注册界面
 */
- (void)pushToRegister{
    UIStoryboard *mainStroyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TelephoneViewController *telephoneVC =[mainStroyBoard instantiateViewControllerWithIdentifier:@"telephone"] ;
    [self.navigationController pushViewController:telephoneVC animated:YES];
}

/** 初始化用户信息单例*/
- (void)initUserIfoWithSession:(MovierDCInterfaceSvc_VDCSession *)ws_session{
    WEAKSELF2
    [SoapOperation Singleton].WS_Session = ws_session;
    
    //初始化userentity
    [[UserEntity sharedSingleton] Applogin:self.telTextField.text appPwd:self.passwordTextField.text LoginType:LoginTypePhone];
    [UserEntity sharedSingleton].sessionId = [[NSString alloc] initWithFormat:@"%@",ws_session.nSessionID];
    [UserEntity sharedSingleton].customerId = [NSString stringWithFormat:@"%@",ws_session.nCustomerID];
    [UserEntity sharedSingleton].ossDir = ws_session.szRootDir;
    [UserEntity sharedSingleton].ossKey = ws_session.szKey;
    [LoginAndRegister fillUseEntity:ws_session];
    
    [[SoapOperation Singleton] WS_GetossConfig:ws_session Success:^(MovierDCInterfaceSvc_VDCOSSConfig *ossconfig) {
        [UserEntity sharedSingleton].ossBucket = ossconfig.szBucket;
        [UserEntity sharedSingleton].ossID = ossconfig.szID;
        [UserEntity sharedSingleton].ossKey = ossconfig.szKey;
        [UserEntity sharedSingleton].ossEndpoint = ossconfig.szEndpoint;
        [[APPUserPrefs Singleton] StartOrderT];
        
        //向后台发送cid和deviceToken
        [weakSelf sendDeviceTokenAndCid];
    } Fail:^(NSError *error) {
        NSLog(@"get oss config error!");
        NSLog(@"%@",[error localizedDescription]);
    }];

}

/** 退出键盘*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

/** 上传cid和devicetoken*/
- (void)sendDeviceTokenAndCid{
    //向后台发送cid和deviceToken
    WEAKSELF2
    [[SoapOperation Singleton] WS_operatedevicelistWithOperationType:1 Success:^(NSNumber *num) {
        NSLog(@"向后台注册cid和deviceToken成功");
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf sendDeviceTokenAndCid];);
    }];
}

/** 退出登录模块*/
- (void)loginSuccess{
    
    [CustomeClass mainQueue:^{
        POSTNOTI(HIDDENLOGINANDREGISTERWINDOW, nil);
    }];
}

/** 登录*/
- (void)userLogin{
    [CustomeClass HUDshow:self.view Tag:123456789];
    WEAKSELF2
    
    // 1. 给服务器发送请求, 判断是否需要注册
    [[SoapOperation Singleton] loginByAccountWithAccount:self.telTextField.text Password:self.passwordTextField.text AccountType:0 Success:^(NSMutableDictionary *serverDataDictionary) {
        [CustomeClass HUDhidden:weakSelf.view Tag:123456789];
        
        //上传cid和devicetoken
        [weakSelf sendDeviceTokenAndCid];
        
        //已经注册过的话就进行登录设置用户信息类
        [weakSelf initUserIfoWithSession:[LoginAndRegister setSessionWithDic:serverDataDictionary]];
        
        [weakSelf loginSuccess];
        
    } Fail:^(NSError *error) {
        [CustomeClass HUDhidden:weakSelf.view Tag:123456789];
        if (error.code == 35) {
            [weakSelf pushToRegister];
        }else{
            [weakSelf userLoginErrorWithLoginStatus:[NSNumber numberWithInteger:error.code] Error:error];
        }
    }];
}

/** 登录失败方法*/
- (void)userLoginErrorWithLoginStatus:(NSNumber *)loginstatus Error:(NSError *)error{
    NSLog(@"soap login error! ret = %@",loginstatus);
    NSLog(@"%@",[error localizedDescription]);
    if ([loginstatus isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_INVALIDUSERORPWD]]) {
        NSString *message = [[NSString alloc] initWithFormat:@"登录失败，用户名或密码错误!"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示!" message:message delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [alert show];
        });
        
    }else{
        NSString *message = [[NSString alloc] initWithFormat:@"登陆失败，请重新登陆!(%@)",loginstatus];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示!" message:message delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [alert show];
        });
    }
}
@end
