//
//  DBOperation.m
//  M-Cut
//
//  Created by Crab00 on 15/10/8.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "VideoDBOperation.h"
#import "FMDatabaseAdditions.h"
#import "UserEntity.h"
#import "CustomeClass.h"
#import "TuwenOBJ.h"
#import "UploadMaterialModel.h"

//定义视频相关字段名
#define ID                      @"ID"
#define VIDEOID                 @"videoID"
#define VIDEONAME               @"videoName"
#define OWNERID                 @"ownerID"
#define OWNERNAME               @"ownerName"
#define OWNERACATAR             @"ownerAcatar"
#define VIDEOLABELNAME          @"LabelName"
#define VIDEOCREATETIME         @"CreateTime"
#define THUMBNAILURL            @"ThumbnailUrl"
#define VIDEOURL                @"ReferenceUrl"
#define NUMPRAISE               @"NumberOfPraise"
#define NUMSHARE                @"NumberOfShare"
#define NUMFAVORITE             @"NumberOfFavorite"
#define NUMCOMMENT              @"NumberOfComment"
#define COLLECTSTATUS           @"CollectStatus"
#define SHARE                   @"Share"
#define VSIGNATURE              @"Signature"
#define USERID                  @"currentUserID"
#define HASREAD                 @"readStatus"

// 增加播放次数
#define VISITCOUNT              @"VisitCount"

//定义视频相关表名称
#define USERMESSAGETABLE        @"Tab_MESSAGE"
#define USERSEARECHMUSICRECORD  @"USERSEARECHMUSICRECORD"
#define USERSEARCHRECORD        @"USERSEARCHRECORD"
#define VIDEO                   @"VIDEO"
#define HOMEVIDEO               @"HOMEVIDEO"
#define FAVOURITEVIDEO          @"FAVOURITEVIDEO"
#define PERSONALVIDEO           @"PERSONALVIDEO"
#define VIDEOLABEL              @"VIDEOLABEL"
#define LABELS                  @"LABELS"

//定义订单相关字段名
#define MUSICSTART              @"musicStart"
#define MUSICEND                @"musicEnd"
#define SEARCHRECORD            @"searchRecord"
#define CREATETIME              @"CreateTime"
#define ORDERLENGTH             @"OrderLength"
#define HEADANDTAIL             @"HeadTail"
#define FILTER                  @"Filter"
#define MUSIC                   @"Music"
#define SUBTITLE                @"Subtitle"
#define CUSTOMSUBTITLE          @"CustomSubtitle"
#define ORDERSTATUS             @"OrderStatus"
#define ORDERID                 @"OrderId"
#define OSSORDERID              @"OSSOrderId"
#define LOCALURL                @"LocalURL"
#define OSSURL                  @"OssURL"
#define ASSERTURL               @"AssertURL"
#define MATERIALTYPE            @"Materialtype"
#define INDEX                   @"SortIndex"
#define DURATION                @"Duration"
#define MATERIALID              @"MaterialId"

//定义订单相关表名称
#define ORDER                   @"MOBILE_ORDER"
#define MATERIAL                @"MATERIAL"
#define ARID                    @"ARID"
#define REWARDTYPE              @"rewardType"
#define MATERIAL2ORDER          @"MATERIALANDORDER"
#define ORDERTYPE               @"orderType"
#define FOLLOWVIDEOID           @"followVideoId"
#define RETAINVOICE             @"retainVoice"


@implementation VideoDBOperation

static VideoDBOperation *Singleton;

+ (VideoDBOperation *)Singleton
{
    @synchronized(self)
    {
        if (!Singleton){
            Singleton = [[VideoDBOperation alloc] init];
            NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docsDir = [dirPaths objectAtIndex:0];
            Singleton->alphaDBpath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Movier.db"]];
            Singleton->db_movier = [FMDatabase databaseWithPath:Singleton->alphaDBpath];
        }
        return Singleton;
    }
}


-(void)CreateTable{
    theLock = [[NSLock alloc] init];
    [self TABLE_NewVideo];
    [self TABLE_NewOrder];
    [self TABLE_NewTemplate];
}

-(void)TABLE_NewVideo{
    [theLock lock];
    {
        if ([db_movier open]) {
            
            //用户选择上传的素材表
            NSString *sqlCreateUploadMaterial = [NSString stringWithFormat:@"create table if not exists %@ ('%@' integer PRIMARY KEY AUTOINCREMENT, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text)", UPLOADMATERIALTAB, UPLOADMATERIALID, UPLOADMATERIALASSETURL, UPLOADMATERIALLOCALURL, UPLOADMATERIALSTATUS, UPLOADMATERIALCREATETIME, UPLOADMATERIALCONTENTSIZE, UPLOADMATERIALFILENAME, UPLOADMATERIALYUNFILENAME];
            BOOL res = [db_movier executeUpdate:sqlCreateUploadMaterial];
            if (!res) {
                NSLog(@"error when creating UPLOADMATERIALTAB");
            }
            
            //线程非安全
            NSString *sqlCreateVideo =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('%@' integer PRIMARY KEY AUTOINCREMENT,'%@' integer,'%@' text,'%@' integer,'%@' text,'%@' text,'%@' text,'%@' text,'%@' text,'%@' text,'%@' integer,'%@' integer,'%@' integer,'%@' integer,'%@' integer,'%@' integer,'%@' text,'%@' integer)",VIDEO,ID,VIDEOID,VIDEONAME,OWNERID,OWNERNAME,OWNERACATAR,VIDEOLABELNAME,VIDEOCREATETIME,THUMBNAILURL,VIDEOURL,NUMPRAISE,NUMSHARE,NUMFAVORITE,NUMCOMMENT,COLLECTSTATUS,SHARE,VSIGNATURE,USERID];
            res = [db_movier executeUpdate:sqlCreateVideo];
            if (!res) {
                NSLog(@"error when creating VIDEO table");
            }
            
            //建立用户分享内容的表
            NSString * sqlCreateShareTable = [NSString stringWithFormat:@"create table if not exists %@ ('%@' integer PRIMARY KEY AUTOINCREMENT, '%@' text, '%@' text, '%@' integer, '%@' text, '%@' integer, '%@' integer, '%@' text, '%@' text)", SHARETABLE, shareID, shareUserID, shareVideoID, shareSourceType, shareContent, shareCellHeight, shareIsShowPlayButtonImage, shareImageUrl, shareVideoUrl];
            res = [db_movier executeUpdate:sqlCreateShareTable];
            if (!res) {
                DEBUGLOG(@"create table error")
            }
            
            //建立用户搜索音乐的记录表
            NSString * sqlCreateUserSearchMusicRecord = [NSString stringWithFormat:@"create table if not exists %@ ('%@' integer PRIMARY KEY AUTOINCREMENT, '%@' text)", USERSEARECHMUSICRECORD, ID, SEARCHRECORD];
            res = [db_movier executeUpdate:sqlCreateUserSearchMusicRecord];
            if (!res) {
                NSLog(@"error when creating USERSEARECHMUSICRECORD table");
            }
            
            //建立用户搜索记录表
            NSString * sqlCreateUserSearchRecord = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('%@' integer PRIMARY KEY AUTOINCREMENT, '%@' text)", USERSEARCHRECORD, ID,SEARCHRECORD];
            res = [db_movier executeUpdate:sqlCreateUserSearchRecord];
            if (!res) {
                NSLog(@"error when creating USERSEARCHRECORD table");
            }
            
            //建立消息表（消息类型有点赞消息、评论消息、评论回复消息、系统通知消息、关注消息、收藏消息）
            NSString * sqlCreateUserNoticeTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('%@' integer PRIMARY KEY AUTOINCREMENT, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text)", USERMESSAGETABLE, ID, DSTCONTENT, DSTCONTENTID, DSTCUSTOMERID, LINKLABELID, LINKTYPE, LINKURL, SRCAVATAR, SRCCONTENT, SRCCONTENTID, SRCCUSTOMERID, SRCNICKNAME, TERM, TIME, MESVIDEOID, VIDEOLABELID, MESVIDEOLABELNAME, MESVIDEONAME, VIDEOTHUMBNAIL, MESVIDEOURL, ISREAD];
            res = [db_movier executeUpdate:sqlCreateUserNoticeTable];
            if (!res) {
                NSLog(@"error when creating USERMESSAGETABLE");
            }
            
            //建立好友，关注，粉丝表
            NSString * sqlCreateFriendTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('%@' integer PRIMARY KEY AUTOINCREMENT, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text)", FRIENDTAB, FRIENDID, FRIENDUSERID, FRIENDHEADURL, FRIENDNICKNAME, FRIENDVIDEONUM, FRIENDVIDEOCOLLECTTIMES, FRIENDSIGNATURE, FRIENDTYPE, FRIENDWITHWHO];
            res = [db_movier executeUpdate:sqlCreateFriendTable];
            if (!res) {
                DEBUGLOG(@"create friendtable error");
            }
            
            //建立私信表
            NSString * sqlCreateFriendMesTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('%@' integer PRIMARY KEY AUTOINCREMENT, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text)", FRIENDMESTAB, FRIENDMESID, FRIENDMESSTARTUSER, FRIENDMESENDUSERID, FRIENDSTARTUSERNICKNAME, FRIENDMESREADSTATUS, FRIENDMESCONTENT, FRIENDHEADIMAGEURL, FRIENDMESSTARTTIME];
            res = [db_movier executeUpdate:sqlCreateFriendMesTable];
            if (!res) {
                DEBUGLOG(@"create FriendMesTable error");
            }
            
            //建立视频关联的索引表，包括主页面，收藏页面，个人页面
            NSString *sqlHomepage =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('%@' integer PRIMARY KEY AUTOINCREMENT,'%@' integer)",HOMEVIDEO,ID,VIDEOID];
            res = [db_movier executeUpdate:sqlHomepage];
            if (!res) {
                NSLog(@"error when creating HOMEPAGEVIDEO table");
            }
            NSString *sqlFavoritepage =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('%@' integer PRIMARY KEY AUTOINCREMENT,'%@' integer)",FAVOURITEVIDEO,ID,VIDEOID];
            res = [db_movier executeUpdate:sqlFavoritepage];
            if (!res) {
                NSLog(@"error when creating Favouritepage table");
            }
            NSString *sqlPersonalpage =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('%@' integer PRIMARY KEY AUTOINCREMENT,'%@' integer,'%@' integer)",PERSONALVIDEO,ID,VIDEOID,HASREAD];
            res = [db_movier executeUpdate:sqlPersonalpage];
            if (!res) {
                NSLog(@"error when creating Personalpage table");
            }
            NSString *sqlvideolabels =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('%@' integer PRIMARY KEY AUTOINCREMENT,'%@' integer,'%@' integer)",VIDEOLABEL,ID,VIDEOID,@"LABEL"];
            res = [db_movier executeUpdate:sqlvideolabels];
            if (!res) {
                NSLog(@"error when creating video&label map table");
            }
            NSString *sqllabel =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('%@' integer PRIMARY KEY AUTOINCREMENT,'LABELID' integer,'NAME' text,'PLABEL' integer,'nType' INTEGER, 'nVideoNum' INTEGER, 'szThumbnail' TEXT, 'szDescribe' TEXT)",LABELS,ID];
            res = [db_movier executeUpdate:sqllabel];
            if (!res) {
                NSLog(@"error when creating label table");
            }
            [db_movier close];
        }
        [theLock unlock];
    }
}

-(void)TABLE_NewTemplate{
    [theLock lock];
    if ([db_movier open]) {
        BOOL res;
        NSString *music =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS MUSIC(_id INTEGER PRIMARY KEY AUTOINCREMENT,nID INTEGER ,szName text,szUrl text,szDesc text,szCreateTime text)"];
        res = [db_movier executeUpdate:music];
        if (!res) {
            NSLog(@"error when creating music table");
        }
        
        //TemplateCat   模板分类
        NSString *TemplateCat =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS TemplateCat(_id INTEGER PRIMARY KEY AUTOINCREMENT,nID INTEGER ,szName text,szReference text,szDesc text)"];
        res = [db_movier executeUpdate:TemplateCat];
        if (!res) {
            NSLog(@"error when creating TemplateCat table");
        }

        NSString *style =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS STYLE(_id INTEGER PRIMARY KEY AUTOINCREMENT,nID INTEGER ,nHeaderAndTailStyle INTEGER,szName text,szThumbnail text,szReference text,szCreateTime text,szDesc text,nHotIndex INTEGER,Applicable_Scene text,LocalURL text)"];
        res = [db_movier executeUpdate:style];
        if (!res) {
            NSLog(@"error when creating style table");
        }
        
        //TemplateCat   模板分类  和 模板 映射表
        NSString *CatandStyle =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS CatAndStyle(_id INTEGER PRIMARY KEY AUTOINCREMENT,nCatID INTEGER ,nStyleID INTEGER)"];
        res = [db_movier executeUpdate:CatandStyle];
        if (!res) {
            NSLog(@"error when creating style and cat map");
        }
        [db_movier close];
    }
    [theLock unlock];
}

