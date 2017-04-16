//
//  MySearchCell.h
//  M-Cut
//
//  Created by admin on 16/3/10.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySearchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property (nonatomic, copy) void(^recordButtonBlock)(NSString *title, UIButton *recordButton);
@end
