//
//  AddLabelViewController.m
//  M-Cut
//
//  Created by apple on 16/12/29.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

/*
    一个组，放所有图片数据，剩下的用一个view来放
    此处有问题：不能确定使用哪个接口上传标签信息
 */

#import "AddLabelViewController.h"
#import "VideoDBOperation.h"
#import "UploadMaterialModel.h"
#import "LabelsView.h"

@interface AddLabelViewController ()
@property (nonatomic, strong) NSMutableArray *cloudUploadMuArray;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray *labelTitleMuArray;
@property (nonatomic, strong) LabelsView *labelsView;
@property (nonatomic, strong) UIView *upView;
@end

@implementation AddLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

#pragma mark - 重写父类方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.cloudUploadMuArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = [super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    return cell;
}

#pragma mark - interface

- (void)setUI{
    NAVIGATIONBARLEFTBARBUTTONITEM(@"取消")
    NAVIGATIONBARRIGHTBARBUTTONITEM(@"保存")
    self.title = @"批量添加标签";
    self.headerHeight = 0;
    [self.view addSubview:self.upView];
    self.imageCollectionView.frame = CGRectMake(0, CGRectGetHeight(self.upView.frame), ISScreen_Width, CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.upView.frame));
}

- (void)leftBarButtonItemAction:(UIButton *)btn{
    [self showActionSheet];
}

- (void)rightBarButtonItemAction:(UIButton *)btn{
    [self saveLabel];
}

- (void)showActionSheet{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"保存标签" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        WEAKSELF2
        [weakSelf saveLabel];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [actionSheet dismissViewControllerAnimated:YES completion:^{
            
        }];
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:^{
        
    }];
    
}

- (void)saveLabel{
    SHOWHUD
    
    /*
     "name": "filename",
     "type": "image/png",
     "etag": "32位md5散列值",
     "createtime": "y-m-d h:m:s",
     "contentsize": "1024"
     */
    NSMutableArray *tempArray = [NSMutableArray new];
    for (UploadMaterialModel *uploadModel in self.cloudUploadMuArray) {
        NSDictionary *imageInfoDic = @{@"name":uploadModel.fileName, @"type":uploadModel.fileType, @"createtime":uploadModel.createTime, @"contentsize":uploadModel.contentSize};
        [tempArray addObject:imageInfoDic];
    }
    
    //上传标签
    [SINGLETON(AFNetWorkManager) updateLabelWithFilePath:[NSString stringWithFormat:@"/%@", self.albumInfoDic[@"dirname"]] FileArray:[tempArray copy] Progress:^(NSProgress *progress) {
        HIDDENHUD
        NSLog(@"%@", progress);
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        HIDDENHUD
        NSLog(@"%@", responseObject);
        SHOWALERT(@"保存成功")
    } Fail:^(NSURLSessionDataTask *task, NSError *error) {
        HIDDENHUD
        NSLog(@"%@", error);
    }];
}

- (void)textChange:(NSNotification *)noti{
    if (self.textField.text.length > 10) {
        SHOWALERT(@"字数已打上限")
    }
}

- (void)textViewEndEditing:(NSNotification *)noti{
    [self.labelTitleMuArray addObject:self.textField.text];
    [self addNewTitle];
}

- (void)addNewTitle{
    self.labelsView = nil;
    self.upView = nil;
    [self.view addSubview:self.upView];
    self.imageCollectionView.frame = CGRectMake(0, CGRectGetHeight(self.upView.frame), ISScreen_Width, CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.upView.frame));
}

#pragma mark - getter

- (NSMutableArray *)cloudUploadMuArray{
    if (!_cloudUploadMuArray) {
        NSArray *tempArray = [[VideoDBOperation Singleton] selectAllMaterialData];
        for (UploadMaterialModel *uploadModel in tempArray) {
            if (uploadModel.status == uploadFinish) {
                [_cloudUploadMuArray addObject:uploadModel];
            }
        }
    }
    return _cloudUploadMuArray;
}

- (NSMutableArray *)labelTitleMuArray{
    LAZYINITMUARRAY(_labelTitleMuArray)
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, 44)];
        REGISTEREDNOTI(textChange:, UITextFieldTextDidChangeNotification);
        REGISTEREDNOTI(textViewEndEditing:, UITextFieldTextDidEndEditingNotification);
    }
    return _textField;
}

- (LabelsView *)labelsView{
    if (!_labelsView) {
        
        _labelsView = [[LabelsView alloc] initWithWidth:ISScreen_Width LabelTitleArray:self.labelTitleMuArray];
        
        _labelsView.frame = CGRectMake(0, 44, ISScreen_Width, _labelsView.height);
        
        [_labelsView setTouchLabelBlock:^(NSInteger index) {
            
        }];
    }
    return _labelsView;
}

- (UIView *)upView{
    if (!_upView) {
        _upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, CGRectGetHeight(self.labelsView.frame) + CGRectGetHeight(self.textField.frame))];
        [_upView addSubview:self.textField];
        [_upView addSubview:self.labelsView];
    }
    return _upView;
}

@end
