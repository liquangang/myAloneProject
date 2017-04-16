//
//  TuwenImageTableViewCell.h
//  M-Cut
//
//  Created by apple on 16/10/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TuwenOBJ.h"

@interface TuwenImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;


/**
 *  获得cell
 */
+ (instancetype)TuwenImageTableViewCellWithTableView:(UITableView *)tableView
                                         ResuableStr:(NSString *)resuableStr
                                            TuwenObj:(TuwenOBJ *)tuwenObj
                                           IndexPath:(NSIndexPath *)index;

//长按block
@property (nonatomic, copy) void(^longTapBlock)();

//删除block
@property (nonatomic, copy) void(^deleteBlock)(NSIndexPath * indexPath);
@end
