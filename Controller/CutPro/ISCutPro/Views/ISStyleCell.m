//
//  ISStyleCell.m
//  M-Cut
//
//  Created by 李亚飞 on 15/11/25.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "ISStyleCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"

@implementation ISStyle

@end

@interface ISStyleCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *styleLabel;
@property (weak, nonatomic) UIView *cover;

@end

@implementation ISStyleCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setStyle:(ISStyle *)style {
    _style = style;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:style.szThumbnail]];
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:style.szThumbnail] placeholderImage:[UIImage imageNamed:@""]];
    self.styleLabel.text = [style.szName addSymbol:@" " space:1];
}


@end
