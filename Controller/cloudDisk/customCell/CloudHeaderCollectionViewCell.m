//
//  CloudHeaderCollectionViewCell.m
//  M-Cut
//
//  Created by apple on 16/12/5.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CloudHeaderCollectionViewCell.h"

@interface CloudHeaderCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *addImageLabel;
@property (weak, nonatomic) IBOutlet UISlider *capacitySlider;
@property (weak, nonatomic) IBOutlet UILabel *allCapacityLabel;
@property (weak, nonatomic) IBOutlet UILabel *spareCapacityLabel;
@end

@implementation CloudHeaderCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)deleteButtonAction:(id)sender {
    self.deleteBlock();
}

- (IBAction)addButtonAction:(id)sender {
    self.addBlock();
}

- (IBAction)searchButtonAction:(id)sender {
    self.searchBlock();
}
@end
