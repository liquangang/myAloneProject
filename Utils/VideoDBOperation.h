//
//  DBOperation.h
//  M-Cut
//
//  Created by Crab00 on 15/10/8.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "VideoInformationObject.h"
#import "App_vpVDCOrderForCreate.h"
#import "MovierDCInterfaceSvc.h"

//消息对象类
#import "MessageObj.h"
#import "FriendModel.h"
#import "PrivateMesObj.h"
@class UploadMaterialModel;

// 定义分享内容表的相关内容
#define SHARETABLE                 @"TABLE_SHARE"
#define shareID                    @"shareID"
#define shareUserID                @"shareUserID"
#define shareVideoID               @"shareVideoID"
#define shareSourceType            @"shareSourceType"
#define shareContent               @"shareContent"
#define shareCellHeight            @"shareCellHeight"
#define shareIsShowPlayButtonImage @"shareIsShowPlayButtonImage"
#define shareImageUrl              @"shareImageUrl"
#define shareVideoUrl              @"shareVideoUrl"

//消息表字段名称
#define DSTCONTENT              @"dstcontent"       //被评论内容的内容体
#define DSTCONTENTID            @"dstcontentid"     //被评论内容的id，即a回复b的评论，此处是b的评论内容id
#define DSTCUSTOMERID           @"dstcustomerid"    //收到消息的用户id，即被评论、被回复、被点赞等的那个用户id
#define LINKLABELID             @"linklabelid"      //系统消息的视频labelid
#define LINKTYPE                @"linktype"         //链接类型，根据它来判断使用linkurl或者linklabelid获取系统消息内容
#define LINKURL                 @"linkurl"          //系统消息的链接url
#define SRCAVATAR               @"srcavatar"        //点赞、评论、回复的那个用户的头像url
#define SRCCONTENT              @"srccontent"       //点赞、评论、回复等的内容体
#define SRCCONTENTID            @"srccontentid"     //点赞、评论、回复等内容的id
#define SRCCUSTOMERID           @"srccustomerid"    //点赞、评论、回复的那个用户的id
#define SRCNICKNAME             @"srcnickname"      //点赞、评论、回复的那个用户的昵称
#define TERM                    @"term"             //术语，用来判断是什么类型的消息
#define TIME                    @"time"             //点赞、评论、回复产生的那个时间
#define MESVIDEOID              @"videoid"          //被点赞、评论、回复的那个影片的videoid
#define VIDEOLABELID            @"videolabelid"     //被点赞、评论、回复的那个影片的话题id
#define MESVIDEOLABELNAME       @"videolabelname"   //被点赞、评论、回复的那个影片的话题name
#define MESVIDEONAME            @"videoname"        //被点赞、评论、回复的那个影片的videoname
#define VIDEOTHUMBNAIL          @"videothumbnail"   //被点赞、评论、回复的那个影片的videothumbnail
#define MESVIDEOURL             @"videourl"         //被点赞、评论、回复的那个影片的url
#define ISREAD                  @"isRead"           //这条消息有没有被读过(0是未读，1是读过)

//用户新影片提示表相关宏定义
#define USERNOPLAYVIDEOTABLE    @"Tab_newVideoPropmt"
#define LOGINUSERID             @"loginUserId"
#define ISPLAY                  @"isPlay" //0是未观看，1是已观看

//消息通知部分术语
#define PRAISETERM @"赞了您的影片"
#define COMMENTSTERM @"评论了您的影片"
#define CARETERM @"关注了您"
#define COLLECTTERM @"收藏了您的影片"
#define NEWVIDEOTERM @"您的大片已上映"
#define FRIENDMESSAGETERM @"给您发了一条私信"
#define SYSTEMMESTERM @"系统通知"
#define REPLYTERM @"回复了您的评论"
#define ATFRIENDTERM @"@了你"
#define UNRELEASE2VIDEOOWNERTERM @"您发布的影片被管理员下架"
#define UNRELEASE2REPORTTERM @"您举报的影片被管理员下架"

#pragma mark - 好友部分

//好友表的名称
#define FRIENDTAB               @"Tab_Friend"

