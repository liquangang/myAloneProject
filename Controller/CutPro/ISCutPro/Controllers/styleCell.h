//
//  styleCell.h
//  M-Cut
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISStyleCell.h"

@protocol styleCellDelegate <NSObject>

- (void)didSelectStyleCellWithIndex:(NSIndexPath *)indexPath;

@end

@interface styleCell : UICollectionViewCell
//缩略图
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;
//灰色
@property (weak, nonatomic) IBOutlet UIImageView *grayImage;
//主题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//箭头
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;
//底部红线
@property (weak, nonatomic) IBOutlet UILabel *redLineLabel;

@property (nonatomic, strong) ISStyle * cellStyle;
/** 普通状态设置方法*/
- (void)setNormalCellWithStyle:(ISStyle *)myStyle;
/** 选中的状态 未被选中的cell设置*/
- (void)setSelectCellWithStyle:(ISStyle *)myStyle;
/** 选中的状态 被选中的cell设置*/
- (void)setDidSelectCellWithStyle:(ISStyle *)myStyle;

@property (nonatomic, weak) id<styleCellDelegate> delegate;

/** 当前cell的位置*/
@property (nonatomic, strong) NSIndexPath * myIndex;
@end
