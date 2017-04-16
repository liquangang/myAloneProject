//
//  CloudDiskSearchRecordFooterCollectionViewCell.m
//  M-Cut
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CloudDiskSearchRecordFooterCollectionViewCell.h"

@implementation CloudDiskSearchRecordFooterCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ADDTAPGESTURE(self.contentView, tapMethod);
}

- (void)tapMethod:(UITapGestureRecognizer *)tap{
    self.tapBlock();
}

@end
