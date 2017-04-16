//
//  StyleDetailCell.h
//  M-Cut
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISStyleDetailCell.h"

@protocol StyleDetailCellDelegate <NSObject>

- (void)didSelectStyleDetailWithIndex:(NSIndexPath *)indexPath;

@end

@interface StyleDetailCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *StyleDetailImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/** 设置未被选中的状态*/
- (void)setNormalDetailCellWithStyle:(ISStyleDetailFrame *)myStyleDetail;
/** 设置被选中的状态*/
- (void)setDidSelectDetailCellWithStyle:(ISStyleDetailFrame *)myStyleDetail;

@property (nonatomic, strong) NSIndexPath * myIndex;
@property (nonatomic, weak) id<StyleDetailCellDelegate> delegate;
@end
