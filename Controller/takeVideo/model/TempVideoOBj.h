//
//  TempVideoOBj.h
//  M-Cut
//
//  Created by apple on 16/10/31.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RewardType){
    coupon,
    without,
    virtulCard
};

@interface TempVideoOBj : NSObject
//视频沙盒路径
@property (nonatomic, copy) NSString * videoUrl;
//视频缩略图
@property (nonatomic, strong) UIImage * videoThumailImage;
//视频时长
@property (nonatomic, assign) NSUInteger videoLength;
//localUrl
@property (nonatomic, copy) NSString * localUrl;
//assUrl
@property (nonatomic, copy) NSString * assUrl;
//createTime
@property (nonatomic, copy) NSString * createTime;
//奖品id
@property (nonatomic, copy) NSString * arid;
//奖品类型
@property (nonatomic, assign) RewardType rewardType;
@end
