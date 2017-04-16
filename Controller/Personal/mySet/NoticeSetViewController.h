//
//  NoticeSetViewController.h
//  M-Cut
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface setObj : NSObject
@property (nonatomic, copy) NSString * setName;
@property (nonatomic, assign) BOOL onOrOff;
- (id)initWithName:(NSString *)name Status:(BOOL)onOrOff;
@end



@interface NoticeSetViewController : UIViewController

@end
