//
//  TakeVideoView.m
//  M-Cut
//
//  Created by apple on 16/10/28.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "TakeVideoView.h"
#import "TakeVideoTableViewCell.h"
#import "TrangleTableViewCell.h"
#import "TempVideoOBj.h"

static NSString * const resuableStr = @"TakeVideoTableViewCell";
static NSString * const resuableStr2 = @"TrangleTableViewCell";

@interface TakeVideoView()<UITableViewDelegate,
                           UITableViewDataSource>
//tableview
@property (nonatomic, strong) UITableView * videoTable;
//底部显示image边框的table
@property (nonatomic, strong) UITableView * trangleTable;
//是否展开视频
@property (nonatomic, assign) BOOL isFold;
//headerview
@property (nonatomic, strong) UIView *headerView;
//rightButton
@property (nonatomic, strong) UIButton *rightButton;
@end

@implementation TakeVideoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headerView];
        
        //注册接受新增视频的通知
        REGISTEREDNOTI(addNewVideo:, SHOWVIDEOATVIDEOTABLE);
        
        self.backgroundColor = ISARGBColor(46, 46, 58, 0.5);
        
        //默认展开table
        self.isFold = YES;
        [self.videoTable reloadData];
    }
    return self;
}

#pragma mark - table代理
- (NSInteger)tableView:(UITableView *)tableView
             numberOfRowsInSection:(NSInteger)section{
    if (!self.isFold) {
        return 0;
    }
    if (tableView == self.trangleTable) {
        return 4;
    }
    return self.dataMuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
                     cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.trangleTable) {
        return [TrangleTableViewCell TrangleTableViewCellWithTable:tableView
                                                       ResuableStr:resuableStr2];
    }
    
    TempVideoOBj *tempVideoOBj;
    tempVideoOBj = self.dataMuArray[indexPath.row];
    
    TakeVideoTableViewCell * cell = [TakeVideoTableViewCell TakeVideoTableViewCellWithTableView:tableView
                                                                                    ResuableStr:resuableStr
                                                                                   VideoThumail:tempVideoOBj.videoThumailImage
                                                                                      IndexPath:indexPath];
    WEAKSELF2
    [cell setPlayBlock:^(NSIndexPath * playIndex) {
        MAINQUEUEUPDATEUI({
            
            //跳转到视频预览界面
            POSTNOTI(PUSHTOPREVIEWVIDEOVC, (@{PREVIEWVIDEOINDEX:playIndex,
                                              PREVIEWVIDEOARRAY:weakSelf.dataMuArray}));
        })
    }];
    [cell setDeleteBlock:^(NSIndexPath * deleteIndex) {
        MAINQUEUEUPDATEUI({
            
            //删除这个位置的视频图片
            [weakSelf.dataMuArray removeObjectAtIndex:deleteIndex.row];
            [weakSelf.videoTable reloadData];
        })
    }];
    
    if (tempVideoOBj.arid.length > 0) {
        cell.rewardImage.hidden = NO;
    }else{
        cell.rewardImage.hidden = YES;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
           heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark - 功能接口

/**
 *  新增视频
 */
- (void)addNewVideo:(NSNotification *)noti{
    if (!self.isFold) {
        self.isFold = YES;
    }
    [self.dataMuArray addObject:noti.userInfo[SHOWVIDEOTHUMAILIMAGE]];
    [self.videoTable reloadData];
    
    //显示使用视频按钮
    self.showUseVideoButton();
}

/**
 *  展开关闭
 */
- (void)foldButtonAction:(UITapGestureRecognizer *)tap{
    self.isFold = !self.isFold;
    [self.videoTable reloadData];
    [self.trangleTable reloadData];
}

#pragma mark - 懒加载
- (UITableView *)videoTable{
    if (!_videoTable) {
        _videoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 35)
                                                   style:UITableViewStylePlain];
        [self addSubview:_videoTable];
        _videoTable.backgroundColor = [UIColor clearColor];
        _videoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _videoTable.delegate = self;
        _videoTable.dataSource = self;
        [_videoTable registerNib:[UINib nibWithNibName:resuableStr bundle:nil]
          forCellReuseIdentifier:resuableStr];
    }
    return _videoTable;
}

- (UITableView *)trangleTable{
    if (!_trangleTable) {
        _trangleTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 35)
                                                     style:UITableViewStylePlain];
        [self insertSubview:_trangleTable belowSubview:self.videoTable];
        _trangleTable.backgroundColor = [UIColor clearColor];
        _trangleTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _trangleTable.userInteractionEnabled = NO;
        _trangleTable.delegate = self;
        _trangleTable.dataSource = self;
        [_trangleTable registerNib:[UINib nibWithNibName:resuableStr2 bundle:nil]
            forCellReuseIdentifier:resuableStr2];
    }
    return _trangleTable;
}

- (UIView *)headerView{
    if (!_headerView) {
        UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       self.bounds.size.width,
                                                                       35)];
        _headerView = headerView;
        headerView.backgroundColor = ISARGBColor(46, 46, 58, 0.6);
        ADDTAPGESTURE(headerView, foldButtonAction)
        
        //左侧图片
        UIImageView * leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 20, 20)];
        [headerView addSubview:leftImageView];
        leftImageView.image = [UIImage imageNamed:@"filmImage"];
        
        //视频标签
        UILabel * videoLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftImageView.frame.origin.x + 20 + 5,
                                                                         10,
                                                                         30,
                                                                         15)];
        [headerView addSubview:videoLabel];
        videoLabel.text = @"视频";
        videoLabel.textColor = [UIColor whiteColor];
        videoLabel.backgroundColor = [UIColor clearColor];
        videoLabel.font = ISFont_13;
        videoLabel.textAlignment = NSTextAlignmentCenter;
        
        //右侧按钮
//        UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 20,
//                                                                            14,
//                                                                            10,
//                                                                            7)];
//        [headerView addSubview:rightButton];
        [_headerView addSubview:self.rightButton];
        
//        if (self.isFold) {
//            self.backgroundColor = ISARGBColor(46, 46, 58, 0.5);
//            [rightButton setImage:[UIImage imageNamed:@"whiteArrowUpImage"]
//                         forState:UIControlStateNormal];
//        }else{
//            self.backgroundColor = [UIColor clearColor];
//            [rightButton setImage:[UIImage imageNamed:@"whiteArrowDownImage"]
//                         forState:UIControlStateNormal];
//        }
    }
    return _headerView;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        //右侧按钮
        UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 20,
                                                                            14,
                                                                            10,
                                                                            7)];
        _rightButton = rightButton;
    }
    if (self.isFold) {
        self.backgroundColor = ISARGBColor(46, 46, 58, 0.5);
        [_rightButton setImage:[UIImage imageNamed:@"whiteArrowUpImage"]
                     forState:UIControlStateNormal];
    }else{
        self.backgroundColor = [UIColor clearColor];
        [_rightButton setImage:[UIImage imageNamed:@"whiteArrowDownImage"]
                     forState:UIControlStateNormal];
    }
    return _rightButton;
}

- (NSMutableArray *)dataMuArray{
    if (!_dataMuArray) {
        _dataMuArray = [NSMutableArray new];
    }
    return _dataMuArray;
}
@end
