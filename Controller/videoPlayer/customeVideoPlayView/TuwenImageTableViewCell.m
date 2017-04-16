//
//  TuwenImageTableViewCell.m
//  M-Cut
//
//  Created by apple on 16/10/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "TuwenImageTableViewCell.h"

@interface TuwenImageTableViewCell()
@property (nonatomic, strong) NSIndexPath * index;
@end

@implementation TuwenImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UILongPressGestureRecognizer * longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(longTapAction:)];
    [self.contentView addGestureRecognizer:longTap];
}
- (IBAction)deleteButtonAction:(id)sender {
    self.deleteBlock(self.index);
}

+ (instancetype)TuwenImageTableViewCellWithTableView:(UITableView *)tableView
                                         ResuableStr:(NSString *)resuableStr
                                            TuwenObj:(TuwenOBJ *)tuwenObj
                                           IndexPath:(NSIndexPath *)index
{
    TuwenImageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:resuableStr];
    if (!cell) {
        cell = XIBCELL(@"TuwenImageTableViewCell")
    }
    cell.index = index;
    if (tuwenObj.isHiddenPlayButton) {
        cell.playButton.hidden = YES;
    }else{
        cell.playButton.hidden = NO;
    }
    
    UIImage * photoImage;
    if (tuwenObj.cellImage) {
        photoImage = tuwenObj.cellImage;
    }else{
        NSURL * imageUrl;
        if (tuwenObj.cellType == videoType) {
            imageUrl = [NSURL URLWithString:STRTOUTF8(tuwenObj.cellImageUrl)];
        }else{
            imageUrl = [NSURL URLWithString:tuwenObj.cellImageUrl];
        }
        photoImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    }
    cell.photoImageView.image = photoImage;
    tuwenObj.cellImage = photoImage;
    
    if (tuwenObj.cellType == videoType) {
        cell.deleteButton.hidden = YES;
    }else{
        cell.deleteButton.hidden = NO;
    }
    return cell;
}

- (void)longTapAction:(UILongPressGestureRecognizer *)longTap{
    self.longTapBlock();
}

@end
