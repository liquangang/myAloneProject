//
//  UploadCell.h
//  M-Cut
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISConst.h"
#import "App_vpVDCOrderForCreate.h"

@interface UploadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *videoNameLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *uploadProgressView;

/** 获得复用cell*/
+ (id)getUploadCellWithTable:(UITableView *)myTable VideoInfo:(NewNSOrderDetail *)orderDetail;
@end
