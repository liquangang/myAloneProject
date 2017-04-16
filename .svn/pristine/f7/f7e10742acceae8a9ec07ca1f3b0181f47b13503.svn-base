//
//  MJGroupHeader.m
//  02-QQ好友列表
//
//  Created by 成良云 on 15/1/11.
//  Copyright (c) 2015年 dazhuankuai. All rights reserved.
//

#import "MJGroupHeader.h"
#import "MJGroup.h"
@interface MJGroupHeader ()

@property (weak, nonatomic) UIButton *nameBtn;
@property (weak, nonatomic) UILabel *onlineLabel;

@end

@implementation MJGroupHeader

+ (instancetype)headerWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    MJGroupHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[MJGroupHeader alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

/**
 *  在这个初始化方法中,MJHeaderView的frame\bounds没有值
 */
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 添加子控件
        // 1.添加按钮
        UIButton *nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        // 背景图片
        [nameBtn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [nameBtn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        // 设置按钮内部的左边箭头图片
        [nameBtn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置按钮中的内容左对齐
        
        nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 设置按钮的内边距
        //        nameBtn.imageEdgeInsets
        nameBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        nameBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [nameBtn addTarget:self action:@selector(nameBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置按钮内部的imageView的内容模式为居中
        nameBtn.imageView.contentMode = UIViewContentModeCenter;
        // 超出边框的内容不需要裁剪
        nameBtn.imageView.clipsToBounds = NO;
        
        [self.contentView addSubview:nameBtn];
        self.nameBtn = nameBtn;
        
        // 2.添加好友数
        UILabel *onlineLabel = [[UILabel alloc] init];
        onlineLabel.textAlignment = NSTextAlignmentRight;
        onlineLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:onlineLabel];
        self.onlineLabel = onlineLabel;
    }
    return self;
}

/**
 *  当一个控件的frame发生改变的时候就会调用
 *
 *  一般在这里布局内部的子控件(设置子控件的frame)
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置按钮的frame
    self.nameBtn.frame = self.bounds;
    
    // 2.设置好友数的frame
    CGFloat countY = 0;
    CGFloat countH = self.frame.size.height;
    CGFloat countW = 150;
    CGFloat countX = self.frame.size.width - 10 - countW;
    self.onlineLabel.frame = CGRectMake(countX, countY, countW, countH);
}

- (void)setGroup:(MJGroup *)group
{
    _group = group;
    
    // 1.设置按钮文字(组名)
    [self.nameBtn setTitle:group.name forState:UIControlStateNormal];
    
    // 2.设置好友数(在线数/总数)
    self.onlineLabel.text = [NSString stringWithFormat:@"%d/%lu", group.online, group.friends.count];
    
    // 3.重新设置左边箭头的状态
    [self didMoveToSuperview];
    
}

/**
 *  监听组名按钮的点击
 */
- (void)nameBtnClick
{
    // 1.修改组模型的标记(状态取反)
    self.group.open = !self.group.open;
    
    // 2.刷新表格
    if ([self.delegate respondsToSelector:@selector(groupHeaderClick:)]) {
        [self.delegate groupHeaderClick:self];
    }
}

/**
 *  当一个控件被添加到父控件中就会调用（这跟是段头，当段头一加载到表中就调用这个方法）
 */
- (void)didMoveToSuperview
{
    if (self.group.open) {
        //让图旋转180度
        self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}


@end
