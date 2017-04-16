//
//  MakeVideoHomePageView.h
//  M-Cut
//
//  Created by liquangang on 2017/1/17.
//  Copyright © 2017年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakeVideoHomePageView : UIView
@property (nonatomic, strong) UIImageView *upImageView;
@property (nonatomic, strong) UIButton *takeVideoButton;
@property (nonatomic, strong) UIButton *selectImageButton;
@property (nonatomic, strong) UIButton *togetherButton;
@property (nonatomic, copy) void(^takeVideoButtonActionBlock)();
@property (nonatomic, copy) void(^selectImageButtonActionBlock)();
@property (nonatomic, copy) void(^togetherButtonActionBlock)();
@end
