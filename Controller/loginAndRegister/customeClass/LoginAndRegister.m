//
//  LoginAndRegister.m
//  M-Cut
//
//  Created by liquangang on 16/9/30.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "LoginAndRegister.h"
#import "SoapOperation.h"
#import "CustomeClass.h"
#import "UserEntity.h"
#import "APPUserPrefs.h"

@interface LoginAndRegister()
@end

@implementation LoginAndRegister

/** 登录（用来判断是否需要注册的方法，如果已经注册就登录, 没有注册的话就进行注册）(（要换绑的账号类型（0-手机、1-微信、2-QQ、3-微博)*/
+ (void)loginWithAccountInfo:(NSDictionary *)accountInfo
                 AccountType:(NSInteger)accountType{
    NSLog(@"%@", accountInfo);
    
    // 1. 给服务器发送请求, 判断是否需要注册
    WEAKSELF2
    [[SoapOperation Singleton] loginByAccountWithAccount:accountInfo[@"openid"]
                                                Password:nil
                                             AccountType:accountType
                                                 Success:^(NSMutableDictionary *serverDataDictionary) {
                                                     
                                                     //上传cid和devicetoken
                                                     [weakSelf sendDeviceTokenAndCid];
        
        //已经注册过的话就进行登录设置用户信息类
        [weakSelf initUserInfoClassWithDic:[weakSelf setSessionWithDic:serverDataDictionary]
                                   Account:[weakSelf setAccountWithThirtAccountInfo:accountInfo
                                                                     ThirdPartyType:accountType]];
    } Fail:^(NSError *error) {
        if (error.code == 35) {
            
           //没有注册过，此时进行注册, 分类进行注册
            if (accountType == 1) {
                
                //微信注册
                [weakSelf wechatRegisterWithDic:accountInfo];
                
            }else if (accountType == 2){
                
                //qq注册
                [weakSelf QQRegisterWithQQInfoDic:accountInfo];
                
            }else if (accountType == 3){
                
                //微博注册
                [weakSelf weiboRegisterWithInfoDic:accountInfo];
            }
        }
    }];
}

/** 登录（注册完成后的登录方法）*/
+ (void)registerFinishLoginWithAccountType:(NSInteger)accountType
                            ThirtyPartyDic:(NSDictionary *)thirtAccountInfo{
    WEAKSELF2
    [[SoapOperation Singleton] loginByAccountWithAccount:thirtAccountInfo[@"openid"]
                                                Password:nil
                                             AccountType:accountType
                                                 Success:^(NSMutableDictionary *serverDataDictionary) {
                                                     
                                                     //上传cid和devicetoken
                                                     [weakSelf sendDeviceTokenAndCid];
                                                     
        //设置用户信息类
        [weakSelf initFirstRegisterUserInfoClassWithDic:[weakSelf setSessionWithDic:serverDataDictionary]
                                                Account:[weakSelf setAccountWithThirtAccountInfo:thirtAccountInfo
                                                                                  ThirdPartyType:accountType]];
                                                     
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf registerFinishLoginWithAccountType:accountType
                                                       ThirtyPartyDic:thirtAccountInfo];);
    }];
}

/** 手机登录*/
+ (void)loginWithTelNum:(NSString *)telNum Password:(NSString *)passwordStr{
    WEAKSELF2
    [[SoapOperation Singleton] loginByAccountWithAccount:telNum Password:passwordStr AccountType:0 Success:^(NSMutableDictionary *serverDataDictionary) {
        [weakSelf initUserInfoWithSession:[weakSelf setSessionWithDic:serverDataDictionary]
                                   TelNum:telNum
                                 Password:passwordStr];
    } Fail:^(NSError *error) {
        if (error.code == 17) {
            [CustomeClass showMessage:@"账户过期，请重新登录！" ShowTime:3];
        }else{
            RELOADSERVERDATA([weakSelf loginWithTelNum:telNum Password:passwordStr];);
        }
    }];
}

