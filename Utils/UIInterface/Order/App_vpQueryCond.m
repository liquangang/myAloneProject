//
//  App_vpQueryCond.m
//  M-Cut
//
//  Created by zhangxiaotian on 15/4/18.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "App_vpQueryCond.h"

@implementation App_vpQueryCond

-(void)setCond:(int)StyleCon filter:(int)FilterCon music:(int)MusicCon sub:(int)SubCon{
    
    _nStyleID = StyleCon;
    _nFilterID = FilterCon;
    _nMusicID = MusicCon;
    _nSubtitleID = SubCon;
    return;
}

@end
