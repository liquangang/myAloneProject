//
//  ISCutProStylNewViewController.h
//  M-Cut
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISStyleDetailCell.h"

@interface ISCutProStylNewViewController : UIViewController
//选中的模板标题
@property (weak, nonatomic) IBOutlet UILabel *styleClassLabel;
@property (weak, nonatomic) IBOutlet UITableView *videoPlayerTable;
//适用场景label
@property (weak, nonatomic) IBOutlet UILabel *styleLabel;
@property (nonatomic, strong) UICollectionView * styleClassCollection;
@property (weak, nonatomic) IBOutlet UIPageControl *styleClassPageControl;
@property (nonatomic, strong) UICollectionView *styleCollectionView;
@property (nonatomic, strong) UIImageView * leftArrow;
@property (nonatomic, strong) UIImageView * rightArrow;

/**
 *  修改模板信息的block
 */
@property (nonatomic, copy) void(^updateStyleBlock)(ISStyleDetail *styleDetail);

@end
