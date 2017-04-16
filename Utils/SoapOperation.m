//
//  Soap4Movier.m
//  M-Cut
//
//  Created by Crab00 on 15/10/6.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "SoapOperation.h"
#import "GlobalVars.h"
#import "MovierDCInterfaceSvc.h"
#import "UserEntity.h"
#import "GeTuiSdk.h"
#import "AppDelegate.h"
#import "CustomeClass.h"
#import "MaterialModel.h"
#import "LoginAndRegister.h"

#define HANDLERETURNVALUE(interfaceMethod, returnObj, blockCode) dispatch_async(dispatch_get_global_queue(0, 0), ^{\
    [_syclock lock];\
    MovierDCInterfaceBindingResponse * response = [self.soapbing interfaceMethod:arg0];\
    [_syclock unlock];\
    if (response.error != nil || response.bodyParts == nil) {\
        block_fail(response.error);return;\
    }else{\
        for (id bodyPart in response.bodyParts) {\
            if ([bodyPart isKindOfClass:[returnObj class]]) {\
                returnObj * ret = (returnObj *)bodyPart;\
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {\
                    block_suc(blockCode);\
                }else{\
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {\
                        [LoginAndRegister getSessionWhenUserAlreadyLogin];\
                    }\
                    block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);\
                    }\
            }else{\
                block_fail(response.error);\
}\
}\
}\
});


@interface SoapOperation()<MovierDCInterfaceBindingResponseDelegate>
@property(nonatomic,retain)MovierDCInterfaceBinding *soapbing;
@end

@implementation SoapOperation


+ (SoapOperation *)Singleton{
    static SoapOperation *Singleton;
    
    @synchronized(self)
    {
        if (!Singleton){
            Singleton = [[SoapOperation alloc] init];
            Singleton.WS_Session = [[MovierDCInterfaceSvc_VDCSession alloc]init];
            Singleton.soapbing = [MovierDCInterfaceSvc MovierDCInterfaceBinding];
            Singleton.syclock = [[NSLock alloc] init];
            Singleton.loginlock = [[NSLock alloc]init];
        }
        return Singleton;
    }
}

-(void)WS_Login:(NSString *)username Password:(NSString *)pw withVersion:(NSString *)appversion Encrypt:(BOOL)bEncrypt Success:(LoginSuccessBlock)block_suc Fail:(LoginFailBlock)block_fail{
    if ([username isEqualToString:@""]) {
        block_fail(@(LOCAL_USER_NIL),[NSError errorWithDomain:@"" code:LOCAL_USER_NIL userInfo:nil]);
    }
    MovierDCInterfaceSvc_loginex *arg0 = [[MovierDCInterfaceSvc_loginex alloc]init];
    arg0.pszUserName = username;
    arg0.pszPassword = pw;
    arg0.pszSubVersion = appversion;
    arg0.pszMainVersion = appversion;
    arg0.bEncrypt = [[USBoolean alloc]initWithBool:bEncrypt];
    arg0.nPlatform = [NSNumber numberWithInt:TYPE_IOS];
    
    [self initCustomer:username withPw:pw Encrypt:bEncrypt Version:appversion];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response =[self.soapbing loginexUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail([NSNumber numberWithInt:MOVIERDC_NETERROR],response.error);
            return;
        }else{
            //        NSArray *responseHeaders = response.headers;
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_VDCSessionEnv *sessenv = (MovierDCInterfaceSvc_VDCSessionEnv*)bodyPart;
                if ([sessenv.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ) {
                    self.WS_Session = sessenv.session;
                    self.usename = username;
                    block_suc(sessenv.session);
                }else{
                    if ([sessenv.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[sessenv.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[sessenv.nRet integerValue] userInfo:nil];
                    block_fail(sessenv.nRet,error);
                }
            }
        }
    });
}

-(void)WS_Login:(NSString*)partyAccount ThirdPartyType:(NSString*)type Token:(NSString*)token Openid:(NSString*)openID APPVersion:(NSString*) version SubVersion:(NSString*)subver Success:(LoginSuccessBlock)block_suc Fail:(LoginFailBlock)block_fail{
    if ([partyAccount isEqualToString:@""]) {
        block_fail(@(LOCAL_USER_NIL),[NSError errorWithDomain:@"" code:LOCAL_USER_NIL userInfo:nil]);
    }
    MovierDCInterfaceSvc_thirdpartylogin *arg0 = [[MovierDCInterfaceSvc_thirdpartylogin alloc]init];
    arg0.pszThirdPartyAccount = partyAccount;
    arg0.nThirdPartyType = @([type intValue]);
    arg0.pszSubVersion = version;
    arg0.pszMainVersion = subver;
    arg0.pszToken = token;
    arg0.pszOpenID = openID;
    arg0.nPlatform = [NSNumber numberWithInt:TYPE_IOS];
    
    [self initThirdPartyCustomer:partyAccount withToken:token OpenID:openID];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing thirdpartyloginUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail([NSNumber numberWithInt:MOVIERDC_NETERROR],response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_VDCSessionEnv* sessenv = (MovierDCInterfaceSvc_VDCSessionEnv*)bodyPart;
                if ([sessenv.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ) {
                    self.WS_Session = sessenv.session;
                    self.usename = openID;
                    block_suc(sessenv.session);
                }else{
                    if ([sessenv.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[sessenv.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[sessenv.nRet integerValue] userInfo:nil];
                    block_fail(sessenv.nRet,error);
                }
            }
        }
    });}

-(void)initThirdPartyCustomer:(NSString*)partyAccount withToken:(NSString*)token OpenID:(NSString*)openID{
    self.thirdpartycount = partyAccount;
    self.openid = token;
    self.token = openID;
}

-(void)initCustomer:(NSString*)use withPw:(NSString*)pw Encrypt:(BOOL)encrypt Version:(NSString*)ver{
    self.usename = use;
    self.password = pw;
    self.bEncrypt = encrypt;
    self.appversion = ver;
}

