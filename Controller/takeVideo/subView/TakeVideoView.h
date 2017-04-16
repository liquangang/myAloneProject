//
//  TakeVideoView.h
//  M-Cut
//
//  Created by apple on 16/10/28.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakeVideoView : UIView
//数据源
@property (nonatomic, strong) NSMutableArray * dataMuArray;

//视频新增完成，此时可以显示使用视频按钮
@property (nonatomic, copy) void(^showUseVideoButton)();
@end