-(void)TABLE_NewOrder{
    [theLock lock];
    {
        if ([db_movier open]) {
            
            //线程非安全，加锁
            //订单表
            NSString *sqlOrder =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('%@' integer PRIMARY KEY AUTOINCREMENT,'%@' integer,'%@' text,'%@' integer,'%@' float,'%@' integer,'%@' integer,'%@' integer,'%@' integer,'%@' text,'%@' text,'%@' integer,'%@' integer)",ORDER,ID,OSSORDERID,CREATETIME,OWNERID,ORDERLENGTH,HEADANDTAIL,FILTER,MUSIC,SUBTITLE,CUSTOMSUBTITLE,VIDEONAME,SHARE,ORDERSTATUS];
            BOOL res = [db_movier executeUpdate:sqlOrder];
            if (!res) {
                NSLog(@"error when creating Order table");
            }
            
            //订单表添加照做影片id
            if (![db_movier columnExists:FOLLOWVIDEOID inTableWithName:ORDER]) {
                
                //执行插入操作
                NSString * alterStr = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ TEXT", ORDER, FOLLOWVIDEOID];
                BOOL res = [db_movier executeUpdate:alterStr];
                if (!res) {
                    DEBUGLOG(@"增加字段失败")
                }
            }
            
            //订单表添加保留原声
            if (![db_movier columnExists:RETAINVOICE inTableWithName:ORDER]) {
                
                //执行插入操作
                NSString * alterStr = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ integer", ORDER, RETAINVOICE];
                BOOL res = [db_movier executeUpdate:alterStr];
                if (!res) {
                    DEBUGLOG(@"增加字段失败")
                }
            }
            
            //素材表
            NSString *sqlMaterial =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('%@' integer PRIMARY KEY AUTOINCREMENT,'%@' integer,'%@' float,'%@' integer,'%@' integer,'%@' text,'%@' text,'%@' text,'%@' text,'UploadID' text)",MATERIAL,ID,INDEX,DURATION,MATERIALTYPE,OWNERID,LOCALURL,OSSURL,ASSERTURL,CREATETIME];
            res = [db_movier executeUpdate:sqlMaterial];
            if (!res) {
                NSLog(@"error when creating Material table");
            }
            
            //添加arid字段
            if (![db_movier columnExists:ARID inTableWithName:MATERIAL]) {
                
                //执行插入操作
                NSString * alterStr = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ TEXT", MATERIAL, ARID];
                BOOL res = [db_movier executeUpdate:alterStr];
                if (!res) {
                    DEBUGLOG(@"增加字段失败")
                }
            }
            
            //添加rewardType字段
            if (![db_movier columnExists:REWARDTYPE inTableWithName:MATERIAL]) {
                
                //执行插入操作
                NSString * alterStr = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ integer", MATERIAL, REWARDTYPE];
                BOOL res = [db_movier executeUpdate:alterStr];
                if (!res) {
                    DEBUGLOG(@"增加字段失败")
                }
            }
            
            //订单表添加订单类型字段
            if (![db_movier columnExists:ORDERTYPE inTableWithName:ORDER]) {
                
                //执行插入操作
                NSString * alterStr = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ integer", ORDER, ORDERTYPE];
                BOOL res = [db_movier executeUpdate:alterStr];
                if (!res) {
                    DEBUGLOG(@"增加字段失败")
                }
            }
            
            //素材表
            NSString *sqlMaterialOrder =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('%@' integer PRIMARY KEY AUTOINCREMENT,'%@' integer,'%@' integer)",MATERIAL2ORDER,ID,ORDERID,MATERIALID];
            res = [db_movier executeUpdate:sqlMaterialOrder];
            if (!res) {
                NSLog(@"error when creating Material2Order table");
            }
            
            [db_movier close];
        }
        [theLock unlock];
    }
}

//线程安全的插入数据
-(void)AddVideo:(int)vId Vname:(NSString*)vName Ownerid:(int)ownerid OwnerName:(NSString*)ownername OwnerPic:(NSString*)ownerpic VideoLabelName:(NSString*)labelname VideoCreateTime:(NSString*)createtime Thumbnail:(NSString*)thumbnail videoURL:(NSString*)videourl Praise:(int)praise Share:(int)share Favourite:(int)favourite Comment:(int)comments CollectStatus:(int)collectstatus ShareStatus:(int)sharestatus Signature:(NSString*)signature currentUser:(int)currentid{
    if ([alphaDBpath isEqualToString:@""]||alphaDBpath == nil) {
        NSLog(@"db_movier path error!");
        return;
    }
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *insertSql= [NSString stringWithFormat:
                              @"INSERT INTO VIDEO ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@') VALUES ('%d', '%@', '%d','%@','%@','%@','%@','%@','%@','%d','%d','%d','%d','%d','%@','%d')",
                              VIDEOID,VIDEONAME,OWNERID,OWNERNAME,OWNERACATAR,VIDEOLABELNAME,VIDEOCREATETIME,THUMBNAILURL,VIDEOURL,NUMPRAISE,NUMSHARE,NUMFAVORITE,COLLECTSTATUS,SHARE,VSIGNATURE,USERID,
                              vId, vName, ownerid,ownername,ownerpic,labelname,createtime,thumbnail,videourl,praise,share,favourite,collectstatus,sharestatus,signature,currentid];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            NSLog(@"error when insert db table");
        }
    }];
    
    return;
}

#pragma mark --- -------------------

/**  新增 visitCount 字段 */
//增加视频数据 vId：视频ID  Vname：视频名称 ownerid：视频所属用户id ownername：视频所属用户名 ownerpic：视频所属用户头像  。。。。待补充
-(void)AddVideo:(int)vId Vname:(NSString*)vName Ownerid:(int)ownerid OwnerName:(NSString*)ownername OwnerPic:(NSString*)ownerpic VideoLabelName:(NSString*)labelname VideoCreateTime:(NSString*)createtime Thumbnail:(NSString*)thumbnail videoURL:(NSString*)videourl Praise:(int)praise Share:(int)share Favourite:(int)favourite Comment:(int)comments CollectStatus:(int)collectstatus ShareStatus:(int)sharestatus Signature:(NSString*)signature currentUser:(int)currentid videoVisitCount:(int)visitCount {
    if ([alphaDBpath isEqualToString:@""]||alphaDBpath == nil) {
        NSLog(@"db_movier path error!");
        return;
    }
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *insertSql= [NSString stringWithFormat:
                              @"INSERT INTO VIDEO ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@') VALUES ('%d', '%@', '%d','%@','%@','%@','%@','%@','%@','%d','%d','%d','%d','%d','%@','%d', '%d')",
                              VIDEOID,VIDEONAME,OWNERID,OWNERNAME,OWNERACATAR,VIDEOLABELNAME,VIDEOCREATETIME,THUMBNAILURL,VIDEOURL,NUMPRAISE,NUMSHARE,NUMFAVORITE,COLLECTSTATUS,SHARE,VSIGNATURE,USERID,VISITCOUNT,
                              vId, vName, ownerid,ownername,ownerpic,labelname,createtime,thumbnail,videourl,praise,share,favourite,collectstatus,sharestatus,signature,currentid,visitCount];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            NSLog(@"error when insert db table");
        }
    }];
    
    return;
}

/**  新增 visitCount 字段 */
//修改视频数据 vId：视频ID  Vname：视频名称 ownerid：视频所属用户id ownername：视频所属用户名 ownerpic：视频所属用户头像  。。。。待补充
-(void)ModefyVideo:(int)vId Vname:(NSString*)vName Ownerid:(int)ownerid OwnerName:(NSString*)ownername OwnerPic:(NSString*)ownerpic VideoLabelName:(NSString*)labelname VideoCreateTime:(NSString*)createtime Thumbnail:(NSString*)thumbnail videoURL:(NSString*)videourl Praise:(int)praise Share:(int)share Favourite:(int)favourite Comment:(int)comments CollectStatus:(int)collectstatus ShareStatus:(int)sharestatus Signature:(NSString*)signature currentUser:(int)currentid videoVisitCount:(int)visitCount {
    if ([alphaDBpath isEqualToString:@""]||alphaDBpath == nil) {
        NSLog(@"db_movier path error!");
        return;
    }
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *updateSql = [NSString stringWithFormat:
                               @"UPDATE VIDEO SET '%@'='%@','%@'='%d','%@'='%@','%@'='%@','%@'='%@','%@'='%@','%@'='%@','%@'='%@','%@'='%d','%@'='%d','%@'='%d','%@'='%d','%@'='%d','%@'='%@','%@'='%d', '%@'='%d' WHERE '%@' = '%d'",
                               VIDEONAME,  vName ,OWNERID,ownerid,OWNERNAME,ownername,OWNERACATAR,ownerpic,VIDEOLABELNAME,labelname,VIDEOCREATETIME,createtime,THUMBNAILURL,thumbnail,VIDEOURL,videourl,NUMPRAISE,praise,NUMSHARE,share,NUMFAVORITE,favourite,COLLECTSTATUS,collectstatus,SHARE,sharestatus,VSIGNATURE,signature,USERID,currentid,VISITCOUNT, visitCount,VIDEOID,  vId];
        BOOL res = [db2 executeUpdate:updateSql];
        if (!res) {
            NSLog(@"error when update db table");
        }
        
    }];
}

#pragma mark --- -------------------

-(void)ModefyVideo:(int)vId Vname:(NSString*)vName Ownerid:(int)ownerid OwnerName:(NSString*)ownername OwnerPic:(NSString*)ownerpic VideoLabelName:(NSString*)labelname VideoCreateTime:(NSString*)createtime Thumbnail:(NSString*)thumbnail videoURL:(NSString*)videourl Praise:(int)praise Share:(int)share Favourite:(int)favourite Comment:(int)comments CollectStatus:(int)collectstatus ShareStatus:(int)sharestatus Signature:(NSString*)signature currentUser:(int)currentid{
    if ([alphaDBpath isEqualToString:@""]||alphaDBpath == nil) {
        NSLog(@"db_movier path error!");
        return;
    }
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *updateSql = [NSString stringWithFormat:
                               @"UPDATE VIDEO SET '%@'='%@','%@'='%d','%@'='%@','%@'='%@','%@'='%@','%@'='%@','%@'='%@','%@'='%@','%@'='%d','%@'='%d','%@'='%d','%@'='%d','%@'='%d','%@'='%@','%@'='%d' WHERE '%@' = '%d'",
                               VIDEONAME,  vName ,OWNERID,ownerid,OWNERNAME,ownername,OWNERACATAR,ownerpic,VIDEOLABELNAME,labelname,VIDEOCREATETIME,createtime,THUMBNAILURL,thumbnail,VIDEOURL,videourl,NUMPRAISE,praise,NUMSHARE,share,NUMFAVORITE,favourite,COLLECTSTATUS,collectstatus,SHARE,sharestatus,VSIGNATURE,signature,USERID,currentid,VIDEOID,  vId];
        BOOL res = [db2 executeUpdate:updateSql];
        if (!res) {
            NSLog(@"error when update db table");
        }
        
    }];
}

-(void)DeleteVideo:(int)videoid{
    if ([alphaDBpath isEqualToString:@""]||alphaDBpath == nil) {
        NSLog(@"db_movier path error!");
        return;
    }
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *deleteSql = [NSString stringWithFormat:
                               @"delete from VIDEO where %@ = '%d'",
                               VIDEOID, videoid];
        BOOL res = [db2 executeUpdate:deleteSql];
        if (!res) {
            NSLog(@"error when delete db table");
        }
        
    }];
}

-(VideoInformationObject*)FindVideo:(int)videoid{
    VideoInformationObject *ret = [[VideoInformationObject alloc]init];
    [theLock lock];
    {
        if ([db_movier open]) {
            NSString * sql = [NSString stringWithFormat:
                              @"SELECT * FROM VIDEO where %@ = '%d'",VIDEOID,videoid];
            FMResultSet * rs = [db_movier executeQuery:sql];
            while ([rs next]) {
                ret = [VideoDBOperation fmset2video:rs];
            };
            if ([ret.videoID isEqualToString:@""]||ret.videoID==nil) {
                [db_movier close];
                [theLock unlock];
                return nil;
            }
            [db_movier close];
        }
        [theLock unlock];
    }
    return ret;
}

-(MovierDCInterfaceSvc_VDCVideoInfoEx*)WS_FindVideo:(int)videoid{
    MovierDCInterfaceSvc_VDCVideoInfoEx *ret = [[MovierDCInterfaceSvc_VDCVideoInfoEx alloc]init];
    [theLock lock];
    {
        if ([db_movier open]) {
            NSString * sql = [NSString stringWithFormat:
                              @"SELECT * FROM VIDEO where %@ = '%d'",VIDEOID,videoid];
            FMResultSet * rs = [db_movier executeQuery:sql];
            while ([rs next]) {
                ret = [VideoDBOperation fmset2ws_video:rs];
            };
            if ([ret.nVideoID isEqualToNumber:@(0)]==YES||ret.nVideoID==nil) {
                [db_movier close];
                [theLock unlock];
                return nil;
            }
            [db_movier close];
        }
        [theLock unlock];
    }
    return ret;
}

-(void)AddHomeVideo:(int)vId {
    if (![self DBConfigCorrect])
        return;
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *insertSql= [NSString stringWithFormat:
                              @"INSERT INTO %@ (%@) VALUES ('%d')",HOMEVIDEO,VIDEOID,vId];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            NSLog(@"error when insert db homevideo");
        }
    }];
    return;
}

//暂时想不起做什么用因为 homevideo现在只有两个字段  id  和 videoid
-(void)ModefyHomeVideo:(int)vId {
    if (![self DBConfigCorrect])
        return;
}

-(void)DeleteHomeVideo:(int)videoid{
    if (![self DBConfigCorrect])
        return;
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *deleteSql = [NSString stringWithFormat:
                               @"delete from %@ where %@ = '%d'",
                               HOMEVIDEO,VIDEOID, videoid];
        BOOL res = [db2 executeUpdate:deleteSql];
        if (!res) {
            NSLog(@"error when delete db homevidoe table");
        }
        
    }];
}

-(BOOL)videoIndexFind:(NSString*) sql{
    int findid = -1;
    [theLock lock];
    {
        if ([db_movier open]) {
            FMResultSet * rs = [db_movier executeQuery:sql];
            while ([rs next]) {
                findid = [rs intForColumn:ID];
            };
            [db_movier close];
        }
        [theLock unlock];
    }
    if (findid>-1) {
        return TRUE;
    }else
        return FALSE;
}
-(BOOL)DBConfigCorrect{
    if ([alphaDBpath isEqualToString:@""]||alphaDBpath == nil) {
        NSLog(@"db_movier path error!");
        return FALSE;
    }else
        return TRUE;
}
-(BOOL)FindHomeVideo:(int)videoid{
    return [self videoIndexFind:[NSString stringWithFormat:
                                 @"SELECT * FROM %@ where %@ = '%d'",HOMEVIDEO,VIDEOID,videoid]];
}

-(void)AddPersonalVideo:(int)vId{
    if (![self DBConfigCorrect])
        return;
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *insertSql= [NSString stringWithFormat:
                              @"INSERT INTO %@ (%@, %@) VALUES ('%d', '%d')",PERSONALVIDEO,VIDEOID, HASREAD, vId, 0];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            NSLog(@"error when insert db homevideo");
        }
    }];
    
    return;
}

//暂时想不起做什么用因为 personalvideo现在只有两个字段  id  和 videoid
-(void)ModefyPersonalVideo:(int)vId {
    if (![self DBConfigCorrect])
        return;
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *insertSql= [NSString stringWithFormat:
                              @" INTO %@ (%@) VALUES ('%d')",PERSONALVIDEO,VIDEOID,vId];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            NSLog(@"error when insert db homevideo");
        }
    }];
}

-(void)DeletePersonalVideo:(int)videoid{
    if (![self DBConfigCorrect])
        return;
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *deleteSql = [NSString stringWithFormat:
                               @"delete from %@ where %@ = '%d'",
                               PERSONALVIDEO,VIDEOID, videoid];
        BOOL res = [db2 executeUpdate:deleteSql];
        if (!res) {
            NSLog(@"error when delete db homevidoe table");
        }
        
    }];
}

