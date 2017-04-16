





//
//  HomepageThirdCollectionViewCell.m
//  M-Cut
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "HomepageThirdCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation HomepageThirdCollectionViewCell
- (id)init{
    if (self = [super init]) {
        self.clipsToBounds = YES;
        
        UIImageView * backImage = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:backImage];
        backImage.contentMode = UIViewContentModeScaleAspectFill;
        self.backImage = backImage;
        
        UILabel * videoLabelNameLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:videoLabelNameLabel];
        videoLabelNameLabel.textColor = [UIColor whiteColor];
        videoLabelNameLabel.textAlignment = NSTextAlignmentCenter;
        videoLabelNameLabel.backgroundColor = [UIColor clearColor];
        self.videoLabelNameLabel = videoLabelNameLabel;
        /*
         NSNumber * nLabelID;
         NSString * szLabelName;
         NSNumber * nParentID;
         NSString * szActivityStatus;
         NSString * szThumbnail;
         NSNumber * nType;
         NSString * szDescribe;
         */
        

    }
    return self;
}
@end