/** 微博注册*/
+ (void)weiboRegisterWithInfoDic:(NSDictionary *)weiboInfoDic{
    /*
     Printing description of response->_data:
     {
     "access_token" = "2.00F4lVHEvdpEKBcec4990ab118kvWE";
     description = "";
     "favourites_count" = 0;
     "followers_count" = 7;
     "friends_count" = 39;
     gender = 1;
     location = "\U5c71\U4e1c \U6f4d\U574a";
     "profile_image_url" = "http://tva4.sinaimg.cn/default/images/default_avatar_male_180.gif";
     "screen_name" = liquangangking;
     "statuses_count" = 22;
     uid = 3775535947;
     verified = 0;
     }
     
     传入的字典包含openid这个key值
     */
    
    WEAKSELF2
    [[SoapOperation Singleton] weiboRegisterWithAccount:weiboInfoDic[@"openid"]
                                          WeiboNickname:weiboInfoDic[@"screen_name"]
                                               Password:nil
                                                 Gender:weiboInfoDic[@"gender"]
                                               Province:nil
                                                   City:nil
                                               Nickname:nil
                                              Signature:nil
                                                 Avatar:weiboInfoDic[@"profile_image_url"]
                                                 TelNum:nil
                                                  Email:nil
                                                Success:^(NSNumber *successInfo) {
        //注册成功后再次登录获得信息
        [weakSelf registerFinishLoginWithAccountType:3
                                      ThirtyPartyDic:weiboInfoDic];
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf weiboRegisterWithInfoDic:weiboInfoDic];);
    }];
}

/** qq注册*/
+ (void)QQRegisterWithQQInfoDic:(NSDictionary *)qqInfoDic{
    /*
     data =     {
     "access_token" = 3EC954B9D09E4AE0BEA56EB6BA8226AD;
     gender = "\U7537";
     openid = 46484620DC3291AE3484A0AE3F7B3E70;
     "profile_image_url" = "http://qzapp.qlogo.cn/qzapp/1104735856/46484620DC3291AE3484A0AE3F7B3E70/100";
     "screen_name" = "\U6211\U53eb\U61ff\U5bb8";
     uid = 46484620DC3291AE3484A0AE3F7B3E70;
     verified = 0;
     };
     */
    WEAKSELF2
    
    NSString * registerGenderStr;
    NSString * genderStr = qqInfoDic[@"gender"];
    if ([genderStr isEqualToString:@"男"]) {
        registerGenderStr = @"1";
    }else if ([genderStr isEqualToString:@"女"]){
        registerGenderStr = @"2";
    }else{
        registerGenderStr = @"0";
    }
    
    [[SoapOperation Singleton] qqRegisterWithAccount:qqInfoDic[@"openid"]
                                          QQNickName:qqInfoDic[@"screen_name"]
                                            Password:nil Gender:registerGenderStr
                                            Province:nil City:nil
                                            Nickname:nil
                                           Signature:nil
                                              Avatar:qqInfoDic[@"profile_image_url"]
                                              TelNum:nil
                                               Email:nil
                                             Success:^(NSNumber *successInfo) {
        //注册成功后再次登录获得信息
        [weakSelf registerFinishLoginWithAccountType:2
                                      ThirtyPartyDic:qqInfoDic];
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf QQRegisterWithQQInfoDic:qqInfoDic];);
    }];
}

/** 微信注册*/
+ (void)wechatRegisterWithDic:(NSDictionary *)wechatInfoDic{
    
    NSString * locationStr = wechatInfoDic[@"location"];
    NSArray * locationArray = [locationStr componentsSeparatedByString:@","];
    NSString * provinceStr = locationArray[1];
    NSString * cityStr = locationArray[2];
    
    WEAKSELF2
    [[SoapOperation Singleton] wechatRegisterWithAccount:wechatInfoDic[@"openid"]
                                          WechatNickname:wechatInfoDic[@"screen_name"]
                                                Password:nil Gender:wechatInfoDic[@"gender"]
                                                Province:provinceStr
                                                    City:cityStr
                                                Nickname:nil
                                               Signature:nil
                                                  Avatar:wechatInfoDic[@"profile_image_url"]
                                                  TelNum:nil
                                                   Email:nil
                                                 Success:^(NSNumber *successInfo) {
                                                     DEBUGSUCCESSLOG(successInfo);
                                                     
            //注册成功后再次登录获得信息
            [weakSelf registerFinishLoginWithAccountType:1
                                          ThirtyPartyDic:wechatInfoDic];
                                                     
    } Fail:^(NSError *error) {
            RELOADSERVERDATA([weakSelf wechatRegisterWithDic:wechatInfoDic];);
    }];
}

