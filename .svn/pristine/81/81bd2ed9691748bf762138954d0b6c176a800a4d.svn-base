//
//  ScrollViewLoop.h
//
//
//  Created by 李亚飞 on 15/11/18.
//  Copyright © 2015年 李亚飞. All rights reserved.
//


#import <UIKit/UIKit.h>

/**  监听 scrollView 图片点击的通知 */
#define ScrollViewLoopClickNotification @"LIScrollViewLoopClickNotification"
#define ScrollViewLoopIndex @"LIScrollViewLoopIndex"

@class ScrollViewLoop;

@protocol ScrollViewLoopDelegate <NSObject>
@optional
/**  点击时的代理 */
- (void)scrollView:(ScrollViewLoop *)scrollView clickAdAtIndex:(NSInteger)index;
@end

@interface ScrollViewLoop : UIView


/**
 *  初始化方法
 *
 *  @param frame       frame
 *  @param adInfoArray 数组里面存储的是图片名
 *
 *  @return self
 */
- (id)initWithFrame:(CGRect)frame andAdInfo:(NSMutableArray*)adInfoArray;

/**  图片数组, 使用 xib 时使用, 存放图片名 */
@property (strong, nonatomic) NSMutableArray *ads;
/**  自动播放, 默认是 NO */
@property (assign, nonatomic) BOOL needsAutoPlay;

@property (weak, nonatomic) id<ScrollViewLoopDelegate> delegate;

- (void)updateAds:(NSMutableArray *)ads;
@end






