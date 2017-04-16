//
//  PlayerView.m
//  M-Cut
//
//  Created by liquangang on 16/9/8.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //搜索部分
        _mySearchView = [[SearchView alloc] initWithFrame:CGRectMake(15, 54, ISScreen_Width - 30, 26)];
        [self addSubview:_mySearchView];
        
        //标签栏部分
        VideoLabelView * myVideoLabelView = [[VideoLabelView alloc] initWithFrame:CGRectMake(0, ISScreen_Width / 3 * 2, ISScreen_Width, 114)];
        [self addSubview:myVideoLabelView];
    }
    return self;
}

@end