//好友表字段名
#define FRIENDID                @"id"                     //这条数据的id
#define FRIENDUSERID            @"userId"                 //好友或粉丝或关注的用户id
#define FRIENDHEADURL           @"iconURL"                //好友或粉丝或关注的头像url
#define FRIENDNICKNAME          @"nickName"               //好友或粉丝或关注的昵称
#define FRIENDVIDEONUM          @"videoNum"               //好友或粉丝或关注的那个用户的视频数量
#define FRIENDVIDEOCOLLECTTIMES @"videoCollectTimes"      //好友或粉丝或关注的那个用户的视频被收藏的数量
#define FRIENDSIGNATURE         @"signature"              //好友或粉丝或关注的那个用户的签名
#define FRIENDTYPE              @"friendType"             //标注是好友或者粉丝或者关注，该字段直接填汉字，不用数字代替
#define FRIENDWITHWHO           @"toUserId"               //这个用户的好友或者粉丝或者关注了前面的userId

#pragma mark - 好友私信表

#define FRIENDMESTAB            @"Tab_FriendMessage"            //好友私信表名称
#define FRIENDMESID             @"id"                           //每条数据的id
#define FRIENDMESSTARTUSER      @"mesStartId"                   //产生这条消息的人
#define FRIENDMESENDUSERID      @"mesEndId"                     //私信接收者
#define FRIENDSTARTUSERNICKNAME @"startUserNickName"            //产生消息的人的昵称
#define FRIENDMESREADSTATUS     @"readStatus"                   //查看状态(0是未读，1是已、读)
#define FRIENDMESCONTENT        @"mesContent"                   //消息内容字符串
#define FRIENDHEADIMAGEURL      @"startUserIconUrl"             //消息发起者的头像url
#define FRIENDMESSTARTTIME      @"time"                         //消息产生的时间

#define UPLOADMATERIALTAB       @"Tab_uploadMaterial"           //上传table
#define UPLOADMATERIALID        @"ID"                           //id
#define UPLOADMATERIALASSETURL  @"assetURL"
#define UPLOADMATERIALLOCALURL  @"localURL"
#define UPLOADMATERIALSTATUS    @"status"                       //文件状态
#define UPLOADMATERIALCREATETIME @"createTime"                  //上传时间
#define UPLOADMATERIALCONTENTSIZE @"contentsize"                //文件大小
#define UPLOADMATERIALFILENAME  @"fileName"                     //苹果系统提供的文件名
#define UPLOADMATERIALYUNFILENAME @"yunFileName"                //阿里云的文件夹名称

@class TuwenOBJ;

@interface VideoDBOperation : NSObject
{
    FMDatabase *db_movier;//全局唯一
    NSString *alphaDBpath;
    NSLock *theLock;//控制db_movier open close 线程安全
}
+ (VideoDBOperation *)Singleton;
-(void)CreateTable;

//获取视频信息
//得到视频数据内容
-(VideoInformationObject*)FindVideo:(int)videoid;
-(MovierDCInterfaceSvc_VDCVideoInfoEx*)WS_FindVideo:(int)videoid;
-(NSMutableArray*)GetVideo:(int)start VideoCount:(int)count;

//新建视频表
-(void)TABLE_NewVideo;

#pragma mark --- -------------------

/**  新增 visitCount 字段 */
//增加视频数据 vId：视频ID  Vname：视频名称 ownerid：视频所属用户id ownername：视频所属用户名 ownerpic：视频所属用户头像  。。。。待补充
-(void)AddVideo:(int)vId Vname:(NSString*)vName Ownerid:(int)ownerid OwnerName:(NSString*)ownername OwnerPic:(NSString*)ownerpic VideoLabelName:(NSString*)labelname VideoCreateTime:(NSString*)createtime Thumbnail:(NSString*)thumbnail videoURL:(NSString*)videourl Praise:(int)praise Share:(int)share Favourite:(int)favourite Comment:(int)comments CollectStatus:(int)collectstatus ShareStatus:(int)sharestatus Signature:(NSString*)signature currentUser:(int)currentid videoVisitCount:(int)visitCount;

/**  新增 visitCount 字段 */
//修改视频数据 vId：视频ID  Vname：视频名称 ownerid：视频所属用户id ownername：视频所属用户名 ownerpic：视频所属用户头像  。。。。待补充
-(void)ModefyVideo:(int)vId Vname:(NSString*)vName Ownerid:(int)ownerid OwnerName:(NSString*)ownername OwnerPic:(NSString*)ownerpic VideoLabelName:(NSString*)labelname VideoCreateTime:(NSString*)createtime Thumbnail:(NSString*)thumbnail videoURL:(NSString*)videourl Praise:(int)praise Share:(int)share Favourite:(int)favourite Comment:(int)comments CollectStatus:(int)collectstatus ShareStatus:(int)sharestatus Signature:(NSString*)signature currentUser:(int)currentid videoVisitCount:(int)visitCount;

