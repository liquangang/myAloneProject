//
//  ConnectFailedView.m
//  M-Cut
//
//  Created by Crab00 on 16/1/7.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "ConnectFailedView.h"

@implementation ConnectFailedView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIImageView *newpic = [[UIImageView alloc]init];
    UIImage *img = [UIImage imageNamed:@"failed"];
    [newpic setImage:img];
    [newpic setFrame:CGRectMake((self.frame.size.width-img.size.width)/2, (self.frame.size.height-img.size.height)/3, img.size.width+1, img.size.height+1)];
    [self addSubview:newpic];
    
    UILabel *label = [[UILabel alloc]init];
    NSString *str = @"网络异常，无法加载信息";
    CGSize sizestr = [str sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT, 0.0) lineBreakMode:NSLineBreakByWordWrapping];
//    CGSize size = [str sizeWithFont:label.font constrainedToSize:CGSizeMake(label.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    [label setFrame:CGRectMake((self.frame.size.width-sizestr.width)/2, (self.frame.size.height-img.size.height)/3+img.size.height+10, sizestr.width+1, sizestr.height+1)];
    [label setText:str];
    
    [self addSubview:label];

}


#pragma mark - Initialization 根据业务逻辑，传入数据，初始化自己

- (id)initItemWithFram:(CGRect)frame andData:(NSMutableDictionary *)paramData{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _imgPic=[[UIImageView alloc] init];
        [_imgPic setImage:[UIImage imageNamed:@"failed"]];
        _aftertext=[[UILabel alloc] init];
    }
    self.dictData=paramData;
    return self;
}

# pragma mark - 重写父类的removeFromSuperview方法，在删除时，使用相应的动画效果

//- (void) removeFromSuperview {
//    
//    [UIView animateWithDuration:0.2 animations:^{
//        self.alpha = 0.0;
//        [self setFrame:CGRectMake(self.frame.origin.x+50, self.frame.origin.y+50, 0, 0)];
////        [_btnDel setFrame:CGRectMake(0, 0, 0, 0)];
//    }completion:^(BOOL finished) {
//        [super removeFromSuperview];
//    }];
//}
@end
