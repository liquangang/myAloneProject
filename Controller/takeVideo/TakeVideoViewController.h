//
//  TakeVideoViewController.h
//  M-Cut
//
//  Created by liquangang on 16/9/28.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakeVideoViewController : UIViewController

//当前已有的素材的总时长
@property (nonatomic, assign) float currentTimeLength;

//当期素材数量
@property (nonatomic, assign) NSUInteger materialNum;

//当前编辑订单id
@property (nonatomic, copy) NSString * currentOrderId;

//是否是一键照做的订单
@property (nonatomic, assign) BOOL isFollowOrder;

/**
 *  拍摄视频回调（需要保存缩略图，该类中没有保存缩略图）
 */
@property (nonatomic, copy) void(^addVideoMaterail)(NSArray * takeVideoArray);
@end
