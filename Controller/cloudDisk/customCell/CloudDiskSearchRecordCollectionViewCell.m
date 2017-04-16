//  CloudDiskSearchRecordCollectionViewCell.m
//  M-Cut
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CloudDiskSearchRecordCollectionViewCell.h"

@implementation CloudDiskSearchRecordCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)deleteButtonAction:(id)sender {
    self.deleteBlock();
}

@end
