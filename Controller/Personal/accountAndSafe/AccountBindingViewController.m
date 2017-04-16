//
//  AccountBindingViewController.m
//  M-Cut
//
//  Created by liquangang on 16/10/6.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "AccountBindingViewController.h"
#import "AccountAndSafeTableViewCell.h"
#import "SoapOperation.h"
#import "BingdingObj.h"
#import "CustomeClass.h"
#import <UMSocial.h>
#import "AleadyBindingWeChatViewController.h"
#import "TelephoneBindingViewController.h"


@interface AccountBindingViewController ()<UITableViewDelegate, UITableViewDataSource, UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UITableView *accountTable;
/** 数据源*/
@property (nonatomic, strong) NSMutableArray * accountInfoMuArray;
@end

@implementation AccountBindingViewController

- (void)dealloc{
    DEBUGSUCCESSLOG(@"dealloc")
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self downloadData];
}

#pragma mark - table代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.accountInfoMuArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BingdingObj * bindingObj = self.accountInfoMuArray[indexPath.row];
    AccountAndSafeTableViewCell * cell = [AccountAndSafeTableViewCell
                                          accountAndSafeTableViewCellWithAccountTypeStr:bindingObj.bindingType
                                          AccountBindingStatues:bindingObj.isBinding
                                          AccountNicknameStr:bindingObj.bindingAccountStr
                                          Table:tableView
                                          AccountType:bindingObj.accountType];
    WEAKSELF2
    [cell setBindingBlock:^(NSInteger accountType) {
        if (accountType == 0) {
            [weakSelf bindingTelNum];
        }else{
            [weakSelf bindingThirtPartyInfoWithAccountType:accountType];
        }
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return;
    }
    BingdingObj * bindingObj = self.accountInfoMuArray[indexPath.row];
    if (!bindingObj.isBinding) {
        return;
    }
    AleadyBindingWeChatViewController * alreadyBindingVc = [AleadyBindingWeChatViewController new];
        /*
         三方代号
        @property (nonatomic, assign) NSInteger thirdPartyIndex;
         */
    alreadyBindingVc.thirdPartyIndex = bindingObj.accountType;
    [self.navigationController pushViewController:alreadyBindingVc animated:YES];
}

#pragma mark - 功能模块
/** 绑定手机*/
- (void)bindingTelNum{
    TelephoneBindingViewController * telBindingVc = [TelephoneBindingViewController new];
    telBindingVc.formWhere = formAccountAndSafeVc;
    [self.navigationController pushViewController:telBindingVc animated:YES];
}

/** 绑定三方方法(（要换绑的账号类型（0-手机、1-微信、2-QQ、3-微博))*/
- (void)bindingThirtPartyInfoWithAccountType:(NSInteger)accountType{
    WEAKSELF2
    NSString * thirtType;
    switch (accountType) {
        case 1:
        {
            thirtType = UMShareToWechatSession;
        }
            break;
        case 2:
        {
            thirtType = UMShareToQQ;
        }
            break;
        case 3:
        {
            thirtType = UMShareToSina;
        }
            break;
        default:
            break;
    }
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:thirtType];
    snsPlatform.loginClickHandler(self,
                                  [UMSocialControllerService defaultControllerService],
                                  YES,
                                  ^(UMSocialResponseEntity *responseFirst){
        if (responseFirst.responseCode == UMSResponseCodeSuccess) {
            [[UMSocialDataService defaultDataService] requestSnsInformation:thirtType
                                                                 completion:^(UMSocialResponseEntity *response)
            {
                 NSMutableDictionary * userInfo = [[NSMutableDictionary alloc] initWithDictionary:response.data];
                                                                                                   
                if (![[userInfo allKeys] containsObject:@"openid"]) {
                        [userInfo setObject:response.data[@"uid"] forKey:@"openid"];
                }
                [weakSelf bindingthirtPartyWithAccountStr:userInfo[@"openid"]
                                                 Nickname:userInfo[@"screen_name"]
                                          ThirtyPartyType:accountType];
            }];
        } else {
            [CustomeClass showMessage:@"获取信息失败" ShowTime:1.5];
        }
    });
}

