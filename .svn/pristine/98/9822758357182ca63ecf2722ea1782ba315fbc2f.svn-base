//
//  FirstClipViewC.h
//  SCNavTabbarDemo
//
//  Created by Crab00 on 15/8/12.
//  Copyright (c) 2015年 SCNavTabbarDemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "PPImageScrollingTableViewCell.h"
#import "NGMoviePlayer.h"

@interface FirstClipViewC : UIViewController<UITableViewDelegate,UITableViewDataSource,PPImageScrollingTableViewCellDelegate,NGMoviePlayerDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *StyleShow;
@property (retain,nonatomic)IBOutlet NGMoviePlayer* player;
@property (weak, nonatomic) IBOutlet UIButton *LastStyle;
@property (weak, nonatomic) IBOutlet UIButton *NextStyle;
@property (strong, nonatomic) IBOutlet UITableView *StyleTableList;

@property (weak, nonatomic) IBOutlet UILabel *StyleName;
@property (weak, nonatomic) IBOutlet UILabel *StyleBrief;
@property (weak, nonatomic) IBOutlet UILabel *StyleScene;

@property (weak, nonatomic) IBOutlet UIScrollView *BottomView;

@property (weak, nonatomic) IBOutlet UIView *midlayout;
@property (strong,nonatomic) NSMutableArray *StyleList;//内部存储字典表 字典表项：name   URL    id    PlayURL   Discribe   Class fitScene

-(void)StopPlay;

@end
