//
//  ISSpecialHeaderView.m
//  M-Cut
//
//  Created by 李亚飞 on 15/12/11.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "ISSpecialHeaderView.h"
#import "ISLabel.h"

#define margin (20.0 / 375 * ISScreen_Width)
#define padding (12.0 / 375 * ISScreen_Width)

@implementation ISLabelFrame

- (void)setLabel:(ISLabel *)label {
    _label = label;
    
    // 图标尺寸
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    CGFloat iconW = 17;
    CGFloat iconH = 17;
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 标题尺寸
    CGFloat titleX = CGRectGetMaxX(_iconF) + padding;
    CGSize titleSize = [label.szLabelName sizeWithWidth:MAXFLOAT font:ISFont_14];
    CGFloat titleW = titleSize.width;
    CGFloat titleH = titleSize.height;
    CGFloat titleY = CGRectGetMidX(_iconF) - titleH * 0.5;
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    // 描述尺寸
    CGFloat descX = iconX;
    CGFloat descY = CGRectGetMaxY(_iconF);
    CGFloat descMaxW = ISScreen_Width - margin * 2;
    CGSize descSize = [label.szDescribe sizeWithWidth:descMaxW font:ISFont_14];
    _descF = (CGRect){{descX, descY}, descSize};
    
    // cell 高度
    _cellH = CGRectGetMaxY(_descF);
}

@end
@interface ISSpecialHeaderView()
/**  标题 */
@property (weak, nonatomic) UILabel *titleLabel;
/**  描述 */
@property (weak, nonatomic) UILabel *descLabel;
/**  icon 图片 */
@property (weak, nonatomic) UIImageView *iconView;
@end

@implementation ISSpecialHeaderView

//+ (instancetype)headerViewWithCollectionView:(UICollectionView *)collectionView  atIndexPath:(NSIndexPath *)indexPath{
//    static NSString *specialHeaderView = @"specialHeaderView";
//    ISSpecialHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:specialHeaderView forIndexPath:indexPath];
//    
//    return header;
//}

- (void)prepareForReuse {
    [super prepareForReuse];
    
//    [self removeFromSuperview];
    [self removeAllSubViews];
    
    [self setupView];
}

- (void)removeAllSubViews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (void)setupView {
    // 图片
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.image = [UIImage imageNamed:@"bookmark-(alt)"];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = ISFont_14;
    titleLabel.textColor = ISRGBColor(64, 74, 88);
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    // 描述
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.font = ISFont_14;
    descLabel.textColor = ISRGBColor(64, 74, 88);
    descLabel.numberOfLines = 0;
    [self addSubview:descLabel];
    self.descLabel = descLabel;
}

- (void)setLabelF:(ISLabelFrame *)labelF {
    _labelF = labelF;
    ISLabel *label = labelF.label;
    
    self.iconView.frame = labelF.iconF;

    self.titleLabel.text = label.szLabelName;
    self.titleLabel.frame = labelF.titleF;

    self.descLabel.text = label.szDescribe;
    self.descLabel.frame = labelF.descF;
}


@end
