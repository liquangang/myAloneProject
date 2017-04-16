//
//  APPUserPrefs.h
//  M-Cut
//
//  Created by zhangxiaotian on 15/1/27.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SMS_SDK/SMSSDK.h> 
#import "CircleQueryLocOrder.h"
#import "GlobalVars.h"
//#import "HomepageVideoOrder.h"
//#import "CollectpageVideoOrder.h"
#import "UIImageView+WebCache.h"
//#import "PersonalInformationSet.h"
//#import "PersonalVideoOrder.h"
#import "FeedBack.h"
//#import "VideoLabel.h"
#import <sqlite3.h>
#import "VideoInformationObject.h"
#import "PrivateLoginCacheInformationObject.h"
#import "App_vpQueryCond.h"
#import "App_vpVDCOrderForCreate.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "Video.h"
#import "App_vpVDCHeaderStyle_C.h"
#import "App_vpVDCFilterStyle_C.h"
#import "App_vpVDCFilter_C.h"
#import "App_vpVDCMusic_C.h"
#import "App_vpVDCSubtitle_C.h"
#import "App_vpVDCHeaderAndTail_C.h"
#import "App_vpVDCFilter.h"
#import "App_vpVDCMusic.h"
#import "App_vpVDCHeaderAndTail.h"
#import "MovierTOrder.h"
//#import "UINavigationController+SGProgress.h"
#import "UMSocial.h"
#import "UserEntity.h"

// 视频评论模型
#import "VideoComment.h"


//订单状态：1.提交完订单。2.订单正在处理中。3.订单处理完成。4.已经推送给用户。
enum OrderStausMask{
    ORDER_STATUS_MASK_NEW_CREATE = 1,
    ORDER_STATUS_MASK_PROCESSING = 2,
    ORDER_STATUS_MASK_FRESH_FINISHED = 4,//状态3
    ORDER_STATUS_MASK_FINISHED = 8//状态4
};
//视频公开状态。0:视频私有、未公开。1:视频公开。2:未公开,但是朋友可以访问。
enum VIDEO_SHARE
{
    VIDEO_SHARE_PRIVATE = 0,
    VIDEO_SHARE_PUBLIC = VIDEO_SHARE_PRIVATE + 1,
    VIDEO_SHARE_FRIEND = VIDEO_SHARE_PUBLIC + 1,
};
//连接方式：1.QQ。2.微信。3.邮箱。4.电话号码。
enum CONTACT_TYPE
{
    CONTACT_TYPE_QQ = 1,
    CONTACT_TYPE_WECHAT = 2,
    CONTACT_TYPE_EMAIL = 3,
    CONTACT_TYPE_TELEPHONE = 4,
};
// 登陆: 0.第一次登陆; 1.登出; 2.登录
enum LOGIN_STATUS
{
    NOW_FRESH = 0,
    NOW_LOGOUT_HASLOGIN = 1,
    NOW_LOGIN = 2,
};

@interface APPUserPrefs : NSObject<UIActionSheetDelegate,MCutTransDelegate>
{
    int currentIndex;//记录订单中已经处理素材的个数
    int currentDB_Home;//当前home页数据库中访问的当前视频ID
    int currentMinGT_Home;//当前home页数据库中视频的最小ID
    int orderID;//订单ID
    bool customerOrderStatus;

    //oss的SDK需要定义的变量。
    NSString *accessKey;
    NSString *secretKey;
    NSString *yourBucket;
    NSString *yourDownloadObjectKey;
    NSString *yourUploadObjectKey;
    NSString *yourUploadDataPath;
    NSString *yourHostId;

    MovierTOrder* order4T;
    
    NSInteger Loginretrytime;//登陆重试次数
}

@property (nonatomic,strong) NSMutableArray *videoInformation;
@property (nonatomic)BOOL wwanable;

//单例方法
+ (APPUserPrefs *)Singleton;

