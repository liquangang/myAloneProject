//
//  APPUserPrefs.m
//  M-Cut
//
//  Created by zhangxiaotian on 15/1/27.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "APPUserPrefs.h"
#import "MovierUtils.h"
#import "VideoDBOperation.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "SoapOperation.h"
#import "UpDateSql.h"
#import "UserEntity.h"
#import "Reachability.h"
#import "APPUserData.h"
#import "MessageObj.h"
#import "MaterialModel.h"
#import "CustomeClass.h"

@implementation APPUserPrefs
@synthesize videoInformation;

- (void)setWwanable:(BOOL)wwanable{
    [APPUserData writeUserInfoWithMobileStatus:wwanable];
    _wwanable = wwanable;
}

+ (APPUserPrefs *)Singleton
{
    static APPUserPrefs *Singleton;
    @synchronized(self)
    {
        if (!Singleton)
            Singleton = [[APPUserPrefs alloc] init];
        return Singleton;
    }
}

-(id)init
{
    self = [super init];
    self.isKeepVoice = NO;
    currentIndex = 0;
    orderID = 0;
    customerOrderStatus = false;
    Loginretrytime = 3;
//    currentDB_Home = [self APP_MaxOfHomePageVideoCacheInformationDBSearch];
    self.videoInformation = [[NSMutableArray alloc] initWithCapacity:10];
//    [self autorelease];
    
    _wwanable = [APPUserData getUserSetInfo];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(submitOrder:) name:MSG_ONEORDER_TRANSFER_OK object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(StartPersonalBacThread:) name:MSG_CUSTOMER_BAC_THREAD_ON object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EndPersonalBacThread:) name:MSG_CUSTOMER_BAC_THREAD_OFF object:nil];
    
    return self;
}

- (PrivateLoginCacheInformationObject *)APP_loginData
{
    PrivateLoginCacheInformationObject *privateLoginCacheInformationObject = [[PrivateLoginCacheInformationObject alloc] init];
    privateLoginCacheInformationObject = [self APP_LoginCacheInformationDBSearch];
    return privateLoginCacheInformationObject;
}

- (PrivateLoginCacheInformationObject *)APP_LoginCacheInformationDBSearch{
    PrivateLoginCacheInformationObject *privateLoginCacheInformationObject = [[PrivateLoginCacheInformationObject alloc] init];
    return privateLoginCacheInformationObject;
}

- (int)login:(NSString *)szName userPassword:(NSString *)szPwd isEncrypt:(bool)encrypt
{
    SoapOperation *soapctl = [SoapOperation Singleton];
    
    NSString* ver = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    [soapctl WS_Login:szName Password:szPwd withVersion:ver Encrypt:encrypt Success:^(MovierDCInterfaceSvc_VDCSession *ws_session) {
        [[UserEntity sharedSingleton] Applogin:szName appPwd:szPwd LoginType:LoginTypePhone];
        [UserEntity sharedSingleton].sessionId = [[NSString alloc] initWithFormat:@"%@",ws_session.nSessionID];
        [UserEntity sharedSingleton].customerId = [NSString stringWithFormat:@"%@",ws_session.nCustomerID];
        [UserEntity sharedSingleton].ossDir = ws_session.szRootDir;
        [UserEntity sharedSingleton].ossKey = ws_session.szKey;
        [soapctl WS_GetossConfig:ws_session Success:^(MovierDCInterfaceSvc_VDCOSSConfig *ossconfig) {
            [UserEntity sharedSingleton].ossBucket = ossconfig.szBucket;
            [UserEntity sharedSingleton].ossID = ossconfig.szID;
            [UserEntity sharedSingleton].ossKey = ossconfig.szKey;
            [UserEntity sharedSingleton].ossEndpoint = ossconfig.szEndpoint;
         } Fail:^(NSError *error) {
             NSLog(@"get oss config error!");
             NSLog(@"%@",[error localizedDescription]);
        }];
//        if (ws_session.n) {
//            statements
//        }
//        NSString *message = [[NSString alloc] initWithFormat:@"登录失败，用户名或密码错误!"];
//        [self ShowAlert:message];

    } Fail:^(NSNumber *loginstatus,NSError *error) {
        NSLog(@"soap login error! ret = %@",loginstatus);
        NSLog(@"%@",[error localizedDescription]);
        if ([loginstatus isEqualToNumber:[NSNumber numberWithInt:MOVIERDC_SERVER_INVALIDUSERORPWD]]) {
            NSString *message = [[NSString alloc] initWithFormat:@"登录失败，用户名或密码错误!"];
            [self ShowAlert:message];
        }
    }];
    
    return NOW_LOGOUT_HASLOGIN;
    
 }


