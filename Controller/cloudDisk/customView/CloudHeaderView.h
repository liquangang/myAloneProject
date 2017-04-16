//
//  CloudHeaderView.h
//  M-Cut
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloudHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *addNumLabel;
@property (weak, nonatomic) IBOutlet UISlider *capacitySlider;
@property (weak, nonatomic) IBOutlet UILabel *allSpaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainSpaceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *CloudDiskImage;

/**
 *  删除
 */
@property (nonatomic, copy) void(^deleteBlock)();

/**
 *  增加
 */
@property (nonatomic, copy) void(^addBlock)();

/**
 *  搜索
 */
@property (nonatomic, copy) void(^searchBlock)();

/**
 *  上传
 */
@property (nonatomic, copy) void(^uploadBlock)();

@end