/** 设置account*/
+ (MovierDCInterfaceSvc_VDCThirdPartyAccount *)setAccountWithThirtAccountInfo:(NSDictionary *)thirtyAccountInfo
                                                               ThirdPartyType:(NSInteger)thirdPartyType{
    MovierDCInterfaceSvc_VDCThirdPartyAccount * appAccount = [MovierDCInterfaceSvc_VDCThirdPartyAccount new];
    
    /*
     @interface MovierDCInterfaceSvc_VDCThirdPartyAccount : NSObject {
     
    NSString * szAccount;
    NSString * szPwd;
    NSNumber * nGender;
    NSString * szLocationProvince;
    NSString * szLocationCity;
    NSString * szNickName;
    NSString * szSignature;
    NSString * szAcatar;
    NSNumber * nThirdPartyType;
     */
    
    appAccount.szAccount = thirtyAccountInfo[@"openid"];
    appAccount.szPwd =
    [thirtyAccountInfo[@"access_token"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    appAccount.nGender = [NSNumber numberWithInt:[thirtyAccountInfo[@"gender"] intValue]];
    appAccount.szNickName = thirtyAccountInfo[@"screen_name"];
    appAccount.szSignature = @"";
    appAccount.szAcatar = thirtyAccountInfo[@"profile_image_url"];
    appAccount.nThirdPartyType = @(thirdPartyType);
    
    [SoapOperation Singleton].usename = appAccount.szNickName;
    
    return appAccount;
}

/** 设置session*/
+ (MovierDCInterfaceSvc_VDCSession *)setSessionWithDic:(NSMutableDictionary *)serverDataDictionary{
    MovierDCInterfaceSvc_VDCSession * appSession = [MovierDCInterfaceSvc_VDCSession new];
    
    /*
     @interface MovierDCInterfaceSvc_VDCSession : NSObject {
     
     NSNumber * nSessionID;
     NSNumber * nCustomerID;
     NSString * szKey;
     NSString * szBucketName;
     NSString * szRootDir;
     */
    
    appSession.nSessionID = [NSNumber numberWithInt:[serverDataDictionary[@"sessionid"] intValue]];
    appSession.nCustomerID = [NSNumber numberWithInt:[serverDataDictionary[@"customerid"] intValue]];
    appSession.szKey = serverDataDictionary[@"key"];
    appSession.szBucketName = serverDataDictionary[@"bucketname"];
    appSession.szRootDir = serverDataDictionary[@"rootdir"];
    
    [SoapOperation Singleton].WS_Session = appSession;
    
    return appSession;
}

/** 手机登录时初始化用户信息类*/
+ (void)initUserInfoWithSession:(MovierDCInterfaceSvc_VDCSession *)ws_session
                         TelNum:(NSString *)telNum
                       Password:(NSString *)passwordStr{
    WEAKSELF2
    //初始化userentity
    [[UserEntity sharedSingleton] Applogin:telNum
                                    appPwd:passwordStr
                                 LoginType:LoginTypePhone];
    [UserEntity sharedSingleton].sessionId = [[NSString alloc] initWithFormat:@"%@",ws_session.nSessionID];
    [UserEntity sharedSingleton].customerId = [NSString stringWithFormat:@"%@",ws_session.nCustomerID];
    [UserEntity sharedSingleton].ossDir = ws_session.szRootDir;
    [UserEntity sharedSingleton].ossKey = ws_session.szKey;
    [[SoapOperation Singleton] WS_GetossConfig:ws_session
                                       Success:^(MovierDCInterfaceSvc_VDCOSSConfig *ossconfig) {
        [UserEntity sharedSingleton].ossBucket = ossconfig.szBucket;
        [UserEntity sharedSingleton].ossID = ossconfig.szID;
        [UserEntity sharedSingleton].ossKey = ossconfig.szKey;
        [UserEntity sharedSingleton].ossEndpoint = ossconfig.szEndpoint;
        [[APPUserPrefs Singleton] StartOrderT];
        //向后台发送cid和deviceToken
        [weakSelf sendDeviceTokenAndCid];
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf initUserInfoWithSession:ws_session TelNum:telNum Password:passwordStr];);
    }];
}