- (PrivateLoginCacheInformationObject *)APP_loginData;//delete arbin
//登录
//输入：用户名、密码
//输出：0成功，非0失败
//- (int)login:(NSString *)szName userPassword:(NSString *)szPwd;

/**
 *  用户第三方登陆, 加密后密码
 *
 *  @param szName  用户名
 *  @param szPwd   密码
 *  @param encrypt 是否加密
 *  0成功，非0失败
 */
- (int)login:(NSString *)szName userPassword:(NSString *)szPwd isEncrypt:(BOOL)encrypt;
-(int)AutoLogin;
//退出登录
//输出：0成功，非0失败
//+ (int)APP_logout;

//标签总数
//输出：视频总数（未用）
//+ (int)APP_getvideolabeltotalnum;
//通过标ID获取对应标签的视频总数
//- (int)APP_getvideototalbylabelid:(int)labelID VideoID:(int)videoID;
//通过标签名获取对应标签的视频总数
//+ (int)APP_getvideototalbylabelname:(NSString *)labelName;
//通过标签ID获取首页视频列表，并写入DB
//- (int)APP_gethomevideotodbbylabelid;
//通过标签ID获取视频列表
//- (NSMutableArray *)APP_getvideobylabelid:(int)labelID StartOf:(int)startOf Count:(int)NumberOfLabel;
//通过标签名字获取视频列表
//+ (NSMutableArray *)APP_getvideobylabelname:(NSString *)labelName StartOf:(int)startOf Count:(int)NumberOfLabel;

//点击赞时通过ID调的函数
//+ (int)APP_praisevideobyid:(int)labelID;
//设置取消点赞
//+ (int)APP_unpraisevideobyid:(int)labelID;
//点击赞时调的函数
//+ (int)APP_praisevideobyname:(NSString *)videoName;
//获得视频是否点赞的状态
//- (int)APP_getpraisestatus:(int)videoID;

//主页视频列表
//- (NSMutableArray *)APP_gethomevideo:(int)startOf Count:(int)NumberOfView LabelType:(int)labeltag;

//通过视频ID来进行收藏或者取消收藏
//- (int)APP_markfavoritebyid:(int)videoID Status:(BOOL)status;
//通过视频名字来进行收藏或者取消收藏
//+ (int)APP_markfavoritebyname:(NSString *)VideoName Status:(BOOL)status;
//通过视频ID获取收藏是否收藏。
//- (int)APP_getfavouritestatus:(int)videoID;

//收藏视频的总数
//+ (int)APP_getfavoritevideototalnum;
//收藏视频列表
//- (int)APP_getfavoritevideo;
//获取收藏视频
//输入：开始视频ID（startOf），获取个数：NumberOfView
//输出：视频列表
//- (NSMutableArray *)APP_getfavoritevideo:(int)startOf Count:(int)NumberOfView;
//获取收藏视频，从数据库读取
//输入：开始视频ID（startOf），获取个数：NumberOfView
//输出：视频列表
//- (NSMutableArray *)APP_getfavoritevideobyDB:(int)startOf Count:(int)NumberOfView;

//反馈意见的接口
//输入：反馈的对象feedBack
//输出：0成功，非0失败
//+ (int)APP_submitfeedback:(FeedBack *)feedBack;

//获得别人视频总数
//输入：反馈的对象feedBack
//输出：0成功，非0失败
//+ (int)APP_gettotalnumofvideoforhomepage:(int)customerID VideoID:(int)videoID;
//获得别人视频列表
//输入：用户ID（customerID），开始视频ID（startOf），获取个数：NumberOfView
//调用 soap接口
//输出：视频列表
//- (NSMutableArray *)soap_getpersonalvideo:(int)customerID Start:(int)startOf Count:(int)NumberOfView;



