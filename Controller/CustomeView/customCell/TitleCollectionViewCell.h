//
//  TitleCollectionViewCell.h
//  M-Cut
//
//  Created by apple on 16/12/14.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *titleButton;

/**
 *  点击事件
 */
@property (nonatomic, copy) void(^titleButtonTouchBlock)();
@end
