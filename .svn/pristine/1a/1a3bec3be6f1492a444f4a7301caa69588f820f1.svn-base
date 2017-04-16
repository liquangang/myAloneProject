//
//  LQGTitleView.h
//  TestDemo
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LQGTitleViewDelegate <NSObject>

- (void)barButtonAction:(UIButton *)barButton;

@end

@interface LQGTitleView : UIView
@property (nonatomic, weak) id<LQGTitleViewDelegate> delegate;
@property (nonatomic, strong) UIButton * button1;
@property (nonatomic, strong) UIButton * button2;
@property (nonatomic, strong) UILabel * label1;
@property (nonatomic, strong) UILabel * label2;

- (id)initWithFrame:(CGRect)frame andDelegate:(NSObject <LQGTitleViewDelegate>*)lqgDelegate;
@end
