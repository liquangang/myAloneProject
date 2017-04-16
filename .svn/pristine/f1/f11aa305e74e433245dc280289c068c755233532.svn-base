//
//  CaptionEditeCollecterViewController.m
//  M-Cut
//
//  Created by zhangxiaotian on 15/6/9.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//
/**   字幕编辑页面*/
#import "CaptionEditeCollecterViewController.h"
#import "App_vpVDCOrderForCreate.h"

extern NSString *captionedite;
@implementation CaptionEditeCollecterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑";
    cellIndex = -1;
    _capeditCV.alwaysBounceVertical = YES;
    
    // 为 _capeditCV 添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewDraging:)];
    pan.minimumNumberOfTouches = 1;
    pan.maximumNumberOfTouches = 3;
    [_capeditCV addGestureRecognizer:pan];
    
    self.textView.text = self.stringText;
    array = [[NSMutableArray alloc] initWithCapacity:1];
    [array addObjectsFromArray:[self.stringText componentsSeparatedByString:@"\r\n"]];
    self.view.backgroundColor = [UIColor clearColor];
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    leftBarButton.frame = CGRectMake(0, 0, 20, 20);
    [leftBarButton addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
}

-(void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)collectionViewDraging:(UIPanGestureRecognizer *)pan {
    static CGFloat start = 0;
    static CGFloat end = 0;
    if (pan.state == UIGestureRecognizerStateBegan) {
        start = [pan locationInView:self.view].y;
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        end = [pan locationInView:self.view].y;
        
        if (start > end) {  // 向上拖拽, 视图向下滚动,
            // 计算滚动到的位置, 以最后一个 cell 的 maxY 为准
            // 如果向上滚动的高度
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:(array.count - 2) inSection:0];
            CaptionEditeCollectionViewCell *cell = (CaptionEditeCollectionViewCell *)[_capeditCV cellForItemAtIndexPath:indexPath];
            CGFloat cellMaxY = CGRectGetMaxY(cell.frame);
            
            CGFloat contentY = (start - end) < cellMaxY ? (start - end) : cellMaxY;
            [_capeditCV setContentOffset:CGPointMake(0, contentY) animated:YES];
        } else {    // 向下拖拽, 视图向上滚动
            // 计算滚动到的位置, 以第一个 cell 的 minY 为准
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
            CaptionEditeCollectionViewCell *cell = (CaptionEditeCollectionViewCell *)[_capeditCV cellForItemAtIndexPath:indexPath];
            CGFloat cellMinY = CGRectGetMinY(cell.frame);
            
            CGFloat contentY = (end - start) < start ? (end - start) : cellMinY;
            [_capeditCV setContentOffset:CGPointMake(0, contentY) animated:YES];
        }
    }
    
    [_capeditCV endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    int counts = (int)[array count] - 1;
    captionedite = @"";
    for (int i = 0; i <= counts; i++) {
        NSString *string = [[NSString alloc] init];
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
        CaptionEditeCollectionViewCell *cell = (CaptionEditeCollectionViewCell *)[self.capeditCV cellForItemAtIndexPath:indexpath];
//        NSArray *array2 = [[NSArray alloc] init];
        NSArray *array2 = [cell.textTV.text componentsSeparatedByString:@"\n"];
        if (!array2) {
//            NSString *string = [[NSString alloc] init];
            NSString *string = [array objectAtIndex:i];
            string = [string stringByAppendingString:@"\r\n"];
            captionedite = [captionedite stringByAppendingString:string];
        }else{
            if ([array2 count]) {
                for (int j = 0; j < [array2 count]; j++) {
                    if ([[array2 objectAtIndex:j] isEqualToString:@""]) {
                        
                    }else{
                        string = [string stringByAppendingString:[array2 objectAtIndex:j]];
                    }
                }
                string = [string stringByAppendingString:@"\r\n"];
            }else{
                string = cell.textTV.text;
                string = [string stringByAppendingString:@"\r\n"];
            }
            captionedite = [captionedite stringByAppendingString:string];
        }
    }
//    NewNSOrderDetail *newNSOrderDetail = [[NewNSOrderDetail alloc] init];
    NewNSOrderDetail *newNSOrderDetail = nil;
    if ([NewUserOrderList Singleton].newcutlist.count > 0) {
        newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
        newNSOrderDetail.szCustomerSubtitle = captionedite;
        [[NewUserOrderList Singleton].newcutlist replaceObjectAtIndex:0 withObject:newNSOrderDetail];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark --  UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark --- 开始编辑时滚动到当前点击的 cell 的位置
- (void)textViewDidBeginEditing:(UITextView *)textView {
    CaptionEditeCollectionViewCell *cell = (CaptionEditeCollectionViewCell *)textView.superview.superview;
    CGFloat height = CGRectGetMinY(cell.frame);
    [_capeditCV setContentOffset:CGPointMake(0, height) animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    UIView *view = textView.superview;
    UILabel *l;
    for (UIView *subView in [view subviews]){
        if([subView isKindOfClass:[UILabel class]])
            l = (UILabel *)subView;
    }
    NSString *s1 = l.text;
    NSMutableArray *b = [[NSMutableArray alloc] init];
    [b addObjectsFromArray:[s1 componentsSeparatedByString:@"."]];
    int ind = [[b objectAtIndex:0] intValue] - 1;
    NSString *s2 = textView.text;
    NSArray *array2 = [[NSArray alloc] init];
    array2 = [s2 componentsSeparatedByString:@"\n"];
    if ([array2 count]) {
        s2 = @"";
        for (int j = 0; j < [array2 count]; j++) {
            if ([[array2 objectAtIndex:j] isEqualToString:@""]) {
                
            }else{
                s2 = [s2 stringByAppendingString:[array2 objectAtIndex:j]];
            }
        }
    }
    [array replaceObjectAtIndex:(NSUInteger)ind withObject:s2];
    [self.delegate changeText:[self combineText:array]];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    NSLog(@"%ld",[array count]);
    return [array count] - 1;
}
//编辑栏中显示数组中的文字（每一行）
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CaptionEditeIdentifier = @"CaptionEditeIdentifier";
//    CaptionEditeCollectionViewCell *captionEditeCollectionViewCell = [[CaptionEditeCollectionViewCell alloc] init];
    CaptionEditeCollectionViewCell *captionEditeCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:CaptionEditeIdentifier forIndexPath:indexPath];
    captionEditeCollectionViewCell.numLab.text = [NSString stringWithFormat:@"%d.",((int)indexPath.row + 1)];
    captionEditeCollectionViewCell.textTV.text = [array objectAtIndex:indexPath.row];
#pragma mark -- 设置 textView 的代理
    captionEditeCollectionViewCell.textTV.delegate = self;
    captionEditeCollectionViewCell.bacgroundview.layer.borderWidth = 0.5;
    captionEditeCollectionViewCell.bacgroundview.layer.borderColor = [UIColor grayColor].CGColor;
    return captionEditeCollectionViewCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cellWidth = (_capeditCV.width-20);
    cellHeight =40;
    return CGSizeMake(cellWidth, cellHeight);
}

-(NSString*)combineText:(NSMutableArray*)muArray
{
    NSString* ret= [[NSString alloc]init];
    for (NSString* member in muArray){
        if (![member isEqualToString:@""]) {
            ret = [ret stringByAppendingString:member];
            ret = [ret stringByAppendingString:@"\r\n"];
        }
    }
    return ret;
}

@end