#pragma mark --- -------------------

//增加视频数据 vId：视频ID  Vname：视频名称 ownerid：视频所属用户id ownername：视频所属用户名 ownerpic：视频所属用户头像  。。。。待补充
-(void)AddVideo:(int)vId Vname:(NSString*)vName Ownerid:(int)ownerid OwnerName:(NSString*)ownername OwnerPic:(NSString*)ownerpic VideoLabelName:(NSString*)labelname VideoCreateTime:(NSString*)createtime Thumbnail:(NSString*)thumbnail videoURL:(NSString*)videourl Praise:(int)praise Share:(int)share Favourite:(int)favourite Comment:(int)comments CollectStatus:(int)collectstatus ShareStatus:(int)sharestatus Signature:(NSString*)signature currentUser:(int)currentid;

//修改视频数据 vId：视频ID  Vname：视频名称 ownerid：视频所属用户id ownername：视频所属用户名 ownerpic：视频所属用户头像  。。。。待补充
-(void)ModefyVideo:(int)vId Vname:(NSString*)vName Ownerid:(int)ownerid OwnerName:(NSString*)ownername OwnerPic:(NSString*)ownerpic VideoLabelName:(NSString*)labelname VideoCreateTime:(NSString*)createtime Thumbnail:(NSString*)thumbnail videoURL:(NSString*)videourl Praise:(int)praise Share:(int)share Favourite:(int)favourite Comment:(int)comments CollectStatus:(int)collectstatus ShareStatus:(int)sharestatus Signature:(NSString*)signature currentUser:(int)currentid;

//删除视频数据
-(void)DeleteVideo:(int)videoid;
-(NSMutableArray*)GetHomeVideo:(int)start Offset:(int)count;
-(NSMutableArray*)GetHomeVideo:(int)start Offset:(int)count withlabels:(NSArray*)labels;
-(NSMutableArray*)GetPersonalVideo:(int)start Offset:(int)count;
-(NSMutableArray*)GetFavouriteVideo:(int)start Offset:(int)count;
-(void)UpdateHomeVideo:(VideoInformationObject*)in;
-(void)UpdateFavouriteVideo:(VideoInformationObject*)in;
-(void)UpdatePersonalVideo:(VideoInformationObject*)in;

-(void)WS_UpdateHomeVideo:(MovierDCInterfaceSvc_VDCVideoInfoEx*)in;

//订单操作
-(void)AddOrder:(NSString*)createtime Owner:(int)ownerId OrderLength:(float)length HeadTail:(int)headid Filter:(int)filterid Music:(int)musicid SubTitle:(int)subtitleid CustomSubtitle:(NSString*)customsubtitle OrderVideoName:(NSString*)videoname ShareSet:(int)sharestatus OSSID:(int)ossid;
-(void)AddCommitOrder:(int)orderid Createtime:(NSString*)createtime Owner:(int)ownerId OrderLength:(float)length HeadTail:(int)headid Filter:(int)filterid Music:(int)musicid SubTitle:(int)subtitleid CustomSubtitle:(NSString*)customsubtitle OrderVideoName:(NSString*)videoname ShareSet:(int)sharestatus OSSID:(int)ossid;
-(void)DeleteOrder:(int)orderid;
-(void)UpdateOrder:(int)orderid ownerCreateTime:(NSString*)createtime Owner:(int)ownerId OrderLength:(float)length HeadTail:(int)headid Filter:(int)filterid Music:(int)musicid SubTitle:(int)subtitleid CustomSubtitle:(NSString*)customsubtitle OrderVideoName:(NSString*)videoname ShareSet:(int)sharestatus OrderStatus:(int)orderstatus OSSID:(int)ossid;

/**
 *  更新订单信息（包含订单类型）
 */
