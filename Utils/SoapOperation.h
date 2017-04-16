//
//  Soap4Movier.h
//  M-Cut
//
//  Created by Crab00 on 15/10/6.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovierDCInterfaceSvc.h"

/*
 #define MOVIERDC_SERVER_NOT_IMPLEMENTED -1  // 服务器未准备好
 #define MOVIERDC_SERVER_OK 0  // 访问成功
 #define MOVIERDC_SERVER_UNKNOWN_ERR 1  // 未知错误
 #define MOVIERDC_SERVER_INITDB_FAILED 2  // 初始化数据库失败
 #define MOVIERDC_SERVER_SOAPALLOC_FAILED 3
 #define MOVIERDC_SERVER_SOAPBIND_FAILED 4  //
 #define MOVIERDC_SERVER_DBOPERATION_FAILED 5  // 数据库语句执行失败
 #define MOVIERDC_SERVER_NOMORE_ITEM 6  // 数据库中务此数据
 #define MOVIERDC_SERVER_INVALID_PARAMETER 7  // 参数无效
 #define MOVIERDC_SERVER_GETDBMGR_FAILED 8  // 获取DBMgr失败
 #define MOVIERDC_SERVER_GETDBCON_FAILED 9  // 获取数据库操作句柄失败
 #define MOVIERDC_SERVER_GETDBCACHE_FAILED 10  // 获取数据库缓存失败
 #define MOVIERDC_SERVER_GETSESSIONMGR_FAILED 11  // 获取SessionMgr失败
 #define MOVIERDC_SERVER_INVALID_SESSION 12  // Session无效
 #define MOVIERDC_SERVER_ACTIVECODE_NOTEXIST 13  //
 #define MOVIERDC_SERVER_ACTIVECODE_EXPIRED 14  //
 #define MOVIERDC_SERVER_ACTIVECODE_INVALID 15
 #define MOVIERDC_SERVER_SESSION_EXPIRED 16  // Session到期
 #define MOVIERDC_SERVER_INVALIDUSERORPWD 17  // 帐号或密码无效
 #define MOVIERDC_SERVER_ALLOCSESSION_FAILED 18  // 分配Session失败
 #define MOVIERDC_SERVER_EMAILEXIST 19  // 邮箱已存在
 #define MOVIERDC_SERVER_TELEXIST 20  // 手机号已存在
 #define MOVIERDC_SERVER_GETMUSICINFO_FAILED 21  // 获取音乐信息失败
 #define MOVIERDC_SERVER_PERMISSION_DENIED 22  // 拒绝访问
 #define MOVIERDC_SERVER_STARTDEAMONTHREADS_FAILED 23  //启动Deamon线程失败
 #define MOVIERDC_SERVER_BADLOCK 24  //
 #define MOVIERDC_SERVER_OUTOFRESOURCE 25  //
 #define MOVIERDC_SERVER_GENERATESIGNATURE_FAILED 26  // 生成签名失败
 #define MOVIERDC_SERVER_ALREADY_PRAISE 27  // 早已点赞
 #define MOVIERDC_SERVER_KICKOUT 28  // 用户被踢出
 #define MOVIERDC_SERVER_INVALIDACTIVITYPWD 29  // 活动密码无效
 #define MOVIERDC_SERVER_ALREADY_EXIST 30  // 早已存在
 #define MOVIERDC_SERVER_INVALID_SECRET 31 // 密码无效
 #define MOVIERDC_SERVER_ACTIVITY_FULL 32
 #define MOVIERDC_SERVER_NOTMEMBEROFACTIVITY 33  //
 #define MOVIERDC_SERVER_ACCOUNT_ALREADYREGISTERED 34 // 帐号早已注册
 #define MOVIERDC_SERVER_ACCOUNT_NOTEXIST 35  // 帐号不存在
 #define MOVIERDC_SERVER_INITSESSIONMGR_FAILED 36  // 初始化SessionMgr失败
 #define MOVIERDC_SERVER_INITAUTOCOMMENT_FAILED 37  // 初始化自动评论失败
 #define MOVIERDC_SERVER_INITSCOREMGR_FAILED 38  // 初始化ScoreMgr失败
 #define MOVIERDC_SERVER_GETSCOREMGR_FAILED 39  // 获取ScoreMgr失败
 #define MOVIERDC_SERVER_GETSCOREACTION_FAILED 40  // 获取积分动作失败
 #define MOVIERDC_SERVER_GETSCORETASK_FAILED 41  // 获取积分任务失败
 #define MOVIERDC_SERVER_ALREADY_FOLLOW 42  // 早已关注
 #define MOVIERDC_SERVER_GETDEVICELISTMGR_FAILED 43  // 获取DeviceListMgr失败
 #define MOVIERDC_SERVER_INITMESSAGEPUSH_FAILED 44  // 初始化消息推送失败
 #define MOVIERDC_SERVER_MSGPUSHSUBMITTASK_FAILED 45  // 提交消息推送任务失败
 #define MOVIERDC_SERVER_GETPRIVILEGEINFO_FAILED 46  // 获取等级信息失败
 #define MOVIERDC_SERVER_GETFRIENDRELATION_FAILED 47  // 获取好友关系失败
 #define MOVIERDC_SERVER_ALLOCATESPACE_FAILED 48  // 分配空间失败
 #define MOVIERDC_SERVER_NOTFRIEND 49  // 没有好友
 #define MOVIERDC_SERVER_ACCOUNTISLOCK 50  // 帐号被封
 51 //不在这个门店范围内
 */

#define MOVIERDC_SERVER_NOT_IMPLEMENTED -1
#define MOVIERDC_SERVER_OK 0
#define MOVIERDC_SERVER_UNKNOWN_ERR 1
#define MOVIERDC_SERVER_INITDB_FAILED 2
#define MOVIERDC_SERVER_SOAPALLOC_FAILED 3
#define MOVIERDC_SERVER_SOAPBIND_FAILED 4
#define MOVIERDC_SERVER_DBOPERATION_FAILED 5
#define MOVIERDC_SERVER_NOMORE_ITEM 6
#define MOVIERDC_SERVER_INVALID_PARAMETER 7
#define MOVIERDC_SERVER_GETDBMGR_FAILED 8
#define MOVIERDC_SERVER_GETDBCON_FAILED 9
#define MOVIERDC_SERVER_GETDBCACHE_FAILED 10
#define MOVIERDC_SERVER_GETSESSIONMGR_FAILED 11
#define MOVIERDC_SERVER_INVALID_SESSION 12
#define MOVIERDC_SERVER_ACTIVECODE_NOTEXIST 13
#define MOVIERDC_SERVER_ACTIVECODE_EXPIRED 14
#define MOVIERDC_SERVER_ACTIVECODE_INVALID 15
#define MOVIERDC_SERVER_SESSION_EXPIRED 16
#define MOVIERDC_SERVER_INVALIDUSERORPWD 17
#define MOVIERDC_SERVER_ALLOCSESSION_FAILED 18
#define MOVIERDC_SERVER_EMAILEXIST 19
#define MOVIERDC_SERVER_TELEXIST 20
#define MOVIERDC_SERVER_GETMUSICINFO_FAILED 21
#define MOVIERDC_SERVER_PERMISSION_DENIED 22
#define MOVIERDC_SERVER_STARTDEAMONTHREADS_FAILED 23
#define MOVIERDC_SERVER_BADLOCK 24
#define MOVIERDC_SERVER_OUTOFRESOURCE 25
#define MOVIERDC_SERVER_GENERATESIGNATURE_FAILED 26
#define MOVIERDC_SERVER_ALREADY_PRAISE 27
#define MOVIERDC_SERVER_KICKOUT 28
#define MOVIERDC_SERVER_INVALIDACTIVITYPWD 29
#define MOVIERDC_SERVER_ALREADY_EXIST 30
#define MOVIERDC_SERVER_INVALID_SECRET 31
#define MOVIERDC_SERVER_ACTIVITY_FULL 32
#define MOVIERDC_SERVER_NOTMEMBEROFACTIVITY 33
#define MOVIERDC_SERVER_THIRDPARTYACCOUNT_ALREADYREGISTERED 34
#define MOVIERDC_SERVER_ACCOUNT_NOTEXIST 35
#define MOVIERDC_SERVER_INITSESSIONMGR_FAILED 36