-(void)ShowAlert:(NSString*)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:ISMaterialUploadSucceedNotification object:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示!" message:msg delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
        [alert show];
    });
}

//多线程开启
-(void)StartOrderT
{
    if (customerOrderStatus == false) {//保证线程只开启一次
        customerOrderStatus = true;
        [self initOSSService];
        order4T = [MovierTOrder Singleton];
        NSLog(@"Start OrderT only once, if this words show twice ,error!");
        [order4T initoss:@"" where2down:@"" Bucket:yourBucket secretKey:secretKey accessKey:accessKey HostId:yourHostId];
        order4T.task.updowndelegate = self;
        [self thread4getOreder];//从服务拿到曾今提交但未完成的订单
//        [self thread4FreshOrder];//轮训服务器，伪消息推送操作
        [self __thread_TransFiles];
    }
}

-(void)EndOrderT{
    if (customerOrderStatus == true) {
        customerOrderStatus = false;
//        [[NSNotificationCenter defaultCenter] removeObserver:order4T];
        [order4T removeselfobserver];
    }
}

- (void)thread4getOreder{//循环还可以改进
    [[SoapOperation Singleton] WS_QueryOrder:nil Success:^(MovierDCInterfaceSvc_VDCOrderForQueryArray *OList) {

        MC_OrderAndMaterialCtrl *dbCtrl = [[MC_OrderAndMaterialCtrl alloc]init];
        for (int i = 0 ; i<[OList.item count]; i++) {
            MovierDCInterfaceSvc_VDCOrderForQuery *item = [OList.item objectAtIndex:i];
            NewNSOrderDetail *newitem = [[NewNSOrderDetail alloc]init];
            if ([item.nOrderStatus isEqualToNumber:@(2)]==YES || [item.nOrderStatus isEqualToNumber:@(3)]==YES) {
                newitem.oss_orderid = [item.nOrderID intValue];
                newitem.createTime = item.szTime;
                newitem.strVideoURL = item.szURL;
                newitem.strVideoThumbnail = item.szThumbnail;
                newitem.order_st = COMMITEDORDER;
                newitem.customer = [[UserEntity sharedSingleton].customerId intValue];
                [dbCtrl AddOrderWithLogin:newitem];
            };
        }
        
    } Fail:^(NSError *error) {
        ;
    }];
    
    return;
}

- (void)thread4FreshOrder{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1&&customerOrderStatus) {
            [NSThread sleepForTimeInterval:3];
//            NSLog(@"I'm alive!! thread4FreshOrder");
            //赋值给查询数组 orders;
            MovierDCInterfaceSvc_VDCOrderIDArray *vdcin = [[MovierDCInterfaceSvc_VDCOrderIDArray alloc]init];
            NSArray *ready4soap = [MC_OrderAndMaterialCtrl GetCommitOrder:[[UserEntity sharedSingleton].customerId intValue] ];
            for (int i = 0; i <[ready4soap count]; i++) {
                NewNSOrderDetail *it = [ready4soap objectAtIndex:i];
                int orderid;
                if (it.oss_orderid!=0) {
                    orderid = (int)it.oss_orderid;
                }else
                    orderid = (int)it.order_id;
                [vdcin addItem:@(orderid)];
            }
            if([vdcin.item count]>0){
                [[SoapOperation Singleton]WS_QueryOrder:nil withID:vdcin Success:^(MovierDCInterfaceSvc_VDCOrderForQueryArray *Olist) {
                    [self NotifyOrder:Olist];
                    ;
                } Fail:^(NSError *error) {
                    ;
                }];
            }

        }
    });
}

//该方法暂时没有位置调用
//-(void)NotifyOrderResult:(struct ns__VDCOrderForQueryArrayEnv)in{
////    int sizeorginal = [orignals count];
////    if(sizeorginal != in._stVDCOrderForQueryArr.__size){
////        NSLog(@"soap queryorders error!");
////        return;
////    }
//    for (int i = 0; i < in._stVDCOrderForQueryArr.__size; i++) {
//        struct ns__VDCOrderForQuery vdcOrderForQuery = *(in._stVDCOrderForQueryArr.__ptr[i]);
//        int tmp = vdcOrderForQuery._nOrderStatus;
//        if (tmp >= 3) {
////            NSString *message = [[NSString alloc] initWithFormat:@"导演，您的大片已上映，快去“我的影片”看看吧。(%d)",vdcOrderForQuery._nOrderID];
//            NSString * message = [[NSString alloc] initWithFormat:@"导演您的大片已上映，快去“我的影片”看看吧。"];
//            [self ShowAlert:message];
////             发出订单制作完成的通知, 有 MovierTabBarViewController 中的 badgeView 设置未播放视频数量
//            [self sendNoti];
//            MC_OrderAndMaterialCtrl *dbCtrl = [[MC_OrderAndMaterialCtrl alloc]init];
//            [dbCtrl ChangeOSSOrderStatus:vdcOrderForQuery._nOrderID Status:FINISHORDER];
//        }
//        
//    }
//}

