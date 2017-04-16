//
//  CloudDiskSearchRecordCollectionViewCell.h
//  M-Cut
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloudDiskSearchRecordCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *recordTextLabel;

/**
 *  删除
 */
@property (nonatomic, copy) void(^deleteBlock)();
@end