/** 活动标签下载 定制标签下载*/
-(void)WS_GetVideoLabel:(MovierDCInterfaceSvc_VDCSession*)session Start:(NSNumber*)offset Count:(NSNumber*)count Parent:(NSNumber*)parent Success:(GetVideoLabelSucB)block_suc Fail:(GetVideoLabelFB)block_fail{

    MovierDCInterfaceSvc_getvideolabelsexbyparentid *arg0 = [[MovierDCInterfaceSvc_getvideolabelsexbyparentid alloc]init];
    arg0.in_ = session;
    arg0.nOffset = offset;
    arg0.nCount = count;
    arg0.nParentID = parent;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response =[self.soapbing getvideolabelsexbyparentidUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            //        NSArray *responseHeaders = response.headers;
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_VDCVideoLabelExArrayEnv * ret = (MovierDCInterfaceSvc_VDCVideoLabelExArrayEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ) {
                    block_suc(ret.stVDCVideoLabelExArray);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_GetCommentsNumByVideoid:(NSNumber*)vid Success:(GetCommentsNumB)block_suc Fail:(SoapErrorB)block_fail{

    MovierDCInterfaceSvc_vpgetcommenttotalnum *arg0 = [[MovierDCInterfaceSvc_vpgetcommenttotalnum alloc]init];
    arg0.nVideoID = vid;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing vpgetcommenttotalnumUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            //        NSArray *responseHeaders = response.headers;
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IntEnv * ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ) {
                    block_suc(ret.nVal);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}
-(void)WS_GetCommentsByVideoid:(NSNumber*)vid Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetCommentsB)block_suc Fail:(SoapErrorB)block_fail{

    MovierDCInterfaceSvc_vpgetcomment *arg0 = [[MovierDCInterfaceSvc_vpgetcomment alloc]init];
    arg0.nVideoID = vid;
    arg0.nOffset = offset;
    arg0.nCount = count;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing vpgetcommentUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            //        NSArray *responseHeaders = response.headers;
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_vpVideoCommentArrEnv* ret = (MovierDCInterfaceSvc_vpVideoCommentArrEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ) {
                    block_suc(ret.stVideoCommentArr);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES ||[ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_INVALID_SESSION]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_SubmitCommentByid:(NSNumber*)vid Session:(MovierDCInterfaceSvc_VDCSession*)ws_session Reply:(NSNumber*)replycommentid Content:(NSString*)cont Success:(SubmitCommentB)block_suc Fail:(SoapErrorB)block_fail{

    MovierDCInterfaceSvc_vpsubmitcomment *arg0 = [[MovierDCInterfaceSvc_vpsubmitcomment alloc]init];
    arg0.nVideoID = vid;
    arg0.in_ = self.WS_Session;
    arg0.nReplyComment = replycommentid;
    arg0.pszComment = cont;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing vpsubmitcommentUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            //        NSArray *responseHeaders = response.headers;
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ) {
//                    block_suc([ret.nVal intValue]);
                    block_suc();
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_RemoveCommentByid:(NSNumber*)commentid Session:(MovierDCInterfaceSvc_VDCSession*)ws_session Success:(RemoveCommentB)block_suc Fail:(SoapErrorB)block_fail{

    MovierDCInterfaceSvc_vpremovecomment *arg0 = [[MovierDCInterfaceSvc_vpremovecomment alloc]init];
    arg0.nCommentID = commentid;
    arg0.in_ = self.WS_Session;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing vpremovecommentUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            //        NSArray *responseHeaders = response.headers;
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ) {
                    //                    block_suc([ret.nVal intValue]);
                    block_suc();
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}
-(void)WS_ReportCommentByid:(NSNumber*)commentid Session:(MovierDCInterfaceSvc_VDCSession*)ws_session ReportType:(NSNumber*)type Reason:(NSString*)reason Success:(RemoveCommentB)block_suc Fail:(SoapErrorB)block_fail{

    MovierDCInterfaceSvc_vpreportcomment *arg0 = [[MovierDCInterfaceSvc_vpreportcomment alloc]init];
    arg0.nCommentID = commentid;
    arg0.in_ = self.WS_Session;
    arg0.nReportType = type;
    arg0.pszReason = reason;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing vpreportcommentUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            //        NSArray *responseHeaders = response.headers;
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ) {
                    //                    block_suc([ret.nVal intValue]);
                    block_suc();
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_SearchUser:(NSString*)keyword Start:(NSNumber*)offset Count:(NSNumber*)count Success:(SearchUserBlock)block_suc Fail:(SoapErrorB)block_fail{

    MovierDCInterfaceSvc_searchuser *arg0 = [[MovierDCInterfaceSvc_searchuser alloc]init];
    arg0.pszKeyWord = keyword;
    arg0.nOffset = offset;
    arg0.nCount = count;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing searchuserUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            //        NSArray *responseHeaders = response.headers;
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_VDCCustomerBaseInfoExArrEnv* ret = (MovierDCInterfaceSvc_VDCCustomerBaseInfoExArrEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ) {
                    //                    block_suc([ret.nVal intValue]);
                    block_suc(ret.stVDCCustomerBaseInfoExArr);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_SearchVideo:(NSString*)keyword Start:(NSNumber*)offset Count:(NSNumber*)count Success:(SearchVideoB)block_suc Fail:(SoapErrorB)block_fail{

    MovierDCInterfaceSvc_searchvideo *arg0 = [[MovierDCInterfaceSvc_searchvideo alloc]init];
    /* elements */
//    NSString * pszKeyWord;
//    NSNumber * nOffset;
//    NSNumber * nCount;
    /* attributes */
    arg0.pszKeyWord = keyword;
    arg0.nOffset = offset;
    arg0.nCount = count;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing searchvideoUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            //        NSArray *responseHeaders = response.headers;
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_VDCVideoInfoExArrayEnv* ret = (MovierDCInterfaceSvc_VDCVideoInfoExArrayEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ) {
                    //                    block_suc([ret.nVal intValue]);
                    block_suc(ret.stVDCVideoInfoArray);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

- (void)WS_SearchMusic:(NSString *)keyword Start:(NSNumber *)offset Count:(NSNumber *)count Success:(SearchMusicBlock)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_vpsearchonlinemusic * arg0 = [[MovierDCInterfaceSvc_vpsearchonlinemusic alloc] init];
    /*
     MovierDCInterfaceSvc_VDCSession * in_;
     NSString * szKeyWord;
     NSNumber * nOffset;
     NSNumber * nCount;
     */
    arg0.in_ = self.WS_Session;
    arg0.szKeyWord = keyword;
    arg0.nOffset = offset;
    arg0.nCount = count;
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [weakSelf.soapbing vpsearchonlinemusicUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (MovierDCInterfaceSvc_vpVDCMusicExArrEnv * bodyPart in response.bodyParts) {
                NSLog(@"%@", [response.bodyParts[0] class]);
                if ([bodyPart.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]] == YES) {
                    NSLog(@"%ld", bodyPart.stMusicExArr.item.count);
                    block_suc(bodyPart.stMusicExArr);
                }else{
                    if ([bodyPart.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {
                        [weakSelf WS_newRELogin:weakSelf.usename Password:weakSelf.password withVersion:weakSelf.appversion Encrypt:weakSelf.bEncrypt];
                    }
                    NSError * error = [NSError errorWithDomain:@"" code:[bodyPart.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

//- (NSArray *)WS_SearchMusic:(NSString *)keyword Start:(NSNumber *)offset Count:(NSNumber *)count{
//    MovierDCInterfaceSvc_vpsearchonlinemusic * arg0 = [[MovierDCInterfaceSvc_vpsearchonlinemusic alloc] init];
//    /*
//     MovierDCInterfaceSvc_VDCSession * in_;
//     NSString * szKeyWord;
//     NSNumber * nOffset;
//     NSNumber * nCount;
//     */
//    arg0.in_ = self.WS_Session;
//    arg0.szKeyWord = keyword;
//    arg0.nOffset = offset;
//    arg0.nCount = count;
//    NSMutableArray * musicArray = [NSMutableArray arrayWithCapacity:0];
//    __weak typeof(self) weakSelf = self;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [_syclock lock];
//        MovierDCInterfaceBindingResponse * response = [weakSelf.soapbing vpsearchonlinemusicUsingBody:arg0];
//        [_syclock unlock];
//        if (response.error != nil || response.bodyParts == nil) {
//            NSLog(@"searchMusicError---response-----%@", response.error);
//            return;
//        }else{
//            NSArray * responseBodyParts = response.bodyParts;
////            for (id bodypart in response.bodyParts) {
////                NSLog(@"%@",[bodypart class]);
////                MovierDCInterfaceSvc_vpVDCMusicExArrEnv *ret = bodypart;
////            }
//            for (id bodyPart in responseBodyParts) {
//                MovierDCInterfaceSvc_vpVDCMusicExArrEnv * ret = (MovierDCInterfaceSvc_vpVDCMusicExArrEnv *)bodyPart;
//                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]] == YES) {
//                    //此处得到搜索音乐的数据
//                    NSLog(@" ret.stMusicArr.item.count-------%ld", ret.stMusicExArr.item.count);
//                }else{
//                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {
//                        [weakSelf WS_RELogin:weakSelf.usename Password:weakSelf.password withVersion:weakSelf.appversion Encrypt:weakSelf.bEncrypt];
//                    }
//                    NSError * error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
//                    NSLog(@"searchMusicError--------%@", error);
//                }
//            }
//        }
//    });
//    return [musicArray copy];
//}

-(void)WS_GetBannerNum:(NSNumber*)labelid Success:(GetBannerNumB)block_suc Fail:(SoapErrorB)block_fail{

    MovierDCInterfaceSvc_getbannertotalnum *arg0 = [[MovierDCInterfaceSvc_getbannertotalnum alloc]init];
    arg0.nLabelID = labelid;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing getbannertotalnumUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            //        NSArray *responseHeaders = response.headers;
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ) {
                    //                    block_suc([ret.nVal intValue]);
                    block_suc(ret.nVal);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}
-(void)WS_GetBanner:(NSNumber*)labelid Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetBanner)block_suc Fail:(SoapErrorB)block_fail{

    MovierDCInterfaceSvc_getbanner *arg0 = [[MovierDCInterfaceSvc_getbanner alloc]init];
    arg0.nLabelID = labelid;
    arg0.nOffset = offset;
    arg0.nCount = count;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing getbannerUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            //        NSArray *responseHeaders = response.headers;
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_VDCBannerInfoArrayEnv* ret = (MovierDCInterfaceSvc_VDCBannerInfoArrayEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ) {
                    //                    block_suc([ret.nVal intValue]);
                    block_suc(ret.stVDCBannerInfoArray);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}


-(void)WS_GetossConfig:(MovierDCInterfaceSvc_VDCSession*)ws_session Success:(GetOssConfigB)block_suc Fail:(SoapErrorB)block_fail{

    MovierDCInterfaceSvc_getossconfig *arg0 = [[MovierDCInterfaceSvc_getossconfig alloc]init];
    arg0.in_ = ws_session;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing getossconfigUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            //        NSArray *responseHeaders = response.headers;
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_VDCOSSConfigEnv* ret = (MovierDCInterfaceSvc_VDCOSSConfigEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ) {
                    //                    block_suc([ret.nVal intValue]);
                    block_suc(ret.stVDCOSSConfig);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_Register:(MovierDCInterfaceSvc_VDCThirdPartyAccountEx*)countinfo Success:(RegisterThirdB)block_suc Fail:(RegisterThirdFailB)block_fail{
    MovierDCInterfaceSvc_registerusingthirdpartyaccountex *arg0 = [[MovierDCInterfaceSvc_registerusingthirdpartyaccountex alloc]init];
    arg0.in_ = countinfo;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing registerusingthirdpartyaccountexUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error,@(500));
            return;
        }else{
            //        NSArray *responseHeaders = response.headers;
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ||[ret.nRet isEqualToNumber:@(34)]==YES) {
                    //                    block_suc([ret.nVal intValue]);
                    block_suc(ret.nRet);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error,ret.nVal);
                }
            }
        }
    });
}

-(void)WS_Register:(NSString *)userName withPassword:(NSString *)userPassword withPhoneNum:(NSString *)userTelephone Success:(RegisterThirdB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_registerusingtel *arg0 = [[MovierDCInterfaceSvc_registerusingtel alloc]init];
    arg0.pszUserName = userName;
    arg0.pszPassword = userPassword;
    arg0.pszTel = userTelephone;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing registerusingtelUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ||[ret.nRet isEqualToNumber:@(34)]==YES) {
                    //                    block_suc([ret.nVal intValue]);
                    block_suc(ret.nRet);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}


-(void)WS_GetSecret:(NSString*)account Platform:(NSNumber*)type Openid:(NSString*)openid Token:(NSString*)token Success:(RegisterThirdB)block_suc Fail:(SoapErrorB)block_fail{

    MovierDCInterfaceSvc_thirdpartygetsecret *arg0 = [[MovierDCInterfaceSvc_thirdpartygetsecret alloc]init];
    arg0.pszThirdPartyAccount = account;
    arg0.pszOpenID = openid;
    arg0.pszToken = token;
    arg0.nThirdPartyType = type;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing thirdpartygetsecretUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            //        NSArray *responseHeaders = response.headers;
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ) {
                    //                    block_suc([ret.nVal intValue]);
                    block_suc(ret.nRet);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_GetPersonalVideos:(MovierDCInterfaceSvc_VDCSession*)ws_session Customer:(NSNumber*)userid Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetVideosB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_getvideoforhomepageex *arg0 = [[MovierDCInterfaceSvc_getvideoforhomepageex alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.nCustomerID = userid;
    arg0.nOffset = offset;
    arg0.nCount = count;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing getvideoforhomepageexUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_VDCVideoInfoExArrayEnv* ret = (MovierDCInterfaceSvc_VDCVideoInfoExArrayEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ) {
                    //                    block_suc([ret.nVal intValue]);
                    block_suc(ret.stVDCVideoInfoArray);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

/** 根据labelid获取视频*/
-(void)WS_GetVideosbyLabel:(MovierDCInterfaceSvc_VDCSession*)ws_session Label:(NSNumber*)labelid Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetVideosB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_getvideobylabelidex *arg0 = [[MovierDCInterfaceSvc_getvideobylabelidex alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.nLabelID = labelid;
    arg0.nOffset = offset;
    arg0.nCount = count;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing getvideobylabelidexUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_VDCVideoInfoExArrayEnv* ret = (MovierDCInterfaceSvc_VDCVideoInfoExArrayEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ) {
                    //                    block_suc([ret.nVal intValue]);
                    block_suc(ret.stVDCVideoInfoArray);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_GetVideosInfo:(MovierDCInterfaceSvc_VDCSession*)ws_session IDarray:(MovierDCInterfaceSvc_IDArray*)array Success:(GetVideosB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_getvideobyvideoidarrex *arg0 = [[MovierDCInterfaceSvc_getvideobyvideoidarrex alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.videoidarr = array;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing getvideobyvideoidarrexUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_VDCVideoInfoExArrayEnv* ret = (MovierDCInterfaceSvc_VDCVideoInfoExArrayEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ) {
                    //                    block_suc([ret.nVal intValue]);
                    block_suc(ret.stVDCVideoInfoArray);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });;
}

-(void)WS_GetTemplateNum:(MovierDCInterfaceSvc_VDCSession*)ws_session Success:(GetTemplateB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_vpgettemplatecattotalnum *arg0 = [[MovierDCInterfaceSvc_vpgettemplatecattotalnum alloc]init];
    arg0.in_ = self.WS_Session;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing vpgettemplatecattotalnumUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    //                    block_suc([ret.nVal intValue]);
                    block_suc(ret.nVal);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_INVALID_SESSION]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
        });

 
}

-(void)WS_GetTemplateCat:(MovierDCInterfaceSvc_VDCSession*)ws_session Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetTemplateArrayB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_vpgettemplatecat *arg0 = [[MovierDCInterfaceSvc_vpgettemplatecat alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.nOffset = offset;
    arg0.nCount = count;
    HANDLERETURNVALUE(vpgettemplatecatUsingBody, MovierDCInterfaceSvc_VDCTemplateCatArrEnv, ret.stTemplateCatArr)
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [_syclock lock];
//        MovierDCInterfaceBindingResponse *response = [self.soapbing vpgettemplatecatUsingBody:arg0];
//        [_syclock unlock];
//        if (response.error!=nil||response.bodyParts==nil) {
//            block_fail(response.error);
//            return;
//        }else{
//            NSArray *responseBodyParts = response.bodyParts;
//            for (id bodyPart in responseBodyParts) {
//                MovierDCInterfaceSvc_VDCTemplateCatArrEnv* ret = (MovierDCInterfaceSvc_VDCTemplateCatArrEnv*)bodyPart;
//                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
//                    //                    block_suc([ret.nVal intValue]);
//                    block_suc(ret.stTemplateCatArr);
//                }else{
//                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES ||[ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_INVALID_SESSION]] == YES) {//被踢出去了
//                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
//                    }
//                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
//                    block_fail(error);
//                }
//            }
//        }
//    });
}

-(void)WS_GetStylebyCat:(MovierDCInterfaceSvc_VDCSession*)ws_session CatType:(NSNumber*)style Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetStyleArrayB)block_suc Fail:(SoapErrorB)block_fail{

    MovierDCInterfaceSvc_vpgetheaderandtailbycat *arg0 = [[MovierDCInterfaceSvc_vpgetheaderandtailbycat alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.nOffset = offset;
    arg0.nCount = count;
    arg0.nTemplateCat = style;
    HANDLERETURNVALUE(vpgetheaderandtailbycatUsingBody, MovierDCInterfaceSvc_vpVDCHeaderAndTailArrayEnv, ret.stHeaderAndTailArr);
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [_syclock lock];
//        MovierDCInterfaceBindingResponse *response = [self.soapbing vpgetheaderandtailbycatUsingBody:arg0];
//        [_syclock unlock];
//        if (response.error!=nil||response.bodyParts==nil) {
//            block_fail(response.error);
//            return;
//        }else{
//            NSArray *responseBodyParts = response.bodyParts;
//            for (id bodyPart in responseBodyParts) {
//                MovierDCInterfaceSvc_vpVDCHeaderAndTailArrayEnv* ret = (MovierDCInterfaceSvc_vpVDCHeaderAndTailArrayEnv*)bodyPart;
//                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
//                    //                    block_suc([ret.nVal intValue]);
//                    block_suc(ret.stHeaderAndTailArr);
//                }else{
//                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
//                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
//                    }
//                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
//                    block_fail(error);
//                }
//            }
//        }
//    });

}

-(void)WS_GetDefaultInfoUseStyle:(MovierDCInterfaceSvc_VDCSession*)ws_session StyleID:(NSNumber*)styleid Success:(GetDefaultInfoWithStyle)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_vpgetdefaultmusicandsubtitlebyheaderandtailid *arg0 = [[MovierDCInterfaceSvc_vpgetdefaultmusicandsubtitlebyheaderandtailid alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.nHeaderAndTailID = styleid;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing vpgetdefaultmusicandsubtitlebyheaderandtailidUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_vpVDCDefaultMusicAndSubtitleForStyle* ret = (MovierDCInterfaceSvc_vpVDCDefaultMusicAndSubtitleForStyle*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    //                    block_suc([ret.nVal intValue]);
                    block_suc(ret.stMusic,ret.stSubtitle);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

/*-(void)WS_GetHeaderNumbyCat:(MovierDCInterfaceSvc_VDCSession*)ws_session CatType:(NSNumber*)style Success:(GetHeaderNumB)block_suc Fail:(SoapErrorB)block_fail{

 [_syclock lock];
    MovierDCInterfaceSvc_vpgetheaderandtailtotalbycat *arg0 = [[MovierDCInterfaceSvc_vpgetheaderandtailtotalbycat alloc]init];
    arg0.in_ = ws_session;
    arg0.nTemplateCat = style;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        MovierDCInterfaceBindingResponse *response = [self.soapbing vpgetheaderandtailtotalbycatUsingBody:arg0];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    //                    block_suc([ret.nVal intValue]);
                    block_suc(ret.nRet);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_RELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });

}*/

-(void)WS_ReportVideo:(MovierDCInterfaceSvc_VDCSession*)ws_session ReportType:(NSNumber*)type VideoId:(NSNumber*)vid Reason:(NSString*)reportReason Success:(ReportVideoB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_userreport *arg0 = [[MovierDCInterfaceSvc_userreport alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.nVideoID = vid;
    arg0.nCategory = type;
    arg0.pszRemark = reportReason;
    NSLog(@"report id = %@",arg0.nVideoID);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing userreportUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    block_suc();
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_SetCollectVideo:(MovierDCInterfaceSvc_VDCSession*)ws_session ChangeStatus:(BOOL)bStauts VideoId:(NSNumber*)vid Success:(ReportVideoB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_markfavoritebyid *arg0 = [[MovierDCInterfaceSvc_markfavoritebyid alloc]init];
    arg0.bOp = [[USBoolean alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.nVideoID = vid;
    [arg0.bOp setBoolValue:bStauts];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing markfavoritebyidUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    block_suc(ret.nVal);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||
                        [ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_INVALID_SESSION]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}


-(void)WS_GetPersonalCollectionNum:(MovierDCInterfaceSvc_VDCSession*)ws_session Success:(GetTotalCollectionB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_getfavoritevideototalnum *arg0 = [[MovierDCInterfaceSvc_getfavoritevideototalnum alloc]init];
    arg0.in_ = self.WS_Session;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing getfavoritevideototalnumUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    block_suc(ret.nVal);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_GetPersonalCollection:(MovierDCInterfaceSvc_VDCSession*)ws_session Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetColectionVideosB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_getfavoritevideoex *arg0 = [[MovierDCInterfaceSvc_getfavoritevideoex alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.nOffset = offset;
    arg0.nCount = count;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing getfavoritevideoexUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_VDCVideoInfoExArrayEnv* ret = (MovierDCInterfaceSvc_VDCVideoInfoExArrayEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    block_suc(ret.stVDCVideoInfoArray);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_GetVideoColletionStatus:(MovierDCInterfaceSvc_VDCSession*)ws_session VideoIds:(MovierDCInterfaceSvc_IDArray*)vids Success:(GetVideoColletionB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_vpgetfavouritestatus *arg0 = [[MovierDCInterfaceSvc_vpgetfavouritestatus alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.idarr = vids;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing vpgetfavouritestatusUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IDArrayEnv* ret = (MovierDCInterfaceSvc_IDArrayEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    block_suc(ret.stIDArr);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_GetMusicList:(MovierDCInterfaceSvc_vpQueryCond*)cond Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetMusicListB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_vpgetmusic *arg0 = [[MovierDCInterfaceSvc_vpgetmusic alloc]init];
    [self.loginlock lock];
    arg0.in_ = self.WS_Session;
    [self.loginlock unlock];
    arg0.invpQueryCond = cond;
    arg0.nOffset = offset;
    arg0.nCount = count;
    HANDLERETURNVALUE(vpgetmusicUsingBody, MovierDCInterfaceSvc_vpVDCMusicArrayEnv, ret.stMusicArr)
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [_syclock lock];
//        MovierDCInterfaceBindingResponse *response = [self.soapbing vpgetmusicUsingBody:arg0];
//        [_syclock unlock];
//        if (response.error!=nil||response.bodyParts==nil) {
//            block_fail(response.error);
//            return;
//        }else{
//            NSArray *responseBodyParts = response.bodyParts;
//            for (id bodyPart in responseBodyParts) {
//                MovierDCInterfaceSvc_vpVDCMusicArrayEnv* ret = (MovierDCInterfaceSvc_vpVDCMusicArrayEnv*)bodyPart;
//                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
//                    //MovierDCInterfaceSvc_vpVDCMusicC
//                    block_suc(ret.stMusicArr);
//                }else{
//                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
//                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
//                    }
//                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
//                    block_fail(error);
//                }
//            }
//        }
//    });
}

-(void)WS_GetSubtitleList:(MovierDCInterfaceSvc_vpQueryCond*)cond Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetSubtitleListB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_vpgetsubtitle *arg0 = [[MovierDCInterfaceSvc_vpgetsubtitle alloc]init];
    arg0.in_ = self.WS_Session;
    MovierDCInterfaceSvc_vpQueryCond *QueryCond = [[MovierDCInterfaceSvc_vpQueryCond alloc] init];
    QueryCond.nStyleID = 0;
    QueryCond.nFilterID = 0;
    QueryCond.nMusicID = 0;
    QueryCond.nSubtitleID = 0;
    arg0.invpQueryCond = QueryCond;
    arg0.nOffset = offset;
    arg0.nCount = count;
    HANDLERETURNVALUE(vpgetsubtitleUsingBody,
                      MovierDCInterfaceSvc_vpVDCSubtitleArrayEnv,
                      ret.stSubtitleArray)
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [_syclock lock];
//        MovierDCInterfaceBindingResponse *response = [self.soapbing vpgetsubtitleUsingBody:arg0];
//        [_syclock unlock];
//        if (response.error!=nil||response.bodyParts==nil) {
//            block_fail(response.error);
//            return;
//        }else{
//            NSArray *responseBodyParts = response.bodyParts;
//            for (id bodyPart in responseBodyParts) {
//                MovierDCInterfaceSvc_vpVDCSubtitleArrayEnv* ret = (MovierDCInterfaceSvc_vpVDCSubtitleArrayEnv*)bodyPart;
//                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
//                    block_suc(ret.stSubtitleArray);
//                }else{
//                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
//                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
//                    }
//                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
//                    block_fail(error);
//                }
//            }
//        }
//    });
}

//-(void)WS_GetCollectVideos:(MovierDCInterfaceSvc_VDCSession*)ws_session VideoId:(NSNumber*)vid Success:(ReportVideoB)block_suc Fail:(SoapErrorB)block_fail{
//    MovierDCInterfaceSvc_markfavoritebyid *arg0 = [[MovierDCInterfaceSvc_markfavoritebyid alloc]init];
//    arg0.in_ = ws_session;
//    arg0.nVideoID = vid;
//    arg0.bOp = [[USBoolean alloc] initWithBool:bStauts];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [_syclock lock];
//        MovierDCInterfaceBindingResponse *response = [self.soapbing markfavoritebyidUsingBody:arg0];
//        [_syclock unlock];
//        if (response.error!=nil||response.bodyParts==nil) {
//            block_fail(response.error);
//            return;
//        }else{
//            NSArray *responseBodyParts = response.bodyParts;
//            for (id bodyPart in responseBodyParts) {
//                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
//                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
//                    block_suc();
//                }else{
//                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES) {//被踢出去了
//                        [self WS_RELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
//                    }
//                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
//                    block_fail(error);
//                }
//            }
//        }
//    });
//}

-(void)WS_CreateOrder:(MovierDCInterfaceSvc_vpVDCOrderForCreate*)orderinfo Success:(CreateOrderB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_vpcreateorder *arg0 = [[MovierDCInterfaceSvc_vpcreateorder alloc]init];
    orderinfo.nVideoLength =[NSNumber numberWithInt:[orderinfo.nVideoLength intValue]];
    orderinfo.stLabelForVideo = [[MovierDCInterfaceSvc_VDCLabelForVideo alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.pvpOrder = orderinfo;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing vpcreateorderUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                if ([bodyPart isKindOfClass:[SOAPFault class]]) {
                    block_fail([NSError errorWithDomain:@"soap error!" code:500 userInfo:nil]);
                    return;                                
                }
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    block_suc(ret.nVal);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_QueryOrder:(MovierDCInterfaceSvc_VDCSession*)ws_session Success:(GetQueryOrderB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_queryordersbyorderstatus *arg0 = [[MovierDCInterfaceSvc_queryordersbyorderstatus alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.nOffset = @(0);        //从第一个开始取
    arg0.nCount = @(500);        //取5个
    arg0.nOrderStatus = @(3);   //订单状态为3
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing queryordersbyorderstatusUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_VDCOrderForQueryArrayEnv* ret = (MovierDCInterfaceSvc_VDCOrderForQueryArrayEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    block_suc(ret.stVDCOrderForQueryArr);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_QueryOrder:(MovierDCInterfaceSvc_VDCSession*)ws_session withID:(MovierDCInterfaceSvc_VDCOrderIDArray*)orderids Success:(GetQueryOrderB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_queryordersbyidarr *arg0 = [[MovierDCInterfaceSvc_queryordersbyidarr alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.orderidarr = orderids;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing queryordersbyidarrUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_VDCOrderForQueryArrayEnv* ret = (MovierDCInterfaceSvc_VDCOrderForQueryArrayEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    block_suc(ret.stVDCOrderForQueryArr);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_QueryUserInfo:(GetUserInfoB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_getcustomerinfoex *arg0 = [[MovierDCInterfaceSvc_getcustomerinfoex alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.nID = self.WS_Session.nCustomerID;
    HANDLERETURNVALUE(getcustomerinfoexUsingBody, MovierDCInterfaceSvc_VDCCustomerInfoEnv, ret.stVDCCustomerInfo)
}

-(void)WS_QueryOtherInfo:(int)userid Success:(GetUserInfoB)block_suc Fail:(SoapErrorB)block_fail
{
//    NSError *error =[self CheckUser];
//    if (error) {
//        block_fail(error);
//        return;
//    }
    MovierDCInterfaceSvc_getcustomerinfoex *arg0 = [[MovierDCInterfaceSvc_getcustomerinfoex alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.nID = @(userid);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing getcustomerinfoexUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_VDCCustomerInfoEnv* ret = (MovierDCInterfaceSvc_VDCCustomerInfoEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    block_suc(ret.stVDCCustomerInfo);
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
    return;
}

-(void)WS_SetUserInfo:(MovierDCInterfaceSvc_VDCCustomerInfo*)baseinfo Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail{
    NSError *error =[self CheckUser];
    if (error) {
        block_fail(error);
        return;
    }
    [self fillCustomer:baseinfo];
    MovierDCInterfaceSvc_updateuserinfo *arg0 = [[MovierDCInterfaceSvc_updateuserinfo alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.info = baseinfo;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing updateuserinfoUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                if([bodyPart isKindOfClass:[MovierDCInterfaceSvc_IntEnv class]]){
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                        block_suc(ret.nVal);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                        block_fail(error);
                    }
                }else
                    block_fail(response.error);
            }
        }
    });
    return;
}

//更新电话号码
- (void)WS_UpdateUserTelnum:(NSString *)newTelnum Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail{
    NSError * error = [self CheckUser];
    if (error) {
        block_fail(error);
        return;
    }
    MovierDCInterfaceSvc_updatetelnum * arg0 = [MovierDCInterfaceSvc_updatetelnum new];
    arg0.in_ = self.WS_Session;
    arg0.pszTel = newTelnum;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * respnose = [self.soapbing updatetelnumUsingBody:arg0];
        [_syclock unlock];
        if (respnose.error != nil || respnose.bodyParts == nil) {
            block_fail(respnose.error);
            return;
        }else{
            for (id bodyPart in respnose.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_IntEnv class]]) {
                    MovierDCInterfaceSvc_IntEnv * ret = (MovierDCInterfaceSvc_IntEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.nVal);
                    }
                    else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        NSError * error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                        block_fail(error);
                    }
                }else{
                    block_fail(respnose.error);
                }
            }
        }
    });
    return;
}

//更新第三方绑定账号（微信号等）
- (void)WS_Updatethirdpartyaccount:(NSString *)thirdPartyAccount ThirdPartyType:(NSInteger)thirdPartyType PszThirdPartyAccountAlias:(NSString *)thirdPartyAlias Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail{
    NSError * error = [self CheckUser];
    if (error) {
        block_fail(error);
        return;
    }
    MovierDCInterfaceSvc_updatethirdpartyaccount * arg0 = [MovierDCInterfaceSvc_updatethirdpartyaccount new];
    arg0.in_ = self.WS_Session;
    arg0.pszThirdPartyAccount = thirdPartyAccount;
    arg0.nThirdPartyType = @(thirdPartyType);
    arg0.pszThirdPartyAccountAlias = thirdPartyAlias;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing updatethirdpartyaccountUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_IntEnv class]]) {
                    MovierDCInterfaceSvc_IntEnv * ret = (MovierDCInterfaceSvc_IntEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.nVal);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
    return;
}

//判断用户相关信息是否存在
- (void)WS_IsCustomerHaveInfoSuccess:(WSRETURNIFHAVEUSERINFO)block_suc Fail:(SoapErrorB)block_fail{
    NSError * error = [self CheckUser];
    if (error) {
        block_fail(error);
        return;
    }
    MovierDCInterfaceSvc_getnewuserscoretask * arg0 = [MovierDCInterfaceSvc_getnewuserscoretask new];
    arg0.in_ = self.WS_Session;
   dispatch_async(dispatch_get_global_queue(0, 0), ^{
       [_syclock lock];
       MovierDCInterfaceBindingResponse * response = [self.soapbing getnewuserscoretaskUsingBody:arg0];
       [_syclock unlock];
       if (response.error != nil || response.bodyParts == nil) {
           block_fail(response.error);
           return;
       }else{
           for (id bodyPart in response.bodyParts) {
               if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCNewUserScoreTaskEnv class]]) {
                   MovierDCInterfaceSvc_VDCNewUserScoreTaskEnv * ret = (MovierDCInterfaceSvc_VDCNewUserScoreTaskEnv *)bodyPart;
                   if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                       block_suc(ret.stNewUserScoreTask);
                   }else{
                       if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                           [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                       }
                       block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                   }
               }else{
                   block_fail(response.error);
               }
           }
       }
   });
}

//2016.06.15新增绑定手机号接口
- (void)WS_UpdateTelNumEx:(NSString *)newTelNum andPassword:(NSString *)password andSuccess:(WSReturnNumberB)block_suc andFail:(SoapErrorB)block_fail{
    NSError * error = [self CheckUser];
    if (error) {
        block_fail(error);
        return;
    }
    MovierDCInterfaceSvc_updatetelnumex * arg0 = [MovierDCInterfaceSvc_updatetelnumex new];
    arg0.in_ = self.WS_Session;
    arg0.pszTel = newTelNum;
    arg0.pszPassword = password;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * respnose = [self.soapbing updatetelnumexUsingBody:arg0];
        [_syclock unlock];
        if (respnose.error != nil || respnose.bodyParts == nil) {
            block_fail(respnose.error);
            return;
        }else{
            for (id bodyPart in respnose.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_IntEnv class]]) {
                    MovierDCInterfaceSvc_IntEnv * ret = (MovierDCInterfaceSvc_IntEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.nVal);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        NSError * error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                        block_fail(error);
                    }
                }else{
                    block_fail(respnose.error);
                }
            }
        }
    });
}

//2016.06.15新增获取手机号和第三方账户绑定状态
- (void)WS_gettelandthirdpartybindstatusWithSuccess:(WSRETURNISBINDINGINFO)block_suc Fail:(SoapErrorB)block_fail{
    NSError * error = [self CheckUser];
    if (error) {
        block_fail(error);
        return;
    }
    MovierDCInterfaceSvc_gettelandthirdpartybindstatus * arg0 = [MovierDCInterfaceSvc_gettelandthirdpartybindstatus new];
    arg0.in_ = self.WS_Session;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing gettelandthirdpartybindstatusUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCTelAndThirdPartyBindStatusEnv class]]) {
                    MovierDCInterfaceSvc_VDCTelAndThirdPartyBindStatusEnv * ret = (MovierDCInterfaceSvc_VDCTelAndThirdPartyBindStatusEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(bodyPart);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

//2016.06.15新增用户积分等级界面信息
- (void)WS_GetmyscoreinshiancoinWithSuccess:(WSRETURNINTEGRALINFO)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_getmyscoreinshiancoin * arg0 = [MovierDCInterfaceSvc_getmyscoreinshiancoin new];
    arg0.in_ = self.WS_Session;
    HANDLERETURNVALUE(getmyscoreinshiancoinUsingBody, MovierDCInterfaceSvc_VDCMyScoreInshianCoinEnv, ret.stMyScoreInshianCoin)
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [_syclock lock];
//        MovierDCInterfaceBindingResponse * response = [self.soapbing getmyscoreinshiancoinUsingBody:arg0];
//        [_syclock unlock];
//        if (response.error != nil || response.bodyParts == nil) {
//            block_fail(response.error);
//            return;
//        }else{
//            for (id bodyPart in response.bodyParts) {
//                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCMyScoreInshianCoinEnv class]]) {
//                    MovierDCInterfaceSvc_VDCMyScoreInshianCoinEnv * ret = (MovierDCInterfaceSvc_VDCMyScoreInshianCoinEnv *)bodyPart;
//                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
//                        block_suc(ret.stMyScoreInshianCoin);
//                    }else{
//                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
//                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
//                        }
//                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
//                    }
//                }else{
//                    block_fail(response.error);
//                }
//            }
//        }
//    });
}

//2016.06.15新增获取用户积分记录
- (void)WS_GetscorelogWithSuccess:(WSRETURNINTEGRALINFO)block_suc Fail:(SoapErrorB)block_fail{
    NSError * error = [self CheckUser];
    if (error) {
        block_fail(error);
        return;
    }
    MovierDCInterfaceSvc_getscorelog * arg0 = [MovierDCInterfaceSvc_getscorelog new];
    arg0.in_ = self.WS_Session;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing getscorelogUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCMyScoreLogArrEnv class]]) {
                    MovierDCInterfaceSvc_VDCMyScoreLogArrEnv * ret = (MovierDCInterfaceSvc_VDCMyScoreLogArrEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(bodyPart);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

//2016.06.21新增得到用户积分日志
- (void)ws_GetscorelogWithOffest:(NSInteger)offest Count:(NSInteger)dayCount Success:(WSRETURNUSERINTRGRALLOG)block_suc Fail:(SoapErrorB)block_fail{
    NSError * error = [self CheckUser];
    if (error) {
        block_fail(error);
        return;
    }
    MovierDCInterfaceSvc_getscorelog * arg0 = [MovierDCInterfaceSvc_getscorelog new];
    arg0.in_ = self.WS_Session;
    arg0.nOffset = @(offest);
    arg0.nDayCount = @(dayCount);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing getscorelogUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCMyScoreLogArrEnv class]]) {
                    MovierDCInterfaceSvc_VDCMyScoreLogArrEnv * ret = (MovierDCInterfaceSvc_VDCMyScoreLogArrEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.stMyScoreLogArr);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

//获取用户信息（2016.06.22新增接口）
- (void)WS_getcustomerinfoex2WithSuccess:(WSRETURNUSERINFO)block_suc Fail:(SoapErrorB)block_fail{
    NSError * error = [self CheckUser];
    if (error) {
        block_fail(error);
        return;
    }
    MovierDCInterfaceSvc_getcustomerinfoex2 * arg0 = [MovierDCInterfaceSvc_getcustomerinfoex2 new];
    arg0.in_ = self.WS_Session;
    arg0.nID = [NSNumber numberWithInt:[[UserEntity sharedSingleton].customerId intValue]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing getcustomerinfoex2UsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCCustomerInfoExEnv class]]) {
                    MovierDCInterfaceSvc_VDCCustomerInfoExEnv * ret = (MovierDCInterfaceSvc_VDCCustomerInfoExEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.stVDCCustomerInfoEx);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

-(MovierDCInterfaceSvc_VDCCustomerInfo*)fillCustomer:(MovierDCInterfaceSvc_VDCCustomerInfo*)baseinfo{
    MovierDCInterfaceSvc_VDCCustomerInfo *ret = [[MovierDCInterfaceSvc_VDCCustomerInfo alloc]init];
    ret = baseinfo;
    if (ret.nCustomerID ==nil) {
        ret.nCustomerID =@(0);
    }
    if (ret.nGender ==nil) {
        ret.nGender =@(0);
    }
    if (ret.szCustomerName ==nil) {
        ret.szCustomerName =@"";
    }
    if (ret.nBirthdayY ==nil) {
        ret.nBirthdayY =@(0);
    }
    if (ret.nBirthdayM ==nil) {
        ret.nBirthdayM =@(0);
    }
    if (ret.nBirthdayD ==nil) {
        ret.nBirthdayD =@(0);
    }
    if (ret.szLocationProvince ==nil) {
        ret.szLocationProvince =@"";
    }
    if (ret.szLocationCity ==nil) {
        ret.szLocationCity =@"";
    }
    if (ret.szTel ==nil) {
        ret.szTel =@"";
    }
    if (ret.szEmail ==nil) {
        ret.szEmail =@"";
    }
    if (ret.szQQ ==nil) {
        ret.szQQ =@"";
    }
    if (ret.nPrivilege ==nil) {
        ret.nPrivilege =@(0);
    }
    if (ret.nScore ==nil) {
        ret.nScore =@(0);
    }
    if (ret.nStatus ==nil) {
        ret.nStatus =@(0);
    }
    if (ret.szRootDir ==nil) {
        ret.szRootDir =@"";
    }
    if (ret.szBucketName ==nil) {
        ret.szBucketName =@"";
    }
    if (ret.szPassword ==nil) {
        ret.szPassword =@"";
    }
    if (ret.szNickname ==nil) {
        ret.szNickname =@"";
    }
    if (ret.szSignature ==nil) {
        ret.szSignature =@"";
    }
    if (ret.szAcatar ==nil) {
        ret.szAcatar =@"";
    }
    return  ret;
}


-(void)WS_CheckTelphone:(NSString*)phoneNum Success:(GetTelOKB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_checktelnumusability *arg0 = [[MovierDCInterfaceSvc_checktelnumusability alloc]init];
    arg0.pszTelnum = phoneNum;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing checktelnumusabilityUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                block_suc(ret.nRet,ret.nVal);
            }
        }
    });
    
    return;
}

-(void)WS_QueryPraiseStatus:(MovierDCInterfaceSvc_IDArray*)videoIds Success:(GetPraiseB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_vpgetpraisestatus *arg0 = [[MovierDCInterfaceSvc_vpgetpraisestatus alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.idarr = videoIds;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing vpgetpraisestatusUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IDArrayEnv* ret = (MovierDCInterfaceSvc_IDArrayEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_TELEXIST]]==YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    block_suc(ret.stIDArr);//使用nRet作为返回值，参考之前写的
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_SetPraise:(NSNumber*)videoID Status:(BOOL)status  Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail{
    if (status) {
        MovierDCInterfaceSvc_praisevideobyid *arg0 = [[MovierDCInterfaceSvc_praisevideobyid alloc]init];
        arg0.in_ = self.WS_Session;
        arg0.nVideoID = videoID;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [_syclock lock];
            MovierDCInterfaceBindingResponse *response = [self.soapbing praisevideobyidUsingBody:arg0];
            [_syclock unlock];
            if (response.error!=nil||response.bodyParts==nil) {
                block_fail(response.error);
                return;
            }else{
                NSArray *responseBodyParts = response.bodyParts;
                for (id bodyPart in responseBodyParts) {
                    MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_ALREADY_PRAISE]]||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.nVal);//使用nRet作为返回值，参考之前写的
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                        block_fail(error);
                    }
                }
            }
        });
    }else{
        MovierDCInterfaceSvc_unpraisevideobyid *arg0 = [[MovierDCInterfaceSvc_unpraisevideobyid alloc]init];
        arg0.in_ = self.WS_Session;
        arg0.nVideoID = videoID;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [_syclock lock];
            MovierDCInterfaceBindingResponse *response = [self.soapbing unpraisevideobyidUsingBody:arg0];
            [_syclock unlock];
            if (response.error!=nil||response.bodyParts==nil) {
                block_fail(response.error);
                return;
            }else{
                NSArray *responseBodyParts = response.bodyParts;
                for (id bodyPart in responseBodyParts) {
                    MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_ALREADY_PRAISE]]==YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                        block_suc(ret.nVal);//使用nRet作为返回值，参考之前写的
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                        block_fail(error);
                    }
                }
            }
        });
    }
}

#pragma mark - 报错
-(void)WS_IncreaseVisit:(NSNumber*)videoID Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_increasevideoattr *arg0 = [[MovierDCInterfaceSvc_increasevideoattr alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.nVideoID = videoID;
    arg0.pszAttrName = @"visitcount";
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing increasevideoattrUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_TELEXIST]]==YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    block_suc(ret.nVal);//视频访问次数
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}
- (void)WS_getVideoShareNum:(NSNumber*)videoID Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail{
//暂时不用  arbin   20151203
}

- (void)WS_IncreaseVideoShareNum:(NSNumber*)videoID Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_increasesharenumbyid *arg0 = [[MovierDCInterfaceSvc_increasesharenumbyid alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.nVideoID = videoID;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing increasesharenumbyidUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_TELEXIST]]==YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    NSLog(@"Increase ret.nVal = %@ ret.nRet = %@",ret.nVal,ret.nRet);
                    block_suc(ret.nVal);//
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_ResetPw:(NSString*)phonenum  VerfyCode:(NSString*)vCode newCode:(NSString*)newpassword Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_resetpasswordusingtel *arg0 = [[MovierDCInterfaceSvc_resetpasswordusingtel alloc]init];
    arg0.pszTel = phonenum;
    arg0.pszCode = vCode;
    arg0.pszNewPwd = newpassword;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing resetpasswordusingtelUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_TELEXIST]]==YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    NSLog(@"Increase ret.nVal = %@ ret.nRet = %@",ret.nVal,ret.nRet);
                    block_suc(ret.nVal);//
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_GetCoupon:(NSNumber*)vId Success:(GetCoponB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_getcuponforgm *arg0 = [[MovierDCInterfaceSvc_getcuponforgm alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.nVideoID = vId;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing getcuponforgmUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_StringEnv* ret = (MovierDCInterfaceSvc_StringEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES&&ret.szContent !=nil) {
                    block_suc(ret.szContent);//
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_GetLabelDescric:(NSNumber*)nLabelID Success:(GetLabelInfo)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_getvideolabelexbylabelid *arg0 = [[MovierDCInterfaceSvc_getvideolabelexbylabelid alloc]init];
    arg0.nLabelID = nLabelID;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing getvideolabelexbylabelidUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_VideoLabelExEnv* ret = (MovierDCInterfaceSvc_VideoLabelExEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    block_suc(ret.stVideoLabelEx);//
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_DeleteVideo:(NSNumber*)vId Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_vpremovevideo *arg0 = [[MovierDCInterfaceSvc_vpremovevideo alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.nVideoID = vId;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing vpremovevideoUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    block_suc(ret.nVal);//
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

- (void)WS_ChangeVideoStatus:(NSNumber*)vId Status:(BOOL)videostatus Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_vpupdatevideosharestatus *arg0 = [[MovierDCInterfaceSvc_vpupdatevideosharestatus alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.nVideoID = vId;
    arg0.bShare =  [[USBoolean alloc]initWithBool:videostatus];
    HANDLERETURNVALUE(vpupdatevideosharestatusUsingBody, MovierDCInterfaceSvc_IntEnv, ret.nVal)
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [_syclock lock];
//        MovierDCInterfaceBindingResponse *response = [self.soapbing vpupdatevideosharestatusUsingBody:arg0];
//        [_syclock unlock];
//        if (response.error!=nil||response.bodyParts==nil) {
//            block_fail(response.error);
//            return;
//        }else{
//            NSArray *responseBodyParts = response.bodyParts;
//            for (id bodyPart in responseBodyParts) {
//                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
//                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
//                    block_suc(ret.nVal);//
//                }else{
//                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
//                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
//                    }
//                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
//                    block_fail(error);
//                }
//            }
//        }
//    });
}

-(void)WS_FeedBack:(MovierDCInterfaceSvc_VDCFeedBack*)feedback Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_submitfeedback *arg0 = [[MovierDCInterfaceSvc_submitfeedback alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.feedback = feedback;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing submitfeedbackUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_IntEnv* ret = (MovierDCInterfaceSvc_IntEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    block_suc(ret.nVal);//
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_GetLaunchPage:(NSNumber*)launchflag Success:(GetLauchInfo)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_getpicbyheightandwidth *arg0 = [[MovierDCInterfaceSvc_getpicbyheightandwidth alloc]init];
    arg0.nRatioIndex = launchflag;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing getpicbyheightandwidthUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_StringArrEnv* ret = (MovierDCInterfaceSvc_StringArrEnv*)bodyPart;
                if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                    block_suc(ret.stStringArr);//ar
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                }
            }
        }
    });
}

-(void)WS_GetStylebyVideoId:(NSNumber*)vid Success:(GetStyleB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_getstylebyvideoid *arg0 = [[MovierDCInterfaceSvc_getstylebyvideoid alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.nVideoID = vid;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing getstylebyvideoidUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_vpVDCHeaderAndTailExEnv* ret = (MovierDCInterfaceSvc_vpVDCHeaderAndTailExEnv*)bodyPart;
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_vpVDCHeaderAndTailExEnv class]]) {
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES&&![ret.nRet isEqualToNumber:@(MOVIERDC_SERVER_NOMORE_ITEM)]) {
                        block_suc(ret.stHeaderAndTailEx);//ar
                    }else if ([ret.nRet isEqualToNumber:@(MOVIERDC_SERVER_NOMORE_ITEM)]){
                        NSError *error = [NSError errorWithDomain:@"no more style item" code:[ret.nRet integerValue] userInfo:nil];
                        block_fail(error);
                    }
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                        block_fail(error);
                    }
                }
            }
        }
    });
}
-(void)WS_GetStylebyLabelId:(NSNumber*)labelid Success:(GetStyleB)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_getstylebylabelid *arg0 = [[MovierDCInterfaceSvc_getstylebylabelid alloc]init];
    arg0.in_ = self.WS_Session;
    arg0.nLabelID = labelid;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse *response = [self.soapbing getstylebylabelidUsingBody:arg0];
        [_syclock unlock];
        if (response.error!=nil||response.bodyParts==nil) {
            block_fail(response.error);
            return;
        }else{
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                MovierDCInterfaceSvc_vpVDCHeaderAndTailExEnv* ret = (MovierDCInterfaceSvc_vpVDCHeaderAndTailExEnv*)bodyPart;
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_vpVDCHeaderAndTailExEnv class]]) {
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES&&![ret.nRet isEqualToNumber:@(MOVIERDC_SERVER_NOMORE_ITEM)]) {
                        block_suc(ret.stHeaderAndTailEx);//ar
                    }else if ([ret.nRet isEqualToNumber:@(MOVIERDC_SERVER_NOMORE_ITEM)]){
                        NSError *error = [NSError errorWithDomain:@"no more style item" code:[ret.nRet integerValue] userInfo:nil];
                        block_fail(error);
                    }
                }else{
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                    NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                    block_fail(error);
                    }
                }
            }
        }
    });
}