//获得自己视频总数
//- (int)APP_getprivatepersonvideo;
//从数据库获取个人视频列表
//输入：开始位置（startOf），请求个数（NumberOfView）
//输出：获取的视频数组
//- (NSMutableArray *)APP_getprivatepersonvideobyDB:(int)startOf Count:(int)NumberOfView;
//删除个人视频
//输入：视频对象ID（nVideoID）
//输出：0成功，非0失败
//- (int)APP_delateprivatepersonvideo:(int)nVideoID;
//更改视频的公开状态
//输入：视频对象ID（nVideoID），更新的视频公开状态（videoStatus）
//输出：0成功，非0失败
//- (int)APP_updatevideostatus:(int)nVideoID VideoStatus:(BOOL)videoStatus;
//视频对象从首页数据库中删除
//输入：插入的视频对象ID（nVideoID）
//输出：0成功，非0失败
//- (int)APP_deletevideofromhome:(int)nVideoID;
//视频对象插入到首页数据库中
//输入：插入的视频对象（videoInformationObject）
//输出：0成功，非0失败
//- (int)APP_insertvideofromhome:(VideoInformationObject *)videoInformationObject;

//设置个人信息
//+ (int)APP_updatecustomerinfo:(PersonalInformationSet *)personalInformationSet;
//返回个人信息
//+ (PersonalInformationSet *)APP_getcustomerinfoex;

//+ (PersonalInformationSet *)APP_getothercustomerinfo:(int)szCustomerID;

//获取选择的类别对象总数
//输入：选择类型（nType），选择条件（app_vpQueryCond）
//输出：选择的类别对象总数
//- (int)APP_getvpelementtotalnum:(int)nType QueryCond:(App_vpQueryCond *)app_vpQueryCond;
//获取片头片尾风格对象总数
//输出：片头片尾风格对象总数
//- (int)APP_vpgetheaderstyletotalnum;
//获取片头片尾风格对象数组
//输入：开始位置（noffset），获取个数（ncount）
//输出：片头片尾风格对象数组
//- (NSMutableArray *)APP_vpgetheaderstyle:(int)nOffset Ncount:(int)ncount;
//获取片头片尾对象数组
//输入：选择条件（app_vpQueryCond），开始位置（noffset），获取个数（ncount）
//输出：片头片尾对象数组
//- (NSMutableArray *)APP_vpgetheaderandtail:(App_vpQueryCond *)app_vpQueryCond Noffset:(int)noffset Ncount:(int)ncount;
//获取滤镜风格对象总数
//输出：滤镜风格对象总数
//- (int)APP_vpgetfilterstyletotalnum;
//获取滤镜风格对象数组
//输入：开始位置（noffset），获取个数（ncount）
//输出：滤镜风格对象数组
//- (NSMutableArray *)APP_vpgetfilterstyle:(int)noffset Ncount:(int)ncount;
//获取滤镜对象数组
//输入：选择条件（app_vpQueryCond），开始位置（noffset），获取个数（ncount）
//输出：滤镜对象数组
//- (NSMutableArray *)APP_vpgetfilter:(App_vpQueryCond *)app_vpQueryCond Noffset:(int)noffset Ncount:(int)ncount;
//获取音乐对象数组
//输入：选择条件（app_vpQueryCond），开始位置（noffset），获取个数（ncount）
//输出：音乐对象数组
//- (NSMutableArray *)APP_vpgetmusic:(App_vpQueryCond *)app_vpQueryCond Noffset:(int)noffset Ncount:(int)ncount;
//获取字幕对象数组
//输入：选择条件（app_vpQueryCond），开始位置（noffset），获取个数（ncount）
//输出：字幕对象数组
//- (NSMutableArray *)APP_vpgetsubtitle:(App_vpQueryCond *)app_vpQueryCond Noffset:(int)noffset Ncount:(int)ncount;
//通过片头片尾ID获取对应的App_vpVDCHeaderAndTail对象
//输入：片头片尾ID（nFilterID）
//输出：App_vpVDCHeaderAndTail对象
//- (App_vpVDCHeaderAndTail *)APP_vpgetstylebyid:(int)nStyleID;
//通过滤镜ID获取对应的App_vpVDCFilter对象
//输入：滤镜ID（nFilterID）
//输出：App_vpVDCFilter对象
//- (App_vpVDCFilter *)APP_vpgetfilterbyid:(int)nFilterID;
//通过音乐ID获取对应的App_vpVDCMusic对象
//输入：音乐ID（nFilterID）
//输出：App_vpVDCMusic对象
//- (App_vpVDCMusic *)APP_vpgetmusicbyid:(int)nFilterID;
//通过字幕ID获取对应的App_vpVDCSubtitle_C对象
//输入：字幕ID（nFilterID）
//输出：App_vpVDCSubtitle_C对象
//- (App_vpVDCSubtitle_C *)APP_vpgetsubtitlebyid:(int)nFilterID;


