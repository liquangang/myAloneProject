//
//  UploadImageQualityView.m
//  M-Cut
//
//  Created by apple on 16/12/22.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "UploadImageQualityView.h"
#import "QualitySelectTableViewCell.h"

static NSString *resuableStr = @"QualitySelectTableViewCell";

@interface UploadImageQualityView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *qualityTable;
@property (nonatomic, strong) UIButton *showQualitySelectButton;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UILabel *selectQualityLabel;
@property (nonatomic, strong) NSArray *qualityDataSource;
@property (nonatomic, strong) NSDictionary *selectQualityInfo;
@end

@implementation UploadImageQualityView

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.qualityDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *qualityInfo = self.qualityDataSource[indexPath.row];
    QualitySelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resuableStr];
    cell.qualityDesLabel.text = qualityInfo[@"des"];
    cell.qualityTitleLabel.text = qualityInfo[@"title"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 6;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, 6)];
    footerView.backgroundColor = ColorFromRGB(0x272732, 1.0);
    return footerView;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectQualityInfo = self.qualityDataSource[indexPath.row];
    self.selectQualityLabel.text = [NSString stringWithFormat:@"照片质量：%@", self.selectQualityInfo[@"title"]];
    self.selectQualityBlock([self.selectQualityInfo[@"type"] integerValue]);
}

#pragma mark - interface

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    self.backgroundColor = ColorFromRGB(0x2E2E3A, 1.0);
    
    [self addSubview:self.qualityTable];
    [self addSubview:self.nextButton];
    [self addSubview:self.selectQualityLabel];
    [self addSubview:self.showQualitySelectButton];
    [self.nextButton addSubview:self.nextLabel];

    //设置约束
    [self setConstraints];
}

- (void)setConstraints{
    WEAKSELF2
    
    [self.qualityTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 44, 0));
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.qualityTable.mas_bottom).with.offset(0);
        make.right.mas_equalTo(weakSelf.mas_right).with.offset(0);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).with.offset(0);
        make.width.mas_equalTo(105);
    }];
    
    [self.nextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.selectQualityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left).with.offset(15);
        make.top.mas_equalTo(weakSelf.qualityTable.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(108, 44));
    }];
    
    [self.showQualitySelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.selectQualityLabel.mas_right).with.offset(0);
        make.top.mas_equalTo(weakSelf.qualityTable.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(33, 44));
    }];
}

- (void)showQualitySelectButtonAction{
    self.showQualitySelectButton.selected = !self.showQualitySelectButton.selected;
    self.qualityTable.hidden = !self.qualityTable.hidden;
    self.showSelectTableBlock(self.qualityTable.hidden);
}

- (void)nextButtonAction{
    self.nextStepBlock([self.selectQualityInfo[@"type"] integerValue]);
}

#pragma mark - getter

- (UITableView *)qualityTable{
    
    if (!_qualityTable) {
        _qualityTable = [[UITableView alloc] init];
        _qualityTable.delegate = self;
        _qualityTable.dataSource = self;
        [_qualityTable registerNib:[UINib nibWithNibName:resuableStr bundle:nil] forCellReuseIdentifier:resuableStr];
        _qualityTable.hidden = YES;
        _qualityTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _qualityTable.scrollEnabled = NO;
        _qualityTable.backgroundColor = [UIColor redColor];
    }
    return _qualityTable;
}

- (NSArray *)qualityDataSource{
    
    if (!_qualityDataSource) {
        _qualityDataSource = @[@{@"title":@"正常", @"des":@"流量消耗较小，推荐使用", @"type":@(normalImage)},
                               @{@"title":@"高清", @"des":@"图片质量高，上传速度较慢", @"type":@(highDefinitionImage)},
                               @{@"title":@"原图", @"des":@"上传速度慢，非WIFI下不建议使用", @"type":@(originalImage)}];
    }
    return _qualityDataSource;
}

- (UILabel *)nextLabel{
    if (!_nextLabel) {
        _nextLabel = [UILabel new];
        _nextLabel.text = @"0 下一步";
        _nextLabel.backgroundColor = ColorFromRGB(0xF4413F, 1.0);
        _nextLabel.font = ISFont_15;
        _nextLabel.textColor = [UIColor whiteColor];
        _nextLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nextLabel;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton new];
        [_nextButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

- (UILabel *)selectQualityLabel{
    if (!_selectQualityLabel) {
        _selectQualityLabel = [UILabel new];
        _selectQualityLabel.text = @"照片质量：正常";
        _selectQualityLabel.font = [UIFont systemFontOfSize:14];
        _selectQualityLabel.textColor = [UIColor whiteColor];
    }
    return _selectQualityLabel;
}

- (UIButton *)showQualitySelectButton{
    if (!_showQualitySelectButton) {
        _showQualitySelectButton = [UIButton new];
        [_showQualitySelectButton setImage:[UIImage imageNamed:@"上箭头灰色"] forState:UIControlStateNormal];
        [_showQualitySelectButton setImage:[UIImage imageNamed:@"下箭头灰色"] forState:UIControlStateSelected];
        [_showQualitySelectButton addTarget:self action:@selector(showQualitySelectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showQualitySelectButton;
}

@end
