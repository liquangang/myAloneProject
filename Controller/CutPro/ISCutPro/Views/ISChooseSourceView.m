//
//  ISChooseSourceView.m
//  M-Cut
//
//  Created by 李亚飞 on 15/11/24.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "ISChooseSourceView.h"
@interface ISChooseSourceView ()

/**  拍摄视频 */
- (IBAction)camera:(id)sender;
/**  从相册中选择 */
- (IBAction)album:(id)sender;
/**  取消操作 */
- (IBAction)cancle:(id)sender;
@property (weak, nonatomic) UIView *coverView;
/**  相册按钮顶部间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *albumBtnTopSpace;
/**  相册按钮右侧间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *albumBtnRightSpace;
/**  左侧标题顶部间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftTitleTopSpace;

/**  按钮中间距离 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerSpace;
/**  拍摄视频按钮顶部间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoBtnTopSpace;
/**  右侧标题顶部间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightTitleTopSpace;

/**  按钮的宽度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidth;

/**  分割线顶部间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineTopView;

@end

@implementation ISChooseSourceView

+ (instancetype)chooseSourceView {
    return [[[NSBundle mainBundle] loadNibNamed:@"ISChooseSourceView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 2;
    self.clipsToBounds = YES;
    
    self.albumBtnTopSpace.constant      = 30.0 / 667 * ISScreen_Height;
    self.videoBtnTopSpace.constant      = 30.0 / 667 * ISScreen_Height;
    self.leftTitleTopSpace.constant     = 13.0 / 667 * ISScreen_Height;
    self.rightTitleTopSpace.constant    = 13.0 / 667 * ISScreen_Height;
    self.lineTopView.constant           = 28.0 / 667 * ISScreen_Height;
    
    self.centerSpace.constant           = 49.0 / 375 * ISScreen_Width;
    self.albumBtnRightSpace.constant    = 65.0 / 375 * ISScreen_Width;
    
    self.buttonWidth.constant           = 61.0 / 375 * ISScreen_Width;
}

- (void)show {
    CGFloat viewX = 38.0 / 375 * ISScreen_Width;
    CGFloat viewW = ISScreen_Width - 2 * viewX;
    CGFloat viewH = 183 / 667.0 * ISScreen_Height;
    CGFloat viewY = (667 - 242 - 183) / 667.0 * ISScreen_Height;
    
    // 添加遮罩
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, ISScreen_Height)];
    coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick:)];
    [coverView addGestureRecognizer:tap];
    [coverView addSubview:self];
    [[UIApplication sharedApplication].keyWindow addSubview:coverView];
    self.coverView = coverView;
    
    self.frame = CGRectMake(viewX, - viewY, viewW, viewH);
    
    [UIView animateWithDuration:0.4 animations:^{
        self.frame = CGRectMake(viewX, viewY, viewW, viewH);
    }];
}

- (void)dismiss {
    [self.coverView removeFromSuperview];
}

- (void)coverClick:(UITapGestureRecognizer *)tap {
    [self dismiss];
}

- (IBAction)camera:(id)sender {
    if ([self.delegate respondsToSelector:@selector(takeVideo)]) {
        [self.delegate takeVideo];
    }
    [self dismiss];
}

- (IBAction)album:(id)sender {
    if ([self.delegate respondsToSelector:@selector(choosePhoto)]) {
        [self.delegate choosePhoto];
    }
    [self dismiss];
}

- (IBAction)cancle:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cancle)]) {
        [self.delegate cancle];
    }
    [self dismiss];
}
@end