#pragma mark - 新影片提示接口
-(void)NotifyOrder:(MovierDCInterfaceSvc_VDCOrderForQueryArray*)orders{
    for (MovierDCInterfaceSvc_VDCOrderForQuery* item in orders.item) {
        if([item.nOrderStatus isEqualToNumber:@(3)]==YES){
            MC_OrderAndMaterialCtrl *dbCtrl = [[MC_OrderAndMaterialCtrl alloc]init];
            [dbCtrl ChangeOSSOrderStatus:[item.nOrderID intValue] Status:FINISHORDER];
            //(提示接口)
            //添加到数据库中
            [self dataRequest:0 count:[NSNumber numberWithInt:1]];
            
            //发出订单制作完成的通知, 有MovierTabBarViewController 中的 badgeView 设置未播放视频数量
//            [self sendNoti];
            
        }
    }
}

-(void)dataRequest:(NSNumber *)start count:(NSNumber *)count
{
    __weak typeof(self) wself = self;
    [[SoapOperation Singleton] WS_GetPersonalVideos:nil
                                           Customer:@([[UserEntity sharedSingleton].customerId intValue])
                                              Start:start
                                              Count:count
                                            Success:^(MovierDCInterfaceSvc_VDCVideoInfoExArray *array){
                                                [wself addVideoInfosWithArray:array.item];
                                            }
                                               Fail:^(NSError *error) {
                                               }];
}

- (void)addVideoInfosWithArray:(NSMutableArray *)array {
    for (NSInteger i = 0; i < array.count; i++) {
        MovierDCInterfaceSvc_VDCVideoInfoEx *videoInfoEx = array[i];
        VideoInformationObject *videoInfo = [[VideoInformationObject alloc] init];
        videoInfo.videoID = [NSString stringWithFormat:@"%@", videoInfoEx.nVideoID];
        videoInfo.videoName = videoInfoEx.szVideoName;
        videoInfo.ownerID = [NSString stringWithFormat:@"%@", videoInfoEx.nOwnerID];
        videoInfo.ownerName = videoInfoEx.szOwnerName;
        videoInfo.ownerAcatar = videoInfoEx.szAcatar;
        videoInfo.videoLabelName = videoInfoEx.szVideoLabel;
        videoInfo.videoCreateTime = videoInfoEx.szCreateTime;
        videoInfo.videoThumbnailUrl = [videoInfoEx.szThumbnail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        videoInfo.videoReferenceUrl = [videoInfoEx.szReference stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        videoInfo.videoSignature = videoInfoEx.szSignature;
        videoInfo.videoNumberOfPraise = [NSString stringWithFormat:@"%@", videoInfoEx.nPraise];
        videoInfo.videoNumberOfShare = [NSString stringWithFormat:@"%@", videoInfoEx.nShareNum];
        videoInfo.videoNumberOfFavorite = [NSString stringWithFormat:@"%@", videoInfoEx.nFavoritesNum];
        videoInfo.videoNumberOfComment = [NSString stringWithFormat:@"%@", videoInfoEx.nCommentsNum];
        videoInfo.videoCollectStatus = [NSString stringWithFormat:@"%@", videoInfoEx.nVideoStatus];
        videoInfo.videoShare = [NSString stringWithFormat:@"%@", videoInfoEx.nVideoShare];
        videoInfo.videoPlayCount = [NSString stringWithFormat:@"%@", videoInfoEx.nVisitCount];
        [MessageObj addNewVideoWithObj:videoInfo];
    }
}

- (void)sendNoti {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSInteger videos = [[defaults valueForKey:@"UserNoPlayVideo"] integerValue];
        [defaults setValue:@(videos + 1) forKey:@"UserNoPlayVideo"];
        [defaults synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:PersonalNotPlayVideoAdd object:nil userInfo:nil];
    });
}

