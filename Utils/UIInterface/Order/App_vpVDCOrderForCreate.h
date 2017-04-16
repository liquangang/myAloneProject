//
//  App_vpVDCOrderForCreate.h
//  M-Cut
//
//  Created by zhangxiaotian on 15/4/18.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>

enum OSSSTATUS
{
    NOURL = 0,
    HASURL = 1,
};
typedef enum : NSUInteger {
    FRESHORDER = 0,                     //编辑中的订单
    DRAFTORDER = 1,                     //草稿箱订单
    READYCOMMITORDER = 2,               //编辑完成准备提交的订单
    NOWTRANSFER =3,                     //上传中的订单
    COMMITEDORDER = 4,                  //已经提交完成的订单
    FINISHORDER = 5,                    //已经完成的订单
    ///////////////////////////////
    ORDERPUB = 10,
    ORDERPRAVITE = 11,
} ORDERSTATUS;

typedef NS_ENUM(NSInteger, OrderType){
    generalOrder,
    generalFollowOrder,
    AROrder,
    ARFollowOrder
};



@interface NewOrderVideoMaterial : NSObject
@property (nonatomic) int nOrderVideoMaterialID;//素材ID
@property (strong,nonatomic) NSString *szUrl;//素材url
@property (nonatomic) int nIndex;//素材索引
@property (strong,nonatomic) NSString *createTime;//素材创建时间
@property (nonatomic) int order_id;//订单id
@property (nonatomic) int file_st;//素材状态
@property (nonatomic) int material_type;//素材类型 （1：照片 2：视频 0：其他）
@property (nonatomic) int material_index;//素材索引
@property (strong,nonatomic) NSString *material_localURL;//素材本地url
@property (strong,nonatomic) NSString *material_ossURL;//素材ossurl
@property (strong,nonatomic) UIImage *material_stream;//图片素材
@property (strong,nonatomic) NSString *material_assetsURL;//素材相册url
@property (nonatomic)float material_playduration;//素材时长
@property (nonatomic)int owner;//素材所有者
@property (strong,nonatomic) NSString* multUpID;
@property (nonatomic, copy) NSString * arId;
@property (nonatomic, assign) NSInteger rewardType;
@end

@interface NewOrderLabelForVideo : NSObject
@property (nonatomic) int nLabelForVideo;
@property (nonatomic) int size;
@property (strong,nonatomic) NSString *createTime;
@end

@interface NewNSOrderDetail : NSObject
@property (strong,nonatomic) NSString *createTime;//订单创建时间
@property (nonatomic) int order_id;//订单ID
@property (nonatomic) int order_st;//订单状态
@property (nonatomic) int customer;//拥有者
@property (nonatomic) float nVideoLength;//视频长度
@property (nonatomic) int nHeaderAndTailID;//片头片尾 风格 模板
@property (nonatomic) int nFilterID;//滤镜
@property (nonatomic) int nMusicID;//音乐
@property (nonatomic) int nMusicStart;//音乐开始
@property (nonatomic) int nMusicEnd;//音乐结束
@property (nonatomic) int nSubtitleID;//字幕
@property (strong,nonatomic) NSString *szCustomerSubtitle;//
@property (strong,nonatomic) NSString *szVideoName;//视频名
@property (nonatomic) int nShareType;//公开状态（0私有 1公有）
@property (strong,nonatomic) NSMutableArray *stMaterialArr;//素材数组
@property (strong,nonatomic) NSMutableArray *stLabelForVideo;//Label数组
@property (strong,nonatomic) NSString *strVideoURL;//订单产生的视频网络地址
@property (strong,nonatomic) NSString *strVideoThumbnail;//缩略图url
@property (nonatomic) int oss_orderid;//oss订单号
@property (nonatomic, assign) OrderType orderType;//订单类型
@property (nonatomic, assign) BOOL isRetainVoice;//保留原声
@property (nonatomic, copy) NSString *followVideoId;//照做的影片id
@property (nonatomic, copy) NSString *videoDes;//影片描述
@end


@interface NewUserOrderList : NSObject//用户app订单列表
{
    NSMutableArray *newcutlist;
}

@property(retain,nonatomic) NSMutableArray *newcutlist;
//@property(retain,nonatomic)

+ (NewUserOrderList *)Singleton;
@end
