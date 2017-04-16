//
//  ISHomeBannerView.m
//  M-Cut
//
//  Created by 李亚飞 on 15/12/10.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "ISHomeBannerView.h"
#import "ScrollViewLoop.h"

//@implementation ISHomeBannerView
//
//- (void)prepareForReuse {
//    [super prepareForReuse];
//    
//    [self removeAllSubViews];
//    
//    [self setupView];
//}
//
//- (void)removeAllSubViews {
//    for (UIView *view in self.subviews) {
//        [view removeFromSuperview];
//    }
//}
////<<<<<<< .mine
//
////-(void)prepareForReuse {
////    [super prepareForReuse];
////    
////    //    [self removeFromSuperview];
////    [self removeAllSubViews];
////    
////    [self setupView];
////}
//
////- (void)removeAllSubViews {
////    for (UIView *view in self.subviews) {
////        [view removeFromSuperview];
////    }
////}
////
////- (void)setupView {
////    // 图片
////    ScrollViewLoop *scrollView = [[ScrollViewLoop alloc] init];
////    [self addSubview:scrollView];
////    self.scrollView = scrollView;
////}
//
////=======
//
//- (void)setupView {
//    // 图片
//    ScrollViewLoop *scrollView = [[ScrollViewLoop alloc] init];
//    [self addSubview:scrollView];
//    self.scrollView = scrollView;
//}
////>>>>>>> .r761
//@end

@interface ISHomeBannerView() <UITextFieldDelegate>
/**  搜索框 */
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewTopMargin;

@end

@implementation ISHomeBannerView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.textField.delegate = self;
    self.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    // 隐藏搜索框
    self.textField.hidden = YES;
    self.scrollViewTopMargin.constant = 0;
}

#pragma mark ---- UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.textField endEditing:YES];
    
    // 发起搜索
    if ([self.delegate respondsToSelector:@selector(homeBannerView:search:)]) {
        [self.delegate homeBannerView:self search:textField.text];
    }
}
@end
