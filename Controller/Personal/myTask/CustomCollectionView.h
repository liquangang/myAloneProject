//
//  CustomCollectionView.h
//  M-Cut
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovierDCInterfaceSvc.h"

@protocol CustomCollectionViewDelegate <NSObject>

- (void)pushVcWithIndex:(NSIndexPath *)myIndex;

@end

@interface CustomCollectionView : UICollectionView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/** 数据源*/
@property (nonatomic, strong) NSMutableArray * myDataSource;
/** 返回自定义的Collectionview*/
+ (id)collectionWithFrame:(CGRect)frame andItemSize:(CGSize)mySize Delegate:(id<CustomCollectionViewDelegate>)delegate UserScoreTask:(MovierDCInterfaceSvc_VDCNewUserScoreTask *)userScoreTaskInfo;
@property (nonatomic, weak) id<CustomCollectionViewDelegate> customCollectionViewDelegate;
@property (nonatomic, strong) MovierDCInterfaceSvc_VDCNewUserScoreTask * myUserScoreTask;
@end
