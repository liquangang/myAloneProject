
//
//  LabelsView.m
//  M-Cut
//
//  Created by apple on 16/12/13.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "LabelsView.h"
#import "NSString+Extension.h"

@interface LabelsView()
@end

@implementation LabelsView

- (instancetype)initWithWidth:(CGFloat)width LabelTitleArray:(NSArray *)labelTitleArray
{
    self = [super init];
    if (self) {
        self.backgroundColor = ColorFromRGB(0x2E2E3A, 1.0);
        self.width = width;
        [self setLabelWithLabelTitleArray:labelTitleArray Width:width];
    }
    return self;
}

- (void)setLabelWithLabelTitleArray:(NSArray *)labelTitleArray Width:(CGFloat)labelViewWidth{
    CGFloat lastX = 15;
    CGFloat lastY = 7;
    CGFloat lastHeight = 0;
    CGFloat allHeight = lastY;
    
    NSInteger index = 0;
    for (NSString *labelTitle in labelTitleArray) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.layer.cornerRadius = 4;
        label.layer.masksToBounds = YES;
        label.text = labelTitle;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = ColorFromRGB(0x4B4B4B, 1.0);
        label.font = ISFont_12;
        label.backgroundColor = ColorFromRGB(0xFFFFFF, 1.0);
        CGSize labelSize = [label.text sizeWithWidth:labelViewWidth - 30 - 28 font:ISFont_12];
        CGFloat width = labelSize.width + 28;
        CGFloat height = labelSize.height + 4;
        
        if (labelViewWidth - (lastX + width) < 15) {
            lastY = lastY + lastHeight + 6;
            allHeight = lastY + height + 7;
            lastX = 15;
        }
        
        label.frame = CGRectMake(lastX, lastY, width, height);
        [self addSubview:label];
        label.tag = 1000000 + index;
        ADDTAPGESTURE(label, labelTap)
        
        lastX = lastX + width + 5;
        lastHeight = height;
        index++;
    }
    
    self.height = allHeight;
}

- (void)setFrameWithPoint:(CGPoint(^)(CGSize mySize))pointBlock{
    CGPoint tempPoint = pointBlock(CGSizeMake(self.width, self.height));
    self.frame = CGRectMake(tempPoint.x, tempPoint.y, self.width, self.height);
}

- (void)labelTap:(UITapGestureRecognizer *)tap{
    self.touchLabelBlock(tap.view.tag - 1000000);
}

@end
