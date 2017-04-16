//
//  ISSpecialTopCell.h
//  M-Cut
//
//  Created by 李亚飞 on 15/12/1.
//  Copyright © 2015年 Crab movier. All rights reserved.
//  定制界面第一个 cell

#import <UIKit/UIKit.h>
@class ISLabel;

//@interface ISLabelFrame : NSObject
///**  label 模型 */
//@property (strong, nonatomic) ISLabel *label;
///**  图标 */
//@property (assign, nonatomic, readonly) CGRect iconF;
///**   标题 */
//@property (assign, nonatomic, readonly) CGRect titleF;
///**  描述 */
//@property (assign, nonatomic, readonly) CGRect descF;
///**  cell 高度 */
//@property (assign, nonatomic, readonly) CGFloat cellH;
//@end

@interface ISSpecialTopCell : UICollectionViewCell
/**  label 模型 */
//@property (strong, nonatomic) ISLabelFrame *labelF;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collection indexPath:(NSIndexPath *)indexPath;
@end