#define LOCAL_SESSION_EROOR     300
#define LOCAL_USER_NIL          301
#define MOVIERDC_NETERROR       299



typedef void (^LoginSuccessBlock)(MovierDCInterfaceSvc_VDCSession* ws_session);
typedef void (^LoginFailBlock)(NSNumber *LoginStatus,NSError *error);
typedef void (^GetVideoLabelSucB)(MovierDCInterfaceSvc_VDCVideoLabelExArray* ws_ret); //ws_ret.item 内容是MovierDCInterfaceSvc_VDCVideoLabelEx
typedef void (^GetVideoLabelFB)(NSError *error);
typedef void (^GetCommentsNumB)(NSNumber *totalnum);
typedef void (^SubmitCommentB)();
typedef void (^RemoveCommentB)();
typedef void (^ReportCommentB)();
typedef void (^GetCommentsB)(MovierDCInterfaceSvc_vpVideoCommentArr* comments);
typedef void (^SearchUserBlock)(MovierDCInterfaceSvc_VDCCustomerBaseInfoExArr* array);
typedef void (^SearchVideoB)(MovierDCInterfaceSvc_VDCVideoInfoExArray* array);
typedef void (^SearchMusicBlock)(MovierDCInterfaceSvc_vpVDCMusicExArr * array);
typedef void (^GetOssConfigB)(MovierDCInterfaceSvc_VDCOSSConfig*);
typedef void (^RegisterThirdB)(NSNumber *registerret);
typedef void (^RegisterThirdFailB)(NSError *error,NSNumber* ret);
typedef void (^GetBannerNumB)(NSNumber *num);
typedef void (^GetBanner)(MovierDCInterfaceSvc_VDCBannerInfoArray *);
typedef void (^GetVideosB)(MovierDCInterfaceSvc_VDCVideoInfoExArray *array);  //返回内容是MovierDCInterfaceSvc_VDCVideoInfoEx
typedef void (^GetOrdersB)(MovierDCInterfaceSvc_VDCOrderForQueryArray *array);//MovierDCInterfaceSvc_VDCOrderForQuery
typedef void (^GetTemplateB)(NSNumber *num);
typedef void (^GetTemplateArrayB)(MovierDCInterfaceSvc_VDCTemplateCatArr *array); // 返回内容是 MovierDCInterfaceSvc_TemplateCat 的数组
typedef void (^GetStyleArrayB)(MovierDCInterfaceSvc_vpVDCHeaderAndTailArray *array);
typedef void (^GetStyleB)(MovierDCInterfaceSvc_vpVDCHeaderAndTailExC *style);
typedef void (^GetStyleSuc)(MovierDCInterfaceSvc_vpVDCHeaderAndTailC * styleDetail);
typedef void (^GetStyleNumB)(NSNumber *num);
typedef void (^ReportVideoB)();
typedef void (^GetTotalCollectionB)(NSNumber *num);
typedef void (^GetDefaultInfoWithStyle)(MovierDCInterfaceSvc_vpVDCMusicC*,MovierDCInterfaceSvc_vpVDCSubtitleC*);
typedef void (^SoapErrorB)(NSError *error);
typedef void (^GetVideoColletionB)(MovierDCInterfaceSvc_IDArray*);   //IDArray.itme 下存放 NSNumber* 数组
typedef void (^GetColectionVideosB)(MovierDCInterfaceSvc_VDCVideoInfoExArray* array);    //收藏视频数组  MovierDCInterfaceSvc_VDCVideoInfoEx 数组
typedef void (^GetMusicListB)(MovierDCInterfaceSvc_vpVDCMusicArray* MList); //数组存放内容  MovierDCInterfaceSvc_vpVDCMusicC 数组
typedef void (^GetSubtitleListB)(MovierDCInterfaceSvc_vpVDCSubtitleArray* SList); //数组存放内容  MovierDCInterfaceSvc_vpVDCSubtitleC 数组
typedef void (^GetQueryOrderB)(MovierDCInterfaceSvc_VDCOrderForQueryArray* Olist);//Olist.item MovierDCInterfaceSvc_VDCOrderForQuery
typedef void (^CreateOrderB)(NSNumber* ret);
typedef void (^GetUserInfoB)(MovierDCInterfaceSvc_VDCCustomerInfo* info);
typedef void (^GetTelOKB)(NSNumber* ret,NSNumber *count);
typedef void (^GetPraiseB)(MovierDCInterfaceSvc_IDArray*); //IDArray.itme 下存放 NSNumber* 数组 返回传入收藏查询数组中收藏过的视频id

typedef void (^WSReturnNumberB)(NSNumber* num);
typedef void (^WSRETURNIFHAVEUSERINFO)(MovierDCInterfaceSvc_VDCNewUserScoreTask * isHaveInfo);//存放判断用户相关信息是否存在的信息
typedef void (^WSRETURNISBINDINGINFO)(MovierDCInterfaceSvc_VDCTelAndThirdPartyBindStatusEnv * isBindingInfo);//2016.06.15版接口更改(存放是否绑定的信息)
typedef void (^WSRETURNINTEGRALINFO)(MovierDCInterfaceSvc_VDCMyScoreInshianCoin * integralAndLevelInfo);//2016.06.15添加（返回用户积分等级界面所需信息）
typedef void (^WSRETURNINTEGRALLOG)(MovierDCInterfaceSvc_VDCMyScoreLogArrEnv * integralLogInfo);//2016.06.15添加（返回用户的积分日志）
typedef void (^WSRETURNUSERINTRGRALLOG)(MovierDCInterfaceSvc_VDCMyScoreLogArr * integralInfo);//2016.06.21添加（返回用户积分日志信息）
typedef void (^WSRETURNUSERINFO)(MovierDCInterfaceSvc_VDCCustomerInfoEx * userInfo);
typedef void (^GetCoponB)(NSString* coponURL);
typedef void (^GetLabelInfo)(MovierDCInterfaceSvc_VDCVideoLabelEx* labelinfo);
typedef void (^GetLauchInfo)(MovierDCInterfaceSvc_StringArr* launchinfos);
typedef void (^GETDEVICEINFOPOSTISSUC)(NSNumber * num);
typedef void (^GETFLLOWINFOSENDINFO)(NSNumber * num);
typedef void(^RETURNSTATUSSENDINFO)(NSNumber * num);
typedef void (^RETURNUSERNUMINFO)(NSNumber * num);
typedef void(^RETURNFRIENDLIST)(MovierDCInterfaceSvc_VDCFriendArr * followList);

typedef void(^RETURNAPPVERSIONINFO)(MovierDCInterfaceSvc_AppVersionEx * appVersionInfo);
typedef void(^RETURNSENDINFO)(NSNumber * num);

