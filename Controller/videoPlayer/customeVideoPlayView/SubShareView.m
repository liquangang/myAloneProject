//
//  SubShareView.m
//  M-Cut
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "SubShareView.h"

@implementation SubShareView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.shareImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20,
                                                                            20,
                                                                            40,
                                                                            40)];
        [self addSubview:self.shareImageView];
        self.shareImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.shareImageView.frame.origin.y + self.shareImageView.frame.size.height + 5.5,
                                                                    40,
                                                                    9)];
        [self addSubview:self.shareLabel];
        self.shareLabel.font = [UIFont systemFontOfSize:8];
        self.shareLabel.textColor = [UIColor whiteColor];
        self.shareLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end
