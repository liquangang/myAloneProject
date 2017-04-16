//
//  VideoPreviewViewController.h
//  M-Cut
//
//  Created by apple on 16/10/29.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPreviewViewController : UIViewController
//数据源
@property (nonatomic, strong) NSArray * videoDataMuArray;
//展示的位置
@property (nonatomic, strong) NSIndexPath * showIndex;
@end
