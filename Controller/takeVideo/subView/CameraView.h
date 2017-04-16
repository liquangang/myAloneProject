//
//  CameraView.h
//  M-Cut
//
//  Created by apple on 16/10/9.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TakeVideoView.h"
#import "ARRewardView.h"

@interface CameraView : UIView

//视频展示table
@property (nonatomic, strong) TakeVideoView *videoShowView;
//ar相关的view
@property (nonatomic, strong) ARRewardView *arRewardView;
//拍摄时长
@property (nonatomic, assign) NSInteger timeLength;
//奖品信息数组
@property (nonatomic, strong) NSMutableArray *rewardArray;
//提示信息
@property (nonatomic, copy) NSString *propmtStr;
//是否展示ar动的效果
@property (nonatomic, assign) BOOL isShowARAnimation;


/**
 *  取消按钮block
 */
@property (nonatomic, copy) void(^cancleBlock)();

/**
 *  拍照按钮block
 */
@property (nonatomic, copy) void(^takeVideoBlock)(UILabel *timeLabel, UIButton *takeVideoButton);

/**
 *  使用视频按钮block
 */
@property (nonatomic, copy) void(^useVideoBlock)();

/**
 *  切换镜头block
 */
@property (nonatomic, copy) void(^changeCameraBlock)();

/**
 *  闪光灯
 */
@property (nonatomic, copy) void(^ledControlBlock)(BOOL isSelect);

/**
 *  打开相册
 */
@property (nonatomic, copy) void(^openAlbumBlock)();

/**
 *  添加view，ar部分默认添加，控制部分需要传参
 */
- (void)addViewWithNeedAddControlView:(BOOL)isNeedControlView;

/**
 *  根据影片id判断是否有ar
 */
- (void)showARWithVideoId:(NSString *)videoId;

/**
 *  test
 */
- (void)testNewYearFu;

@end