-(BOOL)FindPersonalVideo:(int)videoid{
    return [self videoIndexFind:[NSString stringWithFormat:
                                 @"SELECT * FROM %@ where %@ = '%d'",PERSONALVIDEO,VIDEOID,videoid]];
}

-(void)AddFavouriteVideo:(int)vId {
    if (![self DBConfigCorrect])
        return;
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *insertSql= [NSString stringWithFormat:
                              @"INSERT INTO %@ (%@) VALUES ('%d')",FAVOURITEVIDEO,VIDEOID,vId];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            NSLog(@"error when insert db Favouritevideo");
        }
    }];
    return;
}

//暂时想不起做什么用因为 favouritevideo现在只有两个字段  id  和 videoid
-(void)ModefyFavouriteVideo:(int)vId {
    if (![self DBConfigCorrect])
        return;
}

-(void)DeleteFavouriteVideo:(int)videoid{
    if (![self DBConfigCorrect])
        return;
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *deleteSql = [NSString stringWithFormat:
                               @"delete from %@ where %@ = '%d'",
                               FAVOURITEVIDEO,VIDEOID, videoid];
        BOOL res = [db2 executeUpdate:deleteSql];
        if (!res) {
            NSLog(@"error when delete db Favouritevideo table");
        }
    }];
}

-(BOOL)FindFavouriteVideo:(int)videoid{
    return [self videoIndexFind:[NSString stringWithFormat:
                                 @"SELECT * FROM %@ where %@ = '%d'",FAVOURITEVIDEO,VIDEOID,videoid]];
}

-(NSMutableArray*)GetVideo:(int)start VideoCount:(int)count{
    NSMutableArray *ret = [[NSMutableArray alloc]init];
    [theLock lock];
    {
        if ([db_movier open]) {
            
            //线程非安全
            NSString * sql = [NSString stringWithFormat:
                              @"SELECT * FROM VIDEO ORDER BY videoID DESC LIMIT '%d'",count];
            if (start!=0) {
                int end = start+count;
                sql = [NSString stringWithFormat:
                       @"SELECT * FROM VIDEO ORDER BY videoID DESC LIMIT '%d','%d'",start,end];
            }
            FMResultSet * rs = [db_movier executeQuery:sql];
            while ([rs next]) {
                VideoInformationObject *item = [VideoDBOperation fmset2video:rs];
                [ret addObject:item];
            };
            [db_movier close];
        }
        [theLock unlock];
    }
    return ret;
}

+(VideoInformationObject*)fmset2video:(FMResultSet*)rs{
    VideoInformationObject *item = [[VideoInformationObject alloc]init];
    item.videoID = [rs stringForColumn:VIDEOID];
    item.videoName = [rs stringForColumn:VIDEONAME];
    item.ownerID = [rs stringForColumn:OWNERID];
    item.ownerName = [rs stringForColumn:OWNERNAME];
    item.ownerAcatar = [rs stringForColumn:OWNERACATAR];
    item.videoLabelName = [rs stringForColumn:VIDEOLABELNAME];
    item.videoCreateTime = [rs stringForColumn:VIDEOCREATETIME];
    item.videoThumbnailUrl = [rs stringForColumn:THUMBNAILURL];
    item.videoReferenceUrl = [rs stringForColumn:VIDEOURL];
    item.videoSignature = [rs stringForColumn:VSIGNATURE];
    item.videoNumberOfPraise = [rs stringForColumn:NUMPRAISE];
    item.videoNumberOfShare = [rs stringForColumn:NUMSHARE];
    item.videoNumberOfFavorite = [rs stringForColumn:NUMFAVORITE];
    item.videoNumberOfComment = [rs stringForColumn:NUMCOMMENT];
    item.videoCollectStatus = [rs stringForColumn:COLLECTSTATUS];
    item.videoShare = [rs stringForColumn:SHARE];
    
    // 增加播放次数
    item.videoPlayCount = [rs stringForColumn:VISITCOUNT];
    return item;
}

+(MovierDCInterfaceSvc_VDCVideoInfoEx*)fmset2ws_video:(FMResultSet*)rs{
    MovierDCInterfaceSvc_VDCVideoInfoEx *item = [[MovierDCInterfaceSvc_VDCVideoInfoEx alloc]init];
    item.nVideoID = @([rs intForColumn:VIDEOID]);
    item.szVideoName = [rs stringForColumn:VIDEONAME];
    item.nOwnerID = @([rs intForColumn:OWNERID]);
    item.szOwnerName = [rs stringForColumn:OWNERNAME];
    item.szAcatar = [rs stringForColumn:OWNERACATAR];
    item.szVideoLabel = [rs stringForColumn:VIDEOLABELNAME];
    item.szCreateTime = [rs stringForColumn:VIDEOCREATETIME];
    item.szThumbnail = [rs stringForColumn:THUMBNAILURL];
    item.szReference = [rs stringForColumn:VIDEOURL];
    item.szSignature = [rs stringForColumn:VSIGNATURE];
    item.nPraise = @([rs intForColumn:NUMPRAISE]);
    item.nShareNum = @([rs intForColumn:NUMSHARE]);
    item.nFavoritesNum = @([rs intForColumn:NUMFAVORITE]);
    item.nCommentsNum = @([rs intForColumn:NUMCOMMENT]);
    item.nVideoStatus = @([rs intForColumn:COLLECTSTATUS]);
    item.nVideoShare = @([rs intForColumn:SHARE]);
    
    // 增加播放次数
    item.nVisitCount = @([rs intForColumn:VISITCOUNT]);
    return item;
}

+(NewNSOrderDetail*)fmset2order:(FMResultSet*)rs{
    NewNSOrderDetail *item = [[NewNSOrderDetail alloc]init];
    item.order_id = [rs intForColumn:ID];
    item.order_st = [rs intForColumn:ORDERSTATUS];
    item.customer = [rs intForColumn:OWNERID];
    item.nVideoLength = [rs doubleForColumn:ORDERLENGTH];
    item.nHeaderAndTailID = [rs intForColumn:HEADANDTAIL];
    
    //此处数据库并没有这个字段
    //    item.nMusicStart = [rs intForColumn:MUSICSTART];
    //数据库也没有这个字段
    //    item.nMusicEnd = [rs intForColumn:MUSICEND];
    item.nFilterID = [rs intForColumn:FILTER];
    item.nMusicID = [rs intForColumn:MUSIC];
    item.nSubtitleID = [rs intForColumn:SUBTITLE];
    item.szCustomerSubtitle = [rs stringForColumn:CUSTOMSUBTITLE];
    item.szVideoName = [rs stringForColumn:VIDEONAME];
    item.nShareType = [rs intForColumn:SHARE];
    item.createTime = [rs stringForColumn:CREATETIME];
    item.oss_orderid = [rs intForColumn:OSSORDERID];
    item.followVideoId = [rs stringForColumn:FOLLOWVIDEOID];
    return item;
}

+(NewOrderVideoMaterial*)fmset2material:(FMResultSet*)rs{
    NewOrderVideoMaterial *item = [[NewOrderVideoMaterial alloc]init];
    
    //    item.order_id = [rs intForColumn:ORDERID];
    item.material_index = [rs intForColumn:INDEX];
    item.material_playduration = [rs doubleForColumn:DURATION];
    item.material_type = [rs intForColumn:MATERIALTYPE];
    item.owner = [rs intForColumn:OWNERID];
    item.material_localURL = [rs stringForColumn:LOCALURL];
    item.material_ossURL = [rs stringForColumn:OSSURL];
    item.material_assetsURL = [rs stringForColumn:ASSERTURL];
    item.createTime = [rs stringForColumn:CREATETIME];
    item.nOrderVideoMaterialID = [rs intForColumn:ID];
    item.multUpID = [rs stringForColumn:@"UploadID"];   //arbin add 20160115
    item.arId = [rs stringForColumn:ARID];
    item.rewardType = [rs intForColumn:REWARDTYPE];
    return item;
}

#pragma mark -- 增加字段 VisitCount
-(NSMutableArray*)GetHomeVideo:(int)start Offset:(int)count{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    [theLock lock];
    {
        if ([db_movier open]) {
            
            //线程非安全
            //select
            NSString * sql = [NSString stringWithFormat:
                              @"SELECT a.videoID,a.videoName,a.ownerID,a.ownerName,a.ownerAcatar,a.LabelName,a.CreateTime,a.ThumbnailUrl,a.ReferenceUrl,a.NumberOfPraise,a.NumberOfShare,a.NumberOfFavorite,a.NumberOfComment,a.Share,a.Signature,a.VisitCount from Video a,'%@' b where a.videoID = b.videoID order by b.videoID",HOMEVIDEO];
            if (start!=0) {
                int end = start+count;
                sql = [NSString stringWithFormat:
                       @"%@ DESC LIMIT '%d','%d'",sql,start,end];
            }else
                sql = [NSString stringWithFormat:@"%@ DESC LIMIT '%d'",sql,count];
            
            FMResultSet * rs = [db_movier executeQuery:sql];
            while ([rs next]) {
                VideoInformationObject *item = [VideoDBOperation fmset2video:rs];
                [ret addObject:item];
            };
            [db_movier close];
        }
        [theLock unlock];
    }
    return ret;
}

-(NSMutableArray*)GetHomeVideo:(int)start Offset:(int)count withlabels:(NSArray*)labels{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    return ret;
}
#pragma mark -- 增加字段 VisitCount
-(NSMutableArray*)GetPersonalVideo:(int)start Offset:(int)count{
    NSMutableArray *ret = [[NSMutableArray alloc]init];
    [theLock lock];
    {
        if ([db_movier open]) {
            
            //线程非安全
            //select
            NSString * sql = [NSString stringWithFormat:
                              @"SELECT a.videoID,a.videoName,a.ownerID,a.ownerName,a.ownerAcatar,a.LabelName,a.CreateTime,a.ThumbnailUrl,a.ReferenceUrl,a.NumberOfPraise,a.NumberOfShare,a.NumberOfFavorite,a.NumberOfComment,a.Share,a.Signature,a.VisitCount from Video a,PERSONALVIDEO b where a.videoID = b.videoID order by b.videoID"];
            if (start!=0) {
                int end = start+count;
                sql = [NSString stringWithFormat:
                       @"%@ DESC LIMIT '%d','%d'",sql,start,end];
            }else
                sql = [NSString stringWithFormat:@"%@ DESC LIMIT '%d'",sql,count];
            
            FMResultSet * rs = [db_movier executeQuery:sql];
            while ([rs next]) {
                VideoInformationObject *item = [VideoDBOperation fmset2video:rs];
                [ret addObject:item];
            };
            [db_movier close];
        }
        [theLock unlock];
    }
    return ret;
}
#pragma mark -- 增加字段 VisitCount
-(NSMutableArray*)GetFavouriteVideo:(int)start Offset:(int)count{
    NSMutableArray *ret = [[NSMutableArray alloc]init];
    [theLock lock];
    {
        if ([db_movier open]) {
            
            //线程非安全
            //select
            NSString * sql = [NSString stringWithFormat:
                              @"SELECT a.videoID,a.videoName,a.ownerID,a.ownerName,a.ownerAcatar,a.LabelName,a.CreateTime,a.ThumbnailUrl,a.ReferenceUrl,a.NumberOfPraise,a.NumberOfShare,a.NumberOfFavorite,a.NumberOfComment,a.Share,a.Signature,a.VisitCount from Video a,FAVOURITEVIDEO b where a.videoID = b.videoID order by b.videoID"];
            if (start!=0) {
                int end = start+count;
                sql = [NSString stringWithFormat:
                       @"%@ DESC LIMIT '%d','%d'",sql,start,end];
            }else
                sql = [NSString stringWithFormat:@"%@ DESC LIMIT '%d'",sql,count];
            
            FMResultSet * rs = [db_movier executeQuery:sql];
            while ([rs next]) {
                VideoInformationObject *item = [VideoDBOperation fmset2video:rs];
                [ret addObject:item];
            };
            [db_movier close];
        }
        [theLock unlock];
    }
    return ret;
}

-(void)UpdateHomeVideo:(VideoInformationObject*)in{
    [self UpdateVideo:in];
    
    //在video表更新
    if(![self FindHomeVideo:[in.videoID intValue]])
        [self AddHomeVideo:[in.videoID intValue]];
}

-(void)WS_UpdateHomeVideo:(MovierDCInterfaceSvc_VDCVideoInfoEx*)in{
    [self WS_UpdateVideo:in];
    
    //在video表更新
    if(![self FindHomeVideo:[in.nVideoID intValue]])
        [self AddHomeVideo:[in.nVideoID intValue]];
}

-(void)UpdateVideoLabel:(NSString*)videoID LabelName:(NSString*)labelname{
}

-(void)UpdateFavouriteVideo:(VideoInformationObject*)in{
    [self UpdateVideo:in];
    if(![self FindFavouriteVideo:[in.videoID intValue]])
        [self AddFavouriteVideo:[in.videoID intValue]];
}

-(void)UpdatePersonalVideo:(VideoInformationObject*)in{
    [self UpdateVideo:in];
    if(![self FindPersonalVideo:[in.videoID intValue]])
        [self AddPersonalVideo:[in.videoID intValue]];
}

#pragma mark -- 增加字段 VisitCount

-(void)UpdateVideo:(VideoInformationObject*)in{
    VideoInformationObject *vdieoexist = [self FindVideo:[in.videoID intValue]];
    if(vdieoexist!=nil){
        [self ModefyVideo:[in.videoID intValue] Vname:in.videoName Ownerid:[in.ownerID intValue] OwnerName:in.ownerName OwnerPic:in.ownerAcatar VideoLabelName:in.videoLabelName VideoCreateTime:in.videoCreateTime Thumbnail:in.videoThumbnailUrl videoURL:in.videoReferenceUrl Praise:[in.videoNumberOfPraise intValue] Share:[in.videoNumberOfShare intValue] Favourite:[in.videoNumberOfFavorite intValue] Comment:[in.videoNumberOfComment intValue] CollectStatus:[in.videoCollectStatus intValue] ShareStatus:[in.videoShare intValue] Signature:in.videoSignature currentUser:0 videoVisitCount:[in.videoPlayCount intValue]];
        
    }else{
        [self AddVideo:[in.videoID intValue] Vname:in.videoName Ownerid:[in.ownerID intValue] OwnerName:in.ownerName OwnerPic:in.ownerAcatar VideoLabelName:in.videoLabelName VideoCreateTime:in.videoCreateTime Thumbnail:in.videoThumbnailUrl videoURL:in.videoReferenceUrl Praise:[in.videoNumberOfPraise intValue] Share:[in.videoNumberOfShare intValue] Favourite:[in.videoNumberOfFavorite intValue] Comment:[in.videoNumberOfComment intValue] CollectStatus:[in.videoCollectStatus intValue] ShareStatus:[in.videoShare intValue] Signature:in.videoSignature currentUser:0 videoVisitCount:[in.videoPlayCount intValue]];
    }
}

