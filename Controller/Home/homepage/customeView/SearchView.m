//
//  SearchView.m
//  M-Cut
//
//  Created by liquangang on 16/9/8.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //搜索图标
        UIImageView * searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 13)];
        [self addSubview:searchIcon];
        searchIcon.image = [UIImage imageNamed:@"searchIcon"];
        
        //搜所文字
        UILabel * searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, 100, 12)];
        [self addSubview:searchLabel];
        searchLabel.text = @"输入关键字搜索";
        searchLabel.textColor = [UIColor whiteColor];
        searchLabel.font = [UIFont systemFontOfSize:12];
        
        //底部横线
        UILabel * belowLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
        [self addSubview:belowLineLabel];
        belowLineLabel.backgroundColor = IS8d8986;
        
        ADDTAPGESTURE(self, pushToSearchVc)
    }
    return self;
}

- (void)pushToSearchVc:(UITapGestureRecognizer *)tap{
    POSTNOTI(PUSHTOSEARCHVC, nil);
}

@end
