//
//  MyMusicCell.h
//  M-Cut
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyMusicCellDelegate <NSObject>

- (void)playButtonAction:(NSIndexPath *)myIndexPath andMusicUrl:(NSString *)musicUrl;

@end

@interface MyMusicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *musicImage;
@property (weak, nonatomic) IBOutlet UILabel *musicName;
@property (weak, nonatomic) IBOutlet UILabel *singer;
@property (weak, nonatomic) IBOutlet UIImageView *selectImage;
@property (weak, nonatomic) IBOutlet UIImageView *playButton;

@property (nonatomic, strong) NSIndexPath * myIndexPath;
@property (nonatomic, copy) NSString * myMusicUrl;
@property (nonatomic, weak) id<MyMusicCellDelegate> delegate;

@end