-(void)WS_UpdateVideo:(MovierDCInterfaceSvc_VDCVideoInfoEx*)in{
    MovierDCInterfaceSvc_VDCVideoInfoEx *vdieoexist = [self WS_FindVideo:[in.nVideoID intValue]];
    if(vdieoexist!=nil){
        [self ModefyVideo:[in.nVideoID intValue] Vname:in.szVideoName Ownerid:[in.nOwnerID intValue] OwnerName:in.szOwnerName OwnerPic:in.szAcatar VideoLabelName:in.szVideoName VideoCreateTime:in.szCreateTime Thumbnail:in.szThumbnail videoURL:in.szReference Praise:[in.nPraise intValue] Share:[in.nShareNum intValue] Favourite:[in.nFavoritesNum intValue] Comment:[in.nCommentsNum intValue] CollectStatus:[in.nVideoStatus intValue] ShareStatus:[in.nVideoStatus intValue] Signature:in.szSignature currentUser:0 videoVisitCount:[in.nVisitCount intValue]];
        
    }else{
        [self AddVideo:[in.nVideoID intValue] Vname:in.szVideoName Ownerid:[in.nOwnerID intValue] OwnerName:in.szOwnerName OwnerPic:in.szAcatar VideoLabelName:in.szVideoName VideoCreateTime:in.szCreateTime Thumbnail:in.szThumbnail videoURL:in.szReference Praise:[in.nPraise intValue] Share:[in.nShareNum intValue] Favourite:[in.nFavoritesNum intValue] Comment:[in.nCommentsNum intValue] CollectStatus:[in.nVideoStatus intValue] ShareStatus:[in.nVideoStatus intValue] Signature:in.szSignature currentUser:0 videoVisitCount:[in.nVisitCount intValue]];
    }
}


//订单操作
-(void)AddOrder:(NSString*)createtime Owner:(int)ownerId OrderLength:(float)length HeadTail:(int)headid Filter:(int)filterid Music:(int)musicid SubTitle:(int)subtitleid CustomSubtitle:(NSString*)customsubtitle OrderVideoName:(NSString*)videoname ShareSet:(int)sharestatus OSSID:(int)ossid{
    
    //确保数据库配置正确 alphaDBpath
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    
    if([customsubtitle isEqualToString:@"(null)"]==YES)
        NSLog(@"customsubtitle is equal null ");
    
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *insertSql= [NSString stringWithFormat:
                              @"INSERT INTO %@ ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@') VALUES ('%@', '%d', '%f','%d','%d','%d','%d','%@','%@','%d','0','%d')",
                              ORDER,CREATETIME,OWNERID,ORDERLENGTH,HEADANDTAIL,FILTER,MUSIC,SUBTITLE,CUSTOMSUBTITLE,VIDEONAME,SHARE,ORDERSTATUS,OSSORDERID,
                              createtime, ownerId, length,headid,filterid,musicid,subtitleid,customsubtitle, [CustomeClass filterStringWithStr:videoname],sharestatus,ossid];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            NSLog(@"error when insert order table");
        }
    }];
    return;
}

-(void)AddCommitOrder:(int)orderid Createtime:(NSString*)createtime Owner:(int)ownerId OrderLength:(float)length HeadTail:(int)headid Filter:(int)filterid Music:(int)musicid SubTitle:(int)subtitleid CustomSubtitle:(NSString*)customsubtitle OrderVideoName:(NSString*)videoname ShareSet:(int)sharestatus OSSID:(int)ossid{
    
    //确保数据库配置正确 alphaDBpath
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *insertSql= [NSString stringWithFormat:
                              @"INSERT INTO %@ ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@') VALUES ('%@', '%d', '%f','%d','%d','%d','%d','%@','%@','%d','4','%d')",
                              ORDER,CREATETIME,OWNERID,ORDERLENGTH,HEADANDTAIL,FILTER,MUSIC,SUBTITLE,CUSTOMSUBTITLE,VIDEONAME,SHARE,ORDERSTATUS,OSSORDERID,
                              createtime, ownerId, length,headid,filterid,musicid,subtitleid,customsubtitle,videoname,sharestatus,ossid];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            DEBUGLOG(@"insert ORDER error!")
        }
    }];
    return;;
}

-(void)DeleteOrder:(int)orderid{
    
    //确保数据库配置正确 alphaDBpath
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *delSql= [NSString stringWithFormat:@"DELETE FROM %@ where %@='%d'",ORDER,ID,orderid];
        BOOL res = [db2 executeUpdate:delSql];
        if (!res) {
            NSLog(@"error when delete Order record");
        }
    }];
    return;
}

/**
 *  更新订单信息
 */
-(void)UpdateOrder:(int)orderid ownerCreateTime:(NSString*)createtime Owner:(int)ownerId OrderLength:(float)length HeadTail:(int)headid Filter:(int)filterid Music:(int)musicid SubTitle:(int)subtitleid CustomSubtitle:(NSString*)customsubtitle OrderVideoName:(NSString*)videoname ShareSet:(int)sharestatus OrderStatus:(int)orderstatus OSSID:(int)ossid{
    
    if([customsubtitle isEqualToString:@"(null)"]==YES || customsubtitle == nil)//避免用户自定义字幕  null 问题产生
        customsubtitle = @"";
    
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];//确保数据库配置正确 alphaDBpath
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET '%@'='%@','%@'='%d','%@'='%f','%@'='%d','%@'='%d','%@'='%d','%@'='%d','%@'='%@','%@'='%@','%@'='%d','%@'='%d','%@'= '%d' WHERE %@ = '%d'",ORDER,CREATETIME,createtime,OWNERID,ownerId,ORDERLENGTH,length,HEADANDTAIL,headid,FILTER,filterid,MUSIC,musicid,SUBTITLE,subtitleid,CUSTOMSUBTITLE,customsubtitle,VIDEONAME,videoname,SHARE,sharestatus,ORDERSTATUS,orderstatus,OSSORDERID,ossid, ID,orderid];
        BOOL res = [db2 executeUpdate:updateSql];
        if (!res) {
            DEBUGLOG(@"update order error!")
        }
        
    }];
    return;
}

/**
 *  更新订单的照做信息
 */
- (void)UpdateOrder:(int)orderid FollowVideoId:(NSString *)followVideoId{
    
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];//确保数据库配置正确 alphaDBpath
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET '%@'='%@' WHERE %@ = '%d'", ORDER, FOLLOWVIDEOID, followVideoId, ID, orderid];
        BOOL res = [db2 executeUpdate:updateSql];
        if (!res) {
            DEBUGLOG(@"update order error!")
        }
    }];
    return;
}

/**
 *  更新订单信息（包含订单类型）
 */
- (void)UpdateOrder:(int)orderid ownerCreateTime:(NSString*)createtime Owner:(int)ownerId OrderLength:(float)length HeadTail:(int)headid Filter:(int)filterid Music:(int)musicid SubTitle:(int)subtitleid CustomSubtitle:(NSString*)customsubtitle OrderVideoName:(NSString*)videoname ShareSet:(int)sharestatus OrderStatus:(int)orderstatus OSSID:(int)ossid OrderType:(NSInteger)orderType{
    
    if([customsubtitle isEqualToString:@"(null)"]==YES || customsubtitle == nil)//避免用户自定义字幕  null 问题产生
        customsubtitle = @"";
    
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];//确保数据库配置正确 alphaDBpath
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET '%@'='%@','%@'='%d','%@'='%f','%@'='%d','%@'='%d','%@'='%d','%@'='%d','%@'='%@','%@'='%@','%@'='%d','%@'='%d','%@'= '%d', '%@'= '%ld' WHERE %@ = '%d'",ORDER,CREATETIME,createtime,OWNERID,ownerId,ORDERLENGTH,length,HEADANDTAIL,headid,FILTER,filterid,MUSIC,musicid,SUBTITLE,subtitleid,CUSTOMSUBTITLE,customsubtitle,VIDEONAME,videoname,SHARE,sharestatus,ORDERSTATUS,orderstatus,OSSORDERID,ossid, ORDERTYPE, (long)orderType, ID,orderid];
        BOOL res = [db2 executeUpdate:updateSql];
        if (!res) {
            DEBUGLOG(@"update order error!")
        }
        
    }];
    return;
}

/** 更新已经生成的订单的订单状态（是当前登录用户的订单，后台显示已经制作完成，是传入的这个订单）(如果后台拿到的影片里有这个订单就更新该订单订单状态)*/
- (void)updateOrderStatusWithOrderId:(NSString *)orderId{
    
    [[FMDatabaseQueue databaseQueueWithPath:alphaDBpath] inDatabase:^(FMDatabase *db2) {
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET '%@'='%d' WHERE %@ = '%d' and %@ = '%d' and %@ != '%d'", ORDER, ORDERSTATUS, 5, OWNERID, [CURRENTUSERID intValue], OSSORDERID, [orderId intValue], ORDERSTATUS, 0];
        BOOL res = [db2 executeUpdate:updateSql];
        if (!res) {
            DEBUGLOG(@"update order error!")
        }
        
    }];
}

//查找Order，返回值或者nil
-(NewNSOrderDetail*)SearchOrder:(int)ordid{
    NewNSOrderDetail *ret;
    [theLock lock];
    {
        if ([db_movier open]) {
            NSString * sql = [NSString stringWithFormat:
                              @"SELECT * FROM %@ where %@ = '%d'",ORDER,ID,ordid];
            FMResultSet * rs = [db_movier executeQuery:sql];
            while ([rs next]) {
                ret = [VideoDBOperation fmset2order:rs];
                //            NSLog(@"id = %d, name = %@, age = %@  address = %@", Id, name, age, address);
            };
            [db_movier close];
        }
        [theLock unlock];
    }
    return ret;
}

-(NewNSOrderDetail*)SearchOSSOrder:(int)ossorderid{
    NewNSOrderDetail *ret;
    [theLock lock];
    {
        if ([db_movier open]) {
            NSString * sql = [NSString stringWithFormat:
                              @"SELECT * FROM %@ where %@ = '%d'",ORDER,OSSORDERID,ossorderid];
            FMResultSet * rs = [db_movier executeQuery:sql];
            while ([rs next]) {
                ret = [VideoDBOperation fmset2order:rs];
            };
            [db_movier close];
        }
        [theLock unlock];
    }
    return ret;
}

-(NewNSOrderDetail*)SearchLastOrder{
    NewNSOrderDetail *ret;
    [theLock lock];
    {
        if ([db_movier open]) {
            NSString * sql = [NSString stringWithFormat:
                              @"SELECT * FROM %@ where %@ = (SELECT MAX('%@') FROM %@)",ORDER,ID,ID,ORDER];
            FMResultSet * rs = [db_movier executeQuery:sql];
            while ([rs next]) {
                ret = [VideoDBOperation fmset2order:rs];
            };
            [db_movier close];
        }
        [theLock unlock];
    }
    return ret;
}

- (NSMutableArray*)SearchOrder:(int)ownerid withStatus:(int)type{
    NSMutableArray* ret = [[NSMutableArray alloc]init];
    [theLock lock];
    {
        if ([db_movier open]) {
            NSString * sql = [NSString stringWithFormat:
                              @"SELECT * FROM %@ where %@='%d' and %@='%lu'  Order by ID",ORDER,OWNERID,[CURRENTUSERID intValue],ORDERSTATUS,(unsigned long)type];
            FMResultSet * rs = [db_movier executeQuery:sql];
            while ([rs next]) {
                NewNSOrderDetail *item;
                item = [VideoDBOperation fmset2order:rs];
                [ret addObject:item];
            };
            [db_movier close];
        }
    }
    [theLock unlock];
    return ret;
}

-(NSMutableArray*)SearchAllCommitOrder:(int)ownerid{
    NSMutableArray* ret = [[NSMutableArray alloc]init];
    [theLock lock];
    {
        if ([db_movier open]) {
            NSString * sql = [NSString stringWithFormat:
                              @"SELECT * FROM %@ where %@='%d' and %@='%lu'",ORDER,OWNERID,ownerid,ORDERSTATUS,(unsigned long)COMMITEDORDER];
            FMResultSet * rs = [db_movier executeQuery:sql];
            while ([rs next]) {
                NewNSOrderDetail *item;
                item = [VideoDBOperation fmset2order:rs];
                [ret addObject:item];
            };
            [db_movier close];
        }
        [theLock unlock];
    }
    return ret;
}

-(NSMutableArray*)SearchAllFreshOrder:(int)ownerid{
    return [self SearchOrder:ownerid withStatus:FRESHORDER];
}

-(void)DB_AddMaterial:(NewOrderVideoMaterial*)in Owner:(int)Userid{
    [self AddMaterial:in.order_id Position:in.nIndex Playduration:in.material_playduration Type:in.material_type Owner:Userid LocalPath:in.material_localURL OSSPath:in.material_ossURL AssetsPath:in.material_assetsURL OwnerRegisterTime:in.createTime UploadID:in.multUpID ARid:in.arId RewardType:in.rewardType];
}

-(void)DB_UpdateMaterial:(NewOrderVideoMaterial*)in Owner:(int)Userid{
    [self UpdateMaterail:in.nOrderVideoMaterialID Position:in.nIndex Playduration:in.material_playduration Type:in.material_type Owner:Userid LocalPath:in.material_localURL OSSPath:in.material_ossURL AssetsPath:in.material_assetsURL OwnerRegisterTime:in.createTime UploadID:in.multUpID];
}

//素材操作
-(void)AddMaterial:(int)orderid Position:(int)index Playduration:(float)duration Type:(int)type Owner:(int)ownerid LocalPath:(NSString*)localpath OSSPath:(NSString*)ossPath AssetsPath:(NSString*)assetsURL OwnerRegisterTime:(NSString*)registertime UploadID:(NSString*)uploadid ARid:(NSString *)arid RewardType:(NSInteger)rewardType{
    
    //确保数据库配置正确 alphaDBpath
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *insertSql= [NSString stringWithFormat:
                              @"INSERT INTO %@ ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@','UploadID', '%@', '%@') VALUES ('%d', '%f','%d','%d','%@','%@','%@','%@','%@', '%@', '%ld')",
                              MATERIAL,INDEX,DURATION,MATERIALTYPE,OWNERID,LOCALURL,OSSURL,ASSERTURL,CREATETIME, ARID, REWARDTYPE,
                              index, duration,type,ownerid,localpath,ossPath,assetsURL,registertime,uploadid, arid, (long)rewardType];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            DEBUGLOG(@"insert material error!")
        }
    }];
    return;
}