- (void)UpdateOrder:(int)orderid ownerCreateTime:(NSString*)createtime Owner:(int)ownerId OrderLength:(float)length HeadTail:(int)headid Filter:(int)filterid Music:(int)musicid SubTitle:(int)subtitleid CustomSubtitle:(NSString*)customsubtitle OrderVideoName:(NSString*)videoname ShareSet:(int)sharestatus OrderStatus:(int)orderstatus OSSID:(int)ossid OrderType:(NSInteger)orderType;

/**
 *  更新订单的照做信息
 */
- (void)UpdateOrder:(int)orderid FollowVideoId:(NSString *)followVideoId;

- (NewNSOrderDetail *)SearchOrder:(int)orderid;
- (NewNSOrderDetail *)SearchOSSOrder:(int)ossorderid;
- (NSMutableArray *)SearchOrder:(int)ownerid withStatus:(int)type;
- (NewNSOrderDetail *)SearchLastOrder;
-(NSMutableArray*)SearchAllFreshOrder:(int)ownerid;

/** 更新已经生成的订单的订单状态（是当前登录用户的订单，后台显示已经制作完成，是传入的这个订单）(如果后台拿到的影片里有这个订单就更新该订单订单状态)*/
- (void)updateOrderStatusWithOrderId:(NSString *)orderId;

//素材操作
-(void)DB_AddMaterial:(NewOrderVideoMaterial*)in Owner:(int)Userid;
-(void)DB_DeleteMaterial:(int)materialid;
-(void)DB_UpdateMaterial:(NewOrderVideoMaterial*)in Owner:(int)Userid;

//返回 NewOrderVideoMaterial 数组
-(NSMutableArray*)DB_SearchOrderMaterial:(NSArray*)ins;
-(NewOrderVideoMaterial*)DB_SearchMaterail:(int)Userid LocalURL:(NSString*)localpath;
-(NewOrderVideoMaterial*)DB_SearchMaterail:(int)Userid Asserturl:(NSString*)asserturl;

/**
 *  修改素材的arid
 */
- (void)setARIdWithAssetURL:(NSString *)assetURL;

/**
 *  修改rewardType
 */
- (void)setRewardTypeWithAssetURL:(NSString *)assetURL;

//素材订单映射表
-(void)DB_AddMaterialwithOrder:(NewOrderVideoMaterial*)in Order:(int)orderid;
-(NSMutableArray*)DB_SearchMaterails:(int)order;//数组存储materialID；
-(void)DB_DeleteMaterialINOrder:(int)materialId;


//标签操作
-(void)DB_AddLabel:(NSString*)labelname labelId:(NSNumber*)labelid Parent:(NSNumber*)parentid Thumbnail:(NSString*)szThumbnail Type:(NSNumber*)labeltype;

/**
 *  @param: 返回字典表 @"labelname"名称 "labelid"ID "parentid"父ID "labeltype"类型 "labelurl"缩略图URL
 */
-(NSMutableArray*)DB_GetLabels:(NSNumber*)parentid;
-(NSDictionary*)DB_GetLabelInfo:(NSNumber*)labelid;
-(void)DB_DeleteLabelByParentId:(NSNumber*)parentid;
-(void)DB_ModifyLabel:(NSString*)labelname labelId:(NSNumber*)labelid Parent:(NSNumber*)parentid Thumbnail:(NSString*)szThumbnail Type:(NSNumber*)labeltype;

//模板操作
-(void)DB_ClearTempCat;
-(NSInteger)DB_GetTempCatNum;

//MovierDCInterfaceSvc_TemplateCat  数组
-(NSMutableArray*)DB_GetTempCat;
-(void)DB_AddTempCat:(NSInteger)rID CatName:(NSString *)catname CatReference:(NSString*)referenceURL CatDesc:(NSString*)description;

-(void)DB_ClearTemp:(NSNumber*)TempID;
-(NSInteger)DB_GetTempNum:(NSNumber*)CatID;

//MovierDCInterfaceSvc_vpVDCHeaderAndTailC  数组
-(NSMutableArray*)DB_GetTempByCat:(NSNumber*)CatID;
-(void)DB_AddMapCatStyle:(NSNumber*)catid Style:(NSNumber*)styleid;
-(void)MC_AddTemp:(MovierDCInterfaceSvc_vpVDCHeaderAndTailC*)addItem CatID:(NSNumber*)catid;
-(void)MC_CleanAllTemp:(NSNumber*)catid;

#pragma mark ---------

/**  根据 videoID 查询视频读取状态 readStatus  0未播放, 1播放 */
- (int)readStatusByVideoID:(int)videoID;

