//
//  CloudUploadCollectionViewCell.h
//  M-Cut
//
//  Created by apple on 16/12/13.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloudUploadCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *uploadControlButton;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (nonatomic, strong) MBProgressHUD *hud;
@end