/**
 *  修改arid
 */
- (void)setHaveARIdWithAssetURL:(NSString *)assetURL ARId:(NSString *)arId{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@' WHERE %@ = '%@'", MATERIAL, ARID, arId, ASSERTURL, assetURL];
        BOOL res = [db2 executeUpdate:updateSql];
        if (!res) {
            DEBUGLOG(@" update materialTable error! ")
        }
    }];
}

-(void)DB_DeleteMaterial:(int)recordid{
    
    //确保数据库配置正确 alphaDBpath
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *delSql= [NSString stringWithFormat:@"DELETE FROM %@ where %@='%d'",MATERIAL,ID,recordid];
        BOOL res = [db2 executeUpdate:delSql];
        if (!res) {
            NSLog(@"error when delete material record");
        }
    }];
    return;
}

-(void)UpdateMaterail:(int)recordid Position:(int)index Playduration:(float)duration Type:(int)type Owner:(int)ownerid LocalPath:(NSString*)localpath OSSPath:(NSString*)ossPath AssetsPath:(NSString*)assetsURL OwnerRegisterTime:(NSString*)registertime UploadID:(NSString*)uploadid{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET '%@'='%d','%@'='%f','%@'='%d','%@'='%d','%@'='%@','%@'='%@','%@'='%@','%@'='%@', 'UploadID'='%@' WHERE %@ = '%d'",MATERIAL,INDEX, index,DURATION, duration,MATERIALTYPE,type,OWNERID,ownerid,LOCALURL,localpath,OSSURL,ossPath,ASSERTURL,assetsURL,CREATETIME,registertime,uploadid,ID,recordid];
        BOOL res = [db2 executeUpdate:updateSql];
        if (!res) {
            NSLog(@"error when update order table");
        }
        
    }];
    return;
}

-(NSMutableArray*)DB_SearchOrderMaterial:(NSArray*)ins;{
    if ([ins count]<1) {
        return nil;
    }
    NSMutableArray* ret = [[NSMutableArray alloc]init];
    {
        [theLock lock];
        if ([db_movier open]) {
            NewOrderVideoMaterial* item = [[NewOrderVideoMaterial alloc]init];
            NSString* materialid = [ins objectAtIndex:0];
            NSString *sqlor = [NSString stringWithFormat:@"where %@ ='%@'",ID,materialid];
            for (int i = 1; i<[ins count]; i++) {
                NSString* tempid = [ins objectAtIndex:i];
                sqlor = [NSString stringWithFormat:@"%@ or %@='%@'",sqlor,ID,tempid];
            }
            NSString * sql = [NSString stringWithFormat:
                              @"SELECT * FROM %@ %@ ORDER BY ID",MATERIAL,sqlor];
            FMResultSet * rs = [db_movier executeQuery:sql];
            while ([rs next]) {
                item = [VideoDBOperation fmset2material:rs];
                [ret addObject:item];
            };
            [db_movier close];
        }
        [theLock unlock];
    }
    return ret;
}

-(NewOrderVideoMaterial*)DB_SearchMaterail:(int)Userid Asserturl:(NSString*)asserturl{
    NewOrderVideoMaterial *ret = [[NewOrderVideoMaterial alloc] init];
    {
        [theLock lock];
        if ([db_movier open]) {
            NSString * sql = [NSString stringWithFormat:
                              @"SELECT * FROM %@ where %@ = '%d' and %@ = '%@'",MATERIAL,OWNERID,Userid,ASSERTURL,asserturl];
            FMResultSet * rs = [db_movier executeQuery:sql];
            while ([rs next]) {
                ret = [VideoDBOperation fmset2material:rs];
            };
            [db_movier close];
        }
        [theLock unlock];
    }
    return ret;
}

#pragma mark - 修改arid
/**
 *  修改arid
 */
- (void)setARIdWithAssetURL:(NSString *)assetURL{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@' WHERE %@ = '%@'", MATERIAL, ARID, @"0", ASSERTURL, assetURL];
        BOOL res = [db2 executeUpdate:updateSql];
        if (!res) {
            DEBUGLOG(@" update materialTable error! ")
        }
    }];
}

/**
 *  修改rewardType
 */
- (void)setRewardTypeWithAssetURL:(NSString *)assetURL{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@' WHERE %@ = '%@'", MATERIAL, REWARDTYPE, @"0", ASSERTURL, assetURL];
        BOOL res = [db2 executeUpdate:updateSql];
        if (!res) {
            DEBUGLOG(@" update materialTable error! ")
        }
    }];
}

-(NewOrderVideoMaterial*)DB_SearchMaterail:(int)Userid LocalURL:(NSString*)localpath{
    NewOrderVideoMaterial *ret = [[NewOrderVideoMaterial alloc]init];
    {
        [theLock lock];
        if ([db_movier open]) {
            NSString * sql = [NSString stringWithFormat:
                              @"SELECT * FROM %@ where %@ = '%d' and %@ = '%@'",MATERIAL,OWNERID,Userid,LOCALURL,localpath];
            FMResultSet * rs = [db_movier executeQuery:sql];
            while ([rs next]) {
                ret = [VideoDBOperation fmset2material:rs];
            };
            [db_movier close];
        }
        [theLock unlock];
    }
    return ret;
}

-(NewOrderVideoMaterial*)SearchMaterail:(int)materialid{
    NewOrderVideoMaterial *ret;
    [theLock lock];
    {
        if ([db_movier open]) {
            NSString * sql = [NSString stringWithFormat:
                              @"SELECT * FROM %@ where %@ = '%d'",MATERIAL,ID,materialid];
            FMResultSet * rs = [db_movier executeQuery:sql];
            while ([rs next]) {
                ret = [VideoDBOperation fmset2material:rs];
            };
            [db_movier close];
        }
        [theLock unlock];
    }
    return ret;
}

-(void)DB_AddMaterialwithOrder:(NewOrderVideoMaterial*)in Order:(int)orderid{
    
    //确保数据库配置正确 alphaDBpath
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        
        //MATERIAL,ID,ORDERID,INDEX,DURATION,MATERIALTYPE,OWNERID,LOCALURL,OSSURL,ASSERTURL,CREATETIME
        NSString *insertSql= [NSString stringWithFormat:
                              @"INSERT INTO %@ ('%@', '%@') VALUES ('%d','%d')",
                              MATERIAL2ORDER,ORDERID,MATERIALID,orderid,in.nOrderVideoMaterialID];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            NSLog(@"error when insert material record");
        }
    }];
    return;
}
-(NSMutableArray*)DB_SearchMaterails:(int)order{
    NSMutableArray *ret = [[NSMutableArray alloc]init];
    
    [theLock lock];
    {
        if ([db_movier open]) {
            NSString *Sql= [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%d'",MATERIAL2ORDER,ORDERID,order];
            FMResultSet * rs = [db_movier executeQuery:Sql];
            while ([rs next]) {
                [ret addObject:[rs stringForColumn:MATERIALID]];
            };
            [db_movier close];
        }
        [theLock unlock];
    }
    return ret;
}

-(void)DB_DeleteMaterialINOrder:(int)materialId{
    
    //确保数据库配置正确 alphaDBpath
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *delSql= [NSString stringWithFormat:@"DELETE FROM %@ where %@='%d'",MATERIAL2ORDER,MATERIALID,materialId];
        BOOL res = [db2 executeUpdate:delSql];
        if (!res) {
            NSLog(@"error when delete  material2Order record");
        }
    }];
}

#pragma mark ---- 补充缺少的 parentid 字段

-(void)DB_AddLabel:(NSString*)labelname labelId:(NSNumber*)labelid Parent:(NSNumber*)parentid Thumbnail:(NSString*)szThumbnail Type:(NSNumber*)labeltype{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *insertSql= [NSString stringWithFormat:
                              @"INSERT INTO %@ ('LABELID', 'NAME', 'PLABEL', 'nType', 'szThumbnail') VALUES ('%@', '%@', '%@', '%@', '%@')",
                              LABELS, labelid, labelname, parentid,labeltype, szThumbnail];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            NSLog(@"error when insert LABELS record");
        }
    }];
    return;
}
-(NSMutableArray*)DB_GetLabels:(NSNumber*)parentid{
    NSMutableArray *ret = [[NSMutableArray alloc]init];
    [theLock lock];
    {
        if ([db_movier open]) {
            NSString *Sql= [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'",LABELS,@"PLABEL",parentid];
            FMResultSet * rs = [db_movier executeQuery:Sql];
            while ([rs next]) {
                NSDictionary *Item = [NSDictionary
                                      dictionaryWithObjectsAndKeys:[rs stringForColumn:@"NAME"],@"labelname",
                                      [rs stringForColumn:@"LABELID"],@"labelid",
                                      ([rs stringForColumn:@"PLABEL"]==nil)?@"0":[rs stringForColumn:@"PLABEL"],@"parentid",
                                      [rs stringForColumn:@"nType"],@"labeltype",
                                      ([rs stringForColumn:@"szThumbnail"])?@"":[rs stringForColumn:@"IMAGEURL"],@"labelurl",
                                      nil];
                [ret addObject:Item];
            };
            [db_movier close];
        }
        [theLock unlock];
    }
    return ret;
}

-(NSDictionary*)DB_GetLabelInfo:(NSNumber*)labelid{
    NSDictionary *Info;
    [theLock lock];
    {
        if ([db_movier open]) {
            NSString * sql = [NSString stringWithFormat:@"SELECT * FROM LABELS WHERE LABELID = '%@'", labelid];
            FMResultSet *rs = [db_movier executeQuery:sql];
            while ([rs next]) {
                Info = [NSDictionary dictionaryWithObjectsAndKeys:
                        [rs stringForColumn:@"NAME"],@"labelname" ,
                        [rs stringForColumn:@"TYPE"],@"labeltype",
                        ([rs stringForColumn:@"IMAGEURL"])?@"":[rs stringForColumn:@"IMAGEURL"],@"labelurl",
                        ([rs stringForColumn:@"PLABEL"]==nil)?@"0":[rs stringForColumn:@"PLABEL"],@"parentid",
                        [NSString stringWithFormat:@"%@",labelid],@"labelid",nil];
                
            }
            [db_movier close];
        }
        [theLock unlock];
    }
    return Info;
}

-(void)DB_DeleteLabelByParentId:(NSNumber*)parentid {
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *insertSql= [NSString stringWithFormat:
                              @"DELETE FROM %@ WHERE PLABEL = '%@'",
                              LABELS,parentid];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            NSLog(@"error when DELETE PLABEL record (%@)", parentid);
        }
    }];
    return;
}

-(void)DB_ModifyLabel:(NSString*)labelname labelId:(NSNumber*)labelid Parent:(NSNumber*)parentid Thumbnail:(NSString*)szThumbnail Type:(NSNumber*)labeltype{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE LABELS SET NAME = '%@', PLABEL='%@', TYPE='%@',IMAGEURL='%@' WHERE LABELID = '%@'", labelname, parentid,labeltype,szThumbnail,labelid];
        BOOL res = [db2 executeUpdate:updateSql];
        if (!res) {
            NSLog(@"error when UPDATE LABEL record (%@)",labelid);
        }
    }];
}

#pragma mark ---------

/**  根据 videoID 查询视频读取状态 readStatus */
- (int)readStatusByVideoID:(int)videoID {
    
    //假设未播放设置0 如果播放过就设置1
    int hasRead = 0;
    
    // 打开数据库
    [theLock lock];
    {
        if ([db_movier open]) {
            NSString * sql = [NSString stringWithFormat:@"SELECT * FROM PERSONALVIDEO WHERE %@ = '%d'", VIDEOID, videoID];
            FMResultSet *ret = [db_movier executeQuery:sql];
            while ([ret next]) {
                if ([ret intForColumn:HASREAD]) {
                    hasRead = [ret intForColumn:HASREAD];
                }
            }
            [db_movier close];
        }
        [theLock unlock];
    }
    return hasRead;
}

/**  根据 videoID 修改视频读取状态 readStatus */
- (BOOL)modefyReadStatusByVideoID:(int)videoID {
    __block BOOL isSuccess = NO;
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE PERSONALVIDEO SET %@ = '%d' WHERE %@ = '%d'", HASREAD, 1, VIDEOID, videoID];
        isSuccess = [db2 executeUpdate:updateSql];
    }];
    return isSuccess;
}

/**  获得个人表PERSONALVIDEO 中的所有 videoID */
- (NSArray *)allVideoIDs {
    NSMutableArray *videoIDs = [NSMutableArray array];
    
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:PERSONALVIDEO];
            if (isExists) {
                
                // 表格存在, 遍历表格
                FMResultSet *result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@", PERSONALVIDEO]];
                while ([result next]) {
                    int videoID = [result intForColumn:VIDEOID];
                    [videoIDs addObject:@(videoID)];
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    return videoIDs;
}

/** 从数据库中  获得当前未播放的视频数  （0为未播放）*/
- (NSNumber *)getNoPlayVideoNum {
    NSArray *videoIds = [self allVideoIDs];
    int count = 0;
    for (NSNumber *number in videoIds) {
        int ret = [self readStatusByVideoID:[number intValue]];
        if (ret == 0) {
            count ++;
        }
    }
    return @(count);
}

#pragma mark ---------模板操作

-(void)DB_ClearTempCat{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *clearTempcat = [NSString stringWithFormat:@"delete from TemplateCat"];
        BOOL res = [db2 executeUpdate:clearTempcat];
        if (!res) {
            NSLog(@"error when clearTempcat table");
        }
    }];
}

-(NSInteger)DB_GetTempCatNum{
    [theLock lock];
    int temp;
    if ([db_movier open]) {
        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM TemplateCat"];
        FMResultSet * rs = [db_movier executeQuery:sql];
        while ([rs next]) {
            temp = [rs columnCount];
        };
        [db_movier close];
    }
    [theLock unlock];
    return (long)temp;
}