/**  根据 videoID 修改视频读取状态 readStatus */
- (BOOL)modefyReadStatusByVideoID:(int)videoID;

/**  获得个人表PERSONALVIDEO 中的所有 videoID */
- (NSArray *)allVideoIDs;

/**  从数据库中  获得当前未播放的视频数 */
- (NSNumber *)getNoPlayVideoNum;

#pragma mark ---------

/**  用户确认搜索时 记录用户的搜索内容*/
- (void)DB_AddRecord:(NSString *)record;

/**  得到所有的搜索记录 (由旧到新)*/
- (NSArray *)DB_FindRecord;

/**  得到所有的搜索记录 (由新到旧)*/
- (NSArray *)findRecord;

/**查询最新的三条或三条以内搜索记录*/
- (NSArray *)findRecentRecord;

/**删除所有的搜索记录*/
- (void)DeleteAllRecord;

#pragma mark - 音乐搜索记录

/**得到所有音乐搜索记录（最多十条）*/
- (NSArray *)getAllMusicRecord;

/**删除所有音乐搜素记录*/
- (void)deleteSearchMusicRecord;

/**添加音乐搜索记录*/
- (void)addSearchMusicRecord:(NSString *)searchMusic;

#pragma mark - 消息通知表

/**
 *@brief:    增操作（消息表）
 *@param:    mesObj     插入的消息对象
 */
- (void)addMesWithObj:(MessageObj *)mesObj;

/**
 *@brief:    查询所有的对应术语的数据（消息通知）
 *@param:    mesObj     插入的消息对象
 *@return:   NSArray    返回的消息对象的数组
 */
- (NSArray *)getDataWithTerm:(NSString *)dataTerm;

/**
 *@brief:    获得当前用户未读的消息数量（消息通知）
 *@param:    dataTerm     查询术语
 *@return:   NSArray    返回未读消息数量
 */
- (NSInteger)getAllNoReadDataWithDataTerm:(NSString *)dataTerm;

/**
 *@brief:    获得收藏和关注的数据（消息通知）
 *@return:   NSArray    返回关注和收藏未读消息数据
 */
- (NSArray *)getCollectDataAndCareData;

/**
 *@brief:    获得评论和回复的内容（消息通知）
 *@return:   NSArray    返回评论和回复消息数据
 */
- (NSArray *)getCommentDataAndCommentReplyData;

/**
 *@brief:    获得未观看的新影片的数量（收消息的人是我，状态未观看，新影片的术语）
 *@return:   NSInteger  返回未观看的新影片数量
 */
- (NSInteger)getNoPlayNewVideoNum;

/**
 *@brief:    查看某个影片是否未观看(是当前登录用户，是新影片消息，是这个videoId)
*@param:    videoId     查询的影片id
 *@return:   NSString  返回该该影片的观看状态
 */
- (NSString *)getNewVideoReadStatus:(NSString *)videoId;

/**
 *@brief:    修改该影片的观看状态(当前用户为接受者，观看状态为未观看，videoid对应，是新影片消息)
 *@param:    videoId     查询的影片id
 */
- (void)updateNewVideoReadStatus:(NSString *)videoId;

/**
 *@brief:    设置badgenum(设置badgenum时会去查询数据库，然后根据获得的结果进行设置，然后会发出一个通知（各个界面可以接受这个通知，实时修改提示数字）)
 */
- (void)setBadgeNum;

/**
 *@brief:    查找某个新影片生成的消息有没有已经存在数据库中(当前用户，新影片的术语，videoId)
 *@param:    videoId     查询的影片id
 *@return:   BOOL  返回该该影片是否已经插入过
 */
- (BOOL)selectOneNewVideoBornMesWithVideoId:(NSString *)videoId;

#pragma mark - 好友表
/**
 *@brief:    增加好友或者粉丝或者关注
 *@param:   friendModel    需要保存的好友对象
 */
- (void)addFiendWithModel:(FriendModel *)friendModel;

/** 将数组中的好友或者粉丝或者关注加入数据库中*/
/**
 *@brief:    增加好友或者粉丝或者关注
 *@param:   friendArray    需要保存的好友数组
 *@param:   friendType     好友类型
 */
- (void)addFriendWithArray:(NSArray *)friendArray FriendType:(NSString *)friendType;

