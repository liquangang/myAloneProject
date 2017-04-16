//
//  TuwenTextTableViewCell.h
//  M-Cut
//
//  Created by apple on 16/10/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TuwenTextTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelHeight;

/**
 *  获得cell
 */
+ (instancetype)TuwenTextTableViewCellWithTable:(UITableView *)tableView
                                    ResuableStr:(NSString *)resuableStr
                                        Content:(NSString *)content
                                      IndexPath:(NSIndexPath *)index;

//长按block
@property (nonatomic, copy) void(^longTapBlock)();

//删除block
@property (nonatomic, copy) void(^deleteBlock)(NSIndexPath * indexPath);
@end
