//
//  ISStyleDetailHeaderView.m
//  M-Cut
//
//  Created by 李亚飞 on 15/11/28.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "ISStyleDetailHeaderView.h"
#import "UIImageView+WebCache.h"
#import "ISStyleCell.h"

@interface ISStyleDetailHeaderView ()
/**   缩略图 */
@property (weak, nonatomic) UIImageView *iconView;
/**  描述信息 */
@property (weak, nonatomic) UILabel *descLabel;
@end

@implementation ISStyleDetailHeaderView

+ (instancetype)viewWithTableView:(UITableView *)tableView {
    static NSString *ID = @"styleDetailHeaderView";
    ISStyleDetailHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!headerView) {
        headerView = [[ISStyleDetailHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.textColor = [UIColor whiteColor];
    descLabel.numberOfLines = 2;
    descLabel.font = ISFont_15;
    descLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:descLabel];
    self.descLabel = descLabel;
}

- (void)setStyle:(ISStyle *)style {
    _style = style;
    
    // 透视图的尺寸
    CGFloat height = 118.0 / 667 * ISScreen_Height;
    CGFloat width  = ISScreen_Width;
    
    // 设置图片
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:style.szThumbnail]];
    self.iconView.backgroundColor = ISTestRandomColor;
    self.iconView.frame = CGRectMake(0, 0, width, height);
    self.iconView.clipsToBounds = YES;
    self.iconView.contentMode = UIViewContentModeScaleAspectFill;
    
    // 设置文字
    NSString *desc = style.szDesc;
    // 计算15个字的宽度
    NSString *testString = @"样样样样样样样样样样样样样样样";
    CGFloat descMaxW = [testString sizeWithWidth:width font:ISFont_15].width;
    
    CGSize descSize = [desc sizeWithWidth:descMaxW font:ISFont_15];
    self.descLabel.text = desc;
    CGFloat descW = descSize.width;
    CGFloat descH = descSize.height;
    CGFloat descX = (width - descW) * 0.5;
    CGFloat descY = (height - descH) * 0.5;
    self.descLabel.frame = CGRectMake(descX, descY, descW, descH);
}

@end