/** 初始化用户信息类（用户之前已经注册过的调用该方法进行初始化）*/
+ (void)initUserInfoClassWithDic:(MovierDCInterfaceSvc_VDCSession *)ws_session
                         Account:(MovierDCInterfaceSvc_VDCThirdPartyAccount *)account{
    
    
    //初始化userentity
    [[UserEntity sharedSingleton] Applogin:[NSString stringWithFormat:@"%@", account.szAccount]
                                    appPwd:[NSString stringWithFormat:@"%@", account.szPwd]
                                 LoginType:[account.nThirdPartyType intValue]];
    [UserEntity sharedSingleton].sessionId = [[NSString alloc] initWithFormat:@"%@",ws_session.nSessionID];
    [UserEntity sharedSingleton].customerId = [NSString stringWithFormat:@"%@",ws_session.nCustomerID];
    [UserEntity sharedSingleton].ossDir = ws_session.szRootDir;
    [UserEntity sharedSingleton].ossKey = ws_session.szKey;
    [UserEntity sharedSingleton].szNickname = account.szNickName;
    [UserEntity sharedSingleton].szSignature = account.szSignature;
    [UserEntity sharedSingleton].szAcatar = account.szAcatar;
    
    [self setAlreadyUserInfoWithSession:ws_session];
}

/** 初始化（用户已经注册过的）*/
+ (void)setAlreadyUserInfoWithSession:(MovierDCInterfaceSvc_VDCSession *)ws_session{
    WEAKSELF2
    [[SoapOperation Singleton] WS_GetossConfig:ws_session
                                       Success:^(MovierDCInterfaceSvc_VDCOSSConfig *ossconfig) {
                                           [UserEntity sharedSingleton].ossBucket = ossconfig.szBucket;
                                           [UserEntity sharedSingleton].ossID = ossconfig.szID;
                                           [UserEntity sharedSingleton].ossKey = ossconfig.szKey;
                                           [UserEntity sharedSingleton].ossEndpoint = ossconfig.szEndpoint;
                                           [[APPUserPrefs Singleton] StartOrderT];
                                           
                                           [weakSelf sendDeviceTokenAndCid];
                                           
                                           [CustomeClass mainQueue:^{
                                               POSTNOTI(HIDDENLOGINANDREGISTERWINDOW, nil);
                                           }];
                                           
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf setAlreadyUserInfoWithSession:ws_session];);
    }];
}

/** 初始化用户信息类（用户之前没有注册过的调用该方法进行注册）*/
+ (void)initFirstRegisterUserInfoClassWithDic:(MovierDCInterfaceSvc_VDCSession *)ws_session
                                      Account:(MovierDCInterfaceSvc_VDCThirdPartyAccount *)account{
    
    //初始化userentity
    [[UserEntity sharedSingleton] Applogin:[NSString stringWithFormat:@"%@", account.szAccount]
                                    appPwd:[NSString stringWithFormat:@"%@", account.szPwd]
                                 LoginType:[account.nThirdPartyType intValue]];
    [UserEntity sharedSingleton].sessionId = [[NSString alloc] initWithFormat:@"%@", ws_session.nSessionID];
    [UserEntity sharedSingleton].customerId = [NSString stringWithFormat:@"%@", ws_session.nCustomerID];
    [UserEntity sharedSingleton].ossDir = ws_session.szRootDir;
    [UserEntity sharedSingleton].ossKey = ws_session.szKey;
    [UserEntity sharedSingleton].szNickname = account.szNickName;
    [UserEntity sharedSingleton].szSignature = account.szSignature;
    [UserEntity sharedSingleton].szAcatar = account.szAcatar;
    
    [self setUserInfoWithSession:ws_session];
}

/** 填充用户信息的一部分（具体为啥要分开，我也表示很难理解）*/
+ (void)setUserInfoWithSession:(MovierDCInterfaceSvc_VDCSession *)ws_session{
    WEAKSELF2
    [[SoapOperation Singleton] WS_GetossConfig:ws_session
                                       Success:^(MovierDCInterfaceSvc_VDCOSSConfig *ossconfig) {
                                           [UserEntity sharedSingleton].ossBucket = ossconfig.szBucket;
                                           [UserEntity sharedSingleton].ossID = ossconfig.szID;
                                           [UserEntity sharedSingleton].ossKey = ossconfig.szKey;
                                           [UserEntity sharedSingleton].ossEndpoint = ossconfig.szEndpoint;
                                           [[APPUserPrefs Singleton] StartOrderT];
                                           
                                           [weakSelf sendDeviceTokenAndCid];
                                           
                                           MAINQUEUEUPDATEUI({
                                               //跳转完善用户信息页面
                                               POSTNOTI(@"pushToPerfectUserInfoVc", nil);
                                           })
                                           
                                       } Fail:^(NSError *error) {
                                           RELOADSERVERDATA([weakSelf setUserInfoWithSession:ws_session];);
                                       }];
}