/** 绑定三方账户*/
- (void)bindingthirtPartyWithAccountStr:(NSString *)accountStr
                               Nickname:(NSString *)nicknameStr
                        ThirtyPartyType:(NSInteger)thirtPartyType{
    WEAKSELF2
    [[SoapOperation Singleton] bindaccountWithAccount:accountStr
                                             Nickname:nicknameStr
                                          AccountType:thirtPartyType
                                             Password:nicknameStr
                                              Success:^(NSNumber *successInfo) {
                                                  MAINQUEUEUPDATEUI({
                                                      [CustomeClass showMessage:@"绑定成功" ShowTime:1.5];
                                                      [weakSelf downloadData];
                                                  })
    } Fail:^(NSError *error) {
        if (error.code == 34) {
            [CustomeClass showMessage:@"该账号已存在" ShowTime:3.0];
        }else{
            RELOADSERVERDATA([weakSelf bindingthirtPartyWithAccountStr:accountStr
                                                              Nickname:nicknameStr
                                                       ThirtyPartyType:thirtPartyType];);
        }
    }];
}

/** 初始化界面*/
- (void)initUI{
    //导航栏设置
    NAVIGATIONBARTITLEVIEW(@"账户与安全")
    NAVIGATIONBACKBARBUTTONITEM
    
    //注册cell
    [self.accountTable registerNib:[UINib nibWithNibName:@"AccountAndSafeTableViewCell"
                                                  bundle:nil]
            forCellReuseIdentifier:@"AccountAndSafeTableViewCell"];
    
    
}

/** 返回按钮方法*/
- (void)backButtonAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
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
        [weakSelf.accountInfoMuArray removeAllObjects];
        
        NSString * noNickname = @"未上传昵称";
        
        BingdingObj * bindingObj1 = [BingdingObj new];
        bindingObj1.bindingType = @"ID号";
        bindingObj1.isBinding = YES;
        bindingObj1.bindingAccountStr = serverDataDic[@"customer_id"];
        bindingObj1.accountType = -1;
        [weakSelf.accountInfoMuArray addObject:bindingObj1];
        
        BingdingObj * bindingObj2 = [BingdingObj new];
        bindingObj2.bindingType = @"手机";
        bindingObj2.isBinding = [serverDataDic[@"customer_tel"] length] > 0 ? YES : NO;
        bindingObj2.bindingAccountStr = serverDataDic[@"customer_tel"];
        bindingObj2.accountType = 0;
        [weakSelf.accountInfoMuArray addObject:bindingObj2];
        
        BingdingObj * bindingObj3 = [BingdingObj new];
        bindingObj3.bindingType = @"微信";
        bindingObj3.isBinding = [serverDataDic[@"thirdpartywechat"] length] > 0 ? YES : NO;
        bindingObj3.bindingAccountStr = [serverDataDic[@"wechatnickname"] length] > 0 ?
        serverDataDic[@"wechatnickname"] :
        noNickname;
        bindingObj3.accountType = 1;
        [weakSelf.accountInfoMuArray addObject:bindingObj3];
        
        BingdingObj * bindingObj4 = [BingdingObj new];
        bindingObj4.bindingType = @"微博";
        bindingObj4.isBinding = [serverDataDic[@"thirdpartyweibo"] length] > 0 ? YES : NO;
        bindingObj4.bindingAccountStr = [serverDataDic[@"weibonickname"] length] > 0 ?
        serverDataDic[@"weibonickname"] :
        noNickname;
        bindingObj4.accountType = 3;
        [weakSelf.accountInfoMuArray addObject:bindingObj4];
        
        BingdingObj * bindingObj5 = [BingdingObj new];
        bindingObj5.bindingType = @"QQ";
        bindingObj5.isBinding = [serverDataDic[@"thirdpartyqq"] length] > 0 ? YES : NO;
        bindingObj5.bindingAccountStr = [serverDataDic[@"qqnickname"] length] > 0 ?
        serverDataDic[@"qqnickname"] :
        noNickname;
        bindingObj5.accountType = 2;
        [weakSelf.accountInfoMuArray addObject:bindingObj5];
        
        MAINQUEUEUPDATEUI({
            [weakSelf.accountTable reloadData];
        })
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf downloadData];);
    }];
}

#pragma mark - 懒加载
- (NSMutableArray *)accountInfoMuArray{
    if (!_accountInfoMuArray) {
        _accountInfoMuArray = [NSMutableArray new];
    }
    return _accountInfoMuArray;
}
@end
