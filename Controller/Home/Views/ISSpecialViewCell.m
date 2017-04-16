//
//  ISSpecialViewCell.m
//  M-Cut
//
//  Created by 李亚飞 on 15/11/30.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "ISSpecialViewCell.h"
#import "ISLabel.h"
#import "UIImageView+WebCache.h"

@interface ISSpecialViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation ISSpecialViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)setLabel:(ISLabel *)label {
    _label = label;
    
    // 设置图片
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:label.szThumbnail]  placeholderImage:[UIImage imageNamed:@"BG"] options:SDWebImageRetryFailed | SDWebImageRefreshCached];
}

@end
