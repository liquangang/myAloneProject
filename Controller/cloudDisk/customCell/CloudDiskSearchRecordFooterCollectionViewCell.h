//
//  CloudDiskSearchRecordFooterCollectionViewCell.h
//  M-Cut
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloudDiskSearchRecordFooterCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *functionImage;

/**
 *  点击方法
 */
@property (nonatomic, copy) void(^tapBlock)();
@end