//默认返回的数据是数组时使用这个block
//返回的是数组
typedef void(^RETURNDATAARRAY)(NSMutableArray * serverDataArray);

//返回的是字典
typedef void(^RETURNDATADICTIONARY)(NSMutableDictionary * serverDataDictionary);

//返回成功信息时使用这个
typedef void(^RETURNSUCCESSINFO)(NSNumber * successInfo);

//返回字符串时用这个
typedef void(^RETURNDATASTRING)(NSString * serverString);

//返回session
typedef void(^RETURNSESSION)(MovierDCInterfaceSvc_VDCSession * sessionInfo);


@interface SoapOperation : NSObject

@property(nonatomic)NSLock *syclock;
@property(nonatomic)NSLock *loginlock;
@property(nonatomic)NSString* usename;
@property(nonatomic)NSString* password;
@property(nonatomic)NSString* appversion;
@property(nonatomic)BOOL    bEncrypt;
@property(nonatomic,retain)NSString* token;
@property(nonatomic,retain)NSString* thirdpartycount;
@property(nonatomic,retain)NSString* openid;
@property(nonatomic,retain)MovierDCInterfaceSvc_VDCSession *WS_Session;


+ (SoapOperation *)Singleton;

//-(void)WS_Login:(NSString*)username Password:(NSString*)pw withVersion:(NSString*)appversion Encrypt:(BOOL)bEncrypt;7
-(void)WS_Login:(NSString *)username Password:(NSString *)pw withVersion:(NSString *)appversion Encrypt:(BOOL)bEncrypt Success:(LoginSuccessBlock)block_suc Fail:(LoginFailBlock)block_fail;
/**
 *@brief:    第三方登陆
 *@param:
 *@param: Success 成功0 新用户  34 已注册
 *@param:Fail 失败回调
 */
-(void)WS_Login:(NSString*)partyAccount ThirdPartyType:(NSString*)type Token:(NSString*)token Openid:(NSString*)openID APPVersion:(NSString*) version SubVersion:(NSString*)subver Success:(LoginSuccessBlock)block_suc Fail:(LoginFailBlock)block_fail;

/** 根据传入的标签id，获取子标签的信息*/
/**
@param:     soap请求的session  Start   开始      Count   数量      Parent  父标签ID,一级目录填0    Success 成功回调   Fail 失败回调
 */
-(void)WS_GetVideoLabel:(MovierDCInterfaceSvc_VDCSession*)session Start:(NSNumber*)offset Count:(NSNumber*)count Parent:(NSNumber*)parent Success:(GetVideoLabelSucB)block_suc Fail:(GetVideoLabelFB)block_fail;

//评论相关
/**
 @brief:    得到视频评论数 @param:    视频ID @param:    Success 成功回调 @param:    Fail 失败回调 */
-(void)WS_GetCommentsNumByVideoid:(NSNumber*)vid Success:(GetCommentsNumB)block_suc Fail:(SoapErrorB)block_fail;
/**
 @brief:    得到视频相关评论 @param:    视频ID @param:    Start开始 @param:    Count数量 @param:    Success 成功回调 @param:    Fail 失败回调
 */
-(void)WS_GetCommentsByVideoid:(NSNumber*)vid Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetCommentsB)block_suc Fail:(SoapErrorB)block_fail;
/**
 @brief:    提交视频评论 @param:    视频ID @param:    Start开始 @param:    Count数量 @param:    Success成功回调 @param:    Fail 失败回调
 */
-(void)WS_SubmitCommentByid:(NSNumber*)vid Session:(MovierDCInterfaceSvc_VDCSession*)ws_session Reply:(NSNumber*)replycommentid Content:(NSString*)cont Success:(SubmitCommentB)block_suc Fail:(SoapErrorB)block_fail;
/**
 @brief:    移除评论 @param:    评论ID @param:    Start开始 @param:    Count   数量   @param:Success 成功回调     @param:Fail 失败回调
 */
-(void)WS_RemoveCommentByid:(NSNumber*)commentid Session:(MovierDCInterfaceSvc_VDCSession*)ws_session Success:(RemoveCommentB)block_suc Fail:(SoapErrorB)block_fail;
/**
 @brief:    举报评论 @param:    评论ID    @param: soapsession @param: 举报类型 @param: 举报原因   @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_ReportCommentByid:(NSNumber*)commentid Session:(MovierDCInterfaceSvc_VDCSession*)ws_session ReportType:(NSNumber*)type Reason:(NSString*)reason Success:(RemoveCommentB)block_suc Fail:(SoapErrorB)block_fail;

//搜索相关
/**
 @brief:    搜索用户 @param:    关键字    @param:    Start开始 @param:    Count   数量 @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_SearchUser:(NSString*)keyword Start:(NSNumber*)offset Count:(NSNumber*)count Success:(SearchUserBlock)block_suc Fail:(SoapErrorB)block_fail;
//搜索相关
/**
 @brief:    搜索视频 @param:    关键字    @param:    Start开始 @param:    Count   数量 @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_SearchVideo:(NSString*)keyword Start:(NSNumber*)offset Count:(NSNumber*)count Success:(SearchVideoB)block_suc Fail:(SoapErrorB)block_fail;
//搜索相关
/**
 @brief:    搜索音乐 @param:    关键字    @param:    Start开始 @param:    Count   数量 @param: Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_SearchMusic:(NSString *)keyword Start:(NSNumber *)offset Count:(NSNumber *)count Success:(SearchMusicBlock)block_suc Fail:(SoapErrorB)block_fail;
//暂时使用这个
//- (NSArray *)WS_SearchMusic:(NSString *)keyword Start:(NSNumber *)offset Count:(NSNumber *)count;
/**
 @brief:    获取banner总数 @param: @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_GetBannerNum:(NSNumber*)labelid Success:(GetBannerNumB)block_suc Fail:(SoapErrorB)block_fail;
/**
 @brief:    获取banner信息 @param: @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_GetBanner:(NSNumber*)labelid Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetBanner)block_suc Fail:(SoapErrorB)block_fail;

/**
 @param:   soapsession 
 @param: Success 成功回调   
 @param:Fail 失败回调
 */
-(void)WS_GetossConfig:(MovierDCInterfaceSvc_VDCSession*)ws_session Success:(GetOssConfigB)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:    第三方注册 
 *@param: 
 *@param: Success 成功0 新用户  34 已注册   
 *@param:Fail 失败回调
 */
-(void)WS_Register:(MovierDCInterfaceSvc_VDCThirdPartyAccountEx*)countinfo Success:(RegisterThirdB)block_suc Fail:(RegisterThirdFailB)block_fail;

/**
 @brief:    手机注册 @param: @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_Register:(NSString *)userName withPassword:(NSString *)userPassword withPhoneNum:(NSString *)userTelephone Success:(RegisterThirdB)block_suc Fail:(SoapErrorB)block_fail;
/**
 @brief:    获取用户密码 @param: @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_GetSecret:(NSString*)account Platform:(NSNumber*)type Openid:(NSString*)openid Token:(NSString*)token  Success:(RegisterThirdB)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:    得到私人视频s 
 *@param: 
 *@param: Success 成功回调   
 *@param:Fail 失败回调
 */