//判断网络状态
//输出：3g/wifi
//-(NSString*)GetCurrntNet;
//举报视频
//输入：视频ID（nVideoID），举报类型（nCategory），举报描述（Remark）
//输出：0成功，非0失败
//- (int)App_userReport:(int)nVideoID Category:(int)nCategory PszRemark:(NSString *)Remark;
//检测电话号码是否可用
//输入：电话号码（szTelephoneNum）
//输出：0可用，非0不可用
//- (int)APP_Checktelnumusability:(NSString *)szTelephoneNum;
//重置密码
//输入：地区区号（szCode），电话号码（szTelephoneNum），密码（szPassword）
//输出：0成功，非0失败
//- (int)APP_Resetpasswordusingtel:(NSString *)szCode TelephoneNum:(NSString *)szTelephoneNum Password:(NSString *)szPassword;


//获得图片沙盒地址
//输入：url地址
//输出：本地url地址
- (NSString *)APP_getImg:(NSString *)url;
//获取图片
//输入：图片文件的url（url），UIImageView对象（imageView），默认图片文件的名字（imagename）
//输出：UIImage图片对象
- (UIImage *)APP_getImg:(NSString *)url ImageView:(UIImageView *)imageView ImageName:(NSString *)imagename;
//图片数据写入沙盒
//输入：图片对象，数据文件路径filePath
//输出：0成功，非0失败
- (int)APP_WriteToFile:(UIImage *)image FilePath:(NSString *)filePath;


//打开创建数据库
//+(BOOL)openOrCreateDatabase:(NSString*)DbName;

//登录页数据库插入操作
//输入：登录页视频对象privateLoginCacheInformationObject
//输出：0成功，非0失败
//- (int)APP_LoginCacheInformationDBInsert:(PrivateLoginCacheInformationObject *)privateLoginCacheInformationObject;
//登录页数据库删除操作
//输入：登录页视频对象privateLoginCacheInformationObject
//输出：0成功，非0失败
//- (int)APP_LoginCacheInformationDBDelete:(PrivateLoginCacheInformationObject *)privateLoginCacheInformationObject;
//登录页数据库修改操作
//输入：登录页视频对象privateLoginCacheInformationObject
//输出：0成功，非0失败
//- (int)APP_LoginCacheInformationDBChange:(PrivateLoginCacheInformationObject *)privateLoginCacheInformationObject;
//登录页数据库查找操作
//输出：最近登录的数据PrivateLoginCacheInformationObject对象
- (PrivateLoginCacheInformationObject *)APP_LoginCacheInformationDBSearch;
//登录页数据库查找操作
//输入：用户名UserName
//输出：最近登录的数据PrivateLoginCacheInformationObject对象
//- (PrivateLoginCacheInformationObject *)APP_LoginCacheInformationDBSearch:(NSString *)UserName;