- (void)__thread_TransFiles
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //第一次获取上次未上传的订单
        NSArray *Lastorders = [MC_OrderAndMaterialCtrl GetTranferOrders:[[UserEntity sharedSingleton].customerId intValue]];
        for (NewNSOrderDetail *it in Lastorders) {
            NSString* M_strTOrder = [order4T CreateOrder];//创建一个传输订单
            NSString* osspath = [[NSString alloc]initWithFormat:@"%@系统文件夹/Resouse/%@",[UserEntity sharedSingleton].ossDir,[MovierUtils stringFromDateaa:[NSDate date]]];
            [order4T.task changeOssPrefix:osspath];
            NSArray* materials = [[NSArray alloc] initWithArray:[MC_OrderAndMaterialCtrl GetMaterial:[[UserEntity sharedSingleton].customerId intValue] Orderid:it.order_id]];
            BOOL needTransfer = false;
            for (NewOrderVideoMaterial* mitem in materials) {
                if ([mitem.material_ossURL isEqualToString:@""] == TRUE)
                {
                    //                            [order4T AddUpFile2Order:M_strTOrder filename:mitem.material_localURL];
                    [order4T AddUpFile2Order:M_strTOrder filename:mitem.material_assetsURL];
                    needTransfer = true;
                }
            }
            if (needTransfer) {
                [order4T StartOrder:M_strTOrder WWANable:self.wwanable];
                //                        [dbCtrl ChangeOrderStatus:firstT.order_id Status:NOWTRANSFER];
            }else{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:MSG_ONEORDER_TRANSFER_OK object:[NSNumber numberWithInt:it.order_id]];
                NSLog(@" postNotification MSG_ONEORDER_TRANSFER_OK 系统启动");
            }
        }
        while (1&&customerOrderStatus)
        {
//            NSLog(@"__thread_TransFiles");
            @autoreleasepool {//死循环，arc环境需要
                [NSThread sleepForTimeInterval:3];
                NSArray *orders = [MC_OrderAndMaterialCtrl GetReadyOrder:[[UserEntity sharedSingleton].customerId intValue]];
                NewNSOrderDetail *firstT;
                if ([orders count]>0) {
                    firstT = [orders objectAtIndex:0];
                    NSString* M_strTOrder = [order4T CreateOrder];//创建一个传输订单
                    NSString* osspath = [[NSString alloc]initWithFormat:@"%@系统文件夹/Resouse/%@",[UserEntity sharedSingleton].ossDir,[MovierUtils stringFromDateaa:[NSDate date]]];
                    [order4T.task changeOssPrefix:osspath];
                    NSArray* materials = [[NSArray alloc] initWithArray:[MC_OrderAndMaterialCtrl GetMaterial:[[UserEntity sharedSingleton].customerId intValue] Orderid:firstT.order_id]];
                    BOOL needTransfer = false;
                    for (NewOrderVideoMaterial* mitem in materials) {
//                        NSLog(@"aaaa = %d",([mitem.material_ossURL isEqualToString:@""] == YES));
                        if ([mitem.material_ossURL isEqualToString:@""] == YES)
                        {
                            [order4T AddUpFile2Order:M_strTOrder filename:mitem.material_assetsURL];
                            needTransfer = true;
                        }
                    }
                    [MC_OrderAndMaterialCtrl ChangeOrderStatus:firstT.order_id Status:NOWTRANSFER];
                    if (needTransfer) {
                        [order4T StartOrder:M_strTOrder WWANable:self.wwanable];
//                        [dbCtrl ChangeOrderStatus:firstT.order_id Status:NOWTRANSFER];
                    }else{
                        [[NSNotificationCenter defaultCenter] postNotificationName:MSG_ONEORDER_TRANSFER_OK object:[NSNumber numberWithInt:firstT.order_id]];
                        NSLog(@"aaaaaaa submit order without transfer");
                    }

                }
            }
        }
    });
}
/**
 [self initOSSService];
 order4T = [MovierTOrder Singleton];
 [order4T initoss:@"" where2down:@"" Bucket:yourBucket secretKey:secretKey accessKey:accessKey HostId:yourHostId];
 order4T.task.updowndelegate = self;
 */

-(void)StartPersonalBacThread:(NSNotification*) notification{
    NSLog(@"MSG_CUSTOMER_BAC_THREAD_ON");
    [self StartOrderT];
}
-(void)EndPersonalBacThread:(NSNotification*) notification{
     NSLog(@"MSG_CUSTOMER_BAC_THREAD_OFF");
    [self EndOrderT];
    //结束上传订单
}

#pragma mark - 上传订单内容

//上传订单
-(void)submitOrder:(NSNotification*) notification{
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, 1*USEC_PER_SEC);
     dispatch_after(time,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         MC_OrderAndMaterialCtrl *dbCtrl = [[MC_OrderAndMaterialCtrl alloc]init];
         NewNSOrderDetail * it;
         
         if (notification.object!=nil) {
             it = [[VideoDBOperation Singleton] SearchOrder:[notification.object intValue]];
         }else{
             it = [MC_OrderAndMaterialCtrl GetTranferOrder:[[UserEntity sharedSingleton].customerId intValue]];
         }
         
         NSLog(@"wssesion id = %@  order customer = %d, orderid = %d",[SoapOperation Singleton].WS_Session.nCustomerID ,it.customer,it.order_id);
         
         if (it.customer != [[SoapOperation Singleton].WS_Session.nCustomerID intValue]){
             NSLog(@"login != Order ");
             return;
         }
         
         //获取素材数组
         NSMutableArray * materialArray = [MC_OrderAndMaterialCtrl GetMaterial:[[UserEntity sharedSingleton].customerId intValue] Orderid:it.order_id];
         
         if (self.isKeepVoice) {
             it.nMusicStart = 10000;
         }

         if ([it.followVideoId intValue] > 0) {
             
             //一键照做
             [self uploadFollowOrderWithMaterialArray:materialArray OrderDetail:it DbCtrl:dbCtrl];
         }else{
             
             //普通做片
             [self uploadGeneralOrderWithMaterialArray:materialArray OrderDetail:it DbCtrl:dbCtrl];
         }
     });
}

