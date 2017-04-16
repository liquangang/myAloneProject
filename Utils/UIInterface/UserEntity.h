//
//  UserEntity.h
//  MYPassValue
//
//  Created by arbin on 14-12-28.
//  Copyright (c) 2014年 Movier. All rights reserved.
//

#import <Foundation/Foundation.h>

//  app 登陆方式
//要换绑的账号类型（0-手机、1-微信、2-QQ、3-微博
typedef enum {
    /**  手机登陆 */
    LoginTypePhone,
    /**  微信登陆 */
    LoginTypeWeChat,
    /**  qq登录*/
    LoginTypeQQ,
    /**  微博登录*/
    LoginTypeWeibo
}LoginType;

@interface UserEntity : NSObject
{
    NSString *ossBucket;
    NSString *ossEndpoint;
    NSString *ossID;
    NSString *ossKey;
    NSString *ossDir;
    NSString *sessionKey;
    NSString *sessionId;
    NSString *customerId;
    NSString *appUserName;
    NSString *appUserPWD;
    NSInteger vdcLoginret;
    
    
}

+ (UserEntity *)sharedSingleton;
-(void)Applogin:(NSString*)appusername appPwd:(NSString*)appPwd LoginType:(LoginType)typeLoginType;
-(void)Applogout;
-(BOOL)isAppHasLogin;

@property (nonatomic,retain) NSString *ossBucket;
@property (nonatomic,retain) NSString *ossEndpoint;
@property (nonatomic,retain) NSString *ossID;
@property (nonatomic,retain) NSString *ossKey;
@property (nonatomic,retain) NSString *ossDir;
@property (nonatomic,retain) NSString *sessionKey;
@property (nonatomic,retain) NSString *sessionId;
@property (nonatomic,retain) NSString *customerId;
@property (nonatomic,retain) NSString *appUserName;
@property (nonatomic,retain) NSString *appUserPWD;

@property (nonatomic,retain) NSString *szNickname;
@property (nonatomic,retain) NSString *szSignature;
@property (nonatomic,retain) NSString *szAcatar;

@property NSInteger vdcLoginret;

// 登陆类型
@property (assign, nonatomic) LoginType appLoginType;
@end