-(void)WS_GetOrderInfo:(NSArray*)status Customer:(NSNumber*)userid Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetOrdersB)block_suc Fail:(SoapErrorB)block_fail{
    if(_blocktemp ==nil){
        _blocktemp = [[MovierDCInterfaceSvc_VDCOrderForQueryArray alloc]init];
    }else{
        [_blocktemp.item removeAllObjects];
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        int wsquerytimes = 0;
        for (NSNumber* it in status) {
            MovierDCInterfaceSvc_queryordersbyorderstatus *arg0 = [[MovierDCInterfaceSvc_queryordersbyorderstatus alloc]init];
            arg0.in_ = self.WS_Session;
            arg0.nOffset = @(0);        //从第一个开始取
            arg0.nCount = @(500);        //取5个
            arg0.nOrderStatus = (NSNumber*)it;   //订单状态为3
            [_syclock lock];
            MovierDCInterfaceBindingResponse *response = [self.soapbing queryordersbyorderstatusUsingBody:arg0];
            [_syclock unlock];
            wsquerytimes++;
            if (response.error!=nil||response.bodyParts==nil) {
                block_fail(response.error);
            }else{
                NSArray *responseBodyParts = response.bodyParts;
                for (id bodyPart in responseBodyParts) {
                    MovierDCInterfaceSvc_VDCOrderForQueryArrayEnv* ret = (MovierDCInterfaceSvc_VDCOrderForQueryArrayEnv*)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES) {
                        for (NSObject* ait in ret.stVDCOrderForQueryArr.item) {
                            [[SoapOperation Singleton].blocktemp addItem:(MovierDCInterfaceSvc_VDCOrderForQuery *)ait];
                        }
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        NSError *error = [NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil];
                        block_fail(error);
                    }
                    if(wsquerytimes>=[status count]){
                        block_suc([SoapOperation Singleton].blocktemp);
                    }
                }
            }
        }
    });    
}

//重新登陆
-(void)WS_RELogin:(NSString*)username Password:(NSString*)pw withVersion:(NSString*)appversion Encrypt:(BOOL)bEncrypt{

}

//重新登陆
-(void)WS_newRELogin:(NSString*)username Password:(NSString*)pw withVersion:(NSString*)appversion Encrypt:(BOOL)bEncrypt{
    
    [self.loginlock lock];
    if (self.thirdpartycount!=nil || [self.thirdpartycount length]>0) {
        [self WS_Login:self.thirdpartycount ThirdPartyType:@"1" Token:self.token Openid:self.openid APPVersion:appversion SubVersion:appversion Success:^(MovierDCInterfaceSvc_VDCSession *ws_session) {
//            //重新告诉后台cid和deviceToken
//            [self WS_operatedevicelistWithOperationType:1 Success:^(NSNumber *num) {
//                //发送成功
//                NSLog(@"向后台注册cid和deviceToken成功");
//            } Fail:^(NSError *error) {
//                NSLog(@"向后台注册cid和deviceToken失败---%@", error);
//            }];
            [self.loginlock unlock];
        } Fail:^(NSNumber *LoginStatus, NSError *error) {
            [self.loginlock unlock];
        }];
    }else{
        [self WS_Login:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt Success:^(MovierDCInterfaceSvc_VDCSession *ws_session) {
//            //重新告诉后台cid和deviceToken
//            [self WS_operatedevicelistWithOperationType:1 Success:^(NSNumber *num) {
//                //发送成功
//                NSLog(@"向后台注册cid和deviceToken成功");
//            } Fail:^(NSError *error) {
//                NSLog(@"向后台注册cid和deviceToken失败---%@", error);
//            }];
            [self.loginlock unlock];
        } Fail:^(NSNumber *LoginStatus, NSError *error) {
            [self.loginlock unlock];
        }];
    }
    
    
//    if (self.soapbing == nil) {
//        self.soapbing = [MovierDCInterfaceSvc MovierDCInterfaceBinding];
//    }
//    if ([username isEqualToString:@""]) {
//        return;
//    }
//    MovierDCInterfaceSvc_loginex *arg0 = [[MovierDCInterfaceSvc_loginex alloc]init];
//    arg0.pszUserName = username;
//    arg0.pszPassword = pw;
//    arg0.pszSubVersion = appversion;
//    arg0.pszMainVersion = appversion;
//    arg0.bEncrypt = [[USBoolean alloc]initWithBool:bEncrypt];
//    arg0.nPlatform = [NSNumber numberWithInt:TYPE_IOS];
//    [self initCustomer:username withPw:pw Encrypt:bEncrypt Version:appversion];
//    [self.soapbing loginexAsyncUsingBody:arg0 delegate:self];
}