-(NSMutableArray*)DB_GetTempCat{
    [theLock lock];
    NSMutableArray *ret = [[NSMutableArray alloc]init];
    if ([db_movier open]) {
        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM TemplateCat"];
        FMResultSet * rs = [db_movier executeQuery:sql];
        while ([rs next]) {
            MovierDCInterfaceSvc_TemplateCat *item = [[MovierDCInterfaceSvc_TemplateCat alloc]init];
            item.nID = [NSNumber numberWithInt:[rs intForColumn:@"nID"]];
            item.szName = [rs stringForColumn:@"szName"];
            item.szThumbnail = [rs stringForColumn:@"szReference"];
            item.szDesc = [rs stringForColumn:@"szDesc"];
            [ret addObject:item];
        };
        [db_movier close];
    }
    [theLock unlock];
    return ret;
}

-(void)DB_AddTempCat:(NSInteger)recordID CatName:(NSString *)catname CatReference:(NSString*)referenceURL CatDesc:(NSString*)description{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *insertSql= [NSString stringWithFormat:
                              @"INSERT INTO TemplateCat('nID','szName','szReference','szDesc') VALUES ('%zi', '%@', '%@','%@')",
                              recordID,catname,referenceURL,description];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            NSLog(@"error when insert TemplateCat table");
        }
    }];
}

-(void)DB_ClearTemp:(NSNumber*)TempID{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *clearTempcat = [NSString stringWithFormat:@"delete from STYLE where nID = '%@'",TempID];
        BOOL res = [db2 executeUpdate:clearTempcat];
        if (!res) {
            NSLog(@"error when clearTempcat table");
        }
    }];
}

-(NSInteger)DB_GetTempNum:(NSNumber*)CatID{
    [theLock lock];
    NSInteger ret;
    if ([db_movier open]) {
        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM CatAndStyle where nCatID = '%@'",CatID];
        FMResultSet * rs = [db_movier executeQuery:sql];
        ret = [rs columnCount];
        [db_movier close];
    }
    [theLock unlock];
    return ret;
}

//MovierDCInterfaceSvc_vpVDCHeaderAndTailC  数组
-(NSMutableArray*)DB_GetTempByCat:(NSNumber*)CatID{
    [theLock lock];
    NSMutableArray *ret = [[NSMutableArray alloc]init];
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    if ([db_movier open]) {
        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM CatAndStyle where nCatID = '%@'",CatID];
        FMResultSet * rs = [db_movier executeQuery:sql];
        while ([rs next]) {
            NSNumber *newitem = [NSNumber numberWithInt:[rs intForColumn:@"nStyleID"]];
            [temp addObject:newitem];
        }
        for (NSNumber* item in temp) {
            NSString * sqlstyle = [NSString stringWithFormat:@"SELECT * FROM STYLE where nID = '%@'",item];
            FMResultSet * rsstyle = [db_movier executeQuery:sqlstyle];
            while ([rsstyle next]) {
                MovierDCInterfaceSvc_vpVDCHeaderAndTailC *item = [[MovierDCInterfaceSvc_vpVDCHeaderAndTailC alloc]init];
                item.nID = [NSNumber numberWithInt:[rsstyle intForColumn:@"nID"]];
                item.nHeaderAndTailStyle = [NSNumber numberWithInt:[rsstyle intForColumn:@"nHeaderAndTailStyle"]];
                item.szName = [rsstyle stringForColumn:@"szName"];
                item.szThumbnail = [rsstyle stringForColumn:@"szThumbnail"];
                item.szReference = [rsstyle stringForColumn:@"szReference"];
                item.szDesc = [rsstyle stringForColumn:@"szDesc"];
                item.nHotIndex = [NSNumber numberWithInt:[rsstyle intForColumn:@"nHotIndex"]];
                item.szFit = [rsstyle stringForColumn:@"Applicable_Scene"];
                [ret addObject:item];
            };
        }
        [db_movier close];
    }
    [theLock unlock];
    return ret;
}

-(BOOL)DB_GetTemp:(NSNumber*)styleID{
    [theLock lock];
    BOOL ret = FALSE;
    if ([db_movier open]) {
        NSString * sqlstyle = [NSString stringWithFormat:@"SELECT COUNT(*) FROM STYLE where nID = '%@'",styleID];
        NSUInteger count = [db_movier intForQuery:sqlstyle];
        if(count>=1)
            ret = TRUE;
        [db_movier close];
    }
    [theLock unlock];
    return ret;
}


-(void)DB_AddTemp:(NSNumber*)tempID Serverid:(NSNumber*)vdcStyleid StyleName:(NSString*)szName Thumbnail:(NSString*)thumb URL:(NSString*)reference Describe:(NSString*)desc Hot:(NSNumber*)hot Scene:(NSString*)scene{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *insertSql= [NSString stringWithFormat:
                              @"INSERT INTO STYLE('nID','nHeaderAndTailStyle','szName','szThumbnail','szReference','szDesc','nHotIndex','Applicable_Scene') VALUES ('%@', '%@', '%@','%@', '%@', '%@', '%@', '%@')",
                              tempID,vdcStyleid,szName,thumb,reference,desc,hot,scene];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            NSLog(@"error when insert STYLE table");
        }
    }];
}

-(void)DB_AddMapCatStyle:(NSNumber*)catid Style:(NSNumber*)styleid{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *insertSql= [NSString stringWithFormat:@"INSERT INTO CatAndStyle('nCatID','nStyleID') VALUES ('%@', '%@')",catid,styleid];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            NSLog(@"error when insert CatAndStyle table");
        }
    }];
}

-(BOOL)DB_getStyle:(NSNumber*)vdcStyleid{
    [theLock lock];
    BOOL ret = FALSE;
    if ([db_movier open]) {
        NSString * sql = [NSString stringWithFormat:@"SELECT COUNT(*) FROM STYLE where nID = '%@'",vdcStyleid];
        FMResultSet * rs = [db_movier executeQuery:sql];
        if([rs intForColumnIndex:0]==1)
            ret = TRUE;
        [db_movier close];
    }
    [theLock unlock];
    return ret;
}

-(BOOL)DB_getStyleAndCat:(NSNumber*)vdcStyleid Catid:(NSNumber*)catid{
    [theLock lock];
    BOOL ret = FALSE;
    if ([db_movier open]) {
        NSString * sql = [NSString stringWithFormat:@"SELECT COUNT(*) FROM CatAndStyle where nStyleID = '%@' AND nCatID = '%@'",vdcStyleid,catid];
        NSUInteger count = [db_movier intForQuery:sql];
        if(count>=1)
            ret = TRUE;
        [db_movier close];
    }
    [theLock unlock];
    return ret;
}

-(NSMutableArray*)DB_FindStyle:(NSNumber*)catid{
    [theLock lock];
    NSMutableArray *ret = [[NSMutableArray alloc]init];
    if ([db_movier open]) {
        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM CatAndStyle where nCatID = '%@'",catid];
        FMResultSet * rs = [db_movier executeQuery:sql];
        while ([rs next]) {
            NSNumber *newitem = [NSNumber numberWithInt:[rs intForColumn:@"nStyleID"]];
            [ret addObject:newitem];
        }
        [db_movier close];
    }
    [theLock unlock];
    return ret;
}

- (void)DB_RemoveCatAndStyle:(NSNumber*)catid{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *deleteSql = [NSString stringWithFormat:
                               @"delete from CatAndStyle where nCatID = '%@'",catid];
        BOOL res = [db2 executeUpdate:deleteSql];
        if (!res) {
            NSLog(@"error when delete CatAndStyle table");
        }
        
    }];
    return;
}

- (void)MC_AddTemp:(MovierDCInterfaceSvc_vpVDCHeaderAndTailC*)addItem CatID:(NSNumber*)catid{
    if (![self DB_GetTemp:addItem.nID]) {
        [self DB_AddTemp:addItem.nID Serverid:addItem.nHeaderAndTailStyle StyleName:addItem.szName Thumbnail:addItem.szThumbnail URL:addItem.szReference Describe:addItem.szDesc Hot:addItem.nHotIndex Scene:addItem.szFit];
    };
    if (![self DB_getStyleAndCat:addItem.nID Catid:catid]){
        [self DB_AddMapCatStyle:catid Style:addItem.nID];
    };
}

-(void)MC_CleanAllTemp:(NSNumber*)catid{
    NSMutableArray *result = [self DB_FindStyle:catid];
    for (NSNumber* item in result) {
        [self DB_ClearTemp:item];
    }
    [self DB_RemoveCatAndStyle:catid];
}

#pragma mark - 用户搜索记录操作
//增加用户搜索记录
- (void)DB_AddRecord:(NSString *)record
{
    if(record.length == 0){
        return;
    }
    else if(record.length != 0){
        BOOL isRepeat = NO;
        NSArray * recordArray = [[VideoDBOperation Singleton] findRecord];
        for (NSString * everyRecord in recordArray) {
            if ([[NSString stringWithFormat:@"%@", record] isEqualToString:everyRecord]) {
                isRepeat = YES;
            }
        }
        if (isRepeat) {
            return;
        }
    }
    //如果记录条数大于10，更新所有的数据 （把数据放到一个数组里，然后update）
    NSArray * recordArray = [[VideoDBOperation Singleton] DB_FindRecord];
    if (recordArray.count >= 10) {
        //更新所有的行
        NSMutableArray * newRecordArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 10; i++) {
            if (i < 9) {
                [newRecordArray addObject:recordArray[i + 1]];
            }
            else
            {
                [newRecordArray addObject:[NSString stringWithFormat:@"%@", record]];
            }
        }
        for (int i = 0; i < 10; i++) {
            FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
            [queue inDatabase:^(FMDatabase *db2) {
                NSString * updateSql = [NSString stringWithFormat:@"update %@ set %@ = '%@' where %@ = '%@'", USERSEARCHRECORD, SEARCHRECORD, newRecordArray[i], ID, [NSString stringWithFormat:@"%d", i + 1]];
                BOOL isSuccess = [db2 executeUpdate:updateSql];
                if (!isSuccess) {
                    NSLog(@"error update USERSEARCHRECORD");
                }
            }];
        }
    }
    else
    {
        FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
        [queue inDatabase:^(FMDatabase *db2) {
            NSString * insertSql = [NSString stringWithFormat:@"insert into %@('%@', '%@') values ('%@', '%@')", USERSEARCHRECORD, ID, SEARCHRECORD, [NSString stringWithFormat:@"%lu", recordArray.count + 1], record];
            BOOL isSuccess = [db2 executeUpdate:insertSql];
            if (!isSuccess) {
                NSLog(@"error insert USERSEARCHRECORD");
            }
        }];
    }
}

//删除所有的记录
- (void)DeleteAllRecord
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString * deleteSql = [NSString stringWithFormat:@"delete from %@", USERSEARCHRECORD];
        BOOL isSuccess = [db2 executeUpdate:deleteSql];
        if (!isSuccess) {
            NSLog(@"error delete USERSEARCHRECORD");
        }
    }];
}

//查询用户搜索记录(全部 从旧到新)
- (NSArray *)DB_FindRecord
{
    NSMutableArray * ret = [[NSMutableArray alloc] init];
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:USERSEARCHRECORD];
            if (isExists) {
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@", USERSEARCHRECORD]];
                while ([result next]) {
                    NSString * record = [result stringForColumn:SEARCHRECORD];
                    [ret addObject:record];
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    return [ret copy];
}

//查询用户搜索记录(全部 从新到旧)
- (NSArray *)findRecord
{
    NSArray * recordArray = [[VideoDBOperation Singleton] DB_FindRecord];
    NSMutableArray * newRecordArray = [[NSMutableArray alloc] init];
    for(int i = recordArray.count - 1; i >= 0; i--){
        id obj = recordArray[i];
        [newRecordArray addObject:obj];
    }
    if (newRecordArray.count >= 4) {
        [newRecordArray addObject:@"清空搜索记录"];
    }
    return newRecordArray;
}

//查询最新的三条搜索记录(小于三 或者 等于三)
- (NSArray *)findRecentRecord
{
    NSArray * recordArray = [[VideoDBOperation Singleton] findRecord];
    NSMutableArray * newRecordArray = [[NSMutableArray alloc] init];
    if (recordArray.count >= 3) {
        for (int i = 0; i < 3; i++) {
            NSString * obj = recordArray[i];
            [newRecordArray addObject:obj];
        }
        [newRecordArray addObject:@"全部搜索记录"];
    }
    else if(recordArray.count < 3)
    {
        for (id obj in recordArray) {
            [newRecordArray addObject:obj];
        }
    }
    return newRecordArray;
}


#pragma mark - 用户选择音乐时的搜索数据操作
//添加搜索记录到数据库中
- (void)addSearchMusicRecord:(NSString *)searchMusic{
    if ([[searchMusic stringByReplacingOccurrencesOfString:@" " withString:@""] length] == 0) {
        return;
    }
    NSArray * recordArray = [self getAllSearchMusicRecord];
    NSMutableArray * newRecordArray = [NSMutableArray arrayWithArray:recordArray];
    for (int i = 0; i < newRecordArray.count; i++) {
        NSString * musicRecord = recordArray[i];
        if ([searchMusic isEqualToString:musicRecord]) {
            return;
        }
    }
    
    [newRecordArray addObject:searchMusic];
    for (int i = 0; i < newRecordArray.count; i++) {
        NSString * musicRecord = newRecordArray[i];
        if (musicRecord.length == 0) {
            [newRecordArray removeObject:musicRecord];
        }
    }
    
    if (recordArray.count >= 10) {
        
        for (int i = 1; i < newRecordArray.count; i++) {
            FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
            [queue inDatabase:^(FMDatabase *db) {
                BOOL isSuccess = [db executeUpdate:[NSString stringWithFormat:@"update %@ set %@ = '%@' where %@ = '%@'", USERSEARECHMUSICRECORD, SEARCHRECORD, newRecordArray[i], ID, [NSString stringWithFormat:@"%d", i + 1]]];
                if (!isSuccess) {
                    NSLog(@"error update USERSEARECHMUSICRECORD table");
                }
            }];
        }
        
    }
    else{
        FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
        [queue inDatabase:^(FMDatabase *db) {
            BOOL isSuccess = [db executeUpdate:[NSString stringWithFormat:@"insert into %@('%@', '%@') values('%@', '%@')", USERSEARECHMUSICRECORD, ID, SEARCHRECORD, [NSString stringWithFormat:@"%lu", [newRecordArray count] + 1], searchMusic]];
            if (!isSuccess) {
                NSLog(@"error insert USERSEARECHMUSICRECORD table");
            }
        }];
    }
}

//删除所有记录
- (void)deleteSearchMusicRecord
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db) {
        BOOL isSuccess = [db executeUpdate:[NSString stringWithFormat:@"delete from %@", USERSEARECHMUSICRECORD]];
        if (!isSuccess) {
            NSLog(@"error delete USERSEARECHMUSICRECORD table");
        }
    }];
}