/**
 *  照做提交订单
 */
- (void)uploadFollowOrderWithMaterialArray:(NSArray *)materialArray OrderDetail:(NewNSOrderDetail *)it DbCtrl:(MC_OrderAndMaterialCtrl *)dbCtrl{
    WEAKSELF2
    
    //一键照做
    [[SoapOperation Singleton] arCreateOrderFollowExistWithRandomMusic:YES MusicId:[NSString stringWithFormat:@"%d", it.nMusicID] OriginalVoice:self.isKeepVoice ReferenceVideoId:it.followVideoId CustomerSubtitle:it.szCustomerSubtitle VideoName:it.szVideoName VideoDes:it.videoDes ShareType:it.nShareType MaterialArray:[materialArray copy] Success:^(NSMutableDictionary *serverDataDictionary) {
        [weakSelf ShowAlert:@"影片素材上传成功，制作完成将进行通知"];
        [MC_OrderAndMaterialCtrl ChangeOrderStatus:it.order_id Status:COMMITEDORDER];
        [dbCtrl UpdateOssId:[[UserEntity sharedSingleton].customerId intValue] Orderid:it.order_id OSSId:[serverDataDictionary[@"orderid"] intValue]];
        [weakSelf postSuccessNotiWithOrderId:serverDataDictionary[@"orderid"]];
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf uploadFollowOrderWithMaterialArray:materialArray OrderDetail:it DbCtrl:dbCtrl];);
    }];
}

/**
 *  普通提交订单
 */
- (void)uploadGeneralOrderWithMaterialArray:(NSArray *)materialArray OrderDetail:(NewNSOrderDetail *)it DbCtrl:(MC_OrderAndMaterialCtrl *)dbCtrl{
    WEAKSELF2
    
    //普通做片
    [[SoapOperation Singleton] arCreateOrderWithVideoLength:[NSString stringWithFormat:@"%f", it.nVideoLength] HeaderAndTailId:[NSString stringWithFormat:@"%d", it.nHeaderAndTailID] FilterId:[NSString stringWithFormat:@"%d", it.nFilterID] MusicId:[NSString stringWithFormat:@"%d", it.nMusicID] MusicStart:[NSString stringWithFormat:@"%d", it.nMusicStart] MusicEnd:[NSString stringWithFormat:@"%d", it.nMusicEnd] SubtitleId:[NSString stringWithFormat:@"%d", it.nSubtitleID] CustomerSubtitle:it.szCustomerSubtitle VideoName:it.szVideoName VideoDes:it.videoDes ShareType:it.nShareType MaterialArray:[materialArray copy] Success:^(NSMutableDictionary *serverDataDictionary) {
        [weakSelf ShowAlert:@"影片素材上传成功，制作完成将进行通知"];
        [MC_OrderAndMaterialCtrl ChangeOrderStatus:it.order_id Status:COMMITEDORDER];
        [dbCtrl UpdateOssId:[[UserEntity sharedSingleton].customerId intValue] Orderid:it.order_id OSSId:[serverDataDictionary[@"orderid"] intValue]];
        [weakSelf postSuccessNotiWithOrderId:serverDataDictionary[@"orderid"]];
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf uploadGeneralOrderWithMaterialArray:materialArray OrderDetail:it DbCtrl:dbCtrl];);
    }];
}

- (void)postSuccessNotiWithOrderId:(NSString *)orderId{
    
    [CustomeClass mainQueue:^{
        POSTNOTI(orderInfoUploadSuccess, @{orderUploadSuccessId:orderId});
    }];
}

