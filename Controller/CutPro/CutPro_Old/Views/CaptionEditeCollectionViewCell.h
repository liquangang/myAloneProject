//
//  CaptionEditeCollectionViewCell.h
//  M-Cut
//
//  Created by zhangxiaotian on 15/6/9.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CaptionEditeCollectionViewCellDelegate <NSObject>

- (void)CaptionEditeCollectionViewCellTextChanged:(NSString *)string Index:(NSIndexPath *)index;

@end

@interface CaptionEditeCollectionViewCell : UICollectionViewCell

@property (retain,nonatomic) IBOutlet UILabel *numLab;
@property (retain,nonatomic) IBOutlet UITextView *textTV;
@property (weak,nonatomic) IBOutlet UIView *bacgroundview;

@property (nonatomic,weak) id<CaptionEditeCollectionViewCellDelegate> delegate;


@end




