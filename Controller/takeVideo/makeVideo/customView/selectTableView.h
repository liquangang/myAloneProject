//
//  selectTableView.h
//  M-Cut
//
//  Created by liquangang on 2017/1/19.
//  Copyright © 2017年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface selectTableView : UIView<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy) void(^selectBlock)(NSIndexPath *indexPath);
- (void)show;
- (void)hidden;
@end
