//
//  TrangleTableViewCell.h
//  M-Cut
//
//  Created by apple on 16/11/1.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrangleTableViewCell : UITableViewCell

/**
 *  获得cell
 */
+ (id)TrangleTableViewCellWithTable:(UITableView *)tableView
                        ResuableStr:(NSString *)resuableStr;
@end
