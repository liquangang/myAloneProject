//
//  HomeVideoReportCommentViewController.m
//  M-Cut
//
//  Created by 李亚飞 on 15/12/2.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "HomeVideoReportCommentViewController.h"
#import "ISPlaceholderTextView.h"
#import "GlobalVars.h"
//#import "MBProgressHUD+MJ.h"
#import "UserEntity.h"
#import "CustomeClass.h"

#define MaxInputNumber 1000


@interface HomeVideoReportCommentViewController () <UITextViewDelegate>
/**  色情低俗 */
@property (weak, nonatomic) IBOutlet UIButton *vulgarityButton;
/**  政治敏感 */
@property (weak, nonatomic) IBOutlet UIButton *politicSensitiveButton;
/**  人身攻击 */
@property (weak, nonatomic) IBOutlet UIButton *attackButton;
/**  其他 */
@property (weak, nonatomic) IBOutlet UIButton *otherButton;

/**  举报 action */
- (IBAction)reportAction:(UIButton *)sender;

/**  确定按钮 */
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
- (IBAction)confirm:(UIButton *)sender;

/**  用户文本输入框 */
@property (weak, nonatomic) IBOutlet ISPlaceholderTextView *textView;
/**  文本框高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;

/**  记录当前选中的按钮 */
@property (weak, nonatomic) UIButton *selectedButton;

/**  最多允许用户输入的字数 */
@property (weak, nonatomic) IBOutlet UILabel *maxInputCount;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *maxInputHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *maxInputWidth;
/**  用户当前输入的字数 */
@property (weak, nonatomic) IBOutlet UILabel *currentInputCount;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *currentInputHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *currentInputWidth;

@end

