//
//  AlertsCell.h
//  M-Cut
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *alertsImage;
@property (weak, nonatomic) IBOutlet UILabel *alertsDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *noReadMesNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *alertsTypeLabel;


/**
 *@brief:   获得复用cell
 *@param:   设置cell所需的字典
 *@param:   cell所在的table
 *@return:  cell
 */
+ (id)getAlertCellWithDic:(NSDictionary *)dataDic Table:(UITableView *)myTable;

- (void)setAlertCellWithDic:(NSDictionary *)myDic;
@end
