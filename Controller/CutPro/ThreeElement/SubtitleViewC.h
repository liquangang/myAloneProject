//
//  SubtitleViewC.h
//  M-Cut
//
//  Created by Crab00 on 15/8/17.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGMoviePlayer.h"
#import "UIImageView+WebCache.h"
#import "SubtitleCell.h"

@class MovierDCInterfaceSvc_vpVDCSubtitleC;

@interface SubtitleViewC : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger selectedCell;
}

@property (weak, nonatomic) IBOutlet UIImageView *SubtitleShow;
@property (weak, nonatomic) IBOutlet UITableView *SubtitleList;

- (void)SetSelectTableCell:(NSInteger)index;
- (void)SetCellText:(NSString*)newtext;

/**  给影片预览界面传递数据 */
@property (copy, nonatomic) void(^subTitle)(MovierDCInterfaceSvc_vpVDCSubtitleC *subTitle);
- (void)getSubTitle:(void(^)(MovierDCInterfaceSvc_vpVDCSubtitleC *subTitle))subTitle;
@end
