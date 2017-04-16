//
//  ActivityDetailView.h
//  M-Cut
//
//  Created by liquangang on 16/9/19.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityDetailView : UIView
/*****************************************************************
 函数名称：- (instancetype)initWithLabelId:(NSString *)labelId 
                                ActivityDes:(NSString *)activityDesStr;
 函数描述： 活动部分信息展示和banner（2016-09-19增加）
 输入参数：searchText:分类的id
 offset：搜索的起始位置
 count：搜索的数量
 输出参数：block_suc：成功的block
 block_fail：失败的block
 返回值： N/A
 *****************************************************************/
- (instancetype)initWithLabelId:(NSString *)labelId
                    ActivityDes:(NSString *)activityDesStr;

/** 点击banner的block*/
@property (nonatomic, copy) void(^clickBannerImageBlock)(NSInteger bannerPosition, NSMutableArray * bannerInfoArray);

/** view初始化完成需要刷新table*/
@property (nonatomic, copy) void(^reloadTableBlock)();
@end