-(void)reloginandpost:(NSNumber*)orderid{
    if ([[UserEntity sharedSingleton] isAppHasLogin]&&[UserEntity sharedSingleton].appLoginType==LoginTypePhone) {
        [[SoapOperation Singleton]WS_Login:[UserEntity sharedSingleton].appUserName Password:[UserEntity sharedSingleton].appUserPWD withVersion:[UpDateSql getAPPVersion] Encrypt:([UserEntity sharedSingleton].appLoginType==LoginTypePhone)?NO:YES Success:^(MovierDCInterfaceSvc_VDCSession *ws_session) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:MSG_ONEORDER_TRANSFER_OK object:orderid];
            NSLog(@"aaaaaaa submit order reloginandpost use phone login");
        } Fail:^(NSNumber *LoginStatus, NSError *error) {
            NSLog(@"reloginandpost error ! %@",error);;
        }];
        
    }else if ([[UserEntity sharedSingleton] isAppHasLogin]&&[UserEntity sharedSingleton].appLoginType==LoginTypeWeChat){
        [[SoapOperation Singleton] WS_Login:[UserEntity sharedSingleton].appUserName ThirdPartyType:@"1" Token:[UserEntity sharedSingleton].appUserPWD Openid:[UserEntity sharedSingleton].appUserName APPVersion:[UpDateSql getAPPVersion] SubVersion:[UpDateSql getAPPVersion] Success:^(MovierDCInterfaceSvc_VDCSession* ws_session) {
            [[NSNotificationCenter defaultCenter] postNotificationName:MSG_ONEORDER_TRANSFER_OK object:orderid];
             NSLog(@"aaaaaaa submit order reloginandpost use wechat login");
        } Fail:^(NSNumber *LoginStatus,NSError *error) {
            NSLog(@"reloginandpost error ! %@",error);
        }];
    }
}

-(void)upFileProgress:(float)progress
{
    dispatch_async(dispatch_get_global_queue(0,0), ^(void){
        NSString *ratio = [NSString stringWithFormat:@"%f",progress];
        [stockForKVO setValue:ratio forKey:@"upratio"];
    });
}

//- (oneway void) release {
//    if (![NSThread isMainThread]) {
//        [self performSelectorOnMainThread:@selector(release) withObject:nil waitUntilDone:NO];
//    } else {
//        [super release];
//    }
//}

- (void)initOSSService
{
    accessKey = [UserEntity sharedSingleton].ossID;
    secretKey = [UserEntity sharedSingleton].ossKey;
    yourBucket = [UserEntity sharedSingleton].ossBucket;
    yourHostId = [UserEntity sharedSingleton].ossEndpoint;
    yourDownloadObjectKey = @"";
    yourUploadObjectKey = @"";
    yourUploadDataPath = @"";
    /* 4月版本oss官方sdk 初始化
    ossService = [ALBBOSSServiceProvider getService];
    [ossService setGlobalDefaultBucketAcl:PRIVATE];
    [ossService setGlobalDefaultBucketHostId:yourHostId];
    [ossService setAuthenticationType:ORIGIN_AKSK];
    [ossService setGenerateToken:^(NSString *method, NSString *md5, NSString *type, NSString *date, NSString *xoss, NSString *resource){
        NSString *signature = nil;
        NSString *content = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@%@", method, md5, type, date, xoss, resource];
        signature = [OSSTool calBase64Sha1WithData:content withKey:secretKey];
        signature = [NSString stringWithFormat:@"OSS %@:%@", accessKey, signature];
        NSLog(@"here signature:%@", signature);
        return signature;
    }];*/
    
}

-(void)upFileSucess:(NSString *)filename LocalPath:(NSString *)localpath
{
//    NSArray *arrayl =  [filename componentsSeparatedByString: @"/"];
//    int s = (int)[arrayl count];
//    NSString *fileName = [arrayl objectAtIndex:s-1];
//    NewOrderVideoMaterial *newOrderVideoMaterial = [[NewOrderVideoMaterial alloc] init];
//    newOrderVideoMaterial = [APPUserPrefs APP_MaterialArrQueryCacheInformationDBSearchforid:fileName];
//    NSString *locFileName = [[NSString alloc] initWithFormat: @"%@Resouse/%d/%@",[UserEntity sharedSingleton].ossDir,newOrderVideoMaterial.order_id,fileName];
    NSString *fileurl = @"";
    fileurl = [fileurl stringByAppendingFormat:@"http://%@.%@/%@",[UserEntity sharedSingleton].ossBucket,[UserEntity sharedSingleton].ossEndpoint,filename];

//    newOrderVideoMaterial.material_ossURL = fileurl;
//    newOrderVideoMaterial.file_st = 1;
//    [self APP_MaterialCacheInformationDBChange:newOrderVideoMaterial];
//    currentIndex = currentIndex + 1;
//    NSLog(@"%@ had up load!",filename);
    MC_OrderAndMaterialCtrl *dbCtrl = [[MC_OrderAndMaterialCtrl alloc]init];
    [dbCtrl MaterialHasUpload:localpath OSSPath:fileurl AddressType:USEASSERTS Owner:[[UserEntity sharedSingleton].customerId intValue]];
    
    MovierTranslation* tmpload = [MovierTranslation Singleton];
    [tmpload nextupFile];
}

