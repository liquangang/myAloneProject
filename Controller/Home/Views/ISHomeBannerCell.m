//
//  ISHomeBannerCell.m
//  INSHOW
//
//  Created by 李亚飞 on 15/11/16.
//  Copyright © 2015年 李亚飞. All rights reserved.
//

#import "ISHomeBannerCell.h"
#import "ScrollViewLoop.h"

@interface ISHomeBannerCell () <UITextFieldDelegate>
/**  搜索框 */
@property (weak, nonatomic) IBOutlet UITextField *searchField;
/**  scrollView 距离 cell 顶部的间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewTopMargin;

@end

@implementation ISHomeBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = ISBackgroundColor;
    self.searchField.delegate = self;
    self.scrollView.backgroundColor = ISBackgroundColor;
    
    // 隐藏搜索框
    self.searchField.hidden = YES;
    self.scrollViewTopMargin.constant = 4;
}


#pragma mark ---- UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.searchField endEditing:YES];
    
    // 发起搜索
    if ([self.delegate respondsToSelector:@selector(homeBannerCell:search:)]) {
        [self.delegate homeBannerCell:self search:textField.text];
    }
}

@end
