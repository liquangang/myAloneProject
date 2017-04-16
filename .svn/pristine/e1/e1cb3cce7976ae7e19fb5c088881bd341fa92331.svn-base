//
//  MyMovieCell.h
//  M-Cut
//
//  Created by losehero on 15/12/5.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoapOperation.h"

@protocol MyMovieCellDelegate <NSObject>
-(void)MyMovieCellDownButtonDelegate:(NSIndexPath *)currentIndexPath;
-(void)MyMovieCellDeleteButtonDelegate:(NSIndexPath *)currentIndexPath;
@end


@interface MyMovieCell : UITableViewCell

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

//MovierDCInterfaceSvc_VDCVideoInfoEx

/** 用来匹配已经制作完成的影片（如果已经制作完成则不显示）*/

@end