//首页数据库插入操作
//输入：首页视频对象videoInformationObject
//输出：0成功，非0失败
//- (int)APP_HomePageVideoCacheInformationDBInsert:(VideoInformationObject *)videoInformationObject;
//首页数据库删除操作（删除全部）
//输出：0成功，非0失败
//- (int)APP_HomePageVideoCacheInformationDBDelete;
//首页数据库删除操作
//输入：首页视频对象videoInformationObject
//输出：0成功，非0失败
//- (int)APP_HomePageVideoCacheInformationDBDelete:(VideoInformationObject *)videoInformationObject;
//首页数据库删除操作
//输入：首页视频对象ID（nVideoID）
//输出：0成功，非0失败
//- (int)APP_HomePageVideo_PersonCacheInformationDBDelete:(int)nVideoID;
//首页数据库搜索操作
//输入：首页视频对象videoInformationObject
//输出：0有，非0无
//- (int)APP_HomePageVideoCacheInformationDBChange:(VideoInformationObject *)videoInformationObject;
//- (int)APP_HomePageVideoCacheInformationDBUpdate:(NSString *)name CustomerID:(int)ID;
//首页数据库搜索操作
//输入：首页视频对象videoInformationObject
//输出：首页视频对象videoInformationObject
//- (VideoInformationObject *)APP_HomePageVideoCacheInformationDBSearch:(VideoInformationObject *)videoInformationObject;
//首页数据库搜索操作
//输入：首页视频对象videoInformationObject
//输出：首页视频对象videoInformationObject
//- (VideoInformationObject *)APP_HomePageCurrentVideoCacheInformationDBSearch:(VideoInformationObject *)videoInformationObject;
//首页数据库搜索操作（未使用）
//- (NSMutableArray *)APP_HomePageVideoCacheInformationDBSearch:(int)startNumber EndNumber:(int)endNumber CountNumber:(int)countNumber;
//首页数据库搜索操作
//输出：首页视频数据库中视频总数
//- (int)APP_CountOfHomePageVideoCacheInformationDBSearch;
//首页数据库搜索操作
//输出：首页视频数据库中视频最小ID
//- (int)APP_MinOfHomePageVideoCacheInformationDBSearch;
//首页数据库搜索操作
//输出：首页视频数据库中视频最大ID
//- (int)APP_MaxOfHomePageVideoCacheInformationDBSearch;


//收藏页数据库插入操作
//输入：收藏页视频对象videoInformationObject
//输出：0成功，非0失败
//- (int)APP_CollectPageVideoCacheInformationDBInsert:(VideoInformationObject *)videoInformationObject;
//收藏页数据库删除操作（删除全部）
//输出：0成功，非0失败
//- (int)APP_CollectPageVideoCacheInformationDBDelete;
//收藏页数据库删除操作
//输入：收藏页视频对象ID
//输出：0成功，非0失败
//- (int)APP_CollectPageVideoCacheInformationDBDeleteForID:(int)nVideoID;
//收藏页数据库删除操作
//输入：收藏页视频对象videoInformationObject
//输出：0成功，非0失败
//- (int)APP_CollectPageVideoCacheInformationDBDelete:(VideoInformationObject *)videoInformationObject;
//收藏页数据库修改操作
//输入：收藏页视频对象videoInformationObject
//输出：0成功，非0失败
//- (int)APP_CollectPageVideoCacheInformationDBChange:(VideoInformationObject *)videoInformationObject;
//- (int)APP_CollectPageVideoCacheInformationDBUpdate:(NSString *)name CustomerID:(int)ID;
//收藏页数据库搜索操作
//输入：收藏页视频对象videoInformationObject
//输出：收藏页视频对象videoInformationObject
//- (VideoInformationObject *)APP_CollectPageVideoCacheInformationDBSearch:(VideoInformationObject *)videoInformationObject;
//收藏页数据库搜索操作（未使用）
//- (NSMutableArray *)APP_CollectPageVideoCacheInformationDBSearch:(int)startNumber EndNumber:(int)endNumber CountNumber:(int)countNumber;
//收藏页数据库搜索操作
//输出：收藏页视频数据库中视频总数
//- (int)APP_CountOfCollectPageVideoCacheInformationDBSearch;
//收藏页数据库搜索操作
//输出：收藏页视频数据库中视频最小ID
//- (int)APP_MinOfCollectPageVideoCacheInformationDBSearch;
//收藏页数据库搜索操作
//输出：收藏页视频数据库中视频最大ID
//- (int)APP_MaxOfCollectPageVideoCacheInformationDBSearch;