-(void)upFileFailed:(NSString *)filename
{
    MovierTranslation* tmpload = [MovierTranslation Singleton];
//    if ([UserEntity sharedSingleton].appUserName) {
//        [[SoapOperation Singleton] WS_Login:[UserEntity sharedSingleton].appUserName Password:[UserEntity sharedSingleton].appUserPWD withVersion:[UpDateSql getAPPVersion] Encrypt:([UserEntity sharedSingleton].appLoginType==LoginTypePhone)?NO:YES Success:^(MovierDCInterfaceSvc_VDCSession *ws_session) {
//            [tmpload reTranslateData];
//        } Fail:^(NSNumber *LoginStatus, NSError *error) {
//            NSLog(@"reLogin error!");
//        }];
//    };
    [tmpload reTranslateData];
}

-(void)downFileSucess:(NSString *)filename
{
    NSLog(@"%@ had down load!",filename);
}

-(void)deleteAll:(int)videoID
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
//    [array addObjectsFromArray:[APPUserPrefs APP_MaterialArrQueryCacheInformationDBSearch:videoID]];
    int sum = (int)[array count];
    NSString *KCachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    for (int i = 0; i < sum; i++) {
        NewOrderVideoMaterial *newOrderVideoMaterial = [[NewOrderVideoMaterial alloc] init];
        newOrderVideoMaterial = [array objectAtIndex:i];
        if (![newOrderVideoMaterial.material_localURL isEqualToString:@""]) {
            NSString *videoPath = [KCachesPath stringByAppendingPathComponent:newOrderVideoMaterial.material_localURL];
            [self deleteFile:videoPath];
        }
    }
}

-(void)deleteFile:(NSString *)filename {
    NSFileManager* fileManager=[NSFileManager defaultManager];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:filename];
    if (!blHave) {
        NSLog(@"no have");
    }else {
        NSLog(@"have");
        BOOL blDele= [fileManager removeItemAtPath:filename error:nil];
        if (blDele) {
            NSLog(@"dele success");
        }else {
            NSLog(@"dele fail");
        }
    }
}

//-(NSString*)GetCurrntNet
//{
//    NSString* result;
//    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
//    switch ([r currentReachabilityStatus]) {
//        case NotReachable:
//            result=nil;
//            break;
//        case ReachableViaWWAN:
//            result=@"3g";
//            break;
//        case ReachableViaWiFi:
//            result=@"wifi";
//            break;
//    }
//    return result;
//}

-(void)sql2mem:(sqlite3_stmt*)statement{
    VideoInformationObject *videoInformationObject = [[VideoInformationObject alloc] init];
    videoInformationObject.videoID = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
    videoInformationObject.videoName = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
    videoInformationObject.ownerID = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
    videoInformationObject.ownerName = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
    videoInformationObject.ownerAcatar = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
    videoInformationObject.videoLabelName = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
    videoInformationObject.videoCreateTime = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
    videoInformationObject.videoThumbnailUrl = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)];
    videoInformationObject.videoReferenceUrl = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)];
//    videoInformationObject.videoThumbnailUrl = [videoInformationObject.videoThumbnailUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    videoInformationObject.videoReferenceUrl = [videoInformationObject.videoReferenceUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    videoInformationObject.videoNumberOfPraise = [NSString stringWithFormat:@"%d",sqlite3_column_int(statement, 10)];
    videoInformationObject.videoNumberOfShare = [NSString stringWithFormat:@"%d",sqlite3_column_int(statement, 11)];
    videoInformationObject.videoNumberOfFavorite = [NSString stringWithFormat:@"%d",sqlite3_column_int(statement, 12)];
    videoInformationObject.videoCollectStatus = [NSString stringWithFormat:@"%d",sqlite3_column_int(statement, 13)];
    videoInformationObject.videoShare = [NSString stringWithFormat:@"%d",sqlite3_column_int(statement, 14)];
    videoInformationObject.videoSignature = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 15)];
    [videoInformation addObject:videoInformationObject];
}

- (NSString *)APP_getImg:(NSString *)url
{
//    NSString *locImgurl = [[NSString alloc] initWithString:[self APP_OssImgCacheInformationDBSearch:url]];
    return nil;
}