@implementation HomeVideoReportCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航
    [self setupNavigation];
    
    // 设置文本框内容
    self.textView.delegate = self;
    self.textView.placeholder = @"详细填写, 能够让举报得到更好的受理";
    [self setTextViewContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**  设置导航信息 */
- (void)setupNavigation {
    // 标题
    UILabel *label = [[UILabel alloc] init];
    label.text = @"举报";
    label.font = ISFont_17;
    CGSize labelSize = [label.text sizeWithWidth:MAXFLOAT font:ISFont_17];
    label.textColor = ISRGBColor(255, 255, 255);
    label.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
    self.navigationItem.titleView = label;
    
    // 左侧按钮
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];

    leftBarButton.frame = CGRectMake(0, 0, 11, 30);

    [leftBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [leftBarButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    leftBarButton.titleLabel.font = ISFont_16;
    [leftBarButton addTarget:self action:@selector(leftBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
}

- (void)leftBarButtonClick:(UIButton *)button {
#pragma mark - 传递字幕信息
    [self.navigationController popViewControllerAnimated:YES];
}

/**  举报内容 : 色情低俗, 政治敏感, 人身攻击, 盗用作品, 其他 */
- (IBAction)reportAction:(UIButton *)sender {
    // 普通状态下, 点击按钮
    if (self.selectedButton) {  // 当前点击的按钮存在
        if (self.selectedButton == sender) {    // 选中的按钮   ==   现在点击的按钮
            // 说明当前按钮是选中状态
            self.selectedButton = nil;
            // 按钮状态改变
            sender.selected = !sender.selected;     // 等价  sender.selected = NO
        } else {    // 选中的按钮   !=   现在点击的按钮
            // 当前按钮不是选中状态
            self.selectedButton.selected = NO;
            sender.selected = !sender.selected;
            self.selectedButton = sender;       // 等价  sender.selected = YES
        }
    } else {    // 当前点击的按钮 不存在
        self.selectedButton = sender;
        // 按钮状态改变
        sender.selected = !sender.selected;
    }
    
    // 设置 textView 的状态
    [self setTextViewContent];
}

/**  设置 textView 的内容及字体, 确定按钮是否可用 */
- (void)setTextViewContent {
    if (self.selectedButton) {     // 有按钮被选中
        self.textView.hidden = NO;
        self.maxInputCount.hidden = NO;
        self.currentInputCount.hidden = NO;
        if (iPhone4 || iPhone5_5S_5C) {
            // 1. 设置 textView
            self.textView.font = ISFont_12;
            self.textViewHeight.constant = 108;
            
            // 2. 设置统计字数 label 的文字和大小
            [self maxInputLabelSizeWithFont:ISFont_12];
        } else if (iPhone6_6S) {
            self.textView.font = ISFont_14;
            self.textViewHeight.constant = 120;
            
            [self maxInputLabelSizeWithFont:ISFont_14];
        } else if (iPhone6_6SPlus) {
            self.textView.font = ISFont_16;
            self.textViewHeight.constant = 132;
            
            [self maxInputLabelSizeWithFont:ISFont_16];
        }
        // 设置 确定按钮 可用
        self.confirmButton.userInteractionEnabled = YES;
    } else {
        self.textView.hidden = YES;
        self.textViewHeight.constant = 0;
        
        self.maxInputCount.hidden = YES;
        self.currentInputCount.hidden = YES;
        self.maxInputHeight.constant = 0;
        self.maxInputWidth.constant = 0;
        // 设置 确定按钮 不可用
        self.confirmButton.userInteractionEnabled = NO;
    }
}

- (void)maxInputLabelSizeWithFont:(UIFont *)font {
    self.maxInputCount.text = @"/1000 ";
    CGSize maxInputSize = [@"/1000 " sizeWithWidth:MAXFLOAT font:font];
    self.maxInputHeight.constant = maxInputSize.height;
    self.maxInputWidth.constant  = maxInputSize.width + 10;
}

- (void)currentInputLabelSizeWithFont:(UIFont *)font textLength:(NSString *)length {
    self.currentInputCount.text = length;
    CGSize maxInputSize = [length sizeWithWidth:MAXFLOAT font:font];
    self.currentInputHeight.constant = maxInputSize.height;
    self.currentInputWidth.constant  = maxInputSize.width + 10;
}

#pragma mark ---- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    NSInteger length = textView.text.length;
    NSString *content = textView.text;
    
    // 如果文字长度大于1000, 不能继续输入
    if (length > MaxInputNumber) {
        content = [content substringToIndex:MaxInputNumber];
        textView.text = content;
    }
    
    // 设置用户输入文字的个数
    NSString *currentLength = [NSString stringWithFormat:@"%ld", (long)length];
    
    // 根据字数设置颜色
    if (length == MaxInputNumber) {
        self.currentInputCount.textColor = [UIColor redColor];
    } else {
        self.currentInputCount.textColor = ISRGBColor(64, 74, 88);
    }
    
    // 根据屏幕设置大小
    if (iPhone4 || iPhone5_5S_5C) {
        [self currentInputLabelSizeWithFont:ISFont_12 textLength:currentLength];
    } else if (iPhone6_6S) {
        [self currentInputLabelSizeWithFont:ISFont_14 textLength:currentLength];
    } else if (iPhone6_6SPlus) {
        [self currentInputLabelSizeWithFont:ISFont_16 textLength:currentLength];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder]; return NO;
    }
    return YES;
}

/**  确定按钮 */
- (IBAction)confirm:(UIButton *)sender {
    if (self.selectedButton) {
        // 1. 获得 举报的类型(当前选中的按钮)
        NSNumber *type = [self reportType];
        
        // 2. 获得举报的内容
        NSString *content = self.textView.text;
        
        // 3. 将举报内容发送给服务器
        SoapOperation *soap = [SoapOperation Singleton];
        [soap WS_ReportCommentByid:self.commentID Session:nil ReportType:type Reason:content Success:^{
            dispatch_async(dispatch_get_main_queue(), ^{
//                [MBProgressHUD showSuccess:@"举报成功, 我们会尽快处理."];
                [CustomeClass showMessage:@"举报成功, 我们会尽快处理!" ShowTime:3];
            });
        } Fail:^(NSError *error) {
//            NSLog(@"------%s------%@", __func__, error);
            DEBUGLOG(error);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:@"请检查网络"];
//            });
        }];
    }
}

- (NSNumber *)reportType{
    int type = 0;
    if (self.selectedButton == self.vulgarityButton) {
        type = 1;
    } else if (self.selectedButton == self.politicSensitiveButton) {
        type = 2;
    } else if (self.selectedButton == self.attackButton) {
        type = 3;
    } else if (self.selectedButton == self.otherButton) {
        type = 4;
    }
    return @(type);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView endEditing:YES];
}

@end
