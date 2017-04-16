//
//  TuwenTextTableViewCell.m
//  M-Cut
//
//  Created by apple on 16/10/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "TuwenTextTableViewCell.h"
#import "UILabel+LabelHeightAndWidth.h"

@interface TuwenTextTableViewCell()
@property (nonatomic, strong) NSIndexPath * index;
@end

@implementation TuwenTextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UILongPressGestureRecognizer * longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(longTapAction:)];
    [self.contentView addGestureRecognizer:longTap];
}

/**
 *  删除操作
 */
- (IBAction)deleteButtonAction:(id)sender {
    self.deleteBlock(self.index);
}

+ (instancetype)TuwenTextTableViewCellWithTable:(UITableView *)tableView
                                    ResuableStr:(NSString *)resuableStr
                                        Content:(NSString *)content
                                      IndexPath:(NSIndexPath *)index
{
    TuwenTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:resuableStr];
    if (!cell) {
        cell = XIBCELL(@"TuwenTextTableViewCell")
    }
    cell.index = index;
    if (content != nil) {
        cell.contentLabel.text = [NSString stringWithFormat:@"  %@", content];
        cell.contentLabel.textAlignment = NSTextAlignmentCenter;
        cell.contentLabel.font = ISFont_14;
        cell.contentLabel.textColor = UIColorFromRGB(0x2E2E3A);
        cell.contentLabelHeight.constant = [UILabel getHeightByWidth:cell.contentLabel.frame.size.width
                                                               title:cell.contentLabel.text
                                                                font:ISFont_14];
       
        cell.contentLabel.numberOfLines = 0;
    }else{
        cell.contentLabel.text = @"可以在这里添加文字哦";
        cell.contentLabel.textAlignment = NSTextAlignmentCenter;
        cell.contentLabel.font = ISFont_12;
        cell.contentLabel.textColor = UIColorFromRGB(0x6D717D);
    }
    
    return cell;
}

- (void)longTapAction:(UILongPressGestureRecognizer *)longTap{
    self.longTapBlock();
}

@end
