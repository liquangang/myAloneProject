//
//  AccountAndSafeViewController.m
//  M-Cut
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "AccountAndSafeViewController.h"
#import "SoapOperation.h"
#import "WXApi.h"
#import <UMSocial.h>
#import "AleadyBindingWeChatViewController.h"
#import "TelephoneBindingViewController.h"
#import "AlreadyBindingTelephoneViewController.h"
#import "AccountAndSafeTableViewCell.h"
#import "CustomeClass.h"
#import "BingdingObj.h"

@interface AccountAndSafeViewController ()<UITableViewDelegate, UITableViewDataSource, UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UITableView *accountTable;
/** table头视图*/
@property (nonatomic, strong) UIView * myHeaderView;
/** 展示id号码*/
@property (nonatomic, strong) UILabel * idNumLabel;
/** 数据源*/
@property (nonatomic, strong) NSMutableDictionary * dataSource;
/** 下载次数*/
@property (nonatomic, assign) int downloadTimes;
/** 用户的相关信息是否绑定*/
@property (nonatomic, strong) MovierDCInterfaceSvc_VDCTelAndThirdPartyBindStatusEnv * isHaveInfo;
/** 数据源*/
@property (nonatomic, strong) NSMutableArray * bindingDataMuArray;
@end

@implementation AccountAndSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

#pragma mark - initUI
- (void)initUI{
    self.title = @"账户与安全";
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    [self.accountTable registerNib:[UINib nibWithNibName:@"AccountAndSafeTableViewCell" bundle:nil] forCellReuseIdentifier:@"AccountAndSafeTableViewCell"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self downloadBindStatus];
}

#pragma mark - 返回按钮点击方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bindingDataMuArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BingdingObj * bindingObj = self.bindingDataMuArray[indexPath.row];
    AccountAndSafeTableViewCell * cell = [AccountAndSafeTableViewCell
                                          accountAndSafeTableViewCellWithAccountTypeStr:bindingObj.bindingType
                                          AccountBindingStatues:bindingObj.isBinding
                                          AccountNicknameStr:bindingObj.bindingAccountStr
                                          Table:tableView
                                          AccountType:bindingObj.accountType];
    WEAKSELF2
    [cell setBindingBlock:^(NSInteger accountType) {
        [weakSelf bindingThirtPartyAccountWithAccountType:accountType];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BingdingObj * bindingObj = self.bindingDataMuArray[indexPath.row];
    if (![bindingObj.bindingType isEqualToString:@"ID号"] && bindingObj.isBinding) {
        //跳转已绑定页面
        AleadyBindingWeChatViewController * wechatVc = [AleadyBindingWeChatViewController new];
        [self.navigationController pushViewController:wechatVc animated:YES];
    }
}

#pragma mark - 功能模块
- (void)downloadBindStatus{
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
        [weakSelf.bindingDataMuArray removeAllObjects];
        
        NSString * noNickname = @"未上传昵称";
        
        BingdingObj * bindingObj1 = [BingdingObj new];
        bindingObj1.bindingType = @"ID号";
        bindingObj1.isBinding = YES;
        bindingObj1.bindingAccountStr = serverDataDic[@"customer_id"];
        bindingObj1.accountType = -1;
        [weakSelf.bindingDataMuArray addObject:bindingObj1];
        
        BingdingObj * bindingObj2 = [BingdingObj new];
        bindingObj2.bindingType = @"手机";
        bindingObj2.isBinding = [serverDataDic[@"customer_tel"] length] > 0 ? YES : NO;
        bindingObj2.bindingAccountStr = serverDataDic[@"customer_tel"];
        bindingObj2.accountType = 0;
        [weakSelf.bindingDataMuArray addObject:bindingObj2];
        
        BingdingObj * bindingObj3 = [BingdingObj new];
        bindingObj3.bindingType = @"微信";
        bindingObj3.isBinding = [serverDataDic[@"thirdpartywechat"] length] > 0 ? YES : NO;
        bindingObj3.bindingAccountStr = [serverDataDic[@"wechatnickname"] length] > 0 ?
                                        serverDataDic[@"wechatnickname"] :
                                        noNickname;
        bindingObj3.accountType = 1;
        [weakSelf.bindingDataMuArray addObject:bindingObj3];
        
        BingdingObj * bindingObj4 = [BingdingObj new];
        bindingObj4.bindingType = @"微博";
        bindingObj4.isBinding = [serverDataDic[@"thirdpartyweibo"] length] > 0 ? YES : NO;
        bindingObj4.bindingAccountStr = [serverDataDic[@"weibonickname"] length] > 0 ?
                                        serverDataDic[@"weibonickname"] :
                                        noNickname;
        bindingObj4.accountType = 3;
        [weakSelf.bindingDataMuArray addObject:bindingObj4];
        
        BingdingObj * bindingObj5 = [BingdingObj new];
        bindingObj5.bindingType = @"QQ";
        bindingObj5.isBinding = [serverDataDic[@"thirdpartyqq"] length] > 0 ? YES : NO;
        bindingObj5.bindingAccountStr = [serverDataDic[@"qqnickname"] length] > 0 ?
                                        serverDataDic[@"qqnickname"] :
                                        noNickname;
        bindingObj5.accountType = 2;
        [weakSelf.bindingDataMuArray addObject:bindingObj5];
        
        MAINQUEUEUPDATEUI({
            [weakSelf.accountTable reloadData];
        })
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf downloadBindStatus];);
    }];
}

/** 绑定方法*/
- (void)bindingThirtPartyAccountWithAccountType:(NSInteger)accountType{
    NSLog(@"accountType --- %ld", accountType);
    //跳转获得信息
    //上传进行绑定
    switch (accountType) {
        case 1:
        {
            [self getThirtPartyInfoWithThirtyPartyType:UMShareToWechatSession AccountType:1];
        }
            break;
        case 2:
        {
            [self getThirtPartyInfoWithThirtyPartyType:UMShareToQQ AccountType:2];
        }
        case 3:
        {
            [self getThirtPartyInfoWithThirtyPartyType:UMShareToSina AccountType:3];
        }
        default:
            break;
    }
    
}

- (void)getThirtPartyInfoWithThirtyPartyType:(NSString *)thirtpartyType AccountType:(NSInteger)accountType{
    WEAKSELF2
//    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:thirtpartyType];
    snsPlatform.loginClickHandler(self,
                                  [UMSocialControllerService defaultControllerService],
                                  YES,
                                  ^(UMSocialResponseEntity *responseFirst){
            if (responseFirst.responseCode == UMSResponseCodeSuccess) {
                    [[UMSocialDataService defaultDataService]
                     requestSnsInformation:thirtpartyType
                                completion:^(UMSocialResponseEntity *response){
                                    
                    NSMutableDictionary * userInfo =
                    [[NSMutableDictionary alloc] initWithDictionary:response.data];
                                                                                                   
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
                                          AccountType:[NSString stringWithFormat:@"%ld", thirtPartyType]
                                             Password:nicknameStr
                                              Success:^(NSNumber *successInfo) {
        MAINQUEUEUPDATEUI({
            [CustomeClass showMessage:@"绑定成功" ShowTime:1.5];
            [weakSelf downloadBindStatus];
        })
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf bindingthirtPartyWithAccountStr:accountStr
                                                          Nickname:nicknameStr
                                                   ThirtyPartyType:thirtPartyType];);
    }];
}

#pragma mark - 懒加载
- (NSMutableArray *)bindingDataMuArray{
    if (!_bindingDataMuArray) {
        _bindingDataMuArray = [NSMutableArray new];
    }
    return _bindingDataMuArray;
}

@end
