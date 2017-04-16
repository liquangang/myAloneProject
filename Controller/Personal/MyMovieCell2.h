//
//  MyMovieCell2.h
//  M-Cut
//
//  Created by admin on 16/3/4.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMovieCell2 : UITableViewCell
/*
 @property (nonatomic,weak) IBOutlet UILabel *movieTitleLabel;
 @property (nonatomic,weak) IBOutlet UILabel *downloadStatusLabel;
 @property (nonatomic,weak) IBOutlet UIButton *downButton;
 @property (nonatomic,weak) IBOutlet UIButton *deleteButton;
 @property (nonatomic,weak) IBOutlet UILabel *downPressLabel;
 @property (nonatomic,weak) IBOutlet UILabel *autherLabel;
 @property (nonatomic,weak) IBOutlet UILabel *lookLabel;
 @property (nonatomic,weak) IBOutlet UILabel *favoriteLabel;
 @property (nonatomic,weak) IBOutlet UIView *localDownLoadLabel;
 @property (nonatomic,weak) IBOutlet UIImageView *videoImageView;
 @property (nonatomic,strong) NSIndexPath *currentIndexPath;
 @property (nonatomic,weak) id<MyMovieCellDelegate> delegate;
 @property (nonatomic,strong) id moveData;
 */
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *promptLabel;
@property (weak, nonatomic) IBOutlet UIView *localDownLoadLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lookLabel;
@property (weak, nonatomic) IBOutlet UILabel *favouriteLabel;
@property (nonatomic,strong) id moveData;
@property (nonatomic,strong) NSIndexPath *currentIndexPath;
@end
