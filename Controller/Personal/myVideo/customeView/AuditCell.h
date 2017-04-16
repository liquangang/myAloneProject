//
//  AuditCell.h
//  M-Cut
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISConst.h"
#import "App_vpVDCOrderForCreate.h"

@interface AuditCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *videoNameLabel;


/** 获得复用cell*/
+ (id)getAuditCellWithTable:(UITableView *)myTable VideoInfo:(NewNSOrderDetail *)orderDetail;
@end
