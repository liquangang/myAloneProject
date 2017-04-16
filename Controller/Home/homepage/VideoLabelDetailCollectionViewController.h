//
//  VideoLabelDetailCollectionViewController.h
//  M-Cut
//
//  Created by liquangang on 16/9/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoLabelDetailCollectionViewController : UIViewController
/** 该页面标签id*/
@property (nonatomic, copy) NSString * labelId;
/** 该页面标签name*/
@property (nonatomic, copy) NSString * labelName;
/** 如果是活动，活动的详细描述*/
@property (nonatomic, copy) NSString * activityDes;
/** 是否隐藏参与活动按钮*/
@property (nonatomic, assign) BOOL isShowJoinActivityButton;
@end
