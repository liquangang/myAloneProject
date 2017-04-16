//
//  selectTableView.m
//  M-Cut
//
//  Created by liquangang on 2017/1/19.
//  Copyright © 2017年 Crab movier. All rights reserved.
//

#import "selectTableView.h"
#import "XMNAlbumModel.h"

static NSString *const cellResuabelStr = @"UITableViewCell";

@interface selectTableView()
@property (nonatomic, assign) CGRect myFrame;
@end

@implementation selectTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myFrame = frame;
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark - interface

- (void)show{
    [UIView animateWithDuration:0.6 animations:^{
        self.frame = self.myFrame;
    }];
}

- (void)hidden{
    [UIView animateWithDuration:0.6 animations:^{
        self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), 0);
    }];
}

#pragma mark - tableDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellResuabelStr];
    XMNAlbumModel *albumModel = self.dataSource[indexPath.row];
    cell.textLabel.text = albumModel.name;
    cell.backgroundColor = ColorFromRGB(0x2E2E3A, 0.85);
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectBlock(indexPath);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [UIView new];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

#pragma mark - getter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellResuabelStr];
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    LAZYINITMUARRAY(_dataSource)
}

@end