-(void)WS_GetPersonalVideos:(MovierDCInterfaceSvc_VDCSession*)ws_session Customer:(NSNumber*)userid Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetVideosB)block_suc Fail:(SoapErrorB)block_fail;
/**
 @brief:    根据视频label得到视频s @param: @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_GetVideosbyLabel:(MovierDCInterfaceSvc_VDCSession*)ws_session Label:(NSNumber*)labelid Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetVideosB)block_suc Fail:(SoapErrorB)block_fail;

//视频相关
/**
 @brief:    根据视频IDs 得到视频s @param: @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_GetVideosInfo:(MovierDCInterfaceSvc_VDCSession*)ws_session IDarray:(MovierDCInterfaceSvc_IDArray*)array Success:(GetVideosB)block_suc Fail:(SoapErrorB)block_fail;

/**
 @brief:    获取视频模板类型分类总数 @param: @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_GetTemplateNum:(MovierDCInterfaceSvc_VDCSession*)ws_session Success:(GetTemplateB)block_suc Fail:(SoapErrorB)block_fail;

/**
 @brief:    获取视频模板类型分类 @param: @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_GetTemplateCat:(MovierDCInterfaceSvc_VDCSession*)ws_session Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetTemplateArrayB)block_suc Fail:(SoapErrorB)block_fail;

/**
 @brief:    根据category获取模板s @param:CatType 使用GetTemplateCat回调MovierDCInterfaceSvc_TemplateCat.nID查询   @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_GetStylebyCat:(MovierDCInterfaceSvc_VDCSession*)ws_session CatType:(NSNumber*)style Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetStyleArrayB)block_suc Fail:(SoapErrorB)block_fail;

/**
 @brief:    根据Category获取模板数量 @param: @param: Success 成功回调   @param:Fail 失败回调
 */
//-(void)WS_GetHeaderNumbyCat:(MovierDCInterfaceSvc_VDCSession*)ws_session CatType:(NSNumber*)style Success:(GetStyleNumB)block_suc Fail:(SoapErrorB)block_fail;
/**
 @brief:    根据Style获取默认音乐和字幕 @param: @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_GetDefaultInfoUseStyle:(MovierDCInterfaceSvc_VDCSession*)ws_session StyleID:(NSNumber*)styleid Success:(GetDefaultInfoWithStyle)block_suc Fail:(SoapErrorB)block_fail;

/**
 @brief:    举报视频 @param: @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_ReportVideo:(MovierDCInterfaceSvc_VDCSession*)ws_session ReportType:(NSNumber*)type VideoId:(NSNumber*)vid Reason:(NSString*)reportReason Success:(ReportVideoB)block_suc Fail:(SoapErrorB)block_fail;

/**
 @brief:    设置视频收藏状态 @param: ChangeStatus 收藏属性改变 YES 收藏 NO 取消收藏 @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_SetCollectVideo:(MovierDCInterfaceSvc_VDCSession*)ws_session ChangeStatus:(BOOL)bStauts VideoId:(NSNumber*)vid Success:(ReportVideoB)block_suc Fail:(SoapErrorB)block_fail;

/**
 @brief:    得到个人收藏视频数量 @param:ws_session  @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_GetPersonalCollectionNum:(MovierDCInterfaceSvc_VDCSession*)ws_session Success:(GetTotalCollectionB)block_suc Fail:(SoapErrorB)block_fail;

/**
 @brief:    得到个人收藏视频s @param: @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_GetPersonalCollection:(MovierDCInterfaceSvc_VDCSession*)ws_session Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetColectionVideosB)block_suc Fail:(SoapErrorB)block_fail;

/**
 @brief:    查询收藏状态 @param:VideoIds 需要查询收藏状态数组 @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_GetVideoColletionStatus:(MovierDCInterfaceSvc_VDCSession*)ws_session VideoIds:(MovierDCInterfaceSvc_IDArray*)vids Success:(GetVideoColletionB)block_suc Fail:(SoapErrorB)block_fail;

/**
 @brief:    获取音乐列表 @param: @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_GetMusicList:(MovierDCInterfaceSvc_vpQueryCond*)cond Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetMusicListB)block_suc Fail:(SoapErrorB)block_fail;

/**
 @brief:    获取字幕列表 @param: @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_GetSubtitleList:(MovierDCInterfaceSvc_vpQueryCond*)cond Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetSubtitleListB)block_suc Fail:(SoapErrorB)block_fail;

/**
 @brief:    创建订单 @param: vpvdcorder4create @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_CreateOrder:(MovierDCInterfaceSvc_vpVDCOrderForCreate*)orderinfo Success:(CreateOrderB)block_suc Fail:(SoapErrorB)block_fail;

/**
 @brief:    查询未完成订单 @param: ws_session值 @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_QueryOrder:(MovierDCInterfaceSvc_VDCSession*)ws_session Success:(GetQueryOrderB)block_suc Fail:(SoapErrorB)block_fail;
/**
 @brief:    根据订单号查询订单状态 @param: ws_session值 @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_QueryOrder:(MovierDCInterfaceSvc_VDCSession*)ws_session withID:(MovierDCInterfaceSvc_VDCOrderIDArray*)orderids Success:(GetQueryOrderB)block_suc Fail:(SoapErrorB)block_fail;
/**
 *@brief:   根据状态查询订单信息
 */
-(void)WS_GetOrderInfo:(NSArray*)status Customer:(NSNumber*)userid Start:(NSNumber*)offset Count:(NSNumber*)count Success:(GetOrdersB)block_suc Fail:(SoapErrorB)block_fail;
@property(nonatomic)int flagfinish;
@property(nonatomic)int numberOrder;
@property(nonatomic,strong)MovierDCInterfaceSvc_VDCOrderForQueryArray *blocktemp;
/**
 *@brief:    当前登陆的个人信息 
 *@param: 
 *@param: Success 成功回调   
 *@param:Fail 失败回调
 */
-(void)WS_QueryUserInfo:(GetUserInfoB)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:    获取other用户信息
 *@param:
 *@param: Success 成功回调
 *@param:Fail 失败回调
 */
-(void)WS_QueryOtherInfo:(int)userid Success:(GetUserInfoB)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:    修改当前登陆个人信息
 *@param:
 *@param: Success 成功回调
 *@param:Fail 失败回调
 */
-(void)WS_SetUserInfo:(MovierDCInterfaceSvc_VDCCustomerInfo*)baseinfo Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:    电话注册确认/24小时SMS请求数统计 nRet=20 说明已经注册过了
 *@param:  
 *@param: Success 成功回调   
 *@param:Fail 失败回调
 */
