//
//  CustomAlertView.m
//  M-Cut
//
//  Created by apple on 16/12/15.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CustomAlertView.h"
#import <Masonry.h>

@interface CustomAlertView()
@property (nonatomic, strong) UIView *backView;
@end

@implementation CustomAlertView

- (instancetype)initWithTitle:(NSString *)title ButtonTitleArray:(NSArray *)buttonLabelTitleArray Width:(CGFloat)width Height:(CGFloat)height{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ISScreen_Width, ISScreen_Height);
        self.backgroundColor = ColorFromRGB(0x000000, 0.69);
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(ISScreen_Width / 2 - width / 2, ISScreen_Height / 2 - height / 2 - 1, width, height)];
        [self addSubview:backView];
        self.backView = backView;
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.masksToBounds = YES;
        backView.layer.cornerRadius = 6;
        
        //设置顶部标题
        UILabel *titleLabel = [UILabel new];
        [backView addSubview:titleLabel];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.frame = CGRectMake(0, 0, width, 30);
        titleLabel.text = title;
        titleLabel.font = ISFont_15;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = ColorFromRGB(0x2E2E3A, 1.0);
        
        //添加底部的按钮
        CGFloat eveWidth = width / buttonLabelTitleArray.count;
        NSInteger index = 0;
        for (NSString *buttonTitle in buttonLabelTitleArray) {
            UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake(index * eveWidth, height - 30, eveWidth, 30)];
            [backView addSubview:tempButton];
            tempButton.tag = 123456 + index;
            [tempButton setTitle:buttonTitle forState:UIControlStateNormal];
            [tempButton setTitleColor:ColorFromRGB(0xF4413F, 1.0) forState:UIControlStateNormal];
            [tempButton addTarget:self action:@selector(bottomButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            tempButton.backgroundColor = [UIColor whiteColor];
            tempButton.titleLabel.font = ISFont_15;
            tempButton.layer.borderColor = ColorFromRGB(0xBBBCBD, 1.0).CGColor;
            tempButton.layer.borderWidth = 1;
            index++;
        }
    }
    return self;
}

- (void)bottomButtonAction:(UIButton *)btn{
    self.touchBottomButtonBlock(btn.tag - 123456);
}

- (void)addCustomeView:(UIView *)customeView{
    customeView.frame = CGRectMake(0, 30, CGRectGetWidth(self.backView.frame), CGRectGetHeight(self.backView.frame) - 60);
    [self.backView addSubview:customeView];
}

@end