//个人页数据库插入操作
//输入：个人页视频对象videoInformationObject
//输出：0成功，非0失败
//- (int)APP_PrivatePageVideoCacheInformationDBInsert:(VideoInformationObject *)videoInformationObject;
//个人页数据库删除操作（删除全部）
//输出：0成功，非0失败
//- (int)APP_PrivatePageVideoCacheInformationDBDelete;
//个人页数据库删除操作
//输入：个人页视频对象videoInformationObject
//输出：0成功，非0失败
//- (int)APP_PrivatePageVideoCacheInformationDBDelete:(VideoInformationObject *)videoInformationObject;
//个人页数据库修改操作
//输入：个人页视频对象videoInformationObject
//输出：0成功，非0失败
//- (int)APP_PrivatePageVideoCacheInformationDBChange:(VideoInformationObject *)videoInformationObject;
//- (int)APP_PrivatePageVideoCacheInformationDBUpdate:(NSString *)name CustomerID:(int)ID;
//个人页数据库搜索操作
//输入：个人页视频对象videoInformationObject
//输出：个人页视频对象videoInformationObject
//- (VideoInformationObject *)APP_PrivatePageVideoCacheInformationDBSearch:(VideoInformationObject *)videoInformationObject;
//个人页数据库搜索操作（未使用）
//- (NSMutableArray *)APP_PrivatePageVideoCacheInformationDBSearch:(int)startNumber EndNumber:(int)endNumber CountNumber:(int)countNumber;
//个人页数据库搜索操作
//输出：个人页视频数据库中视频总数
//- (int)APP_CountOfPrivatePersonCacheInformationDBSearch;
//个人页数据库搜索操作
//输出：个人页视频数据库中视频最小ID
//- (int)APP_MinOfPrivatePersonCacheInformationDBSearch;
//个人页数据库搜索操作
//输出：个人页视频数据库中视频最大ID
//- (int)APP_MaxOfPrivatePersonCacheInformationDBSearch;

//订单数据库插入操作
//输入：订单对象newNSOrderDetail
//输出：0成功，非0失败
//- (int)APP_OrderDetailCacheInformationDBInsert:(NewNSOrderDetail *)newNSOrderDetail;
//订单数据库删除操作
//输入：订单对象newNSOrderDetail
//输出：0成功，非0失败
//- (int)APP_OrderDetailCacheInformationDBDelete:(NewNSOrderDetail *)newNSOrderDetail;
//订单数据库删除操作（全部）
//输出：0成功，非0失败
//- (int)APP_OrderDetailCacheInformationDBDelete;
//订单数据库删除操作
//输入：订单对象newNSOrderDetail
//输出：0成功，非0失败
//- (int)APP_OrderDetailSelect_CacheInformationDBDelete:(NewNSOrderDetail *)newNSOrderDetail;
//订单数据库修改操作
//输入：订单对象newNSOrderDetail
//输出：0成功，非0失败
//- (int)APP_OrderDetailCacheInformationDBChange:(NewNSOrderDetail *)newNSOrderDetail;
//订单数据库修改操作
//输入：订单对象newNSOrderDetail
//输出：订单对象newNSOrderDetail
//- (NewNSOrderDetail *)APP_OrderDetailCacheInformationDBSearch:(NewNSOrderDetail *)newNSOrderDetail;
//订单数据库查找操作
//输出：所有订单数组
//- (NSMutableArray *)APP_OrderDetailCacheInformationDBSearch;
//订单数据库查找操作（customer = 0 and order_st = 0）
//输出：所有订单数组
//- (NSMutableArray *)APP_OrderDetail_Custerm0_CacheInformationDBSearch;
//订单数据库查找操作（customer = ID and order_st = 0）
//输出：所有订单数组
//- (NSMutableArray *)APP_OrderDetail_Custerm1_CacheInformationDBSearch:(int)value;
//订单数据库查找操作（customer = ID and order_st = 1）
//输出：所有订单数组
//- (NSMutableArray *)APP_OrderDetailQueryCacheInformationDBSearch:(int)value;