#pragma mark - MovierDCInterfaceBindingResponseDelegate
- (void) operation:(MovierDCInterfaceBindingOperation *)operation completedWithResponse:(MovierDCInterfaceBindingResponse *)response{
//    NSArray *responseHeaders = response.headers;
    NSArray *responseBodyParts = response.bodyParts;
//    NSArray *responseErrors = response.error;
    if ([operation isKindOfClass:[MovierDCInterfaceBinding_loginex class]]) {
        for(id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[SOAPFault class]]) {
               
                continue;
            }else if([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCSessionEnv class]])
            {
                MovierDCInterfaceSvc_VDCSessionEnv * sessenv = (MovierDCInterfaceSvc_VDCSessionEnv*)bodyPart;
                if ([sessenv.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]== YES ) {
                    self.WS_Session = sessenv.session;
                }else{
                    if ([sessenv.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[sessenv.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                        [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                    }
//                    NSError *error = [NSError errorWithDomain:@"" code:[sessenv.nRet integerValue] userInfo:nil];
                }
            }
        }
    }else if ([operation isKindOfClass:[MovierDCInterfaceBinding_logout class]]){
        
    }else if ([operation isKindOfClass:[MovierDCInterfaceBinding_registerusingemail class]]){
        
    }else if([operation isKindOfClass:[MovierDCInterfaceBinding_changepassword class]]){
        
    }else if ([operation isKindOfClass:[MovierDCInterfaceBinding_createorder class]]){
        
    }else if ([operation isKindOfClass:[MovierDCInterfaceBinding_getvideolabels class]]){
        
    }//else if ([operation isKindOfClass:[movierdcinterfacebinding_getvideoby)
}

-(NSError*)CheckUser{
//    if (!self.usename) {
//        NSLog(@"WS User Info error!");
//        return [NSError errorWithDomain:@"WS User Info Nil" code:500 userInfo:nil];
//    }else
        return nil;
}

//向后台发送设备信息（2016.07.11新增接口）
- (void)WS_operatedevicelistWithOperationType:(NSInteger)operationType Success:(GETDEVICEINFOPOSTISSUC)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_operatedevicelist * arg0 = [MovierDCInterfaceSvc_operatedevicelist new];
    arg0.in_ = self.WS_Session;
    arg0.nOperationType = @(operationType);
    MovierDCInterfaceSvc_VDCDeviceInfo * myPDI = [MovierDCInterfaceSvc_VDCDeviceInfo new];
    myPDI.nClientType = @(2);
    myPDI.szClientID = [GeTuiSdk clientId];
    AppDelegate * myAppDelegate = APPDELEGATE;
    myPDI.szDeviceToken = myAppDelegate.thisDeviceToken;
    arg0.pDI = myPDI;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing operatedevicelistUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_IntEnv class]]) {
                    MovierDCInterfaceSvc_IntEnv * ret = (MovierDCInterfaceSvc_IntEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        NSLog(@"上传cid和devicetoken成功");
                        block_suc(ret.nVal);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        NSLog(@"上传cid和devicetoken失败");
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

//（2016-07-20）关注某个人
- (void)WS_followWithCustomID:(NSString *)followCustomeId Success:(GETFLLOWINFOSENDINFO)block_suc Fail:(SoapErrorB)block_fail{
    if ([self CheckUser]) {
        block_fail([self CheckUser]);
        return;
    }
    MovierDCInterfaceSvc_follow * arg0 = [MovierDCInterfaceSvc_follow new];
    arg0.in_ = self.WS_Session;
    arg0.nFollowerID = [NSNumber numberWithInt:[followCustomeId intValue]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing followUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_IntEnv class]]) {
                    MovierDCInterfaceSvc_IntEnv * ret = (MovierDCInterfaceSvc_IntEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.nVal);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}
//（2016-07-20）取消关注某个人
- (void)WS_unfollowWithCustomID:(NSString *)unfollowCustomeId Success:(GETFLLOWINFOSENDINFO)block_suc Fail:(SoapErrorB)block_fail{
    if ([self CheckUser]) {
        block_fail([self CheckUser]);
        return;
    }
    MovierDCInterfaceSvc_unfollow * arg0 = [MovierDCInterfaceSvc_unfollow new];
    arg0.in_ = self.WS_Session;
    arg0.nFollowerID = [NSNumber numberWithInt:[unfollowCustomeId intValue]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing unfollowUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_IntEnv class]]) {
                    MovierDCInterfaceSvc_IntEnv * ret = (MovierDCInterfaceSvc_IntEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.nVal);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

//修改用户设置信息
- (void)WS_messagepushonoffWithStatus:(NSString *)statusStr Success:(RETURNSTATUSSENDINFO)block_suc FailL:(SoapErrorB)block_fail{
    if ([self CheckUser]) {
        block_fail([self CheckUser]);
        return;
    }
    MovierDCInterfaceSvc_messagepushonoff * arg0 = [MovierDCInterfaceSvc_messagepushonoff new];
    arg0.in_ = self.WS_Session;
    arg0.bitOnOff = [NSNumber numberWithInt:[statusStr intValue]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing messagepushonoffUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_IntEnv class]]) {
                    MovierDCInterfaceSvc_IntEnv * ret = (MovierDCInterfaceSvc_IntEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.nVal);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

//获取好友，粉丝，关注的数量
- (void)WS_getfriendamountWithFriendType:(NSInteger)friendType Success:(RETURNUSERNUMINFO)block_suc Fail:(SoapErrorB)block_fail{
    if ([self CheckUser]) {
        block_fail([self CheckUser]);
        return;
    }
    MovierDCInterfaceSvc_getfriendamount * arg0 = [MovierDCInterfaceSvc_getfriendamount new];
    arg0.in_ = self.WS_Session;
    arg0.nFriendType = @(friendType);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing getfriendamountUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_IntEnv class]]) {
                    MovierDCInterfaceSvc_IntEnv * ret = (MovierDCInterfaceSvc_IntEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.nVal);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

//获取关注列表
- (void)WS_getfollowlistWithOffset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNFRIENDLIST)block_suc Fail:(SoapErrorB)block_fail{
    if ([self CheckUser]) {
        block_fail([self CheckUser]);
        return;
    }
    MovierDCInterfaceSvc_getfollowlist * arg0 = [MovierDCInterfaceSvc_getfollowlist new];
    arg0.in_ = self.WS_Session;
    arg0.nOffset = @(offset);
    arg0.nCount = @(count);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing getfollowlistUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCFriendArrEnv class]]) {
                    MovierDCInterfaceSvc_VDCFriendArrEnv * ret = (MovierDCInterfaceSvc_VDCFriendArrEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.stFriendArr);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

//获取好友列表
- (void)WS_getfriendlistWithOffset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNFRIENDLIST)block_suc Fail:(SoapErrorB)block_fail{
    if ([self CheckUser]) {
        block_fail([self CheckUser]);
        return;
    }
    MovierDCInterfaceSvc_getfriendlist * arg0 = [MovierDCInterfaceSvc_getfriendlist new];
    arg0.in_ = self.WS_Session;
    arg0.nOffset = @(offset);
    arg0.nCount = @(count);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing getfriendlistUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCFriendArrEnv class]]) {
                    MovierDCInterfaceSvc_VDCFriendArrEnv * ret = (MovierDCInterfaceSvc_VDCFriendArrEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.stFriendArr);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

//获取粉丝列表
- (void)WS_getfunslistWithOffset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNFRIENDLIST)block_suc Fail:(SoapErrorB)block_fail{
    if ([self CheckUser]) {
        block_fail([self CheckUser]);
        return;
    }
    MovierDCInterfaceSvc_getfunslist * arg0 = [MovierDCInterfaceSvc_getfunslist new];
    arg0.in_ = self.WS_Session;
    arg0.nOffset = @(offset);
    arg0.nCount = @(count);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing getfunslistUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCFriendArrEnv class]]) {
                    MovierDCInterfaceSvc_VDCFriendArrEnv * ret = (MovierDCInterfaceSvc_VDCFriendArrEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.stFriendArr);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 发送私信*/
- (void)WS_sendprivatemessageWithTargetUserId:(NSString *)targetUserId MesContent:(NSString *)mesContent Success:(RETURNSENDINFO)block_suc Fail:(SoapErrorB)block_fail{
    if ([self CheckUser]) {
        block_fail([self CheckUser]);
        return;
    }
    MovierDCInterfaceSvc_sendprivatemessage * arg0 = [MovierDCInterfaceSvc_sendprivatemessage new];
    arg0.in_ = self.WS_Session;
    arg0.nTargetCustomerID = [NSNumber numberWithInt:[targetUserId intValue]];
    arg0.pszMessage = mesContent;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing sendprivatemessageUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_IntEnv class]]) {
                    MovierDCInterfaceSvc_IntEnv * ret = (MovierDCInterfaceSvc_IntEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.nVal);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 根据手机号判断这个后台是否存在这个用户*/
- (void)WS_searchtelfriendWithTelArray:(NSArray *)telArray Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail{
    if ([self CheckUser]) {
        block_fail([self CheckUser]);
        return;
    }
    /*
        - (MovierDCInterfaceBindingResponse *)searchtelfriendUsingBody:(MovierDCInterfaceSvc_searchtelfriend *)aBody
     */
    MovierDCInterfaceSvc_searchtelfriend * arg0 = [MovierDCInterfaceSvc_searchtelfriend new];
    arg0.in_ = self.WS_Session;
    arg0.stTelArr = [MovierDCInterfaceSvc_TelArr new];
    [arg0.stTelArr.item addObjectsFromArray:telArray];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing searchtelfriendUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                /*
                @interface MovierDCInterfaceSvc_SearchRetArrEnv : NSObject {
                MovierDCInterfaceSvc_SearchRetArr * stSearchRet;
                NSNumber * nRet;
                
            }*/
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_SearchRetArrEnv class]]) {
                    MovierDCInterfaceSvc_SearchRetArrEnv * ret = (MovierDCInterfaceSvc_SearchRetArrEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.stSearchRet.item);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

- (void)WS_searchfriendWithSearchContent:(NSString *)searchContent Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail{
    /*
     - (MovierDCInterfaceBindingResponse *)searchfriendUsingBody:(MovierDCInterfaceSvc_searchfriend *)aBody
     */
    MovierDCInterfaceSvc_searchfriend * arg0 = [MovierDCInterfaceSvc_searchfriend new];
    arg0.in_ = self.WS_Session;
    arg0.nOffset = @(offset);
    arg0.nCount = @(count);
    arg0.szSearchContent = searchContent;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing searchfriendUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                /*
                 @interface MovierDCInterfaceSvc_VDCFriendArrEnv : NSObject {
                 
                 
                MovierDCInterfaceSvc_VDCFriendArr * stFriendArr;
                NSNumber * nRet;
                
                }
                 
                 }*/
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCFriendArrEnv class]]) {
                    MovierDCInterfaceSvc_VDCFriendArrEnv * ret = (MovierDCInterfaceSvc_VDCFriendArrEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.stFriendArr.item);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
 
}

