//
//  CaptionCollectionViewCell.h
//  M-Cut
//
//  Created by 刘海香 on 15/4/7.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaptionCollectionViewCell : UITableViewCell

@property (retain,nonatomic) IBOutlet UILabel *labelView;
@property (weak,nonatomic) IBOutlet UIView *bacgroundview;
@property (retain,nonatomic) IBOutlet UIButton *editbt;

@end