//订单素材数据库插入操作
//输入：订单素材对象newOrderVideoMaterial
//输出：0成功，非0失败
//- (int)APP_MaterialCacheInformationDBInsert:(NewOrderVideoMaterial *)newOrderVideoMaterial;
//订单素材数据库删除操作
//输入：订单素材对象newOrderVideoMaterial
//输出：0成功，非0失败
//- (int)APP_MaterialCacheInformationDBDelete:(NewOrderVideoMaterial *)newOrderVideoMaterial;
//订单素材数据库删除操作（全部删除）
//输出：0成功，非0失败
//- (int)APP_MaterialCacheInformationDBDelete;
//订单素材数据库删除操作（同一订单）
//输入：订单创建时间：createTime，素材索引：material_index
//输出：0成功，非0失败
//- (int)APP_MaterialCacheInformationDBDelete:(int)createTime Material_Index:(int)material_index;
//订单素材数据库修改操作
//输入：订单素材对象newOrderVideoMaterial
//输出：0成功，非0失败
//- (int)APP_MaterialCacheInformationDBChange:(NewOrderVideoMaterial *)newOrderVideoMaterial;
//- (int)APP_MaterialCacheInformationDBChange1:(NewOrderVideoMaterial *)newOrderVideoMaterial;
//订单素材数据库查找操作
//输入：订单素材对象newOrderVideoMaterial
//输出：订单素材对象newOrderVideoMaterial
//- (NewOrderVideoMaterial *)APP_MaterialCacheInformationDBSearch:(NewOrderVideoMaterial *)newOrderVideoMaterial useindex:(int)index;
//订单素材数据库查找操作
//输入：订单素材对象newOrderVideoMaterial
//输出：订单素材对象数组
//- (NSMutableArray *)APP_MaterialArrCacheInformationDBSearch:(NewOrderVideoMaterial *)newOrderVideoMaterial;
//订单素材数据库查找操作
//输入：订单id：value
//输出：订单素材对象数组
//+ (NSMutableArray *)APP_MaterialArrQueryCacheInformationDBSearch:(int)value;
//订单素材数据库查找操作
//输入：素材名filename
//输出：订单素材对象newOrderVideoMaterial
//+ (NewOrderVideoMaterial *)APP_MaterialArrQueryCacheInformationDBSearchforid:(NSString *)filename;

//云端图片数据库插入操作
//输入：云端图片url（ossImgUrl），本地图片url：（locImgUrl）
//输出：0成功，非0失败
//- (int)APP_OssImgCacheInformationDBInsert:(NSString *)ossImgUrl LocImgUrl:(NSString *)locImgUrl;
//云端图片数据库删除操作
//输出：0成功，非0失败
//- (int)APP_OssImgCacheInformationDBDelete;
//云端图片数据库查找操作
//输入：云端图片url（ossImgUrl）
//输出：本地图片url：（locImgUrl）
//- (NSString *)APP_OssImgCacheInformationDBSearch:(NSString *)ossImgUrl;

#pragma mark ------- 转发---------
/** 获得转发数 */
//- (int)APP_getShareNumByVideoID:(int)videoID;
/** 转发一条视频, 0成功, 其他失败  */
//- (int)APP_increaseShareNumByVideoID:(int)videoID;

#pragma mark ------- 视频播放次数---
/** 点击视频播放次数加1, 返回-1失败, 其他值是视频的播放总次数 */
//- (int)APP_setVideoPlayNumByVideoID:(int)videoID;
#pragma mark ------- -------------


-(void)StartOrderT;    // 开启个人线程
-(void)EndOrderT;       //关闭个人线程

/** 保存是否保留原声*/
@property (nonatomic, assign) BOOL isKeepVoice;
@end
