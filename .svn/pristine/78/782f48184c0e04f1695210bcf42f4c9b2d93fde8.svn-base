//
//  myslider1.m
//  myslider
//
//  Created by Crab00 on 15/10/27.
//  Copyright © 2015年 Crab00. All rights reserved.
//

#import "MVRightOverSlider.h"

@implementation MVRightOverSlider


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*- (void)drawRect:(CGRect)rect {
    // Drawing code
}*/

- (BOOL)continueTrackingWithTouch:(UITouch *)touch
                        withEvent:(UIEvent *)event{
    [super continueTrackingWithTouch:touch withEvent:event];
    float offset = [touch locationInView:self].x - [touch previousLocationInView:self].x;
//        NSLog(@"touch event = %@",event);
//    NSLog(@"touch event before = %@  now = %@",NSStringFromCGPoint(aaa),NSStringFromCGPoint(bbb));
//    NSLog(@"slider value = %f max = %f",self.value,self.maximumValue);
    if (self.value == self.maximumValue) {
        [self recordRect];
        [self changeposition:offset];
    }
    return TRUE;
}

- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event{
    
    if (bOverRight) {
        [self.fulldelegate SliderRightOver];
        [UIView animateWithDuration:1.0 animations:^{
            [self setFrame:resumeRect];
            
            bOverRight = FALSE;
        }];
    }
}

-(BOOL)changeposition:(float)offset{
    CGRect newframe = self.frame;
    newframe.size.width += offset;
//    [self setValue:self.maximumValue animated:TRUE];
//    self.maximumValue+=10;
    [self setFrame:newframe];
//        self.value = self.maximumValue;
    return TRUE;
}

-(void)recordRect{
    if (bOverRight) {//之前已经记录过了
        return;
    }
    bOverRight = TRUE;
    resumeRect = self.frame;
}

@end