/**
 *@brief:    删除好友表的数据
 *@param:    deleteUserID     要删除的好友或者关注或者粉丝的id
 *@param:    friendType       要删除的好友类型
 */
- (void)deleteFriendTabWithUserId:(NSString *)deleteUserID Type:(NSString *)friendType;

/**
 *@brief:    更改好友表的数据
 *@param:    friendModel      更改到的数据
 *@param:    userId           要更改的用户的id
 *@param:    friendType       要更改的用户的类型
 */
- (void)updateFriendWithModel:(FriendModel *)friendModel UserId:(NSString *)userId Type:(NSString *)friendType;

/**
 *@brief:    根据好友类型查询好友表
 *@param:    friendType       要查寻的用户的类型
 *@return:    查寻结果
 */
- (NSArray *)selectFriendTabWithType:(NSString *)friendType;

/**
 *@brief:    根据好友类型查询好友数量
 *@param:    friendType       要查寻的用户的类型
 *@return:    查寻结果
 */
- (NSInteger)selectFriendNumTabWithType:(NSString *)friendType;

/**
 *@brief:    查询好友表里面某一个关注获得粉丝或者好友是否存在
 *@param:    friendUserId       好友或粉丝或关注的用户的id
 *@param:    friendType         是好友或粉丝或关注
 *@return:    查寻结果（有没有这个用户）
 */
- (BOOL)selectOneFriend:(NSString *)friendUserId FriendType:(NSString *)friendType;

/**
 *@brief:    删除当前登录用户的某个好友类型的全部
 *@param:    friendType         是好友或粉丝或关注
 */
- (void)deleteFriendTabWithType:(NSString *)friendType;

#pragma mark - 私信表
/**
 *@brief:    私信表插入数据(插入当前登录用户的数据时查看状态设为已查看， 数据对象来自后台)
 *@param:    mesObj       数据对象
 */
- (void)addMesWithMesObj:(MessageObj *)mesObj;

/**
 *@brief:    私信表插入数据(插入当前登录用户的数据时查看状态设为已查看， 数据对象来自app内)
 *@param:    mesObj       数据对象
 */
- (void)addMesWithPrivateMesObj:(PrivateMesObj *)privateMesObj;

/**
 *@brief:    更改私信表的内容(更改看过的数据的内容的查看状态)
 *@param:    friendUserId       好友的用户的id
 */
- (void)updateMesTabWithStartUserId:(NSString *)friendUserId;

/**
 *@brief:    查询与某个好友的私信内容
 *@param:    friendUserId       好友的用户的id
 *@return:    查寻结果（所有的私信记录）
 */
- (NSArray *)selectMesFromMesTabWithStartUserId:(NSString *)friendUserId;

/**
 *@brief:    查询与某个好友的未读的消息数量
 *@param:    friendUserId       好友的用户的id
 *@return:    查寻结果（所有的未读私信数量）
 */
- (NSInteger)selectNoReadPrivateMes:(NSString *)friendUserId;

/**
 *@brief:    查询所有未读消息(私信消息)
 *@return:    查寻结果（所有的未读私信数量）
 */
- (NSInteger)selectAllNoReadFriendPrivateMesNum;

#pragma mark - 图文分享部分
/**
 * 判断是否存在某些数据
 */
- (BOOL)isSaveShareDataWithVideoId:(NSString *)videoID;

/**
 *  增加或者更新数据
 */
- (void)addOrUpdateShareDataWithTuwenObj:(TuwenOBJ *)tuwenObj
                                 VideoId:(NSString *)videoID;

/**
 *  删除分享数据
 */
- (void)deleteShareDataWithVideoId:(NSString *)videoID;

/**
 *  查询所有数据
 */
- (NSArray *)selectAllShareDataWithVideoID:(NSString *)videoID;

#pragma mark - 上传素材表

/**
 *  增加数据
 */
- (void)insertDataWithModel:(UploadMaterialModel *)uploadMaterialModel;

/**
 *  删除数据
 */
- (void)deleteData;

/**
 *  更新数据
 */
- (void)updateDataWithModel:(UploadMaterialModel *)uploadMaterialModel;

/**
 *  查询所有未上传的数据
 */
- (NSArray *)selectUploadMaterialData;

/**
 *  查寻所有数据
 */
- (NSArray *)selectAllMaterialData;
@end
