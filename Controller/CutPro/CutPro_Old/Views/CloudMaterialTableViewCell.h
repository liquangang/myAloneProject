//
//  CloudMaterialTableViewCell.h
//  M-Cut
//
//  Created by zhangxiaotian on 15/4/16.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloudMaterialTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *folderImagV;
@property (retain, nonatomic) IBOutlet UILabel *folderNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *folderCreateTimeLabel;

@end