-(void)WS_CheckTelphone:(NSString*)phoneNum Success:(GetTelOKB)block_suc Fail:(SoapErrorB)block_fail;
/**
 @brief:    获取视频点赞状态 @param: 视频标签列表 @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_QueryPraiseStatus:(MovierDCInterfaceSvc_IDArray*)videoIds Success:(GetPraiseB)block_suc Fail:(SoapErrorB)block_fail;

/**
 @brief:    设置视频点赞状态 @param: 视频标签列表 @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_SetPraise:(NSNumber*)videoID Status:(BOOL)status  Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail;

/**
 @brief:    增加视频播放数 返回播放次数 @param: 视频标签列表 @param: Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_IncreaseVisit:(NSNumber*)videoID Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail;

/**
 @brief:    得到视频分享数 返回播放次数 @param: 视频标签列表 @param: Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_getVideoShareNum:(NSNumber*)videoID Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail;

/**
 @brief:    增加视频分享数 返回播放次数 @param: 视频标签列表 @param: Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_IncreaseVideoShareNum:(NSNumber*)videoID Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   重置密码
 *@param:   电话号码
 *@param:   短信验证码
 *@param:   新密码
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_ResetPw:(NSString*)phonenum VerfyCode:(NSString*)vCode newCode:(NSString*)newpassword Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   获取优惠券
 *@param:   电话号码
 *@param:   短信验证码
 *@param:   新密码
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_GetCoupon:(NSNumber*)vId Success:(GetCoponB)block_suc Fail:(SoapErrorB)block_fail;


/**
 *@brief:   通过id获取label详细
 *@param:   视频标签ID
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_GetLabelDescric:(NSNumber*)nLabelID Success:(GetLabelInfo)block_suc Fail:(SoapErrorB)block_fail;


/**
 *@brief:   删除个人视频
 *@param:   视频标签ID
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_DeleteVideo:(NSNumber*)vId Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   更改个人视频状态
 *@param:   视频标签ID
 *@param:   公开状态 真 公开   假 非公开
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_ChangeVideoStatus:(NSNumber*)vId Status:(BOOL)videostatus Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   意见反馈
 *@param:   视频标签ID
 *@param:   公开状态 真 公开   假 非公开
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_FeedBack:(MovierDCInterfaceSvc_VDCFeedBack*)feedback Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   首页Launch页面
 *@param:   视频标签ID
 *@param:   公开状态 真 公开   假 非公开
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
-(void)WS_GetLaunchPage:(NSNumber*)launchflag Success:(GetLauchInfo)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   获取视频的风格属性
 */
-(void)WS_GetStylebyVideoId:(NSNumber*)vid Success:(GetStyleB)block_suc Fail:(SoapErrorB)block_fail;
/**
 *@brief:   获取标签所属的风格属性
 */
-(void)WS_GetStylebyLabelId:(NSNumber*)labelid Success:(GetStyleB)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   更改绑定的电话号码(旧版-2016.06.15之前版)
 *@param:   更改后的电话号码
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_UpdateUserTelnum:(NSString *)newTelnum Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   更改绑定的电话号码(新版-2016.06.15版)
 *@param:   更改后的电话号码
 *@param:   用户设置的密码
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_UpdateTelNumEx:(NSString *)newTelNum andPassword:(NSString *)password andSuccess:(WSReturnNumberB)block_suc andFail:(SoapErrorB)block_fail;

/**
 *@brief:   更改第三方账号（微信等）
 *@param:   更改后的微信号
 *@param:   更改的第三方账户平台类型
 *@param:   更改的第三方账户别名
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_Updatethirdpartyaccount:(NSString *)thirdPartyAccount ThirdPartyType:(NSInteger)thirdPartyType PszThirdPartyAccountAlias:(NSString *)thirdPartyAlias Success:(WSReturnNumberB)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   判断用户的部分信息是否存在（绑定的手机号、微信号等)
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_IsCustomerHaveInfoSuccess:(WSRETURNIFHAVEUSERINFO)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   2016.06.15新增获取手机号和第三方账户绑定状态（只返回手机号和三方账户绑定状态）
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_gettelandthirdpartybindstatusWithSuccess:(WSRETURNISBINDINGINFO)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   2016.06.15新增获取用户积分日志
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_GetscorelogWithSuccess:(WSRETURNINTEGRALINFO)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   2016.06.15新增获取用户积分等级等的信息
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_GetmyscoreinshiancoinWithSuccess:(WSRETURNINTEGRALINFO)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   2016.06.21新增得到用户积分日志
 *@param:   请求的数据起始位置
 *@param:   请求的数据个数
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)ws_GetscorelogWithOffest:(NSInteger)offest Count:(NSInteger)dayCount Success:(WSRETURNUSERINTRGRALLOG)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   获取用户信息（2016.06.22新增接口）
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_getcustomerinfoex2WithSuccess:(WSRETURNUSERINFO)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   向后台发送设备信息（2016.07.11新增接口）
 *@param:   operationType 操作类型 传入1时后台保存cid和deviceToken 传入2时后台删除cid和deviceToken
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_operatedevicelistWithOperationType:(NSInteger)operationType Success:(GETDEVICEINFOPOSTISSUC)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   (2016-07-20)取消关注某个人
 *@param:   unfollowCustomeId 取消关注的那个人的CustomeId
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_unfollowWithCustomID:(NSString *)unfollowCustomeId Success:(GETFLLOWINFOSENDINFO)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   （2016-07-20）关注某个人
 *@param:   followCustomeId 关注的那个人的CustomeId
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_followWithCustomID:(NSString *)followCustomeId Success:(GETFLLOWINFOSENDINFO)block_suc Fail:(SoapErrorB)block_fail;


/**
 *@brief:   修改用户设置信息
 *@param:   statusStr 修改后的status（传一个十进制字符串）
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_messagepushonoffWithStatus:(NSString *)statusStr Success:(RETURNSTATUSSENDINFO)block_suc FailL:(SoapErrorB)block_fail;

/**
 *@brief:   获取好友，粉丝，关注的数量
 *@param:   friendType 1表示关注 2好友 3粉丝
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_getfriendamountWithFriendType:(NSInteger)friendType Success:(RETURNUSERNUMINFO)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   获取好友列表
 *@param:   offset 请求开始的位置
 *@param:   count 请求得数量
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_getfriendlistWithOffset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNFRIENDLIST)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   获取粉丝列表
 *@param:   offset 请求开始的位置
 *@param:   count 请求得数量
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_getfunslistWithOffset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNFRIENDLIST)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   获取关注列表
 *@param:   offset 请求开始的位置
 *@param:   count 请求得数量
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_getfollowlistWithOffset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNFRIENDLIST)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   发送私信
 *@param:   targetUserId 目标用户ID
 *@param:   mesContent 私信内容
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_sendprivatemessageWithTargetUserId:(NSString *)targetUserId MesContent:(NSString *)mesContent Success:(RETURNSENDINFO)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   根据手机号判断这个后台是否存在这个用户
 *@param:   telArray 本地通讯录数组
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_searchtelfriendWithTelArray:(NSArray *)telArray Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   搜索好友接口
 *@param:   searchContent 搜索内容
 *@param:   offset 搜索起始位置
 *@param:   count 搜索数量
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_searchfriendWithSearchContent:(NSString *)searchContent Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   获取是否关注当前影片的制作者
 *@param:   userId 要查询的用户id
 *@param:   Success 成功回调 (0-无关系，1-关注，2-好友，3-粉丝)  @param:Fail 失败回调
 */
