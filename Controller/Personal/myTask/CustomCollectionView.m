//
//  CustomCollectionView.m
//  M-Cut
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CustomCollectionView.h"
#import "NewUserTaskCollectionViewCell.h"
#import "MovierDCInterfaceSvc.h"
#import "SoapOperation.h"
//#import "AccountAndSafeViewController.h"
//#import "AccountBindingViewController.h"

@implementation CustomCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

static NSString * cellId = @"cell";

- (NSMutableArray *)myDataSource{
    if (!_myDataSource) {
        _myDataSource = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewUserTaskProperty List" ofType:@"plist"]];
    }
    return _myDataSource;
}


+ (id)collectionWithFrame:(CGRect)frame andItemSize:(CGSize)mySize Delegate:(id<CustomCollectionViewDelegate>)delegate UserScoreTask:(MovierDCInterfaceSvc_VDCNewUserScoreTask *)userScoreTaskInfo{
    UICollectionViewFlowLayout * myLayout = [UICollectionViewFlowLayout new];
    myLayout.itemSize = mySize;
    myLayout.minimumLineSpacing = 0;
    myLayout.minimumInteritemSpacing = 0;
    myLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    CustomCollectionView * customeCollectionView = [[CustomCollectionView alloc] initWithFrame:frame collectionViewLayout:myLayout];
    customeCollectionView.customCollectionViewDelegate = delegate;
    customeCollectionView.myUserScoreTask = userScoreTaskInfo;
    return customeCollectionView;
}


- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if ([super initWithFrame:frame collectionViewLayout:layout]) {
        self.frame = frame;
        self.collectionViewLayout = layout;
        self.dataSource = self;
        self.delegate = self;
        [self registerNib:[UINib nibWithNibName:@"NewUserTaskCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellId];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.myDataSource.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NewUserTaskCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    // Configure the cell
    NSDictionary * dic = self.myDataSource[indexPath.row];
    NSString * str = [[dic allValues] firstObject];
    NSString * str1 = [[dic allKeys] firstObject];
    cell.taskDesLabel.text = str;
    cell.taskImage.image = [UIImage imageNamed:[str1 componentsSeparatedByString:@"?"][0]];
    if (self.myUserScoreTask.IsBindTel.boolValue && [cell.taskDesLabel.text isEqualToString:@"绑定手机"]) {
        cell.taskImage.image = [UIImage imageNamed:[str1 componentsSeparatedByString:@"?"][1]];
    }
    if (self.myUserScoreTask.nCustomerID.boolValue && [cell.taskDesLabel.text isEqualToString:@"注册账号"]) {
        cell.taskImage.image = [UIImage imageNamed:[str1 componentsSeparatedByString:@"?"][1]];
    }
    if (self.myUserScoreTask.HaveBirthday.boolValue && [cell.taskDesLabel.text isEqualToString:@"设置生日"]) {
        cell.taskImage.image = [UIImage imageNamed:[str1 componentsSeparatedByString:@"?"][1]];
    }
    if (self.myUserScoreTask.HaveNickName.boolValue && [cell.taskDesLabel.text isEqualToString:@"设置昵称"]) {
        cell.taskImage.image = [UIImage imageNamed:[str1 componentsSeparatedByString:@"?"][1]];
    }
    if (self.myUserScoreTask.HaveAvatar.boolValue && [cell.taskDesLabel.text isEqualToString:@"设置头像"]) {
        cell.taskImage.image = [UIImage imageNamed:[str1 componentsSeparatedByString:@"?"][1]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.customCollectionViewDelegate respondsToSelector:@selector(pushVcWithIndex:)]) {
        [self.customCollectionViewDelegate pushVcWithIndex:indexPath];
    }
}

@end