- (UIImage *)APP_getImg:(NSString *)url ImageView:(UIImageView *)imageView  ImageName:(NSString *)imagename
{
    UIImage *img;
//    NSString *urlimage = [[NSString alloc] initWithString:[[APPUserPrefs Singleton] APP_getImg:url]];
//    if ([urlimage isEqualToString:@""])
    {
        NSURL *imagePath1 = [NSURL URLWithString:url];
        //下面两行代码暂未使用
//        NSArray *tmpArray = [url componentsSeparatedByString: @"/"];
//        NSString *strfilename = [NSString stringWithFormat:@"%@%@",[tmpArray objectAtIndex:[tmpArray count]-2],[tmpArray objectAtIndex:[tmpArray count]-1]];
//        [[APPUserPrefs Singleton] APP_OssImgCacheInformationDBInsert:url LocImgUrl:strfilename];
        [imageView sd_setImageWithURL:imagePath1 placeholderImage:[UIImage imageNamed:imagename]];
        img = imageView.image;
    }
    
    //图片缓存sqlite，该部分已经被删除
//    else{
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *path = [paths objectAtIndex:0];
//        NSString *filePath = [path stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
//        filePath = [filePath stringByAppendingPathComponent:urlimage];
//        BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:filePath];
//        if (!blHave) {
//            img = [UIImage imageNamed:imagename];
//        }else
//        {
//            NSData *data = [NSData dataWithContentsOfFile:filePath];
//            if (data == nil) {
//                img = [UIImage imageNamed:imagename];
//            }else{
//                img = [[UIImage alloc] initWithData:data];
//            }
//        }
//    }
    return img;
}

- (int)APP_WriteToFile:(UIImage *)image FilePath:(NSString *)fileName
{
    int aRet = -1;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
    filePath = [filePath stringByAppendingPathComponent:fileName];
    BOOL blHave=[UIImagePNGRepresentation(image)writeToFile:filePath atomically:YES];
    if (!blHave) {
        aRet = 1;
    }else
    {
        aRet = 0;
    }
    return aRet;
}

-(int)AutoLogin{
    if ([[UserEntity sharedSingleton] isAppHasLogin]) {
        SoapOperation *soapctl = [SoapOperation Singleton];
        NSString* ver = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        if ([UserEntity sharedSingleton].appLoginType == LoginTypePhone) {
            [soapctl WS_Login:[UserEntity sharedSingleton].appUserName Password:[UserEntity sharedSingleton].appUserPWD withVersion:ver Encrypt:false Success:^(MovierDCInterfaceSvc_VDCSession *ws_session) {
                //初始化 UserEntity 的值，除userinfo外
                [self fillUseEntity:ws_session SoapCtl:soapctl];
            } Fail:^(NSNumber *loginstatus,NSError *error) {
                NSLog(@"soap login error! ret = %@",loginstatus);
                NSLog(@"%@",[error localizedDescription]);
//                Loginretrytime--;
//                [self AutoLogin];
            }];
        }else {
            [soapctl WS_Login:[UserEntity sharedSingleton].appUserName ThirdPartyType:@"1" Token:[UserEntity sharedSingleton].appUserPWD Openid:[UserEntity sharedSingleton].appUserName APPVersion:ver SubVersion:ver Success:^(MovierDCInterfaceSvc_VDCSession *ws_session) {
                //初始化 UserEntity 的值，除userinfo外
                [self fillUseEntity:ws_session SoapCtl:soapctl];
            } Fail:^(NSNumber *LoginStatus, NSError *error) {
                NSLog(@"soap login error! ret = %@",LoginStatus);
                NSLog(@"%@",[error localizedDescription]);
//                Loginretrytime--;
//                [self AutoLogin];
            }];
        }
        return NOW_LOGIN;
        
    }else
        return NOW_FRESH;
    
}

-(void)fillUseEntity:(MovierDCInterfaceSvc_VDCSession*)ws_session SoapCtl:(SoapOperation*)soapctl{
    //初始化 UserEntity 的值，除userinfo外
    [UserEntity sharedSingleton].sessionId = [[NSString alloc] initWithFormat:@"%@",ws_session.nSessionID];
    [UserEntity sharedSingleton].customerId = [NSString stringWithFormat:@"%@",ws_session.nCustomerID];
    [UserEntity sharedSingleton].ossDir = ws_session.szRootDir;
    [UserEntity sharedSingleton].ossKey = ws_session.szKey;
    [soapctl WS_GetossConfig:ws_session Success:^(MovierDCInterfaceSvc_VDCOSSConfig *ossconfig) {
        [UserEntity sharedSingleton].ossBucket = ossconfig.szBucket;
        [UserEntity sharedSingleton].ossID = ossconfig.szID;
        [UserEntity sharedSingleton].ossKey = ossconfig.szKey;
        [UserEntity sharedSingleton].ossEndpoint = ossconfig.szEndpoint;
        [[APPUserPrefs Singleton] StartOrderT];
    } Fail:^(NSError *error) {
        NSLog(@"get oss config error!");
        NSLog(@"%@",[error localizedDescription]);
    }];
}
@end