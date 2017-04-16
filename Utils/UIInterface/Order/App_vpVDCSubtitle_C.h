//
//  App_vpVDCSubtitle_C.h
//  M-Cut
//
//  Created by zhangxiaotian on 15/4/20.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface App_vpVDCSubtitle_C : NSObject
@property (nonatomic) int nID;//ID
@property (nonatomic,strong) NSString *szName;//名字
@property (nonatomic,strong) NSString *szUrl;//url
@property (nonatomic,strong) NSString *szCreateTime;//创建时间
@property (nonatomic,strong) NSString *szThumbnail;//缩略图
@property (nonatomic) int nLength;//长度
@property (nonatomic,strong) NSString *szRecommend;//推荐字幕
@property (nonatomic,strong) NSString *szModel;//字幕模型标准
@property (nonatomic,strong) NSString *szReference;//字幕预览视频URL



@end