/** 获取是否关注当前影片的制作者*/
- (void)WS_getfriendrelationWithUserId:(NSString *)userId Success:(RETURNSUCCESSINFO)block_suc Fail:(SoapErrorB)block_fail{
    if ([self CheckUser]) {
        block_fail([self CheckUser]);
        return;
    }
    /*
        - (MovierDCInterfaceBindingResponse *)getfriendrelationUsingBody:(MovierDCInterfaceSvc_getfriendrelation *)aBody
     */
    MovierDCInterfaceSvc_getfriendrelation * arg0 = [MovierDCInterfaceSvc_getfriendrelation new];
    arg0.in_ = self.WS_Session;
    arg0.nUserID = [NSNumber numberWithInt:[userId intValue]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing getfriendrelationUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_IntEnv class]]) {
                    MovierDCInterfaceSvc_IntEnv * ret = (MovierDCInterfaceSvc_IntEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.nVal);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 获取相关用户的影片（用户的全部影片或者私密影片或者公开的影片）(需要传入的参数有用户id、分享类型、偏移量、请求数量)*/
- (void)WS_getvideosbyuseridWithUserId:(NSString *)userId ShareType:(NSInteger)shareType Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail{
    if ([self CheckUser]) {
        block_fail([self CheckUser]);
        return;
    }
    /*
     请求方法
     - (MovierDCInterfaceBindingResponse *)getvideosbyuseridUsingBody:(MovierDCInterfaceSvc_getvideosbyuserid *)aBody
     
     请求对象
     @interface MovierDCInterfaceSvc_getvideosbyuserid : NSObject
     
    MovierDCInterfaceSvc_VDCSession * in_;
    NSNumber * nUserID;
    NSNumber * nShareType;
    NSNumber * nOffset;
    NSNumber * nCount;
     
     返回值对象
     @interface MovierDCInterfaceSvc_VDCVideoArrEnv : NSObject
    MovierDCInterfaceSvc_VDCVideoArr * stVArr;
    NSNumber * nRet;
     @interface MovierDCInterfaceSvc_VDCVideoArr : NSObject
    NSMutableArray *item
     
     */
    MovierDCInterfaceSvc_getvideosbyuserid * arg0 = [MovierDCInterfaceSvc_getvideosbyuserid new];
    arg0.in_ = self.WS_Session;
    arg0.nUserID = [NSNumber numberWithInt:[userId intValue]];
    arg0.nShareType = @(shareType);
    arg0.nOffset = @(offset);
    arg0.nCount = @(count);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing getvideosbyuseridUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCVideoArrEnv class]]) {
                    MovierDCInterfaceSvc_VDCVideoArrEnv * ret = (MovierDCInterfaceSvc_VDCVideoArrEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        //对后台的keyvalue数组进行处理
                        /*
                        最外层的：MovierDCInterfaceSvc_VDCKeyValueArr
                        第一层： MovierDCInterfaceSvc_VDCKeyValueArr
                        第二层： MovierDCInterfaceSvc_VDCKeyValue
                         第二层对象的属性：
                         NSString * szKey;
                         NSString * szValue;
                         */
                        NSMutableArray * serverDataMuArray = [NSMutableArray new];
                        for (MovierDCInterfaceSvc_VDCKeyValueArr * videoInfo in ret.stVArr.item) {
                            //把每个影片的信息保存成字典
                            NSMutableDictionary * videoInfoDic = [NSMutableDictionary new];
                            for (MovierDCInterfaceSvc_VDCKeyValue * videoDetailInfo in videoInfo.item) {
                                [videoInfoDic setObject:videoDetailInfo.szValue.length > 0 ? videoDetailInfo.szValue : @"" forKey:videoDetailInfo.szKey];
                            }
                            
                            [serverDataMuArray addObject:videoInfoDic];
                        }
                        block_suc(serverDataMuArray);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 获取用户信息（当前登录用户的个人信息或者其他用户的个人信息）（2016-08-03增加）（获得更加详细的用户信息，该接口可以获得影片热度、影片好评等信息）(需要传入的参数有用户的userid)*/
- (void)WS_getuserinfoWithUserID:(NSString *)userID Success:(RETURNDATADICTIONARY)block_suc Fail:(SoapErrorB)block_fail{
    /*
     请求方法
     - (MovierDCInterfaceBindingResponse *)getuserinfoUsingBody:(MovierDCInterfaceSvc_getuserinfo *)aBody
     
     请求对象
     @interface MovierDCInterfaceSvc_getuserinfo : NSObject
    MovierDCInterfaceSvc_VDCSession * in_;
    NSNumber * nUserID;
     
     接收到的消息对象
     @interface MovierDCInterfaceSvc_VDCKeyValueArrEnv : NSObject
     MovierDCInterfaceSvc_VDCKeyValueArr * stKV;
     NSNumber * nRet;
     
     */
    MovierDCInterfaceSvc_getuserinfo * arg0 = [MovierDCInterfaceSvc_getuserinfo new];
    arg0.in_ = self.WS_Session;
    arg0.nUserID = [NSNumber numberWithInt:[userID intValue]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing getuserinfoUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCKeyValueArrEnv class]]) {
                    MovierDCInterfaceSvc_VDCKeyValueArrEnv * ret = (MovierDCInterfaceSvc_VDCKeyValueArrEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        //处理数据
                        NSMutableDictionary * userInfoDic = [NSMutableDictionary new];
                        for (MovierDCInterfaceSvc_VDCKeyValue * subUserInfo in ret.stKV.item) {
                            [userInfoDic setValue:subUserInfo.szValue.length > 0 ? subUserInfo.szValue : @"" forKey:subUserInfo.szKey];
                        }
                        block_suc(userInfoDic);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
    
    /*
     Printing description of serverDataDic:
     {
     "Customer_Privilege" = 1;
     "Customer_Score" = "";
     background = "http://movier-vdctest.oss-cn-beijing.aliyuncs.com/movier/background/background.jpg";
     bucketname = "movier-vdctest";
     collectamount = 10;
     "customer_avatar" = "http://movier-vdctest.oss-cn-beijing.aliyuncs.com/movier/sysres/9848.jpg";
     "customer_birthdayd" = 1;
     "customer_birthdaym" = 1;
     "customer_birthdayy" = 2000;
     "customer_city" = "\U6d77\U6dc0";
     "customer_email" = "";
     "customer_gender" = 1;
     "customer_id" = 9848;
     "customer_inshiancoin" = 203;
     "customer_name" = 01390000008;
     "customer_nickname" = 1234567;
     "customer_privilege" = 1;
     "customer_province" = "\U5317\U4eac";
     "customer_qq" = "";
     "customer_rootdir" = "movier-users/9848131612d63ef2b271eb1007/";
     "customer_score" = 229;
     "customer_signature" = "";
     "customer_status" = 497;
     "customer_tel" = 01390000008;
     "customerinfo_status" = 780;
     registertime = "2016-05-03 18:21:52";
     videoamount = 3;
     videopraiseamount = 106;
     videoviewamount = 7404;
     }
     */
}

/** 设置个人信息的接口（上传更新完的个人信息）（需要的参数有session，keyvalue对象）*/
- (void)WS_setuserinfoWithKeyValue:(MovierDCInterfaceSvc_VDCKeyValue *)userInfoKeyValue Success:(RETURNSUCCESSINFO)block_suc Fail:(SoapErrorB)block_fail{
    if ([self CheckUser]) {
        block_fail([self CheckUser]);
        return;
    }
    /*
     与后台交互的接口
     - (MovierDCInterfaceBindingResponse *)setuserinfoUsingBody:(MovierDCInterfaceSvc_setuserinfo *)aBody
     
     参数对象
     @interface MovierDCInterfaceSvc_setuserinfo : NSObject
    MovierDCInterfaceSvc_VDCSession * in_;
    MovierDCInterfaceSvc_VDCKeyValueArr * stUserInfo;
     

     */
    MovierDCInterfaceSvc_setuserinfo * arg0 = [MovierDCInterfaceSvc_setuserinfo new];
    arg0.in_ = self.WS_Session;
    MovierDCInterfaceSvc_VDCKeyValueArr * keyValueArr = [MovierDCInterfaceSvc_VDCKeyValueArr new];
    [keyValueArr.item addObject:userInfoKeyValue];
    arg0.stUserInfo = keyValueArr;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing setuserinfoUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_IntEnv class]]) {
                    MovierDCInterfaceSvc_IntEnv * ret = (MovierDCInterfaceSvc_IntEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.nVal);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 设置影片的标题，话题，封面等信息接口（新的影片制作流程中使用）（传入的参数有影片id，影片属性数组）*/
- (void)WS_setvideoinfoWithVideoId:(NSString *)videoId VideoAttributeArr:(NSArray *)videoAttributeArr Success:(RETURNSUCCESSINFO)block_suc Fail:(SoapErrorB)block_fail{
    if ([self CheckUser]) {
        block_fail([self CheckUser]);
        return;
    }
    /*
     与后台交互的接口
     - (MovierDCInterfaceBindingResponse *)setvideoinfoUsingBody:(MovierDCInterfaceSvc_setvideoinfo *)aBody 
     
     参数对象属性
     
    MovierDCInterfaceSvc_VDCSession * in_;
    NSNumber * nVideoID;
    MovierDCInterfaceSvc_VDCKeyValueArr * stKVArr;
    
     
     
     */
    MovierDCInterfaceSvc_setvideoinfo * arg0 = [MovierDCInterfaceSvc_setvideoinfo new];
    arg0.in_ = self.WS_Session;
    arg0.nVideoID = [NSNumber numberWithInt:[videoId intValue]];
    MovierDCInterfaceSvc_VDCKeyValueArr * keyValueArr = [MovierDCInterfaceSvc_VDCKeyValueArr new];
    [keyValueArr.item addObjectsFromArray:[NSMutableArray arrayWithArray:videoAttributeArr]];
    arg0.stKVArr = keyValueArr;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing setvideoinfoUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_IntEnv class]]) {
                    MovierDCInterfaceSvc_IntEnv * ret = (MovierDCInterfaceSvc_IntEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.nVal);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效11
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 获取首页标签内容（2016-08-11）(需要传入的参数：nVideoLabelLocation（1-表示获取首页顶部标签，2-表示获取首页底部标签）起始位置，请求数量)*/
- (void)WS_getvideolabelsexWithVideoLabelLocation:(NSInteger)videoLabelLocation Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail{
    /*
     请求方法
     - (MovierDCInterfaceBindingResponse *)getvideolabelsexUsingBody:(MovierDCInterfaceSvc_getvideolabelsex *)aBody
     
     请求对象
     MovierDCInterfaceSvc_VDCSession * in_;
     NSNumber * nVideoLabelLocation;
     NSNumber * nOffset;
     NSNumber * nCount;
     
     返回值对象
     @interface MovierDCInterfaceSvc_VDCVideoLabelEx2ArrayEnv : NSObject 
    MovierDCInterfaceSvc_VDCVideoLabelEx2Array * stVDCVideoLabelExArray;
    NSNumber * nRet;
     
     */
    MovierDCInterfaceSvc_getvideolabelsex * arg0 = [MovierDCInterfaceSvc_getvideolabelsex new];
//    arg0.in_ = self.WS_Session;
    arg0.nVideoLabelLocation = [NSNumber numberWithInteger:videoLabelLocation];
    arg0.nOffset = [NSNumber numberWithInteger:offset];
    arg0.nCount = [NSNumber numberWithInteger:count];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing getvideolabelsexUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCVideoLabelEx2ArrayEnv class]]) {
                    MovierDCInterfaceSvc_VDCVideoLabelEx2ArrayEnv * ret = (MovierDCInterfaceSvc_VDCVideoLabelEx2ArrayEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        /*
                            MovierDCInterfaceSvc_VDCVideoLabelEx2
                         */
                        block_suc(ret.stVDCVideoLabelExArray.item);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 返回的数据内部有一层数组*/
+ (NSMutableDictionary *)analysisDataWithObjectArray:(NSArray *)objectArray{
    //处理数据
    NSMutableDictionary * userInfoDic = [NSMutableDictionary new];
    for (MovierDCInterfaceSvc_VDCKeyValue * subUserInfo in objectArray) {
        [userInfoDic setValue:subUserInfo.szValue.length > 0 ? subUserInfo.szValue : @"" forKey:subUserInfo.szKey];
    }
    return userInfoDic;
}

/** 返回的数据内部有二层数组*/
- (NSMutableArray *)analysisDataWithArray:(NSMutableArray *)objectArray{
    NSMutableArray * serverDataMuArray = [NSMutableArray new];
    for (MovierDCInterfaceSvc_VDCKeyValueArr * videoInfo in objectArray) {
        //把每个影片的信息保存成字典
        NSMutableDictionary * videoInfoDic = [NSMutableDictionary new];
        for (MovierDCInterfaceSvc_VDCKeyValue * videoDetailInfo in videoInfo.item) {
            [videoInfoDic setObject:videoDetailInfo.szValue.length > 0 ? videoDetailInfo.szValue : @"" forKey:videoDetailInfo.szKey];
        }
        
        [serverDataMuArray addObject:videoInfoDic];
    }
    return serverDataMuArray;
}

/** 获取首页背景图片*/
- (void)WS_gethomepagebackgroundSuccess:(RETURNDATASTRING)block_suc Fail:(SoapErrorB)block_fail{
    /*
        - (MovierDCInterfaceBindingResponse *)gethomepagebackgroundUsingBody:(MovierDCInterfaceSvc_gethomepagebackground *)aBody
     
     @interface MovierDCInterfaceSvc_VDCHomePageBackgroundEnv
    NSString * URL;
    NSNumber * nRet;
     */
    MovierDCInterfaceSvc_gethomepagebackground * arg0 = [MovierDCInterfaceSvc_gethomepagebackground new];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing gethomepagebackgroundUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCHomePageBackgroundEnv class]]) {
                    MovierDCInterfaceSvc_VDCHomePageBackgroundEnv * ret = (MovierDCInterfaceSvc_VDCHomePageBackgroundEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        /*
                         MovierDCInterfaceSvc_VDCVideoLabelEx2
                         */
                        block_suc(ret.URL);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 获取banner列表(需要传入的参数有：nCategory 表示获取的是标签还是话题（1-标签，2-话题）nWhere 话题或标签的ID，nOffset 请求偏移， nCount 请求个数)*/
- (void)WS_getbannerlistWithCategory:(NSInteger)category Where:(NSString *)labelId Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_getbannerlist * arg0 = [MovierDCInterfaceSvc_getbannerlist new];
    arg0.in_ = self.WS_Session;
    arg0.nCategory = @(category);
    arg0.nWhere = [NSNumber numberWithInt:[labelId intValue]];
    arg0.nOffset = @(offset);
    arg0.nCount = @(count);
    HANDLERETURNVALUE(getbannerlistUsingBody,
                      MovierDCInterfaceSvc_VDCBannerArrEnv,
                      [self getServerDataMuArrayWithArray:ret.stBArr.item])
    
    /*
     Printing description of ((__NSDictionaryM *)0x000000015c5c1a80):
     {
     category = 1;
     id = 3;
     indexorder = 0;
     labelid = 12;
     para1 = 15;表示个人主页
     para2 = 0;
     para3 = "";网页
     status = 0;
     thumbnail = "http://movier-vdc.oss-cn-beijing.aliyuncs.com/movier/sysres/LabelRes/BannerRes/GuoMei/GM-banner.jpg";
     topicid = 0;
     type = 2;1-个人主页， 2-标签， 3-网页， 4-话题
     
     Type字段为1--para1表示个人主页
     Type字段为2--para1表示标签
     Type字段为4--para1表示话题
     Tyep为3--表示Para3为网页
     }
     */
}

/** 获取收藏的视频(nUserID 获取该用户的收藏影片， nOffset 请求起始偏移地址， nCount 请求个数)*/
- (void)WS_getcollectvideosWithUserId:(NSString *)userId Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail{
    if ([self CheckUser]) {
        block_fail([self CheckUser]);
        return;
    }
    /*
     请求方法
     - (MovierDCInterfaceBindingResponse *)getcollectvideosUsingBody:(MovierDCInterfaceSvc_getcollectvideos *)aBody
     
     请求对象
     MovierDCInterfaceSvc_getcollectvideos
     MovierDCInterfaceSvc_VDCSession * in_;
     NSNumber * nUserID;
     NSNumber * nOffset;
     NSNumber * nCount;
     
     返回值对象
     @interface MovierDCInterfaceSvc_VDCVideoArrEnv : NSObject {
     
    MovierDCInterfaceSvc_VDCVideoArr * stVArr;
    NSNumber * nRet;
     */
    MovierDCInterfaceSvc_getcollectvideos * arg0 = [MovierDCInterfaceSvc_getcollectvideos new];
    arg0.in_ = self.WS_Session;
    arg0.nUserID = [NSNumber numberWithInt:[userId intValue]];
    arg0.nOffset = @(offset);
    arg0.nCount = @(count);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing getcollectvideosUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCVideoArrEnv class]]) {
                    MovierDCInterfaceSvc_VDCVideoArrEnv * ret = (MovierDCInterfaceSvc_VDCVideoArrEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        /*
                         第一层 数组元素
                         MovierDCInterfaceSvc_VDCVideoArr
                         
                         第二层 数组元素
                         MovierDCInterfaceSvc_VDCKeyValueArr
                         */
                        
                        NSMutableArray * serverDataMuArray = [NSMutableArray new];
                        for (MovierDCInterfaceSvc_VDCKeyValueArr * videoInfoArr in ret.stVArr.item) {
                            //把每个影片的信息保存成字典
                            NSMutableDictionary * videoInfoDic = [NSMutableDictionary new];
                            for (MovierDCInterfaceSvc_VDCKeyValue * videoInfo in videoInfoArr.item) {
                                [videoInfoDic setObject:videoInfo.szValue.length > 0 ? videoInfo.szValue : @"" forKey:videoInfo.szKey];
                            }
                            
                            [serverDataMuArray addObject:videoInfoDic];
                        }
                        
                        block_suc(serverDataMuArray);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 话题搜索接口（szSearchContent 搜索内容, nOffset 偏移量， nCount 请求数量）*/
- (void)WS_searchtopicsWithSearchContent:(NSString *)searchContent Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail{
    /*
     请求方法
     - (MovierDCInterfaceBindingResponse *)searchtopicsUsingBody:(MovierDCInterfaceSvc_searchtopics *)aBody
     
     请求对象
     MovierDCInterfaceSvc_searchtopics
     
     MovierDCInterfaceSvc_VDCSession * in_;
     NSString * szSearchContent;
     NSNumber * nOffset;
     NSNumber * nCount;
     
     返回值对象
     @interface MovierDCInterfaceSvc_VDCTopicsArrEnv : NSObject {
     
     MovierDCInterfaceSvc_VDCTopicsArr * stTArr;
     NSNumber * nRet;
     */
    
    MovierDCInterfaceSvc_searchtopics * arg0 = [MovierDCInterfaceSvc_searchtopics new];
    arg0.in_ = self.WS_Session;
    arg0.szSearchContent = searchContent;
    arg0.nOffset = @(offset);
    arg0.nCount = @(count);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing searchtopicsUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCTopicsArrEnv class]]) {
                    MovierDCInterfaceSvc_VDCTopicsArrEnv * ret = (MovierDCInterfaceSvc_VDCTopicsArrEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        /*
                         MovierDCInterfaceSvc_VDCKeyValueArr
                         */
                        
                        NSMutableArray * serverDataMuArray = [NSMutableArray new];
                        for (MovierDCInterfaceSvc_VDCKeyValueArr * topicInfoArr in ret.stTArr.item) {
                            NSMutableDictionary * topicInfoDic = [NSMutableDictionary new];
                            for (MovierDCInterfaceSvc_VDCKeyValue * topicInfo in topicInfoArr.item) {
                                [topicInfoDic setObject:topicInfo.szValue.length > 0 ? topicInfo.szValue : @"" forKey:topicInfo.szKey];
                            }
                            
                            [serverDataMuArray addObject:topicInfoDic];
                        }
                        
                        block_suc(serverDataMuArray);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** @好友(nVideoID 影片ID, stCustomerIDArr 用户ID数组)*/
- (void)WS_atfriendbycustomeridarrWithVideoId:(NSString *)videoId UserIdArr:(NSArray *)userIdArr Success:(RETURNSUCCESSINFO)block_suc Fail:(SoapErrorB)block_fail{
    if ([self CheckUser]) {
        block_fail([self CheckUser]);
        return;
    }
    /*
     与后台交互的接口
     - (MovierDCInterfaceBindingResponse *)atfriendbycustomeridarrUsingBody:(MovierDCInterfaceSvc_atfriendbycustomeridarr *)aBody
     
     参数对象属性
     
     MovierDCInterfaceSvc_VDCSession * in_;
     NSNumber * nVideoID;
     MovierDCInterfaceSvc_VDCIntArr * stCustomerIDArr;
     
     
     
     */
    MovierDCInterfaceSvc_atfriendbycustomeridarr * arg0 = [MovierDCInterfaceSvc_atfriendbycustomeridarr new];
    arg0.in_ = self.WS_Session;
    arg0.nVideoID = [NSNumber numberWithInt:[videoId intValue]];
    arg0.stCustomerIDArr = [MovierDCInterfaceSvc_VDCIntArr new];
    [arg0.stCustomerIDArr.item addObjectsFromArray:userIdArr];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing atfriendbycustomeridarrUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_IntEnv class]]) {
                    MovierDCInterfaceSvc_IntEnv * ret = (MovierDCInterfaceSvc_IntEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.nVal);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效11
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 发布影片(nVideoID 影片ID)*/
- (void)WS_releasevideoWithVideoId:(NSString *)videoId Success:(RETURNSUCCESSINFO)block_suc Fail:(SoapErrorB)block_fail{
    /*
     接口
    - (MovierDCInterfaceBindingResponse *)releasevideoUsingBody:(MovierDCInterfaceSvc_releasevideo *)aBody
     */
    
    if ([self CheckUser]) {
        block_fail([self CheckUser]);
        return;
    }
    MovierDCInterfaceSvc_releasevideo * arg0 = [MovierDCInterfaceSvc_releasevideo new];
    arg0.in_ = self.WS_Session;
    arg0.nVideoID = [NSNumber numberWithInt:[videoId intValue]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing releasevideoUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_IntEnv class]]) {
                    MovierDCInterfaceSvc_IntEnv * ret = (MovierDCInterfaceSvc_IntEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.nVal);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效11
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 下架影片（nVideoID 影片ID）*/
- (void)WS_unreleasevideoWithVideoId:(NSString *)videoId Success:(RETURNSUCCESSINFO)block_suc Fail:(SoapErrorB)block_fail{
    /*
     接口
     - (MovierDCInterfaceBindingResponse *)unreleasevideoUsingBody:(MovierDCInterfaceSvc_unreleasevideo *)aBody
     */
    
    if ([self CheckUser]) {
        block_fail([self CheckUser]);
        return;
    }
    MovierDCInterfaceSvc_unreleasevideo * arg0 = [MovierDCInterfaceSvc_unreleasevideo new];
    arg0.in_ = self.WS_Session;
    arg0.nVideoID = [NSNumber numberWithInt:[videoId intValue]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing unreleasevideoUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_IntEnv class]]) {
                    MovierDCInterfaceSvc_IntEnv * ret = (MovierDCInterfaceSvc_IntEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.nVal);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效11
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 通过话题id获取影片(nTopicsID 话题ID， nOffset 偏移量， nCount 请求数量)*/
- (void)WS_getvideosbytopicidWithTopicsId:(NSString *)topicsId Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail{
    if ([self CheckUser]) {
        block_fail([self CheckUser]);
        return;
    }
    /*
     请求方法
     - (MovierDCInterfaceBindingResponse *)getvideosbytopicidUsingBody:(MovierDCInterfaceSvc_getvideosbytopicid *)aBody 
     
     请求对象
     MovierDCInterfaceSvc_VDCSession * in_;
     NSNumber * nTopicID;
     NSNumber * nOffset;
     NSNumber * nCount;
     
     返回值对象
     @interface MovierDCInterfaceSvc_VDCVideoArrEnv : NSObject {
     
     MovierDCInterfaceSvc_VDCVideoArr * stVArr;
     NSNumber * nRet;
     */
    MovierDCInterfaceSvc_getvideosbytopicid * arg0 = [MovierDCInterfaceSvc_getvideosbytopicid new];
    arg0.in_ = self.WS_Session;
    arg0.nTopicID = [NSNumber numberWithInt:[topicsId intValue]];
    arg0.nOffset = @(offset);
    arg0.nCount = @(count);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing getvideosbytopicidUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCVideoArrEnv class]]) {
                    MovierDCInterfaceSvc_VDCVideoArrEnv * ret = (MovierDCInterfaceSvc_VDCVideoArrEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        /*
                         第一层 数组元素
                         MovierDCInterfaceSvc_VDCVideoArr
                         
                         第二层 数组元素
                         MovierDCInterfaceSvc_VDCKeyValueArr
                         */
                        
                        NSMutableArray * serverDataMuArray = [NSMutableArray new];
                        for (MovierDCInterfaceSvc_VDCKeyValueArr * videoInfoArr in ret.stVArr.item) {
                            //把每个影片的信息保存成字典
                            NSMutableDictionary * videoInfoDic = [NSMutableDictionary new];
                            for (MovierDCInterfaceSvc_VDCKeyValue * videoInfo in videoInfoArr.item) {
                                [videoInfoDic setObject:videoInfo.szValue.length > 0 ? videoInfo.szValue : @"" forKey:videoInfo.szKey];
                            }
                            
                            [serverDataMuArray addObject:videoInfoDic];
                        }
                        
                        block_suc(serverDataMuArray);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 通过父话题获取子话题(nParentID 父话题ID， nOffset 偏移量， nCount 请求数量)*/
- (void)WS_gettopicsbyparenttopicWithParentId:(NSString *)parentId Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail{
    /*
     请求方法
     - (MovierDCInterfaceBindingResponse *)gettopicsbyparenttopicUsingBody:(MovierDCInterfaceSvc_gettopicsbyparenttopic *)aBody
     
     请求对象
     MovierDCInterfaceSvc_VDCSession * in_;
     NSNumber * nParentID;
     NSNumber * nOffset;
     NSNumber * nCount;
     
     返回值对象
     @interface MovierDCInterfaceSvc_VDCTopicsArrEnv : NSObject {
     
     MovierDCInterfaceSvc_VDCTopicsArr * stTArr;
     NSNumber * nRet;
     */
    
    MovierDCInterfaceSvc_gettopicsbyparenttopic * arg0 = [MovierDCInterfaceSvc_gettopicsbyparenttopic new];
    arg0.in_ = self.WS_Session;
    arg0.nParentID = [NSNumber numberWithInt:[parentId intValue]];
    arg0.nOffset = @(offset);
    arg0.nCount = @(count);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing gettopicsbyparenttopicUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCTopicsArrEnv class]]) {
                    MovierDCInterfaceSvc_VDCTopicsArrEnv * ret = (MovierDCInterfaceSvc_VDCTopicsArrEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        /*
                         MovierDCInterfaceSvc_VDCKeyValueArr
                         */
                        
                        NSMutableArray * serverDataMuArray = [NSMutableArray new];
                        for (MovierDCInterfaceSvc_VDCKeyValueArr * topicInfoArr in ret.stTArr.item) {
                            NSMutableDictionary * topicInfoDic = [NSMutableDictionary new];
                            for (MovierDCInterfaceSvc_VDCKeyValue * topicInfo in topicInfoArr.item) {
                                [topicInfoDic setObject:topicInfo.szValue.length > 0 ? topicInfo.szValue : @"" forKey:topicInfo.szKey];
                            }
                            
                            [serverDataMuArray addObject:topicInfoDic];
                        }
                        
                        block_suc(serverDataMuArray);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 通过影片id获取话题(nVideoID 影片ID， nOffset 偏移量， nCount 请求数量)*/
- (void)WS_gettopicsbyvideoidWithVideoId:(NSString *)videoId Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail{
    /*
     请求方法
     - (MovierDCInterfaceBindingResponse *)gettopicsbyvideoidUsingBody:(MovierDCInterfaceSvc_gettopicsbyvideoid *)aBody
     
     请求对象
     MovierDCInterfaceSvc_VDCSession * in_;
     NSNumber * nParentID;
     NSNumber * nOffset;
     NSNumber * nCount;
     
     返回值对象
     @interface MovierDCInterfaceSvc_VDCTopicsArrEnv : NSObject {
     
     MovierDCInterfaceSvc_VDCTopicsArr * stTArr;
     NSNumber * nRet;
     */
    
    MovierDCInterfaceSvc_gettopicsbyvideoid * arg0 = [MovierDCInterfaceSvc_gettopicsbyvideoid new];
    arg0.in_ = self.WS_Session;
    arg0.nVideoID = [NSNumber numberWithInt:[videoId intValue]];
    arg0.nOffset = @(offset);
    arg0.nCount = @(count);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing gettopicsbyvideoidUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCTopicsArrEnv class]]) {
                    MovierDCInterfaceSvc_VDCTopicsArrEnv * ret = (MovierDCInterfaceSvc_VDCTopicsArrEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        /*
                         MovierDCInterfaceSvc_VDCKeyValueArr
                         */
                        
                        NSMutableArray * serverDataMuArray = [NSMutableArray new];
                        for (MovierDCInterfaceSvc_VDCKeyValueArr * topicInfoArr in ret.stTArr.item) {
                            NSMutableDictionary * topicInfoDic = [NSMutableDictionary new];
                            for (MovierDCInterfaceSvc_VDCKeyValue * topicInfo in topicInfoArr.item) {
                                [topicInfoDic setObject:topicInfo.szValue.length > 0 ? topicInfo.szValue : @"" forKey:topicInfo.szKey];
                            }
                            
                            [serverDataMuArray addObject:topicInfoDic];
                        }
                        
                        block_suc(serverDataMuArray);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 获取影片信息（nVideoID 影片ID）*/
- (void)WS_getvideoinfoWithVideoId:(NSString *)videoId Success:(RETURNDATADICTIONARY)block_suc Fail:(SoapErrorB)block_fail{
    /*
     请求方法
     - (MovierDCInterfaceBindingResponse *)getvideoinfoUsingBody:(MovierDCInterfaceSvc_getvideoinfo *)aBody
     
     接收到的消息对象
     @interface MovierDCInterfaceSvc_VDCKeyValueArrEnv : NSObject
     MovierDCInterfaceSvc_VDCKeyValueArr * stKV;
     NSNumber * nRet;
     
     */
    MovierDCInterfaceSvc_getvideoinfo * arg0 = [MovierDCInterfaceSvc_getvideoinfo new];
    arg0.in_ = self.WS_Session;
    arg0.nVideoID = [NSNumber numberWithInt:[videoId intValue]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing getvideoinfoUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCKeyValueArrEnv class]]) {
                    MovierDCInterfaceSvc_VDCKeyValueArrEnv * ret = (MovierDCInterfaceSvc_VDCKeyValueArrEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        //处理数据
                        NSMutableDictionary * userInfoDic = [NSMutableDictionary new];
                        for (MovierDCInterfaceSvc_VDCKeyValue * subUserInfo in ret.stKV.item) {
                            [userInfoDic setValue:subUserInfo.szValue.length > 0 ? subUserInfo.szValue : @"" forKey:subUserInfo.szKey];
                        }
                        block_suc(userInfoDic);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 根据父标签获得子标签（nLabelID 父标签ID，nOffset 起始偏移， nCount 请求个数）*/
- (void)WS_getlabelsbyparentidWithLabelId:(NSString *)labelId Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_getlabelsbyparentid * arg0 = [MovierDCInterfaceSvc_getlabelsbyparentid new];
    arg0.in_ = self.WS_Session;
    arg0.nLabelID = [NSNumber numberWithInt:[labelId intValue]];
    arg0.nOffset = @(offset);
    arg0.nCount = @(count);
    HANDLERETURNVALUE(getlabelsbyparentidUsingBody,
                      MovierDCInterfaceSvc_VDCLabelArrEnv,
                      [self getServerDataMuArrayWithArray:ret.stLArr.item])
    /*
     Printing description of ((__NSDictionaryM *)0x0000000170255ae0):
     {
     activitystatus = "";
     des = "\U201c\U4e00\U7701\U518d\U7701\Uff0c\U5168\U6c11High\U7701\U201d \U56fd\U7f8e\U5728\U7ebf1212\U5fae\U89c6\U9891\U5f81\U96c6\U5927\U8d5b\U706b\U70ed\U8fdb\U884c\U4e2d\Uff0112\U670810\U201412\U65e5\Uff0c\U53ea\U8981\U5728\U201c\U6620\U50cf\U201dAPP\U6216\U201c\U6620\U50cf\U5de5\U574a\U201d\U5fae\U4fe1\U516c\U4f17\U53f7\U56fd\U7f8e\U5728\U7ebf\U6d3b\U52a8\U4e13\U533a\U62cd\U6444\U89c6\U9891\Uff0c\U558a\U51fa\U6d3b\U52a8\U53e3\U53f7\U201c\U56fd\U7f8e\U5728\U7ebf\U5927\U7701\U8282\U201d\U5e76\U5c06\U89c6\U9891\U5206\U4eab\U5230\U793e\U4ea4\U5e73\U53f0\Uff0c\U65e2\U988612\U4ebf\U56fd\U7f8e\U5728\U7ebf\U4ee3\U91d1\U5238\Uff0c\U8fd8\U6709iPad pro\U3001IPHONE6S\U7b49\U597d\U793c\U76f8\U9001\Uff01\U5956\U54c1\U4e30\U5bcc\Uff0c\U5c0f\U4f19\U4f34\U4eec\U5feb\U5feb\U884c\U52a8\U8d77\U6765\U5427\Uff01";
     "label_id" = 15;
     "label_name" = "12.12\U5927\U7701\U8282\U89c6\U9891\U5f81\U96c6\U6d3b\U52a8";
     parent = 12;
     thumbnail = "http://movier-vdc.oss-cn-beijing.aliyuncs.com/movier/sysres/LabelRes/BannerRes/GuoMei/GM-banner-thumbnail.jpg";
     type = 1;
     }
     */
}

//获取海量获赞的影片信息（nOffset 偏移量，nCount 请求数量）
- (void)WS_getchallengetaskpraiseWithoffset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail{
    /*
        - (MovierDCInterfaceBindingResponse *)getchallengetaskpraiseUsingBody:(MovierDCInterfaceSvc_getchallengetaskpraise *)aBody
     
     @interface MovierDCInterfaceSvc_VDCRecordArrEnv : NSObject
     
    MovierDCInterfaceSvc_VDCRecordArr * stRArr;
    NSNumber * nRet;
     */
    MovierDCInterfaceSvc_getchallengetaskpraise * arg0 = [MovierDCInterfaceSvc_getchallengetaskpraise new];
    arg0.in_ = self.WS_Session;
    arg0.nOffset = @(offset);
    arg0.nCount = @(count);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing getchallengetaskpraiseUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCRecordArrEnv class]]) {
                    MovierDCInterfaceSvc_VDCRecordArrEnv * ret = (MovierDCInterfaceSvc_VDCRecordArrEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        NSMutableArray * serverDataMuArray = [NSMutableArray new];
                        for (MovierDCInterfaceSvc_VDCKeyValueArr * topicInfoArr in ret.stRArr.item) {
                            NSMutableDictionary * topicInfoDic = [NSMutableDictionary new];
                            for (MovierDCInterfaceSvc_VDCKeyValue * topicInfo in topicInfoArr.item) {
                                [topicInfoDic setObject:topicInfo.szValue.length > 0 ? topicInfo.szValue : @"" forKey:topicInfo.szKey];
                            }
                            
                            [serverDataMuArray addObject:topicInfoDic];
                        }
                        
                        block_suc(serverDataMuArray);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

//获取挑战任务中海量浏览的影片信息 参数：in 交互凭证， nOffset 偏移量，nCount 请求数量，ret 返回值
- (void)WS_getchallengetaskviewWithOffset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail{
    /*
     - (MovierDCInterfaceBindingResponse *)getchallengetaskviewUsingBody:(MovierDCInterfaceSvc_getchallengetaskview *)aBody 
     
     @interface MovierDCInterfaceSvc_VDCRecordArrEnv : NSObject
     
     MovierDCInterfaceSvc_VDCRecordArr * stRArr;
     NSNumber * nRet;
     */
    MovierDCInterfaceSvc_getchallengetaskview * arg0 = [MovierDCInterfaceSvc_getchallengetaskview new];
    arg0.in_ = self.WS_Session;
    arg0.nOffset = @(offset);
    arg0.nCount = @(count);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing getchallengetaskviewUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCRecordArrEnv class]]) {
                    MovierDCInterfaceSvc_VDCRecordArrEnv * ret = (MovierDCInterfaceSvc_VDCRecordArrEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        NSMutableArray * serverDataMuArray = [NSMutableArray new];
                        for (MovierDCInterfaceSvc_VDCKeyValueArr * topicInfoArr in ret.stRArr.item) {
                            NSMutableDictionary * topicInfoDic = [NSMutableDictionary new];
                            for (MovierDCInterfaceSvc_VDCKeyValue * topicInfo in topicInfoArr.item) {
                                [topicInfoDic setObject:topicInfo.szValue.length > 0 ? topicInfo.szValue : @"" forKey:topicInfo.szKey];
                            }
                            
                            [serverDataMuArray addObject:topicInfoDic];
                        }
                        
                        block_suc(serverDataMuArray);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||[ret.nRet isEqualToNumber:[NSNumber numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {//被踢出去了或者失效
                            [self WS_newRELogin:self.usename Password:self.password withVersion:self.appversion Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@"" code:[ret.nRet integerValue] userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

//更新提示接口
- (void)WS_getappversionSuccess:(RETURNAPPVERSIONINFO)block_suc Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_getappversion * arg0 = [MovierDCInterfaceSvc_getappversion new];
    arg0.nAppType = @(2);
    NSString * appVersion = [CustomeClass getAppVersion];
    NSArray * versionArray = [appVersion componentsSeparatedByString:@"."];
    arg0.pszMainVersion = versionArray[0];
    arg0.pszSubVersion = versionArray[1];
    HANDLERETURNVALUE(getappversionUsingBody,
                      MovierDCInterfaceSvc_AppVersionExArrEnv,
                      ret.stAppVersionExArr.item.count > 0 ? ret.stAppVersionExArr.item[0] : nil)
}

/** 使用手机号注册接口（函数原型：int ns__telregister(struct ns__VDCKeyValueArr stUserInfo, struct ns__IntEnv& ret)）*/
- (void)telRegisterWithTelNum:(NSString *)telNum Password:(NSString *)password Success:(RETURNSUCCESSINFO)block_suc Fail:(SoapErrorB)block_fail{
    /*
     - (MovierDCInterfaceBindingResponse *)telregisterUsingBody:(MovierDCInterfaceSvc_telregister *)aBody
     //请求参数
     MovierDCInterfaceSvc_VDCKeyValueArr * stUserInfo;
     
     */
    MovierDCInterfaceSvc_telregister * arg0 = [MovierDCInterfaceSvc_telregister new];
    NSDictionary * dic1 = @{@"telnum":telNum};
    NSDictionary * dic2 = @{@"md5password":[CustomeClass md5Str:password]};
    NSDictionary * dic3 = @{@"apptype":@"2"};
    [arg0.stUserInfo.item addObject:dic1];
    [arg0.stUserInfo.item addObject:dic2];
    [arg0.stUserInfo.item addObject:dic3];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing telregisterUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_IntEnv class]]) {
                    MovierDCInterfaceSvc_IntEnv * ret = (MovierDCInterfaceSvc_IntEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber
                                                   numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.nVal);
                    }else{
                        if ([ret.nRet isEqualToNumber:[NSNumber
                                                       numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||
                            [ret.nRet isEqualToNumber:[NSNumber
                                                       numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {
                            //被踢出去了或者失效
                            [self WS_newRELogin:self.usename
                                       Password:self.password
                                    withVersion:self.appversion
                                        Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@""
                                                       code:[ret.nRet integerValue]
                                                   userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 三方授权注册（qq、微信、微博等）(int ns__thirdpartyregister(struct ns__VDCKeyValueArr stUserInfo, struct ns__IntEnv& ret)*/
- (void)thirdpartyregisterWithAccount:(NSString *)accountStr
                               Gender:(NSString *)genderStr
                             Province:(NSString *)provinceStr
                                 City:(NSString *)cityStr
                             NickName:(NSString *)nickNameStr
                               Avatar:(NSString *)avatarStr
                               TelNum:(NSString *)telNumStr
                                Email:(NSString *)emailStr
                       ThirtPartyType:(NSString *)thirtPartyTypeStr
                           ThirtAlias:(NSString *)thirtyAliasStr
                              Success:(RETURNSUCCESSINFO)block_suc
                                 Fail:(SoapErrorB)block_fail{
    /*
        - (MovierDCInterfaceBindingResponse *)thirdpartyregisterUsingBody:(MovierDCInterfaceSvc_thirdpartyregister *)aBody
     */
    
    MovierDCInterfaceSvc_thirdpartyregister * arg0 = [MovierDCInterfaceSvc_thirdpartyregister new];
    [arg0.stUserInfo.item addObject:@{@"account":accountStr}];
    [arg0.stUserInfo.item addObject:@{@"gender":genderStr}];
    [arg0.stUserInfo.item addObject:@{@"province":provinceStr}];
    [arg0.stUserInfo.item addObject:@{@"city":cityStr}];
    [arg0.stUserInfo.item addObject:@{@"nickname":nickNameStr}];
    [arg0.stUserInfo.item addObject:@{@"avatar":avatarStr}];
    [arg0.stUserInfo.item addObject:@{@"telnum":telNumStr}];
    [arg0.stUserInfo.item addObject:@{@"email":emailStr}];
    [arg0.stUserInfo.item addObject:@{@"apptype":@"2"}];
    [arg0.stUserInfo.item addObject:@{@"thirdpartytype":thirtPartyTypeStr}];
    [arg0.stUserInfo.item addObject:@{@"thirdpartyalias":thirtyAliasStr}];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing
                                                       thirdpartyregisterUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_IntEnv class]]) {
                    MovierDCInterfaceSvc_IntEnv * ret = (MovierDCInterfaceSvc_IntEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber
                                                   numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.nVal);
                    }else{
                        if ([ret.nRet
                             isEqualToNumber:[NSNumber
                                              numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||
                            [ret.nRet
                             isEqualToNumber:[NSNumber
                                              numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {
                            //被踢出去了或者失效
                            [self WS_newRELogin:self.usename
                                       Password:self.password
                                    withVersion:self.appversion
                                        Encrypt:self.bEncrypt];
                        }
                        block_fail([NSError errorWithDomain:@""
                                                       code:[ret.nRet integerValue]
                                                   userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 手机号登录（int ns__loginbyusername(struct ns__VDCKeyValueArr stUserInfo, struct ns__VDCSessionEnv& ret)）*/
- (void)loginByTelNumWithUSerName:(NSString *)userNameStr
                         Password:(NSString *)passwordStr
                          Success:(RETURNSESSION)block_suc
                             Fail:(SoapErrorB)block_fail{
    /*
     - (MovierDCInterfaceBindingResponse *)loginbyusernameUsingBody:(MovierDCInterfaceSvc_loginbyusername *)aBody
        MovierDCInterfaceSvc_VDCSessionEnv
     */
    MovierDCInterfaceSvc_loginbyusername * arg0 = [MovierDCInterfaceSvc_loginbyusername new];
    [arg0.stUserInfo.item addObject:@{@"username":userNameStr}];
    [arg0.stUserInfo.item addObject:@{@"password":passwordStr}];
    [arg0.stUserInfo.item addObject:@{@"apptype":@"2"}];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing
                                                       loginbyusernameUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCSessionEnv class]]) {
                    MovierDCInterfaceSvc_VDCSessionEnv * ret = (MovierDCInterfaceSvc_VDCSessionEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber
                                                   numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.session);
                    }else{
                        if ([ret.nRet
                             isEqualToNumber:[NSNumber
                                              numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||
                            [ret.nRet
                             isEqualToNumber:[NSNumber
                                              numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {
                                 //被踢出去了或者失效
                                 [self WS_newRELogin:self.usename
                                            Password:self.password
                                         withVersion:self.appversion
                                             Encrypt:self.bEncrypt];
                             }
                        block_fail([NSError errorWithDomain:@""
                                                       code:[ret.nRet integerValue]
                                                   userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 三方登录接口（int ns__loginbythirdparty(struct ns__VDCKeyValueArr stUserInfo, struct ns__VDCSessionEnv& ret)）*/
- (void)loginByThirdpartyWithThirdpartyAccount:(NSString *)thirdpartyAccountStr
                                ThirdpartyType:(NSString *)thirdpartyTypeStr
                                       Success:(RETURNSESSION)block_suc
                                          Fail:(SoapErrorB)block_fail{
    /*
     - (MovierDCInterfaceBindingResponse *)loginbythirdpartyUsingBody:(MovierDCInterfaceSvc_loginbythirdparty *)aBody
     */
    MovierDCInterfaceSvc_loginbythirdparty * arg0 = [MovierDCInterfaceSvc_loginbythirdparty new];
    [arg0.stUserInfo.item addObject:@{@"thirdpartyaccount":thirdpartyAccountStr}];
    [arg0.stUserInfo.item addObject:@{@"thirdpartytype":thirdpartyTypeStr}];
    [arg0.stUserInfo.item addObject:@{@"apptype":@"2"}];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing
                                                       loginbythirdpartyUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCSessionEnv class]]) {
                    MovierDCInterfaceSvc_VDCSessionEnv * ret = (MovierDCInterfaceSvc_VDCSessionEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber
                                                   numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        block_suc(ret.session);
                    }else{
                        if ([ret.nRet
                             isEqualToNumber:[NSNumber
                                              numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||
                            [ret.nRet
                             isEqualToNumber:[NSNumber
                                              numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {
                                 //被踢出去了或者失效
                                 [self WS_newRELogin:self.usename
                                            Password:self.password
                                         withVersion:self.appversion
                                             Encrypt:self.bEncrypt];
                             }
                        block_fail([NSError errorWithDomain:@""
                                                       code:[ret.nRet integerValue]
                                                   userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 通过分类id获取影片（getvideosbylabelid）*/
- (void)getVideosByLabelIdWithLabelId:(NSString *)labelId
                               Offset:(NSInteger)offset
                                Count:(NSInteger)count
                              Success:(RETURNDATAARRAY)block_suc
                                 Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_getvideosbylabelid * arg0 = [MovierDCInterfaceSvc_getvideosbylabelid new];
    arg0.in_ = self.WS_Session;
    arg0.nLabelID = [NSNumber numberWithInt:[labelId intValue]];
    arg0.nOffset = @(offset);
    arg0.nCount = @(count);
    HANDLERETURNVALUE(getvideosbylabelidUsingBody,
                      MovierDCInterfaceSvc_VDCRecordArrEnv,
                      [self getServerDataMuArrayWithArray:ret.stRArr.item])
    /*
     Printing description of videoInfoEx:
     {
     activity = 1;
     "customer_avatar" = "http://movier-vdc.oss-cn-beijing.aliyuncs.com/movier/sysres/avatar/avatar_1522.jpg";
     "customer_nickname" = "\U3000\U3000\U6df1\U60c5\U5373\U662f\U6b7b\U7f6a";
     "customer_signature" = "";
     followexistcount = 0;
     "order_id" = 69800;
     resolution = "720:408";
     "video_commentsnum" = 6;
     "video_createtime" = "2016-10-28 10:23:30";
     "video_favoritesnum" = 2;
     "video_id" = 69729;
     "video_name" = "\U725b\U4eba\U96c6\U95262";
     "video_owner" = 22742;
     "video_praise" = 827;
     "video_reference" = "http://movier-vdc.oss-cn-beijing.aliyuncs.com/movier-users/227424715a54f7fecd2fb80419572f/\U7cfb\U7edf\U6587\U4ef6\U5939/order-generate/2016-10-28/1477621410906.mp4";
     "video_share" = 1;
     "video_sharenum" = 13;
     "video_status" = 2;
     "video_thumbnail" = "http://movier-vdc.oss-cn-beijing.aliyuncs.com/movier-users/227424715a54f7fecd2fb80419572f/\U7cfb\U7edf\U6587\U4ef6\U5939/order-generate/2016-10-28/1477621410906.jpg";
     visitcount = 946;
     }
     */
}

/** 搜索影片接口（ns__searchvideosbykey）*/
- (void)searchVideosByKeyWithSearchText:(NSString *)searchText
                                 Offset:(NSInteger)offset
                                  Count:(NSInteger)count
                                Success:(RETURNDATAARRAY)block_suc
                                   Fail:(SoapErrorB)block_fail
{
    /*
     - (MovierDCInterfaceBindingResponse *)searchvideosbykeyUsingBody:(MovierDCInterfaceSvc_searchvideosbykey *)aBody
     @interface MovierDCInterfaceSvc_searchvideosbykey : NSObject {
     
 
    MovierDCInterfaceSvc_VDCSession * in_;
    NSString * pszKeyWord;
    NSNumber * nOffset;
    NSNumber * nCount;
 
}
     
     @interface MovierDCInterfaceSvc_VDCRecordArrEnv : NSObject {
     
     
     MovierDCInterfaceSvc_VDCRecordArr * stRArr;
     NSNumber * nRet;
     
     @interface MovierDCInterfaceSvc_VDCRecordArr : NSObject {
     
     NSMutableArray *item;
     */
    MovierDCInterfaceSvc_searchvideosbykey * arg0 = [MovierDCInterfaceSvc_searchvideosbykey new];
    arg0.in_ = self.WS_Session;
    arg0.pszKeyWord = searchText;
    arg0.nOffset = @(offset);
    arg0.nCount = @(count);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing
                                                       searchvideosbykeyUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCRecordArrEnv class]]) {
                    MovierDCInterfaceSvc_VDCRecordArrEnv * ret = (MovierDCInterfaceSvc_VDCRecordArrEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber
                                                   numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        //获得数据
                        NSMutableArray * serverDataMuArray = [NSMutableArray new];
                        for (MovierDCInterfaceSvc_VDCKeyValueArr * topicInfoArr in ret.stRArr.item) {
                            NSMutableDictionary * topicInfoDic = [NSMutableDictionary new];
                            for (MovierDCInterfaceSvc_VDCKeyValue * topicInfo in topicInfoArr.item) {
                                [topicInfoDic setObject:topicInfo.szValue.length > 0 ? topicInfo.szValue : @""
                                                 forKey:topicInfo.szKey];
                            }
                            
                            [serverDataMuArray addObject:topicInfoDic];
                        }
                        
                        block_suc(serverDataMuArray);
                    }else{
                        if ([ret.nRet
                             isEqualToNumber:[NSNumber
                                              numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||
                            [ret.nRet
                             isEqualToNumber:[NSNumber
                                              numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {
                                 //被踢出去了或者失效
                                 [self WS_newRELogin:self.usename
                                            Password:self.password
                                         withVersion:self.appversion
                                             Encrypt:self.bEncrypt];
                             }
                        block_fail([NSError errorWithDomain:@""
                                                       code:[ret.nRet integerValue]
                                                   userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

/** 根据id数组获取影片信息(ns__getvideosbyvideoidarr)*/
- (void)getvideosbyvideoidarrWithIdArray:(NSArray *)idArray Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail{
    /*
     int ns__getvideosbyvideoidarr(struct ns__VDCSession *in, struct ns__VDCIntArr stIDArr, struct ns__VDCRecordArrEnv& ret)
        - (MovierDCInterfaceBindingResponse *)getvideosbyvideoidarrUsingBody:(MovierDCInterfaceSvc_getvideosbyvideoidarr *)aBody
     MovierDCInterfaceSvc_VDCSession * in_;
     MovierDCInterfaceSvc_VDCIntArr * stIDArr;
     */
    MovierDCInterfaceSvc_getvideosbyvideoidarr * arg0 = [MovierDCInterfaceSvc_getvideosbyvideoidarr new];
    arg0.in_ = self.WS_Session;
    MovierDCInterfaceSvc_VDCIntArr * vdcIntArr = [MovierDCInterfaceSvc_VDCIntArr new];
    [vdcIntArr.item addObjectsFromArray:idArray];
    arg0.stIDArr = vdcIntArr;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_syclock lock];
        MovierDCInterfaceBindingResponse * response = [self.soapbing
                                                       getvideosbyvideoidarrUsingBody:arg0];
        [_syclock unlock];
        if (response.error != nil || response.bodyParts == nil) {
            block_fail(response.error);
            return;
        }else{
            for (id bodyPart in response.bodyParts) {
                if ([bodyPart isKindOfClass:[MovierDCInterfaceSvc_VDCRecordArrEnv class]]) {
                    MovierDCInterfaceSvc_VDCRecordArrEnv * ret = (MovierDCInterfaceSvc_VDCRecordArrEnv *)bodyPart;
                    if ([ret.nRet isEqualToNumber:[NSNumber
                                                   numberWithInteger:MOVIERDC_SERVER_OK]]) {
                        //获得数据
                        NSMutableArray * serverDataMuArray = [NSMutableArray new];
                        for (MovierDCInterfaceSvc_VDCKeyValueArr * topicInfoArr in ret.stRArr.item) {
                            NSMutableDictionary * topicInfoDic = [NSMutableDictionary new];
                            for (MovierDCInterfaceSvc_VDCKeyValue * topicInfo in topicInfoArr.item) {
                                [topicInfoDic setObject:topicInfo.szValue.length > 0 ? topicInfo.szValue : @""
                                                 forKey:topicInfo.szKey];
                            }
                            
                            [serverDataMuArray addObject:topicInfoDic];
                        }
                        
                        block_suc(serverDataMuArray);
                    }else{
                        if ([ret.nRet
                             isEqualToNumber:[NSNumber
                                              numberWithInt:MOVIERDC_SERVER_KICKOUT]] == YES||
                            [ret.nRet
                             isEqualToNumber:[NSNumber
                                              numberWithInteger:MOVIERDC_SERVER_INVALID_SESSION]]== YES) {
                                 //被踢出去了或者失效
                                 [self WS_newRELogin:self.usename
                                            Password:self.password
                                         withVersion:self.appversion
                                             Encrypt:self.bEncrypt];
                             }
                        block_fail([NSError errorWithDomain:@""
                                                       code:[ret.nRet integerValue]
                                                   userInfo:nil]);
                    }
                }else{
                    block_fail(response.error);
                }
            }
        }
    });
}

#pragma mark - 登录注册

/** 登录接口*/
- (void)loginByAccountWithAccount:(NSString *)accountStr
                         Password:(NSString *)passwordStr
                      AccountType:(NSInteger)accountType
                          Success:(RETURNDATADICTIONARY)block_suc
                             Fail:(SoapErrorB)block_fail{
    
    /*
     （：int ns__loginbyaccount(struct ns__VDCKeyValueArr stAccountInfo, int nAccountType, struct ns__VDCKeyValueArrEnv& SessionEnv)）
     
     - (MovierDCInterfaceBindingResponse *)loginbyaccountUsingBody:(MovierDCInterfaceSvc_loginbyaccount *)aBody
     MovierDCInterfaceSvc_loginbyaccount:
     MovierDCInterfaceSvc_VDCKeyValueArr * stAccountInfo;
     NSNumber * nAccountType;
     
     @interface MovierDCInterfaceSvc_VDCKeyValueArrEnv : NSObject {
     
    MovierDCInterfaceSvc_VDCKeyValueArr * stKV;
    NSNumber * nRet;
     */
    MovierDCInterfaceSvc_loginbyaccount * arg0 = [MovierDCInterfaceSvc_loginbyaccount new];
    arg0.stAccountInfo = [MovierDCInterfaceSvc_VDCKeyValueArr new];
    
    [arg0.stAccountInfo.item addObject:[self newAKeyValueWithKey:@"account"
                                                           Value:accountStr]];
    [arg0.stAccountInfo.item addObject:[self newAKeyValueWithKey:@"apptype"
                                                           Value:@"2"]];
    if (accountType == 0 && passwordStr != nil && passwordStr.length > 0) {
        [arg0.stAccountInfo.item addObject:[self newAKeyValueWithKey:@"password"
                                                               Value:[CustomeClass md5Str:passwordStr]]];
    }
    arg0.nAccountType = @(accountType);
    
    HANDLERETURNVALUE(loginbyaccountUsingBody,
                      MovierDCInterfaceSvc_VDCKeyValueArrEnv,
                      [self getServerDicWith:ret.stKV.item])
}

/**
 *  返回一个keyvalue对象
 */
- (MovierDCInterfaceSvc_VDCKeyValue *)newAKeyValueWithKey:(NSString *)keyStr
                                                    Value:(NSString *)valueStr{
    MovierDCInterfaceSvc_VDCKeyValue * keyValueObj = [MovierDCInterfaceSvc_VDCKeyValue new];
    keyValueObj.szKey = keyStr;
    keyValueObj.szValue = valueStr;
    return keyValueObj;
}

- (void)sendDeviceTokenAndCid{
    //向后台发送cid和deviceToken
    [[SoapOperation Singleton] WS_operatedevicelistWithOperationType:1
                                                             Success:^(NSNumber *num) {
        NSLog(@"向后台注册cid和deviceToken成功");
    } Fail:^(NSError *error) {
        NSLog(@"向后台注册cid和deviceToken失败---%@", error);
    }];
}

/** qq注册（int ns__qqregister(struct ns__VDCKeyValueArr stQQInfo, struct ns__IntEnv& ret)）*/
- (void)qqRegisterWithAccount:(NSString *)qqAccountStr
                   QQNickName:(NSString *)qqNicknameStr
                     Password:(NSString *)passwordStr
                       Gender:(NSString *)genderStr
                     Province:(NSString *)provinceStr
                         City:(NSString *)cityStr
                     Nickname:(NSString *)nickNameStr
                    Signature:(NSString *)signatureStr
                       Avatar:(NSString *)avatarStr
                       TelNum:(NSString *)telNumStr
                        Email:(NSString *)emailStr
                      Success:(RETURNSUCCESSINFO)block_suc
                         Fail:(SoapErrorB)block_fail{
    /*
     - (MovierDCInterfaceBindingResponse *)qqregisterUsingBody:(MovierDCInterfaceSvc_qqregister *)aBody
     @interface MovierDCInterfaceSvc_qqregister : NSObject {
     
    MovierDCInterfaceSvc_VDCKeyValueArr * stQQInfo;
     
     
     @interface MovierDCInterfaceSvc_VDCKeyValueArr : NSObject {
     
     
    NSMutableArray *item;
    
}
     */
    MovierDCInterfaceSvc_qqregister * arg0 = [MovierDCInterfaceSvc_qqregister new];
    arg0.stQQInfo = [MovierDCInterfaceSvc_VDCKeyValueArr new];
    [arg0.stQQInfo.item addObject:[self newAKeyValueWithKey:@"account"
                                                      Value:qqAccountStr]];
    [arg0.stQQInfo.item addObject:[self newAKeyValueWithKey:@"qqnickname"
                                                      Value:qqNicknameStr]];
    [arg0.stQQInfo.item addObject:[self newAKeyValueWithKey:@"apptype"
                                                      Value:@"2"]];
    [arg0.stQQInfo.item addObject:[self newAKeyValueWithKey:@"gender"
                                                      Value:genderStr]];
    [arg0.stQQInfo.item addObject:[self newAKeyValueWithKey:@"avatar"
                                                      Value:avatarStr]];
    HANDLERETURNVALUE(qqregisterUsingBody,
                      MovierDCInterfaceSvc_IntEnv,
                      ret.nVal)
}

/** 微博注册（int ns__weiboregister(soap* s, struct ns__VDCKeyValueArr stWeiBoInfo, struct ns__IntEnv& ret)）*/
- (void)weiboRegisterWithAccount:(NSString *)accountStr
                   WeiboNickname:(NSString *)weiboNicknameStr
                        Password:(NSString *)passwordStr
                          Gender:(NSString *)genderStr
                        Province:(NSString *)provinceStr
                            City:(NSString *)cityStr
                        Nickname:(NSString *)nicknameStr
                       Signature:(NSString *)signatureStr
                          Avatar:(NSString *)avatarStr
                          TelNum:(NSString *)telNumStr
                           Email:(NSString *)emailStr
                         Success:(RETURNSUCCESSINFO)block_suc
                            Fail:(SoapErrorB)block_fail{
    
    /*
     - (MovierDCInterfaceBindingResponse *)weiboregisterUsingBody:(MovierDCInterfaceSvc_weiboregister *)aBody
     
     @interface MovierDCInterfaceSvc_weiboregister : NSObject {
     
     
    MovierDCInterfaceSvc_VDCKeyValueArr * stWeiBoInfo;
    
}
     
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
     */
    MovierDCInterfaceSvc_weiboregister * arg0 = [MovierDCInterfaceSvc_weiboregister new];
    arg0.stWeiBoInfo = [MovierDCInterfaceSvc_VDCKeyValueArr new];
//    [arg0.stWeiBoInfo.item addObject:[self newAKeyValueWithKey:@"account"
//                                                         Value:accountStr]];
//    [arg0.stWeiBoInfo.item addObject:[self newAKeyValueWithKey:@"weibonickname"
//                                                         Value:weiboNicknameStr]];
//    [arg0.stWeiBoInfo.item addObject:[self newAKeyValueWithKey:@"gender"
//                                                         Value:genderStr]];
//    [arg0.stWeiBoInfo.item addObject:[self newAKeyValueWithKey:@"avatar"
//                                                         Value:avatarStr]];
//    [arg0.stWeiBoInfo.item addObject:[self newAKeyValueWithKey:@"apptype"
//                                                         Value:@"2"]];
   
    
    [arg0.stWeiBoInfo addItem:[self newAKeyValueWithKey:@"account"
                                                  Value:accountStr]];
    [arg0.stWeiBoInfo addItem:[self newAKeyValueWithKey:@"weibonickname"
                                                  Value:weiboNicknameStr]];
    [arg0.stWeiBoInfo addItem:[self newAKeyValueWithKey:@"gender"
                                                  Value:genderStr]];
    [arg0.stWeiBoInfo addItem:[self newAKeyValueWithKey:@"avatar"
                                                  Value:avatarStr]];
    [arg0.stWeiBoInfo addItem:[self newAKeyValueWithKey:@"apptype"
                                                  Value:@"2"]];
    HANDLERETURNVALUE(weiboregisterUsingBody,
                      MovierDCInterfaceSvc_IntEnv,
                      ret.nVal)
}

/** 微信注册（int ns__wechatregister(soap* s, struct ns__VDCKeyValueArr stWeChatInfo, struct ns__IntEnv& ret)）*/
- (void)wechatRegisterWithAccount:(NSString *)weichatAccountStr
                   WechatNickname:(NSString *)wechatNicknameStr
                         Password:(NSString *)passwordStr
                           Gender:(NSString *)genderStr
                         Province:(NSString *)provinceStr
                             City:(NSString *)cityStr
                         Nickname:(NSString *)nicknameStr
                        Signature:(NSString *)signatureStr
                           Avatar:(NSString *)avatarStr
                           TelNum:(NSString *)telNumStr
                            Email:(NSString *)emailStr
                          Success:(RETURNSUCCESSINFO)block_suc
                             Fail:(SoapErrorB)block_fail{
    /*
     - (MovierDCInterfaceBindingResponse *)wechatregisterUsingBody:(MovierDCInterfaceSvc_wechatregister *)aBody
     @interface MovierDCInterfaceSvc_wechatregister : NSObject {
     
     
    MovierDCInterfaceSvc_VDCKeyValueArr * stWeChatInfo;
    
}
     */
    MovierDCInterfaceSvc_wechatregister * arg0 = [MovierDCInterfaceSvc_wechatregister new];
    arg0.stWeChatInfo = [MovierDCInterfaceSvc_VDCKeyValueArr new];
    [arg0.stWeChatInfo.item addObject:[self newAKeyValueWithKey:@"account"
                                                          Value:weichatAccountStr]];
    [arg0.stWeChatInfo.item addObject:[self newAKeyValueWithKey:@"wechatnickname"
                                                          Value:wechatNicknameStr]];
    [arg0.stWeChatInfo.item addObject:[self newAKeyValueWithKey:@"gender"
                                                          Value:genderStr]];
    [arg0.stWeChatInfo.item addObject:[self newAKeyValueWithKey:@"avatar"
                                                          Value:avatarStr]];
    [arg0.stWeChatInfo.item addObject:[self newAKeyValueWithKey:@"apptype"
                                                          Value:@"2"]];
    HANDLERETURNVALUE(wechatregisterUsingBody,
                      MovierDCInterfaceSvc_IntEnv,
                      ret.nVal)
}

/** 获取账户绑定状态（int ns__getaccountbindstatus(soap* s, struct ns__VDCSession *in, struct ns__VDCKeyValueArrEnv& ret)）*/
- (void)getAccountBindStatusSuccess:(RETURNDATADICTIONARY)block_suc
                               Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_getaccountbindstatus * arg0 = [MovierDCInterfaceSvc_getaccountbindstatus new];
    arg0.in_ = self.WS_Session;
    HANDLERETURNVALUE(getaccountbindstatusUsingBody,
                      MovierDCInterfaceSvc_VDCKeyValueArrEnv,
                      [self getServerDicWith:ret.stKV.item])
}


/** 绑定三方（int ns__bindaccount(soap* s, struct ns__VDCSession *in, struct ns__VDCKeyValueArr stAccountInfo, struct ns__IntEnv& ret)）*/
- (void)bindaccountWithAccount:(NSString *)accountStr
                      Nickname:(NSString *)nicknameStr
                   AccountType:(NSInteger)accountTypeStr
                      Password:(NSString *)passwordStr
                       Success:(RETURNSUCCESSINFO)block_suc
                          Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_bindaccount * arg0 = [MovierDCInterfaceSvc_bindaccount new];
    arg0.in_ = self.WS_Session;
    arg0.stAccountInfo = [MovierDCInterfaceSvc_VDCKeyValueArr new];
    [arg0.stAccountInfo.item addObject:[self newAKeyValueWithKey:@"account"
                                                           Value:accountStr]];
    [arg0.stAccountInfo.item addObject:[self newAKeyValueWithKey:@"accountnickname"
                                                           Value:nicknameStr]];
    [arg0.stAccountInfo.item addObject:[self newAKeyValueWithKey:@"accounttype"
                                                           Value:[NSString stringWithFormat:@"%ld", accountTypeStr]]];
    
    HANDLERETURNVALUE(bindaccountUsingBody,
                      MovierDCInterfaceSvc_IntEnv,
                      ret.nVal)
}

#pragma mark - ar部分

/**
 *  返回是否在规定范围内
 */
-(void)WS_CheckGMLBS:(NSNumber*)longtitude
                 Pos:(NSNumber*)latitude
              Radius:(NSNumber*)ra
             Success:(WSReturnNumberB)block_suc
                Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_gmlbs *arg0 = [[MovierDCInterfaceSvc_gmlbs alloc]init];
    arg0.x = longtitude;
    arg0.y = latitude;
    arg0.radius = ra;
    HANDLERETURNVALUE(gmlbsUsingBody,
                      MovierDCInterfaceSvc_IntEnv,
                      ret.nVal)
}

/**
 *  富文本分享
 */
- (void)richSnippetsWithVideoId:(NSString *)videoId
                       Platform:(NSInteger)platform
            RichSnippetsContent:(NSString *)richSnippetsContent
                        Success:(RETURNSUCCESSINFO)block_suc
                           Fail:(SoapErrorB)block_fail
{
    MovierDCInterfaceSvc_shareex * arg0 = [MovierDCInterfaceSvc_shareex new];
    arg0.in_ = self.WS_Session;
    arg0.nVideoID = [NSNumber numberWithInt:[videoId intValue]];
    //nPlatform 平台（0-未知， 1-新浪微博，2-qq空间， 3-朋友圈， ...）
    arg0.nPlatform = @(platform);
    arg0.pszContent = richSnippetsContent;
    HANDLERETURNVALUE(shareexUsingBody, MovierDCInterfaceSvc_IntEnv, ret.nVal)
}

/**
 *  ar分享
 */
- (void)arShareWithVideoId:(NSString *)videoId
                  Platform:(NSInteger)platform
       RichSnippetsContent:(NSString *)richSnippetsContent
                   Success:(RETURNSUCCESSINFO)block_suc
                      Fail:(SoapErrorB)block_fail
{
    MovierDCInterfaceSvc_gmshare * arg0 = [MovierDCInterfaceSvc_gmshare new];
    arg0.in_ = self.WS_Session;
    arg0.nVideoID = [NSNumber numberWithInt:[videoId intValue]];
    //nPlatform 平台（0-未知， 1-新浪微博，2-qq空间， 3-朋友圈， ...）
    arg0.nPlatform = @(platform);
    arg0.pszContent = richSnippetsContent;
    HANDLERETURNVALUE(gmshareUsingBody, MovierDCInterfaceSvc_IntEnv, ret.nVal)
}

/**
 *  返回的数据是数组
 */
- (NSMutableArray *)getServerDataMuArrayWithArray:(NSMutableArray *)serverDataArray{
    //获得数据
    NSMutableArray * serverDataMuArray = [NSMutableArray new];
    for (MovierDCInterfaceSvc_VDCKeyValueArr * topicInfoArr in serverDataArray) {
        NSMutableDictionary * topicInfoDic = [NSMutableDictionary new];
        for (MovierDCInterfaceSvc_VDCKeyValue * topicInfo in topicInfoArr.item) {
            [topicInfoDic setObject:topicInfo.szValue.length > 0 ? topicInfo.szValue : @""
                             forKey:topicInfo.szKey];
        }
        
        [serverDataMuArray addObject:topicInfoDic];
    }
    return serverDataMuArray;
}

/**
 *  返回的数据是字典
 */
- (NSMutableDictionary *)getServerDicWith:(NSMutableArray *)serverMuArray{
    //获得数据
    NSMutableDictionary * topicInfoDic = [NSMutableDictionary new];
    for (MovierDCInterfaceSvc_VDCKeyValue * topicInfo in serverMuArray) {
        [topicInfoDic setObject:topicInfo.szValue.length > 0 ? topicInfo.szValue : @""
                         forKey:topicInfo.szKey];
    }
    return topicInfoDic;
}

#pragma mark - ar部分（2016-11-09）

/**
 *  获取ar
 *  getType :1-观看获得过奖励的影片 3一键照做摄影时获取AR 4-普通做片摄影时获取AR
 */
- (void)getARWithGetType:(NSInteger)getType
                 VideoId:(NSString *)videoId
               Longitude:(double)longitude
                Latitude:(double)latitude
                  Radius:(NSInteger)radius
                 Success:(RETURNDATADICTIONARY)block_suc
                    Fail:(SoapErrorB)block_fail
{
    MovierDCInterfaceSvc_gmgetar * arg0 = [MovierDCInterfaceSvc_gmgetar new];
    arg0.in_ = self.WS_Session;
    arg0.nType = @(getType);
    arg0.stReference = [MovierDCInterfaceSvc_VDCKeyValueArr new];
    [arg0.stReference addItem:[self newAKeyValueWithKey:@"videoid" Value:videoId]];
    [arg0.stReference addItem:[self newAKeyValueWithKey:@"longitude"
                                                  Value:[NSString stringWithFormat:@"%lf", longitude]]];
    [arg0.stReference addItem:[self newAKeyValueWithKey:@"latitude"
                                                  Value:[NSString stringWithFormat:@"%lf", latitude]]];
    [arg0.stReference addItem:[self newAKeyValueWithKey:@"radius"
                                                  Value:[NSString stringWithFormat:@"%ld", radius]]];
    HANDLERETURNVALUE(gmgetarUsingBody,
                      MovierDCInterfaceSvc_VDCKeyValueArrEnv,
                      [self getServerDicWith:ret.stKV.item])
}

/**
 *  ar获取宝箱
 */
- (void)getARBoxWithARId:(NSString *)arId
                 Success:(RETURNDATADICTIONARY)block_suc
                    Fail:(SoapErrorB)block_fail
{
    MovierDCInterfaceSvc_gmgetchest * arg0 = [MovierDCInterfaceSvc_gmgetchest new];
    arg0.in_ = self.WS_Session;
    arg0.nARLogID = [NSNumber numberWithInt:[arId intValue]];
    HANDLERETURNVALUE(gmgetchestUsingBody,
                      MovierDCInterfaceSvc_VDCKeyValueArrEnv,
                      [self getServerDicWith:ret.stKV.item])
}

/**
 *  ar打开宝箱
 */
- (void)openARBoxWithBoxId:(NSString *)boxId
                   Success:(RETURNDATADICTIONARY)block_suc
                      Fail:(SoapErrorB)block_fail
{
    MovierDCInterfaceSvc_gmopenchest * arg0 = [MovierDCInterfaceSvc_gmopenchest new];
    arg0.in_ = self.WS_Session;
    arg0.nChestLogID = [NSNumber numberWithInt:[boxId intValue]];
    HANDLERETURNVALUE(gmopenchestUsingBody,
                      MovierDCInterfaceSvc_VDCKeyValueArrEnv,
                      [self getServerDicWith:ret.stKV.item])
    
    /*
     Printing description of serverDataDictionary:
     {
     arawardlogid = 2627;
     desc = "";
     flag = 0;
     index = 0;
     name = "8000\U5143\U865a\U62df\U7535\U5668";
     type = 3;(1-代金券 3-虚拟卡牌
     url = "http://movier-vdc.oss-cn-beijing.aliyuncs.com/movier/HomePageVideo/card_have_all.gif";
     }
     */
}

#pragma mark - ar(2016-11-15)

/**
 *  观看获得奖励的影片获取ar(途径：1-观看获得过奖励的影片 3一键照做摄影时获取AR 4-普通做片摄影时获取AR)
 */
- (void)getARWhenWatchVideoWithVideoId:(NSString *)videoId
                               Success:(RETURNDATADICTIONARY)block_suc
                                  Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_gmgetar * arg0 = [MovierDCInterfaceSvc_gmgetar new];
    arg0.in_ = self.WS_Session;
    arg0.nType = @(1);
    arg0.stReference = [MovierDCInterfaceSvc_VDCKeyValueArr new];
    [arg0.stReference addItem:[self newAKeyValueWithKey:@"videoid"
                                                  Value:videoId]];
    HANDLERETURNVALUE(gmgetarUsingBody,
                      MovierDCInterfaceSvc_VDCKeyValueArrEnv,
                      [self getServerDicWith:ret.stKV.item])
}

/**
 *  摄影时获取ar
 */
- (void)getARWhenTakeVideoWithType:(NSInteger)getType
                         Longitude:(double)longitude
                          Latitude:(double)latitude
                            Radius:(double)radius
                           Success:(RETURNDATADICTIONARY)block_suc
                              Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_gmgetar * arg0 = [MovierDCInterfaceSvc_gmgetar new];
    arg0.in_ = self.WS_Session;
    arg0.nType = @(getType);
    arg0.stReference = [MovierDCInterfaceSvc_VDCKeyValueArr new];
    [arg0.stReference addItem:[self newAKeyValueWithKey:@"longitude"
                                                  Value:[NSString stringWithFormat:@"%lf", longitude]]];
    [arg0.stReference addItem:[self newAKeyValueWithKey:@"latitude"
                                                  Value:[NSString stringWithFormat:@"%lf", latitude]]];
    [arg0.stReference addItem:[self newAKeyValueWithKey:@"radius"
                                                  Value:[NSString stringWithFormat:@"%lf", radius]]];
    HANDLERETURNVALUE(gmgetarUsingBody,
                      MovierDCInterfaceSvc_VDCKeyValueArrEnv,
                      [self getServerDicWith:ret.stKV.item])
    
    /*
     返回的ar内容 --- {
     ARInfoDictionary =     {
     arid = 1;
     arlogid = 249;
     arname = "AR\U5b9d\U7bb1";
     arurl = "http://movier-vdc.oss-cn-beijing.aliyuncs.com/movier/HomePageVideo/Box.gif";
     };
     }
     */
}

/**
 *  ar一键照做
 */
- (void)arCreateOrderFollowExistWithRandomMusic:(BOOL)randomMusic
                                        MusicId:(NSString *)musicId
                                  OriginalVoice:(BOOL)originalVoice
                               ReferenceVideoId:(NSString *)referenceVideoId
                               CustomerSubtitle:(NSString *)customerSubtitle
                                      VideoName:(NSString *)videoName
                                       VideoDes:(NSString *)videoDes
                                      ShareType:(BOOL)shareType
                                  MaterialArray:(NSArray *)materialArray
                                        Success:(RETURNDATADICTIONARY)block_suc
                                           Fail:(SoapErrorB)block_fail

{
    MovierDCInterfaceSvc_gmcreateorderfollowexist * arg0 = [MovierDCInterfaceSvc_gmcreateorderfollowexist new];
    arg0.in_ = self.WS_Session;
    arg0.stReference = [MovierDCInterfaceSvc_VDCKeyValueArr new];
    //是否随机音乐
    [arg0.stReference.item addObject:[self newAKeyValueWithKey:@"randommusic"
                                                         Value:[NSString stringWithFormat:@"%d", randomMusic]]];
    //不随机音乐的音乐id
    if (!randomMusic) {
        [arg0.stReference.item addObject:[self newAKeyValueWithKey:@"musicid"
                                                             Value:musicId]];
    }
    //是否保留原声
    [arg0.stReference.item addObject:[self newAKeyValueWithKey:@"originalvoice"
                                                         Value:[NSString stringWithFormat:@"%d", originalVoice]]];
    //被照做的影片id
    [arg0.stReference.item addObject:[self newAKeyValueWithKey:@"referencevideoid"
                                                         Value:referenceVideoId]];
    //用户添加的字幕
    [arg0.stReference.item addObject:[self newAKeyValueWithKey:@"customersubtitle"
                                                         Value:customerSubtitle]];
    //影片名
    [arg0.stReference.item addObject:[self newAKeyValueWithKey:@"videoname"
                                                         Value:videoName]];
    //影片描述
    [arg0.stReference.item addObject:[self newAKeyValueWithKey:@"videodesc"
                                                         Value:videoDes]];
    //是否公开
    [arg0.stReference.item addObject:[self newAKeyValueWithKey:@"sharetype"
                                                         Value:[NSString stringWithFormat:@"%d", shareType]]];
    
    //素材数组
    arg0.stMaterials = [MovierDCInterfaceSvc_VDCRecordArr new];
    for (NewOrderVideoMaterial * materialObj in materialArray) {
        MovierDCInterfaceSvc_VDCKeyValueArr * keyValueArr = [MovierDCInterfaceSvc_VDCKeyValueArr new];
        [keyValueArr.item addObject:[self newAKeyValueWithKey:@"url"
                                                        Value:materialObj.material_ossURL]];
        [keyValueArr.item addObject:[self newAKeyValueWithKey:@"index"
                                                        Value:[NSString stringWithFormat:@"%ld", (long)materialObj.nIndex]]];
//        [keyValueArr.item addObject:[self newAKeyValueWithKey:@"awardtype"
//                                                        Value:[NSString stringWithFormat:@"%ld", (long)materialObj.rewardType]]];
//        [keyValueArr.item addObject:[self newAKeyValueWithKey:@"awardlogid"
//                                                        Value:materialObj.arId]];
        [arg0.stMaterials.item addObject:keyValueArr];
    }
    
    HANDLERETURNVALUE(gmcreateorderfollowexistUsingBody,
                      MovierDCInterfaceSvc_VDCKeyValueArrEnv,
                      [self getServerDicWith:ret.stKV.item])
}

/**
 *  ar创建订单
 */
- (void)arCreateOrderWithVideoLength:(NSString *)videoLength
                     HeaderAndTailId:(NSString *)headerAndTailId
                            FilterId:(NSString *)filterId
                             MusicId:(NSString *)musicId
                          MusicStart:(NSString *)musicStart
                            MusicEnd:(NSString *)musicEnd
                          SubtitleId:(NSString *)subTitleId
                    CustomerSubtitle:(NSString *)customerSubTitle
                           VideoName:(NSString *)videoName
                            VideoDes:(NSString *)videoDes
                           ShareType:(BOOL)shareType
                       MaterialArray:(NSArray *)materialArray
                             Success:(RETURNDATADICTIONARY)block_suc
                                Fail:(SoapErrorB)block_fail
{
    MovierDCInterfaceSvc_gmcreateorder * arg0 = [MovierDCInterfaceSvc_gmcreateorder new];
    arg0.in_ = self.WS_Session;
    arg0.stReference = [MovierDCInterfaceSvc_VDCKeyValueArr new];
    //影片时长
    [arg0.stReference.item addObject:[self newAKeyValueWithKey:@"videolength"
                                                         Value:videoLength]];
    //模板id
    [arg0.stReference.item addObject:[self newAKeyValueWithKey:@"headerandtailid"
                                                         Value:headerAndTailId]];
    //滤镜id
    [arg0.stReference.item addObject:[self newAKeyValueWithKey:@"filterid"
                                                         Value:filterId]];
    //音乐id
    [arg0.stReference.item addObject:[self newAKeyValueWithKey:@"musicid"
                                                         Value:musicId]];
    //保留原声字段，大于10000保留原声，0不保留原声
    [arg0.stReference.item addObject:[self newAKeyValueWithKey:@"musicstart"
                                                         Value:musicStart]];
    //目前未使用
    [arg0.stReference.item addObject:[self newAKeyValueWithKey:@"musicend"
                                                         Value:musicEnd]];
    //字幕id
    [arg0.stReference.item addObject:[self newAKeyValueWithKey:@"subtitleid"
                                                         Value:subTitleId]];
    //用户填写的字幕
    [arg0.stReference.item addObject:[self newAKeyValueWithKey:@"customersubtitle"
                                                         Value:customerSubTitle]];
    //影片名
    [arg0.stReference.item addObject:[self newAKeyValueWithKey:@"videoname"
                                                         Value:videoName]];
    //影片描述
    [arg0.stReference.item addObject:[self newAKeyValueWithKey:@"videodesc"
                                                         Value:videoDes]];
    //是否公开
    [arg0.stReference.item addObject:[self newAKeyValueWithKey:@"sharetype"
                                                         Value:[NSString stringWithFormat:@"%d", shareType]]];
    //素材数组
    arg0.stMaterials = [MovierDCInterfaceSvc_VDCRecordArr new];
    for (NewOrderVideoMaterial * materialObj in materialArray) {
        MovierDCInterfaceSvc_VDCKeyValueArr * keyValueArr = [MovierDCInterfaceSvc_VDCKeyValueArr new];
        [keyValueArr.item addObject:[self newAKeyValueWithKey:@"url"
                                                        Value:materialObj.material_ossURL]];
        [keyValueArr.item addObject:[self newAKeyValueWithKey:@"index"
                                                        Value:[NSString stringWithFormat:@"%ld", (long)materialObj.nIndex]]];
//        [keyValueArr.item addObject:[self newAKeyValueWithKey:@"awardtype"
//                                                        Value:[NSString stringWithFormat:@"%ld", (long)materialObj.rewardType]]];
//        [keyValueArr.item addObject:[self newAKeyValueWithKey:@"awardlogid"
//                                                        Value:materialObj.arId]];
        [arg0.stMaterials.item addObject:keyValueArr];
    }
    HANDLERETURNVALUE(gmcreateorderUsingBody,
                      MovierDCInterfaceSvc_VDCKeyValueArrEnv,
                      [self getServerDicWith:ret.stKV.item])
}

/**
 *  ar获取宝箱
 */
- (void)getARChestWithLogId:(NSString *)arLogId
                    Success:(RETURNDATADICTIONARY)block_suc
                       Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_gmgetchest *arg0 = [MovierDCInterfaceSvc_gmgetchest new];
    arg0.in_ = self.WS_Session;
    arg0.nARLogID = [NSNumber numberWithInt:[arLogId intValue]];
    HANDLERETURNVALUE(gmgetchestUsingBody,
                      MovierDCInterfaceSvc_VDCKeyValueArrEnv,
                      [self getServerDicWith:ret.stKV.item])
}

/**
 *  AR 打开宝箱
 */
- (void)openARChestWithChestId:(NSString *)chestId
                       Success:(RETURNDATADICTIONARY)block_suc
                          Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_gmopenchest *arg0 = [MovierDCInterfaceSvc_gmopenchest new];
    arg0.in_ = self.WS_Session;
    arg0.nChestLogID = [NSNumber numberWithInt:[chestId intValue]];
    HANDLERETURNVALUE(gmopenchestUsingBody,
                      MovierDCInterfaceSvc_VDCKeyValueArrEnv,
                      [self getServerDicWith:ret.stKV.item])
}

/**
 *  获奖信息实时显示
 */
- (void)getRecentRewardInfoWithCount:(NSInteger)count
                             Success:(RETURNDATAARRAY)block_suc
                                Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_gmgetrealtimeawardinfo *arg0 = [MovierDCInterfaceSvc_gmgetrealtimeawardinfo new];
    arg0.nCount = @(count);
    HANDLERETURNVALUE(gmgetrealtimeawardinfoUsingBody,
                      MovierDCInterfaceSvc_VDCRecordArrEnv,
                      [self getServerDataMuArrayWithArray:ret.stRArr.item])
}

/**
 *  获取用户卡牌
 */
- (void)getUserCardWithSuccess:(RETURNDATAARRAY)block_suc
                          Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_gmgetvirtualcardbyuserid *arg0 = [MovierDCInterfaceSvc_gmgetvirtualcardbyuserid new];
    arg0.in_ = self.WS_Session;
    HANDLERETURNVALUE(gmgetvirtualcardbyuseridUsingBody,
                      MovierDCInterfaceSvc_VDCRecordArrEnv,
                      [self getServerDataMuArrayWithArray:ret.stRArr.item])
}

/**
 *  获取用户奖品
 */
- (void)getARRewardWithSuccess:(RETURNDATAARRAY)block_suc
                          Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_gmgetawardbyuserid *arg0 = [MovierDCInterfaceSvc_gmgetawardbyuserid new];
    arg0.in_ = self.WS_Session;
    HANDLERETURNVALUE(gmgetawardbyuseridUsingBody,
                      MovierDCInterfaceSvc_VDCRecordArrEnv,
                      [self getServerDataMuArrayWithArray:ret.stRArr.item])
}

/**
 *  AR 卡牌合成
 */
- (void)arCardSyntheticWithCardIdArray:(NSArray *)cardIdArray
                               Success:(RETURNDATADICTIONARY)block_suc
                                  Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_gmcardcompound *arg0 = [MovierDCInterfaceSvc_gmcardcompound new];
    arg0.in_ = self.WS_Session;
    arg0.stCardIDArr = [MovierDCInterfaceSvc_VDCIntArr new];
    for (NSNumber *cardId in cardIdArray) {
        [arg0.stCardIDArr addItem:cardId];
    }
    HANDLERETURNVALUE(gmcardcompoundUsingBody,
                      MovierDCInterfaceSvc_VDCKeyValueArrEnv,
                      [self getServerDicWith:ret.stKV.item])
}

/**
 *  获得各种券的数量
 */
- (void)getNumOfCouponWithSuccess:(RETURNDATADICTIONARY)block_suc
                             Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_gmgettokenamount * arg0 = [MovierDCInterfaceSvc_gmgettokenamount new];
    arg0.in_ = self.WS_Session;
    HANDLERETURNVALUE(gmgettokenamountUsingBody,
                      MovierDCInterfaceSvc_VDCKeyValueArrEnv,
                      [self getServerDicWith:ret.stKV.item])
}

/**
 *  获取各种券兑换规则
 */
- (void)getCouponExchangeRuleWithSuccess:(RETURNDATAARRAY)block_suc
                                    Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_gmgettokenexchangerule *arg0 = [MovierDCInterfaceSvc_gmgettokenexchangerule new];
    arg0.in_ = self.WS_Session;
    HANDLERETURNVALUE(gmgettokenexchangeruleUsingBody,
                      MovierDCInterfaceSvc_VDCRecordArrEnv,
                      [self getServerDataMuArrayWithArray:ret.stRArr.item])
}

/**
 *  ar各种券兑换奖品
 */
- (void)couponExchangeRewardWithTokenType:(NSInteger)couponType
                                 RewareID:(NSString *)rewardId
                                  Success:(RETURNDATADICTIONARY)block_suc
                                   Fail:(SoapErrorB)block_fail{
    MovierDCInterfaceSvc_gmtokenexchange * arg0 = [MovierDCInterfaceSvc_gmtokenexchange new];
    arg0.in_ = self.WS_Session;
    arg0.nTokenType = @(couponType);
    arg0.nAwardID = [NSNumber numberWithInt:[rewardId intValue]];
    HANDLERETURNVALUE(gmtokenexchangeUsingBody,
                      MovierDCInterfaceSvc_VDCKeyValueArrEnv,
                      [self getServerDicWith:ret.stKV.item])
}

@end
