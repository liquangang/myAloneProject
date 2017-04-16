









//
//  TitleCollectionViewCell.m
//  M-Cut
//
//  Created by apple on 16/12/14.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "TitleCollectionViewCell.h"

@implementation TitleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)titleButtonAction:(id)sender {
    self.titleButtonTouchBlock();
}
@end
