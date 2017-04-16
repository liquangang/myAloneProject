//
//  ISActiviteCell.m
//  M-Cut
//
//  Created by 李亚飞 on 15/11/30.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "ISActiviteCell.h"
#import "ISLabel.h"
#import "UIImageView+WebCache.h"

@interface ISActiviteCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *visitCountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *visitCountLabelWidth;

@end

@implementation ISActiviteCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)setLabel:(ISLabel *)label {
    _label = label;
    
    // 图片
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:label.szThumbnail]  placeholderImage:[UIImage imageNamed:@"BG"] options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    
    // 观看次数
    NSString *visit = [NSString stringWithFormat:@"参与数量:%@", label.nVideoNum];
    CGSize visitSize = [visit sizeWithWidth:MAXFLOAT font:ISFont_14];
    self.visitCountLabel.text = visit;
    self.visitCountLabelWidth.constant = visitSize.width + 10;
    
    // 名称
    self.nameLabel.text = label.szLabelName;
}

@end