//获取该表中的所有数据（从新到旧）
- (NSArray *)getAllMusicRecord{
    NSArray * recoreArray = [self getAllSearchMusicRecord];
    NSMutableArray * muArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = recoreArray.count - 1; i >= 0; i--) {
        [muArray addObject:recoreArray[i]];
    }
    if (recoreArray.count >= 1) {
        [muArray addObject:@"清空记录"];
    }
    return [muArray copy];
}

//获取该表中的所有数据(从旧到新)
- (NSArray *)getAllSearchMusicRecord{
    NSMutableArray * muArray = [NSMutableArray arrayWithCapacity:0];
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isSuccess = [db_movier tableExists:USERSEARECHMUSICRECORD];
            if (isSuccess) {
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@", USERSEARECHMUSICRECORD]];
                while ([result next]) {
                    NSString * record = [result stringForColumn:SEARCHRECORD];
                    [muArray addObject:record];
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    return [muArray copy];
}




#pragma mark - ---------------------------------------消息通知表-----------------------------------------
//增操作（消息表）
- (void)addMesWithObj:(MessageObj *)mesObj{
    
    //删除过期的消息（id超过一千）
    [self deleteMes];
    
    //插入新数据
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *insertSql= [NSString stringWithFormat:@"INSERT INTO %@('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@') VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')", USERMESSAGETABLE, DSTCONTENT, DSTCONTENTID, DSTCUSTOMERID, LINKLABELID, LINKTYPE, LINKURL, SRCAVATAR, SRCCONTENT, SRCCONTENTID, SRCCUSTOMERID, SRCNICKNAME, TERM, TIME, MESVIDEOID, VIDEOLABELID, MESVIDEOLABELNAME, MESVIDEONAME, VIDEOTHUMBNAIL, MESVIDEOURL, ISREAD, mesObj.dstcontent, mesObj.dstcontentid, mesObj.dstcustomerid, mesObj.linklabelid, mesObj.linktype, mesObj.linkurl, mesObj.srcavatar, mesObj.srccontent, mesObj.srccontentid, mesObj.srccustomerid, mesObj.srcnickname, mesObj.term, mesObj.time, mesObj.videoid, mesObj.videolabelid, mesObj.videolabelname, mesObj.videoname, mesObj.videothumbnail, mesObj.videourl, mesObj.isRead];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            NSLog(@"error when insert USERMESSAGETABLE table");
        }
    }];
    
    //刷新提示数据
    [self setBadgeNum];
}

/** 查找某个新影片生成的消息有没有已经存在数据库中(当前用户，新影片的术语，videoId)*/
- (BOOL)selectOneNewVideoBornMesWithVideoId:(NSString *)videoId{
    BOOL isHave = NO;
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:USERMESSAGETABLE];
            if (isExists) {
                
                //查询未读的消息标的消息数量
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ = '%@' and %@ = '%@' and %@ = '%@'", USERMESSAGETABLE, DSTCUSTOMERID, CURRENTUSERID, TERM, NEWVIDEOTERM, MESVIDEOID, videoId]];
                while ([result next]) {
                    isHave = YES;
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    return isHave;
}

/** 设置badgenum(消息部分界面数字改变通知一致从这里发出)（查找依据：是当前登录用户（如果没有用户登录，置为零，当前的方法是可以实现的，直接根据用户id判断就可以）、未读）*/
- (void)setBadgeNum{
    NSInteger noReadNum = 0;
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:USERMESSAGETABLE];
            if (isExists) {
                //查询未读的消息标的消息数量
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ = '%@' and %@ = '%@'", USERMESSAGETABLE, DSTCUSTOMERID, CURRENTUSERID, ISREAD, @"0"]];
                while ([result next]) {
                    noReadNum++;
                }
                
                //查询未读的好友消息
                FMResultSet * result2 = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ = '%@' and %@ = '%@'", FRIENDMESTAB, FRIENDMESENDUSERID, CURRENTUSERID, FRIENDMESREADSTATUS, @"0"]];
                while ([result2 next]) {
                    noReadNum++;
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    MAINQUEUEUPDATEUI({
        [UIApplication sharedApplication].applicationIconBadgeNumber = noReadNum;
        POSTNOTI(UPDATEPROPMTLABELTEXT, nil);
    })
}

//删除id超过一千的数据（消息表）
- (void)deleteMes{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *deleteSql = [NSString stringWithFormat:
                               @"delete from %@ where ID > 1000", USERMESSAGETABLE];
        BOOL res = [db2 executeUpdate:deleteSql];
        if (!res) {
            NSLog(@"error when delete USERMESSAGETABLE table");
        }
        
    }];
    return;
}

//查询所有的对应术语的数据（消息通知）
//查找所有数据(需要匹配术语和当前登录用户的id)，只要被查找过，就证明被读过，就更新所有查到的每条数据的isread字段为已读，同时更新badge的数量
- (NSArray *)getDataWithTerm:(NSString *)dataTerm{
    NSMutableArray * ret = [NSMutableArray new];
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:USERMESSAGETABLE];
            if (isExists) {
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ = '%@' and %@ = '%@' order by %@ desc", USERMESSAGETABLE, TERM, dataTerm, DSTCUSTOMERID, [UserEntity sharedSingleton].customerId, TIME]];
                while ([result next]) {
                    [ret addObject:[MessageObj getMesObjWithDBData:result]];
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    
    [self updateAlreadyReadDataStatusWithTerm:dataTerm];
    
    return [ret copy];
}

/** 更新查过的数据的观看状态*/
- (void)updateAlreadyReadDataStatusWithTerm:(NSString *)dataTerm{
    //修改查过的数据的观看状态
    [[FMDatabaseQueue databaseQueueWithPath:alphaDBpath] inDatabase:^(FMDatabase *db2) {
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@' WHERE %@ = '%@' and %@ = '%@' and %@ = '%@'", USERMESSAGETABLE, ISREAD, @"1", DSTCUSTOMERID, CURRENTUSERID, TERM, dataTerm, ISREAD, @"0"];
        
        BOOL isSuccess = [db2 executeUpdate:updateSql];
        if (!isSuccess) {
            DEBUGLOG(@"update USERMESSAGETABLE error");
        }
    }];
    [self setBadgeNum];
}

/** 获得评论和回复的内容*/
- (NSArray *)getCommentDataAndCommentReplyData{
    NSMutableArray * ret = [NSMutableArray new];
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:USERMESSAGETABLE];
            if (isExists) {
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ in('%@', '%@') and %@ = '%@' order by %@ desc", USERMESSAGETABLE, TERM, COMMENTSTERM, REPLYTERM, DSTCUSTOMERID, [UserEntity sharedSingleton].customerId, TIME]];
                while ([result next]) {
                    [ret addObject:[MessageObj getMesObjWithDBData:result]];
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    
    [self updateAlreadyReadDataStatusWithTerm:COMMENTSTERM];
    [self updateAlreadyReadDataStatusWithTerm:REPLYTERM];
    
    return [ret copy];
}

/** 获得收藏和关注的数据*/
- (NSArray *)getCollectDataAndCareData{
    NSMutableArray * ret = [NSMutableArray new];
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:USERMESSAGETABLE];
            if (isExists) {
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ in('%@', '%@') and %@ = '%@' order by %@ desc", USERMESSAGETABLE, TERM, CARETERM, COLLECTTERM, DSTCUSTOMERID, [UserEntity sharedSingleton].customerId, TIME]];
                while ([result next]) {
                    [ret addObject:[MessageObj getMesObjWithDBData:result]];
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    
    [self updateAlreadyReadDataStatusWithTerm:COLLECTTERM];
    [self updateAlreadyReadDataStatusWithTerm:CARETERM];
    
    return [ret copy];
}

/** 获得当前用户未读的消息数量(消息表中的未读消息)*/
- (NSInteger)getAllNoReadDataWithDataTerm:(NSString *)dataTerm{
    NSInteger noReadNum = 0;
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:USERMESSAGETABLE];
            if (isExists) {
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ = '%@' and %@ = '%@' and %@ = '%@'", USERMESSAGETABLE, ISREAD, @"0", DSTCUSTOMERID, [UserEntity sharedSingleton].customerId, TERM, dataTerm]];
                while ([result next]) {
                    noReadNum++;
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    return noReadNum;
}

/** 获得未观看的新影片的数量（收消息的人是我，状态未观看，新影片的术语）*/
- (NSInteger)getNoPlayNewVideoNum{
    NSInteger noReadNum = 0;
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:USERMESSAGETABLE];
            if (isExists) {
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ = '%@' and %@ = '%@' and %@ = '%@'", USERMESSAGETABLE, ISREAD, @"0", DSTCUSTOMERID, [UserEntity sharedSingleton].customerId, TERM, NEWVIDEOTERM]];
                while ([result next]) {
                    noReadNum++;
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    return noReadNum;
}


/** 查看某个影片是否未观看(是当前登录用户，是新影片消息，是这个videoId)*/
- (NSString *)getNewVideoReadStatus:(NSString *)videoId{
    NSString * readStatus = @"表中没有该影片";
    [theLock lock];
    {
        if ([db_movier open]) {
            if ([db_movier tableExists:USERMESSAGETABLE]) {
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ = '%@' and %@ = '%@' and %@ = '%@'", USERMESSAGETABLE, DSTCUSTOMERID, CURRENTUSERID, TERM, NEWVIDEOTERM, MESVIDEOID, videoId]];
                while ([result next]) {
                    if ([[result stringForColumn:ISREAD] boolValue]) {
                        readStatus = @"已观看";
                    }else{
                        readStatus = @"未观看";
                    }
                }
            }
        }
    }
    [theLock unlock];
    return readStatus;
}

/** 修改该影片的观看状态(当前用户为接受者，观看状态为未观看，videoid对应，是新影片消息)*/
- (void)updateNewVideoReadStatus:(NSString *)videoId{
    //先查一下该影片有没有观看，未观看的话执行更新，已观看的话不执行
    if ([[self getNewVideoReadStatus:videoId] isEqualToString:@"表中没有该影片"] || [[self getNewVideoReadStatus:videoId] isEqualToString:@"已观看"]) {
        //已观看不需要更改
        return;
    }
    
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        BOOL isSuccess = NO;
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@' WHERE %@ = '%@' and %@ = '%@' and %@ = '%@' and %@ = '%@'", USERMESSAGETABLE, ISREAD, @"1", DSTCUSTOMERID, CURRENTUSERID, TERM, NEWVIDEOTERM, ISREAD, @"0", MESVIDEOID, videoId];
        isSuccess = [db2 executeUpdate:updateSql];
        if (!isSuccess) {
            DEBUGLOG(@"update USERMESSAGETABLE error");
        }
    }];
    
    [self setBadgeNum];
    
}
#pragma mark - 好友数据库

/** 增加好友或者粉丝或者关注*/
- (void)addFiendWithModel:(FriendModel *)friendModel{
    
    if ([self selectOneFriend:friendModel.userId FriendType:friendModel.friendType]) {
        return;
    }
    
    //插入新数据
    [[FMDatabaseQueue databaseQueueWithPath:alphaDBpath] inDatabase:^(FMDatabase *db2) {
        if (friendModel.nickName == NULL) {
            friendModel.nickName = @"";
        }
        if (friendModel.signature == NULL) {
            friendModel.signature = @"";
        }
        NSString * friendNickname = friendModel.nickName;
        NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:
                                     @"~!@#$%^&*()_+`{}|:<>?-=[]\\;',./~！@#￥%……&*（）——+·{}|：“《》？-=【】、；‘，。、"];
        friendNickname = [[friendNickname componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
        
        
        NSString * friendSignature = friendModel.signature;
        friendSignature = [[friendSignature componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
        
        NSString *insertSql= [NSString stringWithFormat:@"INSERT INTO %@('%@','%@','%@','%@','%@','%@','%@','%@') VALUES ('%@','%@','%@','%@','%@','%@','%@','%@')", FRIENDTAB, FRIENDUSERID, FRIENDHEADURL, FRIENDNICKNAME, FRIENDVIDEONUM, FRIENDVIDEOCOLLECTTIMES, FRIENDSIGNATURE, FRIENDTYPE, FRIENDWITHWHO, friendModel.userId, friendModel.iconURL, friendNickname, friendModel.videoNum, friendModel.videoCollectTimes, friendSignature, friendModel.friendType, CURRENTUSERID];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            DEBUGLOG(@"insert FRIENDTAB");
        }
    }];
}

/** 将数组中的好友或者粉丝或者关注加入数据库中*/
- (void)addFriendWithArray:(NSArray *)friendArray FriendType:(NSString *)friendType{
    [self deleteFriendTabWithType:friendType];
    
    //插入新数据
    [[FMDatabaseQueue databaseQueueWithPath:alphaDBpath] inDatabase:^(FMDatabase *db2) {
        if (friendArray.count > 0) {
            for (FriendModel * friendModel in friendArray) {
                NSString * friendNickname = friendModel.nickName;
                NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:
                                             @"~!@#$%^&*()_+`{}|:<>?-=[]\\;',./~！@#￥%……&*（）——+·{}|：“《》？-=【】、；‘，。、"];
                friendNickname = [[friendNickname componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
                
                
                NSString * friendSignature = friendModel.signature;
                friendSignature = [[friendSignature componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
                
                NSString *insertSql= [NSString stringWithFormat:@"INSERT INTO %@('%@','%@','%@','%@','%@','%@','%@','%@') VALUES ('%@','%@','%@','%@','%@','%@','%@','%@')", FRIENDTAB, FRIENDUSERID, FRIENDHEADURL, FRIENDNICKNAME, FRIENDVIDEONUM, FRIENDVIDEOCOLLECTTIMES, FRIENDSIGNATURE, FRIENDTYPE, FRIENDWITHWHO, friendModel.userId, friendModel.iconURL, friendNickname, friendModel.videoNum, friendModel.videoCollectTimes, friendSignature, friendModel.friendType, CURRENTUSERID];
                BOOL res = [db2 executeUpdate:insertSql];
                if (!res) {
                    DEBUGLOG(@"insert FRIENDTAB");
                }
            }
        }
    }];
}

/** 删除好友表的数据*/
- (void)deleteFriendTabWithUserId:(NSString *)deleteUserID Type:(NSString *)friendType{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *deleteSql = [NSString stringWithFormat:
                               @"delete from %@ where %@ = '%@' and %@ = '%@' and %@ = '%@'", FRIENDTAB, FRIENDUSERID, deleteUserID, FRIENDTYPE, friendType, FRIENDWITHWHO, CURRENTUSERID];
        BOOL res = [db2 executeUpdate:deleteSql];
        if (!res) {
            DEBUGLOG(@"delete FRIENDTAB");
        }
    }];
    return;
}

/** 删除当前登录用户的某个好友类型的全部*/
- (void)deleteFriendTabWithType:(NSString *)friendType{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *deleteSql = [NSString stringWithFormat:
                               @"delete from %@ where %@ = '%@' and %@ = '%@'", FRIENDTAB, FRIENDTYPE, friendType, FRIENDWITHWHO, CURRENTUSERID];
        BOOL res = [db2 executeUpdate:deleteSql];
        if (!res) {
            DEBUGLOG(@"delete FRIENDTAB");
        }
    }];
    return;
}

/** 更改好友表的数据*/
- (void)updateFriendWithModel:(FriendModel *)friendModel UserId:(NSString *)userId Type:(NSString *)friendType{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@', %@ = '%@', %@ = '%@', %@ = '%@', %@ = '%@', %@ = '%@', %@ = '%@' %@ = '%@' WHERE %@ = '%@' and %@ = '%@' and %@ = '%@'", FRIENDTAB, FRIENDUSERID, friendModel.userId, FRIENDHEADURL, friendModel.iconURL, FRIENDNICKNAME, friendModel.nickName, FRIENDVIDEONUM, friendModel.videoNum, FRIENDVIDEOCOLLECTTIMES, friendModel.videoCollectTimes, FRIENDSIGNATURE, friendModel.signature, FRIENDTYPE, friendModel.friendType, FRIENDUSERID, userId, FRIENDWITHWHO, friendModel.toUserId, FRIENDTYPE, friendType, FRIENDWITHWHO, CURRENTUSERID];
        BOOL isSuccess = [db2 executeUpdate:updateSql];
        if (!isSuccess) {
            DEBUGLOG(@"update FRIENDTAB");
        }
    }];
}

/** 根据好友类型查询好友表*/
- (NSArray *)selectFriendTabWithType:(NSString *)friendType{
    NSMutableArray * friendMuArray = [NSMutableArray new];
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:FRIENDTAB];
            if (isExists) {
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ = '%@' and %@ = '%@'", FRIENDTAB, FRIENDTYPE, friendType, FRIENDWITHWHO, CURRENTUSERID]];
                while ([result next]) {
                    [friendMuArray addObject:[FriendModel getFriendModelWithResult:result]];
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    return [friendMuArray copy];
}

/** 根据好友类型查询好友数量*/
- (NSInteger)selectFriendNumTabWithType:(NSString *)friendType{
    NSInteger num = 0;
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:FRIENDTAB];
            if (isExists) {
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ = '%@' and %@ = '%@'", FRIENDTAB, FRIENDTYPE, friendType, FRIENDWITHWHO, CURRENTUSERID]];
                while ([result next]) {
                    num++;
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    return num;
}

/** 查询好友表里面某一个关注获得粉丝或者好友是否存在*/
- (BOOL)selectOneFriend:(NSString *)friendUserId FriendType:(NSString *)friendType{
    BOOL isHave = NO;
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:FRIENDTAB];
            if (isExists) {
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ = '%@' and %@ = '%@' and %@ = '%@'", FRIENDTAB, FRIENDTYPE, friendType, FRIENDWITHWHO, CURRENTUSERID, FRIENDUSERID, friendUserId]];
                while ([result next]) {
                    isHave = YES;
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    return isHave;
}


#pragma mark - 私信表
/** 私信表插入数据(数据对象来自后台)*/
- (void)addMesWithMesObj:(MessageObj *)mesObj{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *insertSql= [NSString stringWithFormat:@"INSERT INTO %@('%@','%@','%@','%@','%@','%@','%@') VALUES ('%@','%@','%@','%@','%@','%@','%@')", FRIENDMESTAB, FRIENDMESSTARTUSER, FRIENDMESENDUSERID, FRIENDSTARTUSERNICKNAME, FRIENDMESREADSTATUS, FRIENDMESCONTENT, FRIENDHEADIMAGEURL, FRIENDMESSTARTTIME, mesObj.srccustomerid, mesObj.dstcustomerid, mesObj.srcnickname, mesObj.srccustomerid == CURRENTUSERID ? @"1" : @"0", mesObj.srccontent, mesObj.srcavatar, mesObj.time];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            DEBUGLOG(@"insert FRIENDMESTAB error")
        }
    }];
    
    [self setBadgeNum];
}

/** 私信表插入数据(数据对象来自app内)*/
- (void)addMesWithPrivateMesObj:(PrivateMesObj *)privateMesObj{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *insertSql= [NSString stringWithFormat:@"INSERT INTO %@('%@','%@','%@','%@','%@','%@','%@') VALUES ('%@','%@','%@','%@','%@','%@','%@')", FRIENDMESTAB, FRIENDMESSTARTUSER, FRIENDMESENDUSERID, FRIENDSTARTUSERNICKNAME, FRIENDMESREADSTATUS, FRIENDMESCONTENT, FRIENDHEADIMAGEURL, FRIENDMESSTARTTIME, privateMesObj.mesStartId, privateMesObj.mesEndId, privateMesObj.startUserNickName, privateMesObj.mesStartId == CURRENTUSERID ? @"1" : @"0", privateMesObj.mesContent, privateMesObj.startUserIconUrl, privateMesObj.time];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            DEBUGLOG(@"insert FRIENDMESTAB error")
        }
    }];
}

