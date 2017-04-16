//
//  ActivityDetailView.m
//  M-Cut
//
//  Created by liquangang on 16/9/19.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "ActivityDetailView.h"
#import "SoapOperation.h"
#import "CustomeClass.h"
#import "SDCycleScrollView.h"

@interface ActivityDetailView()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray * bannerMuArray;
@property (nonatomic, strong) NSMutableArray * bannerInfoArray;
@end

@implementation ActivityDetailView

#pragma mark - 懒加载
- (NSMutableArray *)bannerInfoArray{
    if (!_bannerInfoArray) {
        _bannerInfoArray = [NSMutableArray new];
    }
    return _bannerInfoArray;
}

- (NSMutableArray *)bannerMuArray{
    if (!_bannerMuArray) {
        _bannerMuArray = [NSMutableArray new];
    }
    return _bannerMuArray;
}

- (instancetype)initWithLabelId:(NSString *)labelId
                    ActivityDes:(NSString *)activityDesStr
{
    self = [super init];
    if (self) {
        [self downloadBannerDataLabelId:labelId ActivityDes:activityDesStr];
    }
    return self;
}

//添加banner图片
- (void)downloadBannerDataLabelId:(NSString *)labelId
                      ActivityDes:(NSString *)activityDesStr{
    WEAKSELF(weakSelf);
    [[SoapOperation Singleton] WS_getbannerlistWithCategory:1 Where:labelId Offset:0 Count:66 Success:^(NSMutableArray *serverDataArray) {
        MAINQUEUEUPDATEUI({
            CGFloat bannerViewHeight = ISScreen_Width / 367 * 138;
            
            if (serverDataArray.count == 0) {
                bannerViewHeight = 0;
            }else{
                weakSelf.bannerInfoArray = serverDataArray;
                for (NSMutableDictionary * dic in serverDataArray) {
                    [weakSelf.bannerMuArray addObject:dic[@"thumbnail"]];
                }
                
                CGRect cycleFrame = CGRectMake(0,
                                               0,
                                               ISScreen_Width,
                                               bannerViewHeight);
                SDCycleScrollView * cycleView = [SDCycleScrollView cycleScrollViewWithFrame:cycleFrame
                                                                                   delegate:self
                                                                           placeholderImage:nil];
                [weakSelf addSubview:cycleView];
                cycleView.imageURLStringsGroup = [weakSelf.bannerMuArray copy];
            }
            
            if (activityDesStr.length > 0) {
                
                //活动缩略图
                UIImageView * leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(15,
                                                                                        bannerViewHeight + 12,
                                                                                        26,
                                                                                        30)];
                [weakSelf addSubview:leftImage];
                leftImage.image = [UIImage imageNamed:@"activityIntroduceImage"];
                
                //活动介绍标签
                UILabel * activityLabel = [[UILabel alloc] initWithFrame:CGRectMake(48,
                                                                                    20 + bannerViewHeight,
                                                                                    188,
                                                                                    15)];
                [weakSelf addSubview:activityLabel];
                activityLabel.text = @"标签介绍";
                activityLabel.textColor = ISLIKEGRAYCOLOR;
                activityLabel.font = ISFont_15;
                
                //活动简介
                UITextView * activityTextView = [[UITextView alloc] init];
                activityTextView.editable = NO;
                activityTextView.backgroundColor = [UIColor clearColor];
                [weakSelf addSubview:activityTextView];
                activityTextView.textColor = ISLIKEGRAYCOLOR;
                activityTextView.font = ISFont_12;
                activityTextView.text = activityDesStr;
                activityTextView.scrollEnabled = NO;
                CGSize contentSize = [activityTextView sizeThatFits:CGSizeMake(ISScreen_Width - 56 - 16,
                                                                               MAXFLOAT)];
                activityTextView.frame = CGRectMake(28,
                                                    bannerViewHeight + 50,
                                                    ISScreen_Width - 56,
                                                    contentSize.height);
                weakSelf.frame = CGRectMake(0,
                                            0,
                                            ISScreen_Width,
                                            activityTextView.frame.size.height + activityTextView.frame.origin.y + 16);
            }else{
                weakSelf.frame = CGRectMake(0, 0, ISScreen_Width, bannerViewHeight);
            }
            weakSelf.reloadTableBlock();
        })
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf downloadBannerDataLabelId:labelId
                                                 ActivityDes:activityDesStr];);
    }];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView
   didSelectItemAtIndex:(NSInteger)index{
    self.clickBannerImageBlock(index, self.bannerInfoArray);
}

@end
