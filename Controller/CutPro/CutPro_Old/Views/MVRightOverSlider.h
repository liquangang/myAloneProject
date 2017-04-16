//
//  myslider1.h
//  myslider
//
//  Created by Crab00 on 15/10/27.
//  Copyright © 2015年 Crab00. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MVOverslider <NSObject>

@optional
-(void)SliderRightOver;

@end

@interface MVRightOverSlider : UISlider
{
    BOOL bOverRight;//超出右端界限
    CGRect resumeRect;//用来记录原始位置
}

@property(nonatomic,retain)id<MVOverslider> fulldelegate;

@end
