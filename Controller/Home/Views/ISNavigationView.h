//
//  ISNavigationView.h
//  INSHOW
//
//  Created by 李亚飞 on 15/11/12.
//  Copyright © 2015年 李亚飞. All rights reserved.
//  首页 home 导航条按钮视图

#import <UIKit/UIKit.h>
@class ISNavigationView;

@protocol ISNavigationViewDelegate <NSObject>

@optional
/**  点击按钮, 加载控制器 */
- (void)navigationView:(ISNavigationView *)navigationView didClickButton:(UIButton *)button;

/**  点击下拉按钮 */
- (void)navigationView:(ISNavigationView *)navigationView didClickDropButton:(UIButton *)dropButton;

@end

@interface ISNavigationView : UIView

/**
 *  @param      titles      子控制器标题
 */
@property (strong, nonatomic) NSArray *titles;

@property (weak, nonatomic) id<ISNavigationViewDelegate> delegate;

// 初始化方法
+ (instancetype)navigationView;

/**  
 *  @param      titles      子控制器标题
 */
+ (instancetype)navigationViewWithTitles:(NSArray *)titles;

/**
 *  移除标题
 */
- (void)removeTitles;

/**  滚动到选中的 button 的位置 */
- (void)scrollToButton:(UIButton *)button;
@end