/** 更改私信表的内容(更改看过的数据的内容的查看状态)*/
- (void)updateMesTabWithStartUserId:(NSString *)friendUserId{
    //修改查过的数据的观看状态
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        BOOL isSuccess = NO;
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@' WHERE %@ = '%@' and %@ = '%@'", FRIENDMESTAB, FRIENDMESREADSTATUS, @"1", FRIENDMESENDUSERID, CURRENTUSERID, FRIENDMESSTARTUSER, friendUserId];
        /*
         UPDATE TABLE SET readStatus = 1 where mesStartId = 759 and mesEndId = 9846;
         */
        isSuccess = [db2 executeUpdate:updateSql];
        if (!isSuccess) {
            DEBUGLOG(@"update FRIENDMESTAB error");
        }
    }];
    
    [self setBadgeNum];
}

/** 查询与某个好友的私信内容*/
- (NSArray *)selectMesFromMesTabWithStartUserId:(NSString *)friendUserId{
    NSMutableArray * ret = [NSMutableArray new];
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:FRIENDMESTAB];
            if (isExists) {
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ in('%@', '%@') and %@ in('%@', '%@')", FRIENDMESTAB, FRIENDMESSTARTUSER, friendUserId, CURRENTUSERID, FRIENDMESENDUSERID, CURRENTUSERID, friendUserId]];
                while ([result next]) {
                    [ret addObject:[PrivateMesObj getPrivateMesObjWithDBResult:result]];
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    
    //修改所有查询过的数据的查看状态
    [self updateMesTabWithStartUserId:friendUserId];
    
    return [ret copy];
}

/** 查询与某个好友的未读的消息数量*/
- (NSInteger)selectNoReadPrivateMes:(NSString *)friendUserId{
    NSInteger noReadNum = 0;
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:FRIENDMESTAB];
            if (isExists) {
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ = '%@' and %@ = '%@' and %@ = '%@'", FRIENDMESTAB, FRIENDMESSTARTUSER, friendUserId, FRIENDMESENDUSERID, CURRENTUSERID, FRIENDMESREADSTATUS, @"0"]];
                while ([result next]) {
                    noReadNum++;
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    return noReadNum;
}

/** 查询所有未读消息数量(私信消息)*/
- (NSInteger)selectAllNoReadFriendPrivateMesNum{
    NSInteger noReadNum = 0;
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:FRIENDMESTAB];
            if (isExists) {
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ = '%@' and %@ = '%@'", FRIENDMESTAB, FRIENDMESENDUSERID, CURRENTUSERID, FRIENDMESREADSTATUS, @"0"]];
                while ([result next]) {
                    noReadNum++;
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    return noReadNum;
}

#pragma mark - 图文分享部分

/**
 * 判断是否存在某些数据
 */
- (BOOL)isSaveShareDataWithVideoId:(NSString *)videoID{
    BOOL isSave = NO;
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:SHARETABLE];
            if (isExists) {
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ = '%@' and %@ = '%@'", SHARETABLE, shareUserID, CURRENTUSERID, shareVideoID, videoID]];
                while ([result next]) {
                    isSave = YES;
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    return isSave;
}

/**
 *  增加或者更新数据
 */
- (void)addOrUpdateShareDataWithTuwenObj:(TuwenOBJ *)tuwenObj VideoId:(NSString *)videoID{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *insertSql= [NSString stringWithFormat:@"INSERT INTO %@('%@','%@','%@','%@','%@','%@','%@','%@') VALUES ('%@','%@','%ld','%@','%ld','%ld','%@','%@')", SHARETABLE, shareUserID, shareVideoID, shareSourceType, shareContent, shareCellHeight, shareIsShowPlayButtonImage, shareImageUrl, shareVideoUrl, CURRENTUSERID, videoID, (long)tuwenObj.cellType, tuwenObj.cellContent, (long)tuwenObj.cellHeight, (long)tuwenObj.isHiddenPlayButton, tuwenObj.cellImageUrl, tuwenObj.cellVideoUrl];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            DEBUGLOG(@"insert SHARETABLE error")
        }
    }];
}

/**
 *  删除分享数据
 */
- (void)deleteShareDataWithVideoId:(NSString *)videoID{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *deleteSql = [NSString stringWithFormat:
                               @"delete from %@ where %@ = '%@' and %@ = '%@'", SHARETABLE, shareUserID, CURRENTUSERID, shareVideoID, videoID];
        BOOL res = [db2 executeUpdate:deleteSql];
        if (!res) {
            DEBUGLOG(@"delete SHARETABLE");
        }
    }];
}

/**
 *  查询所有数据
 */
- (NSArray *)selectAllShareDataWithVideoID:(NSString *)videoID{
    NSMutableArray * ret = [NSMutableArray new];
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:SHARETABLE];
            if (isExists) {
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ = '%@' and %@ = '%@'", SHARETABLE, shareUserID, CURRENTUSERID, shareVideoID, videoID]];
                while ([result next]) {
                    [ret addObject:[TuwenOBJ getTuwenOBjWithResult:result]];
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    
    return [ret copy];
}

#pragma mark - 上传素材表

/**
 *  增加数据
 */
- (void)insertDataWithModel:(UploadMaterialModel *)uploadMaterialModel{
    
    if ([self selectIsAlreadyHaveWithMdoel:uploadMaterialModel]) {
        [self updateDataWithModel:uploadMaterialModel];
        return;
    }
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@('%@','%@','%@', '%@', '%@', '%@', '%@') VALUES ('%@','%@','%@','%@','%@', '%@', '%@')", UPLOADMATERIALTAB, UPLOADMATERIALASSETURL, UPLOADMATERIALLOCALURL, UPLOADMATERIALSTATUS, UPLOADMATERIALCREATETIME, UPLOADMATERIALCONTENTSIZE, UPLOADMATERIALFILENAME, UPLOADMATERIALYUNFILENAME, uploadMaterialModel.assetURL, uploadMaterialModel.localURL, [NSString stringWithFormat:@"%lu", uploadMaterialModel.status], uploadMaterialModel.createTime, uploadMaterialModel.contentSize, uploadMaterialModel.fileName, uploadMaterialModel.yunFileName];
        BOOL res = [db2 executeUpdate:insertSql];
        if (!res) {
            NSLog(@"insert UPLOADMATERIALTAB error");
        }
    }];
}

/**
 *  删除数据
 */
- (void)deleteData{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        NSString *deleteSql = [NSString stringWithFormat:
                               @"delete from %@ where %@ = '%@'", UPLOADMATERIALTAB, UPLOADMATERIALSTATUS, [NSString stringWithFormat:@"%lu", uploadFinish]];
        BOOL res = [db2 executeUpdate:deleteSql];
        if (!res) {
            DEBUGLOG(@"delete UPLOADMATERIALTAB");
        }
    }];
}

/**
 *  更新数据
 */
- (void)updateDataWithModel:(UploadMaterialModel *)uploadMaterialModel{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:alphaDBpath];
    [queue inDatabase:^(FMDatabase *db2) {
        BOOL isSuccess = NO;
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@' WHERE %@ = '%@'", UPLOADMATERIALTAB, UPLOADMATERIALSTATUS, [NSString stringWithFormat:@"%lu", uploadMaterialModel.status], UPLOADMATERIALFILENAME, uploadMaterialModel.fileName];
        isSuccess = [db2 executeUpdate:updateSql];
        if (!isSuccess) {
            DEBUGLOG(@"update UPLOADMATERIALTAB error");
        }
    }];
}

/**
 *  查寻所有等待上传的数据
 */
- (NSArray *)selectUploadMaterialData{
    NSMutableArray * ret = [NSMutableArray new];
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:SHARETABLE];
            if (isExists) {
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ = '%@'", UPLOADMATERIALTAB, UPLOADMATERIALSTATUS, [NSString stringWithFormat:@"%lu", uploadStart]]];
                while ([result next]) {
                    [ret addObject:[UploadMaterialModel getModelWithResult:result]];
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    
    return [ret copy];
}

/**
 *  查寻所有数据
 */
- (NSArray *)selectAllMaterialData{
    NSMutableArray * ret = [NSMutableArray new];
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:SHARETABLE];
            if (isExists) {
                FMResultSet * result = [db_movier executeQuery:[NSString stringWithFormat:@"select * from %@", UPLOADMATERIALTAB]];
                while ([result next]) {
                    [ret addObject:[UploadMaterialModel getModelWithResult:result]];
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    
    return [ret copy];
}

- (BOOL)selectIsAlreadyHaveWithMdoel:(UploadMaterialModel *)uploadModel{
    BOOL isHave = NO;
    [theLock lock];
    {
        if ([db_movier open]) {
            BOOL isExists = [db_movier tableExists:SHARETABLE];
            if (isExists) {
                NSString *tempStr = [NSString stringWithFormat:@"select * from %@ where %@ = '%@'", UPLOADMATERIALTAB, UPLOADMATERIALFILENAME, uploadModel.fileName];
                FMResultSet * result = [db_movier executeQuery:tempStr];
                while ([result next]) {
                    isHave = YES;
                }
            }
        }
        [db_movier close];
    }
    [theLock unlock];
    
    return isHave;
}

@end