#pragma mark - 我的界面默认获得session方法
/** 每次进入app时获得session（已经登录状态下）*/
+ (void)getSessionWhenUserAlreadyLogin{
    
    if (![UserEntity sharedSingleton].isAppHasLogin) {
        return;
    }
    WEAKSELF2
    [[SoapOperation Singleton] loginByAccountWithAccount:[UserEntity sharedSingleton].appUserName
                                                Password:(([UserEntity sharedSingleton].appLoginType == 0) ?
                                                          [UserEntity sharedSingleton].appUserPWD : nil)
                                             AccountType:[UserEntity sharedSingleton].appLoginType
                                                 Success:^(NSMutableDictionary *serverDataDictionary) {
                                                     
                //已经注册过的话就进行登录设置用户信息类
                [weakSelf fillUseEntity:[weakSelf setSessionWithDic:serverDataDictionary]];
    } Fail:^(NSError *error) {
        if (error.code == 50) {
            [CustomeClass showMessage:@"抱歉，账号被封！" ShowTime:3];
        } else if (error.code == 35){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"personalbacToff" object:nil];
            [[UserEntity sharedSingleton] Applogout];
            //ws_session 清空
            [SoapOperation Singleton].WS_Session = nil;
        }else{
            RELOADSERVERDATA([weakSelf getSessionWhenUserAlreadyLogin];);
        }
    }];
}

/** 每次进入app时的默认获得session*/
+ (void)fillUseEntity:(MovierDCInterfaceSvc_VDCSession*)ws_session{
    [self setUserInfoAtAPPStartWithSession:ws_session];
    WEAKSELF2
    [UserEntity sharedSingleton].customerId = [NSString stringWithFormat:@"%@",ws_session.nCustomerID ];
    [[SoapOperation Singleton] WS_QueryUserInfo:^(MovierDCInterfaceSvc_VDCCustomerInfo *info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SoapOperation Singleton].usename = info.szNickname;
            [UserEntity sharedSingleton].szNickname = info.szNickname;
            [UserEntity sharedSingleton].szSignature = info.szSignature;
            [UserEntity sharedSingleton].szAcatar = info.szAcatar;
            
            [CustomeClass mainQueue:^{
                
                //通知我的页面更新用户个人信息
                POSTNOTI(@"updateUserInfo", nil);
            }];
        });
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf fillUseEntity:ws_session];);
    }];
}

/** 设置用户信息类的另一部分*/
+ (void)setUserInfoAtAPPStartWithSession:(MovierDCInterfaceSvc_VDCSession *)ws_session{
    WEAKSELF2
    [[SoapOperation Singleton] WS_GetossConfig:ws_session
                                       Success:^(MovierDCInterfaceSvc_VDCOSSConfig *ossconfig) {
                                           [UserEntity sharedSingleton].ossBucket = ossconfig.szBucket;
                                           [UserEntity sharedSingleton].ossID = ossconfig.szID;
                                           [UserEntity sharedSingleton].ossKey = ossconfig.szKey;
                                           [UserEntity sharedSingleton].ossEndpoint = ossconfig.szEndpoint;
                                           [[APPUserPrefs Singleton] StartOrderT];
   } Fail:^(NSError *error) {
       RELOADSERVERDATA([weakSelf setUserInfoAtAPPStartWithSession:ws_session];);
   }];
}

/** 上传cid和devicetoken*/
+ (void)sendDeviceTokenAndCid{
    
    //向后台发送cid和deviceToken
    WEAKSELF2
    [[SoapOperation Singleton] WS_operatedevicelistWithOperationType:1
                                                             Success:^(NSNumber *num) {
        
    } Fail:^(NSError *error) {
        NSLog(@"%@", error);
        [weakSelf sendDeviceTokenAndCid];
    }];
}
@end
