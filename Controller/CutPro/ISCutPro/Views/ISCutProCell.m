//
//  ISCutProCell.m
//  M-Cut
//
//  Created by 李亚飞 on 15/11/24.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "ISCutProCell.h"
#import "TempVideoOBj.h"

@interface ISCutProCell ()
@property (weak, nonatomic) IBOutlet UIImageView *rewardImage;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
- (IBAction)deleteClick:(id)sender;

@end

@implementation ISCutProCell

/**  相册 cell */
static NSString *CutProIdentifier_cell = @"CutProIdentifier_cell";

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.indexLabel.layer.cornerRadius = 7;
    self.indexLabel.clipsToBounds = YES;
    self.indexLabel.hidden = YES;
    
    self.photo.layer.cornerRadius = 2;
    self.photo.clipsToBounds = YES;
    
//    self.timeLabel.hidden = YES;
}

- (IBAction)deleteClick:(id)sender {
    // 删除按钮的点击, 由控制器完成删除操作
    if ([self.delegate respondsToSelector:@selector(cutproCell:deleteClick:)]) {
        [self.delegate cutproCell:self deleteClick:sender];
    }
}

/**
 *  根据arid设置奖品图片的显示隐藏
 */
- (void)setCouponImageWithArid:(NSString *)arId{
    if (arId.length > 0 && [arId intValue] > 0) {
        self.rewardImage.hidden = NO;
    }else{
        self.rewardImage.hidden = YES;
    }
}

- (void)setRewardImageWithArray:(NSArray *)takeVideoArray{
    BOOL isShow = NO;
    for (TempVideoOBj * tempVideoObj in takeVideoArray) {
        if ([tempVideoObj.videoThumailImage isEqual:self.photo.image]) {
            isShow = YES;
        }
    }
    self.rewardImage.hidden = !isShow;
}

- (void)setContent:(UIImage *)image  atIndex:(NSInteger)index totalCount:(NSInteger)count materialPath:(NSString *)materialUrl{
    
    // 设置图片
    self.photo.image = image;
    
    //设置视频时间
    self.timeLabel.text = [NSString stringWithFormat:@"%.fs", [materialUrl floatValue]];
    if ([materialUrl floatValue] < 1) {
        self.timeLabel.text = @"1s";
    }
    
    // 设置索引
    if (index < count - 1) {
        self.photo.contentMode = UIViewContentModeScaleAspectFill;
        self.deleteButton.hidden = NO;
        self.indexLabel.hidden = NO;
        //判断是视频时就显示时长标签，不是就隐藏
        if ([materialUrl isEqualToString:@"3"] || [materialUrl isEqualToString:@"0"]) {//是图片, 不显示
            self.timeLabel.hidden = YES;
        }else{
            self.timeLabel.hidden = NO;
        }
        
        self.indexLabel.text = [NSString stringWithFormat:@"%d", (int)(index + 1)];
    } else {
        self.photo.contentMode = UIViewContentModeScaleAspectFit;
        self.deleteButton.hidden = YES;
        self.indexLabel.hidden = YES;
        self.timeLabel.hidden = YES;
    }
}

@end
