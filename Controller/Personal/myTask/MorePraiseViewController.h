//
//  MorePraiseViewController.h
//  M-Cut
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MorePraiseViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *videoTable;
/** 被点赞的数量*/
@property (nonatomic, copy) NSString * praiseStr;
/** 界面展示的影片数据源*/
@property (nonatomic, strong) NSMutableArray * videoMuArray;
@end
