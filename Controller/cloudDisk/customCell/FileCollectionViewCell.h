//
//  FileCollectionViewCell.h
//  M-Cut
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *fileThumailImage;
@property (weak, nonatomic) IBOutlet UILabel *fileNameLabel;
@end