- (void)WS_getfriendrelationWithUserId:(NSString *)userId Success:(RETURNSUCCESSINFO)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   获取相关用户的影片（用户的全部影片或者私密影片或者公开的影片）(需要传入的参数有用户id、分享类型、偏移量、请求数量)
 *@param:   userId                      要查询的用户id
 *@param:   shareType                   分享类型 (0--私有，1--公有，3-所有影片）
 *@param:   offset                      要查询的起始位置
 *@param:   count                       要查询的影片数量
 *@param:   Success 成功回调(返回的是数组，数组里面装的是每一个影片信息的字典)   @param:Fail 失败回调
 */
- (void)WS_getvideosbyuseridWithUserId:(NSString *)userId ShareType:(NSInteger)shareType Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   获取用户信息（当前登录用户的个人信息或者其他用户的个人信息）（2016-08-03增加）（获得更加详细的用户信息，该接口可以获得影片热度、影片好评等信息）(需要传入的参数有用户的userid)
 *@param:   userId                      要查询的用户id
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_getuserinfoWithUserID:(NSString *)userID Success:(RETURNDATADICTIONARY)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   设置个人信息的接口（上传更新完的个人信息）（需要的参数有session，keyvalue对象）（2016-08-03增加）
 *@param:   userInfoKeyValueArr                修改后的用户信息数组
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_setuserinfoWithKeyValue:(MovierDCInterfaceSvc_VDCKeyValue *)userInfoKeyValue Success:(RETURNSUCCESSINFO)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   设置影片的标题，话题，封面等信息接口（新的影片制作流程中使用）（传入的参数有影片id，影片属性数组）（2016-08-03增加）
 *@param:   videoId                要修改的影片的id
 *@param:   videoAttributeArr      修改后的影片信息数组
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_setvideoinfoWithVideoId:(NSString *)videoId VideoAttributeArr:(NSArray *)videoAttributeArr Success:(RETURNSUCCESSINFO)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   获取首页标签内容（2016-08-11）(需要传入的参数：nVideoLabelLocation（1-表示获取首页顶部标签，2-表示获取首页底部标签）起始位置，请求数量)
 *@param:   videoLabelLocation     需要的数据位置（1-表示获取首页顶部标签，2-表示获取首页底部标签）
 *@param:   offset                 数据的起始位置
 *@param:   count                  数据的数量
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_getvideolabelsexWithVideoLabelLocation:(NSInteger)videoLabelLocation Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   获取首页背景图片
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_gethomepagebackgroundSuccess:(RETURNDATASTRING)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   获取banner列表(需要传入的参数有：nCategory 表示获取的是标签还是话题（1-标签，2-话题）nWhere 话题或标签的ID，nOffset 请求偏移， nCount 请求个数)
 *@param:   category               表示获取的是标签还是话题（1-标签，2-话题）
 *@param:   offset                 数据的起始位置
 *@param:   count                  数据的数量
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_getbannerlistWithCategory:(NSInteger)category Where:(NSString *)labelId Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:  获取收藏的视频(nUserID 获取该用户的收藏影片， nOffset 请求起始偏移地址， nCount 请求个数)
 *@param:   userId                 获取该用户的收藏影片
 *@param:   offset                 数据的起始位置
 *@param:   count                  数据的数量
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_getcollectvideosWithUserId:(NSString *)userId Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:  话题搜索接口（szSearchContent 搜索内容, nOffset 偏移量， nCount 请求数量）
 *@param:   searchContent          话题搜索内容
 *@param:   offset                 数据的起始位置
 *@param:   count                  数据的数量
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_searchtopicsWithSearchContent:(NSString *)searchContent Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   @好友(nVideoID 影片ID, stCustomerIDArr 用户ID数组)
 *@param:   videoId                @好友的那个影片的id
 *@param:   userIdArr              @的所有好友的id的数组
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_atfriendbycustomeridarrWithVideoId:(NSString *)videoId UserIdArr:(NSArray *)userIdArr Success:(RETURNSUCCESSINFO)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   发布影片(nVideoID 影片ID)
 *@param:   videoId                影片的id
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_releasevideoWithVideoId:(NSString *)videoId Success:(RETURNSUCCESSINFO)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   下架影片（nVideoID 影片ID）
 *@param:   videoId                影片的id
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_unreleasevideoWithVideoId:(NSString *)videoId Success:(RETURNSUCCESSINFO)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:  通过话题id获取影片(nTopicsID 话题ID， nOffset 偏移量， nCount 请求数量)
 *@param:   topicsId               话题id
 *@param:   offset                 数据的起始位置
 *@param:   count                  数据的数量
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_getvideosbytopicidWithTopicsId:(NSString *)topicsId Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:  通过父话题获取子话题(nParentID 父话题ID， nOffset 偏移量， nCount 请求数量)
 *@param:   parentId               父话题id
 *@param:   offset                 数据的起始位置
 *@param:   count                  数据的数量
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_gettopicsbyparenttopicWithParentId:(NSString *)parentId Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:  通过影片id获取话题(nVideoID 影片ID， nOffset 偏移量， nCount 请求数量)
 *@param:   videoId                影片ID
 *@param:   offset                 数据的起始位置
 *@param:   count                  数据的数量
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_gettopicsbyvideoidWithVideoId:(NSString *)videoId Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:   获取影片信息
 *@param:   videoId             影片ID
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_getvideoinfoWithVideoId:(NSString *)videoId Success:(RETURNDATADICTIONARY)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:  根据父标签获得子标签（nLabelID 父标签ID，nOffset 起始偏移， nCount 请求个数）
 *@param:   labelId                视屏标签ID
 *@param:   offset                 数据的起始位置
 *@param:   count                  数据的数量
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_getlabelsbyparentidWithLabelId:(NSString *)labelId Offset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:  获取海量获赞的影片信息（nOffset 偏移量，nCount 请求数量）
 *@param:   offset                 数据的起始位置
 *@param:   count                  数据的数量
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_getchallengetaskpraiseWithoffset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail;

/**
 *@brief:  获取挑战任务中海量浏览的影片信息 参数：in 交互凭证， nOffset 偏移量，nCount 请求数量，ret 返回值）
 *@param:   offset                 数据的起始位置
 *@param:   count                  数据的数量
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_getchallengetaskviewWithOffset:(NSInteger)offset Count:(NSInteger)count Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail;


/**
 *@brief:  更新提示
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)WS_getappversionSuccess:(RETURNAPPVERSIONINFO)block_suc Fail:(SoapErrorB)block_fail;

/*****************************************************************
 函数名称：- (void)telRegisterWithTelNum:(NSString *)telNum 
                            Password:(NSString *)password 
                            Success:(RETURNSUCCESSINFO)block_suc 
                            Fail:(SoapErrorB)block_fail;
 函数描述：使用手机号注册接口（2016-09-18增加）
 输入参数：telNum：注册使用的手机号码
         password：注册使用的密码
 输出参数：block_suc：注册成功的block
         block_fail：注册失败的block
 返回值： N/A
 *****************************************************************/
- (void)telRegisterWithTelNum:(NSString *)telNum
                     Password:(NSString *)password
                      Success:(RETURNSUCCESSINFO)block_suc
                         Fail:(SoapErrorB)block_fail;

/*****************************************************************
 函数名称：- (void)thirdpartyregisterWithAccount:(NSString *)accountStr
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
                                          Fail:(SoapErrorB)block_fail;
 函数描述：使用三方平台注册接口（2016-09-18增加）
 输入参数：accountStr：注册使用的三方账户
           password：注册使用的密码
          genderStr：性别
        provinceStr：省份
            cityStr:城市
        nickNameStr:昵称
          avatarStr:头像url
          telNumStr：三方账户绑定的电话号码
           emailStr：三方账户绑定的邮箱账号
  thirtPartyTypeStr:三方账户类型，是微博或者qq或者微信
     thirtyAliasStr：三方账户别名
 输出参数：block_suc：注册成功的block
        block_fail：注册失败的block
 返回值： N/A
 *****************************************************************/
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
                                 Fail:(SoapErrorB)block_fail;

/*****************************************************************
 函数名称：- (void)loginByTelNumWithUSerName:(NSString *)userNameStr
                                  Password:(NSString *)passwordStr
                                   Success:(RETURNSESSION)block_suc
                                      Fail:(SoapErrorB)block_fail;
 函数描述：使用手机号登录接口（2016-09-19增加）
 输入参数：userNameStr:用户名即账号
         passwordStr：密码
 输出参数：block_suc：成功的block
         block_fail：失败的block
 返回值：  N/A
 *****************************************************************/
- (void)loginByTelNumWithUSerName:(NSString *)userNameStr
                         Password:(NSString *)passwordStr
                          Success:(RETURNSESSION)block_suc
                             Fail:(SoapErrorB)block_fail;

/*****************************************************************
 函数名称：- (void)loginByThirdpartyWithThirdpartyAccount:(NSString *)thirdpartyAccountStr
                                         ThirdpartyType:(NSString *)thirdpartyTypeStr
                                                Success:(RETURNSESSION)block_suc
                                                   Fail:(SoapErrorB)block_fail;
 函数描述：三方号登录接口（2016-09-19增加）
 输入参数：thirdpartyAccountStr:三方账号
         thirdpartyTypeStr：密码
 输出参数：block_suc：成功的block
         block_fail：失败的block
 返回值： N/A
 *****************************************************************/
- (void)loginByThirdpartyWithThirdpartyAccount:(NSString *)thirdpartyAccountStr
                                ThirdpartyType:(NSString *)thirdpartyTypeStr
                                       Success:(RETURNSESSION)block_suc
                                          Fail:(SoapErrorB)block_fail;

/*****************************************************************
 函数名称：- (void)getVideosByLabelIdWithLabelId:(NSString *)labelId
                                        Offset:(NSInteger)offset
                                         Count:(NSInteger)count
                                       Success:(RETURNDATAARRAY)block_suc
                                          Fail:(SoapErrorB)block_fail;
 函数描述：通过分类id获取影片（2016-09-19增加）
 输入参数：labelId:分类的id
           offset：搜索的起始位置
            count：搜索的数量
 输出参数：block_suc：成功的block
         block_fail：失败的block
 返回值： N/A
 *****************************************************************/
- (void)getVideosByLabelIdWithLabelId:(NSString *)labelId
                               Offset:(NSInteger)offset
                                Count:(NSInteger)count
                              Success:(RETURNDATAARRAY)block_suc
                                 Fail:(SoapErrorB)block_fail;

/*****************************************************************
 函数名称：- (void)searchVideosByKeyWithSearchText:(NSString *)searchText
                                           Offset:(NSInteger)offset
                                            Count:(NSInteger)count
                                          Success:(RETURNDATAARRAY)block_suc
                                             Fail:(SoapErrorB)block_fail;
 函数描述： 搜索影片接口（2016-09-19增加）
 输入参数：searchText:分类的id
              offset：搜索的起始位置
               count：搜索的数量
 输出参数：block_suc：成功的block
         block_fail：失败的block
 返回值： N/A
 *****************************************************************/
- (void)searchVideosByKeyWithSearchText:(NSString *)searchText
                                 Offset:(NSInteger)offset
                                  Count:(NSInteger)count
                                Success:(RETURNDATAARRAY)block_suc
                                   Fail:(SoapErrorB)block_fail;

/*****************************************************************
 函数名称：- (void)getvideosbyvideoidarrWithIdArray:(NSArray *)idArray Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail;
 函数描述： 根据影片的id数组获得影片信息（2016-09-22增加）
 输入参数：idArray:影片的id数组
 输出参数：block_suc：成功的block
         block_fail：失败的block
 返回值： N/A
 *****************************************************************/
- (void)getvideosbyvideoidarrWithIdArray:(NSArray *)idArray Success:(RETURNDATAARRAY)block_suc Fail:(SoapErrorB)block_fail;

#pragma mark - 登录注册部分

/*****************************************************************
 函数描述：登录接口（2016-09-27增加）
 输入参数：accountStr:登录账号
         passwordStr:密码
         accountType:账户类型（要换绑的账号类型（0-手机、1-微信、2-QQ、3-微博））
 输出参数：block_suc：成功的block
         block_fail：失败的block
 返回值： N/A
 *****************************************************************/
- (void)loginByAccountWithAccount:(NSString *)accountStr Password:(NSString *)passwordStr AccountType:(NSInteger)accountType Success:(RETURNDATADICTIONARY)block_suc Fail:(SoapErrorB)block_fail;

/*****************************************************************
 函数描述：qq注册（2016-09-27增加）
 输入参数：qqAccountStr:注册的qq账号
         qqNicknameStr：qq昵称
         passwordStr：qq加密的密码
         genderStr：性别
         provinceStr：省
         cityStr:市
         nickNameStr：在映像上使用的昵称
         signatureStr：签名
         avatarStr：头像地址
         telNumStr：qq绑定的手机号码
         emailStr：qq绑定的邮箱
 输出参数：block_suc：成功的block
         block_fail：失败的block
 返回值： N/A
 *****************************************************************/
- (void)qqRegisterWithAccount:(NSString *)qqAccountStr QQNickName:(NSString *)qqNicknameStr Password:(NSString *)passwordStr Gender:(NSString *)genderStr Province:(NSString *)provinceStr City:(NSString *)cityStr Nickname:(NSString *)nickNameStr Signature:(NSString *)signatureStr Avatar:(NSString *)avatarStr TelNum:(NSString *)telNumStr Email:(NSString *)emailStr Success:(RETURNSUCCESSINFO)block_suc Fail:(SoapErrorB)block_fail;

/*****************************************************************
 函数描述：微博注册（2016-09-27增加）
 输入参数：accountStr:注册的微博账号
         weiboNicknameStr：微博昵称
         passwordStr：微博加密的密码
         genderStr：性别
         provinceStr：省
         cityStr:市
         nickNameStr：在映像上使用的昵称
         signatureStr：签名
         avatarStr：头像地址
         telNumStr：微博绑定的手机号码
         emailStr：微博绑定的邮箱
 输出参数：block_suc：成功的block
 block_fail：失败的block
 返回值： N/A
 *****************************************************************/
- (void)weiboRegisterWithAccount:(NSString *)accountStr WeiboNickname:(NSString *)weiboNicknameStr Password:(NSString *)passwordStr Gender:(NSString *)genderStr Province:(NSString *)provinceStr City:(NSString *)cityStr Nickname:(NSString *)nicknameStr Signature:(NSString *)signatureStr Avatar:(NSString *)avatarStr TelNum:(NSString *)telNumStr Email:(NSString *)emailStr Success:(RETURNSUCCESSINFO)block_suc Fail:(SoapErrorB)block_fail;

/*****************************************************************
 函数描述：微信注册（2016-09-27增加）
 输入参数：weichatAccountStr:注册的微信账号
         wechatNicknameStr：微信昵称
         passwordStr：微信加密的密码
         genderStr：性别
         provinceStr：省
         cityStr:市
         nickNameStr：在映像上使用的昵称
         signatureStr：签名
         avatarStr：头像地址
         telNumStr：微信绑定的手机号码
         emailStr：微信绑定的邮箱
 输出参数：block_suc：成功的block
 block_fail：失败的block
 返回值： N/A
 *****************************************************************/
- (void)wechatRegisterWithAccount:(NSString *)weichatAccountStr WechatNickname:(NSString *)wechatNicknameStr Password:(NSString *)passwordStr Gender:(NSString *)genderStr Province:(NSString *)provinceStr City:(NSString *)cityStr Nickname:(NSString *)nicknameStr Signature:(NSString *)signatureStr Avatar:(NSString *)avatarStr TelNum:(NSString *)telNumStr Email:(NSString *)emailStr Success:(RETURNSUCCESSINFO)block_suc Fail:(SoapErrorB)block_fail;

/*****************************************************************
 函数描述：获取绑定状态（2016-09-27增加）
 输入参数：N/A
 输出参数：block_suc：成功的block
         block_fail：失败的block
 返回值： N/A
 *****************************************************************/
- (void)getAccountBindStatusSuccess:(RETURNDATADICTIONARY)block_suc Fail:(SoapErrorB)block_fail;

/*****************************************************************
 函数描述：绑定三方账户（2016-09-30增加）
 输入参数：accountStr：要绑定的三方账号
         nicknameStr:要绑定的三方账户昵称
         accountTypeStr:要绑定定的三放账户类型（要换绑的账号类型（0-手机、1-微信、2-QQ、3-微博）
         passwordStr：要绑定的三方的密码
 输出参数：block_suc：成功的block
         block_fail：失败的block
 返回值： N/A
 *****************************************************************/
- (void)bindaccountWithAccount:(NSString *)accountStr Nickname:(NSString *)nicknameStr AccountType:(NSInteger)accountTypeStr Password:(NSString *)passwordStr Success:(RETURNSUCCESSINFO)block_suc Fail:(SoapErrorB)block_fail;

#pragma mark - ar部分

/*****************************************************************
 函数描述：上传经纬度（2016-10-10增加）
 输入参数：longtitude：经度值
         latitude:纬度值
         ra:半径
 输出参数：block_suc：成功的block
         block_fail：失败的block
 返回值： N/A
 *****************************************************************/
-(void)WS_CheckGMLBS:(NSNumber*)longtitude
                 Pos:(NSNumber*)latitude
              Radius:(NSNumber*)ra
             Success:(WSReturnNumberB)block_suc
                Fail:(SoapErrorB)block_fail;

/*****************************************************************
 函数描述：富文本分享（2016-10-11增加）
 输入参数：videoId：影片id
         platform:平台（0-未知， 1-新浪微博，2-qq空间， 3-朋友圈， ...）
         richSnippetsContent:富文本字符串
 输出参数：block_suc：成功的block
         block_fail：失败的block
 返回值： N/A
 *****************************************************************/
- (void)richSnippetsWithVideoId:(NSString *)videoId
                       Platform:(NSInteger)platform
            RichSnippetsContent:(NSString *)richSnippetsContent
                        Success:(RETURNSUCCESSINFO)block_suc
                           Fail:(SoapErrorB)block_fail;

/*****************************************************************
 函数描述：ar分享（2016-10-11增加）
 输入参数：videoId：影片id
         platform:平台（0-未知， 1-新浪微博，2-qq空间， 3-朋友圈， ...）
         richSnippetsContent:富文本字符串
 输出参数：block_suc：成功的block
         block_fail：失败的block
 返回值： N/A
 *****************************************************************/
- (void)arShareWithVideoId:(NSString *)videoId
                  Platform:(NSInteger)platform
       RichSnippetsContent:(NSString *)richSnippetsContent
                   Success:(RETURNSUCCESSINFO)block_suc
                      Fail:(SoapErrorB)block_fail;

#pragma mark - ar(2016-11-09)

/**
 *@brief:   获取ar
 *@param:   getType        获取途径(1-观看获得过奖励的影片 3一键照做摄影时获取AR 4-普通做片摄影时获取AR)
 *@param:   videoId        如果是途径是1，需要传入这个参数，影片id
 *@param:   longitude      如果是途径是3或4，需要传入这个参数，经度
 *@param:   latitude       如果是途径是3或4，需要传入这个参数，纬度
 *@param:   radius         如果是途径是3或4，需要传入这个参数，半径
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)getARWithGetType:(NSInteger)getType
                 VideoId:(NSString *)videoId
               Longitude:(double)longitude
                Latitude:(double)latitude
                  Radius:(NSInteger)radius
                 Success:(RETURNDATADICTIONARY)block_suc
                    Fail:(SoapErrorB)block_fail;

/**
 *@brief:   ar获取宝箱
 *@param:   arId        ar的id
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)getARBoxWithARId:(NSString *)arId
                 Success:(RETURNDATADICTIONARY)block_suc
                    Fail:(SoapErrorB)block_fail;

/**
 *@brief:   ar打开宝箱
 *@param:   boxId        宝箱的id
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)openARBoxWithBoxId:(NSString *)boxId
                   Success:(RETURNDATADICTIONARY)block_suc
                      Fail:(SoapErrorB)block_fail;


#pragma mark - ar(2016-11-15)

/**
 *@brief:   观看获得奖励的影片获取ar
 *@param:   videoId        观看的那个影片的id
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)getARWhenWatchVideoWithVideoId:(NSString *)videoId
                               Success:(RETURNDATADICTIONARY)block_suc
                                  Fail:(SoapErrorB)block_fail;

/**
 *@brief:   摄影时获取ar
 *@param:   longitude        经度
 *@param:   latitude         纬度
 *@param:   radius           半径
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)getARWhenTakeVideoWithType:(NSInteger)getType
                         Longitude:(double)longitude
                          Latitude:(double)latitude
                            Radius:(double)radius
                           Success:(RETURNDATADICTIONARY)block_suc
                              Fail:(SoapErrorB)block_fail;

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
                                           Fail:(SoapErrorB)block_fail;

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
                                Fail:(SoapErrorB)block_fail;

/**
 *@brief:   ar获取宝箱
 *@param:   arLogId        获取ar接口中获取的id
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)getARChestWithLogId:(NSString *)arLogId
                    Success:(RETURNDATADICTIONARY)block_suc
                       Fail:(SoapErrorB)block_fail;

/**
 *@brief:   AR 打开宝箱
 *@param:   chestId        获取宝箱接口中获取宝箱的id
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)openARChestWithChestId:(NSString *)chestId
                       Success:(RETURNDATADICTIONARY)block_suc
                          Fail:(SoapErrorB)block_fail;

/**
 *  获奖信息实时显示
 */
- (void)getRecentRewardInfoWithCount:(NSInteger)count
                             Success:(RETURNDATAARRAY)block_suc
                                Fail:(SoapErrorB)block_fail;

/**
 *  获取用户卡牌
 */
- (void)getUserCardWithSuccess:(RETURNDATAARRAY)block_suc
                          Fail:(SoapErrorB)block_fail;

/**
 *  获取用户奖品
 */
- (void)getARRewardWithSuccess:(RETURNDATAARRAY)block_suc
                          Fail:(SoapErrorB)block_fail;

/**
 *@brief:   AR 卡牌合成
 *@param:   cardIdArray        各个卡牌的id，使用nsnumber保存
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)arCardSyntheticWithCardIdArray:(NSArray *)cardIdArray
                               Success:(RETURNDATADICTIONARY)block_suc
                                  Fail:(SoapErrorB)block_fail;

/**
 *  获得各种券的数量
 */
- (void)getNumOfCouponWithSuccess:(RETURNDATADICTIONARY)block_suc
                             Fail:(SoapErrorB)block_fail;

/**
 *@brief:   获取各种券兑换规则
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)getCouponExchangeRuleWithSuccess:(RETURNDATAARRAY)block_suc
                                    Fail:(SoapErrorB)block_fail;

/**
 *
 */
/**
 *@brief:   ar各种券兑换奖品
 *@param:   couponType      券类型
 *@param:   rewardId       兑换的奖品id
 *@param:   Success 成功回调   @param:Fail 失败回调
 */
- (void)couponExchangeRewardWithTokenType:(NSInteger)couponType
                                 RewareID:(NSString *)rewardId
                                  Success:(RETURNDATADICTIONARY)block_suc
                                     Fail:(SoapErrorB)block_fail;

@end
