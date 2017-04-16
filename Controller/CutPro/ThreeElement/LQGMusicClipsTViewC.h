//
//  ViewController.h
//  TestDemo
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovierDCInterfaceSvc_vpVDCMusicC;

@interface LQGMusicClipsTViewC : UIViewController
/**  最佳配乐的数据源，从影片概览页面获得*/
@property (strong,nonatomic) MovierDCInterfaceSvc_vpVDCMusicC *recommadMusic;

/**  给影片预览界面传递数据 */
@property (copy, nonatomic) void(^music)(id music,NSIndexPath *seleteIndex, NSString * objName);
- (void)getMusic:(void(^)(id music,NSIndexPath *seleteIndex, NSString * objName))music;

@end

