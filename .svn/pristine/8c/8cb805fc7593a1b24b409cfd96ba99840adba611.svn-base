//
//  CaptionEditeCollecterViewController.h
//  M-Cut
//
//  Created by zhangxiaotian on 15/6/9.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaptionEditeCollectionViewCell.h"

@protocol TextFieldChangeDelegate <NSObject>

-(void)changeText:(NSString *)text;

@end

@interface CaptionEditeCollecterViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate>
{
    NSMutableArray *array;
    int index;
    CGFloat cellWidth;
    CGFloat cellHeight;
    CGFloat margin;
    int cellIndex;
}
@property (retain, nonatomic) IBOutlet UICollectionView *capeditCV;

@property (retain,nonatomic) IBOutlet UITextView *textView;
@property (retain,nonatomic) NSString *stringText;

@property (nonatomic, unsafe_unretained) id <TextFieldChangeDelegate>delegate;
@end
