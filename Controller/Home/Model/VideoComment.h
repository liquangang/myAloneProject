//
//  VideoComment.h
//  M-Cut
//
//  Created by 李亚飞 on 15/11/22.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoComment : NSObject

@property (assign, nonatomic) int nCommentID;
@property (assign, nonatomic) int nCustomerID;
@property (assign, nonatomic) int nVideoID;
@property (assign, nonatomic) int nreplyComment;
@property (copy, nonatomic) NSString *szNickname;
@property (copy, nonatomic) NSString *szAvatar;
@property (copy, nonatomic) NSString *szCreateTime;
@property (copy, nonatomic) NSString *szContent;

@end


@interface VideoCommentFrame : NSObject
@property (strong, nonatomic) VideoComment *comment;

/**  用户图标的尺寸 */
@property (assign, nonatomic, readonly) CGRect iconF;
/**  用户 昵称的尺寸 */
@property (assign, nonatomic, readonly) CGRect nickNameF;
/**  评论时间的尺寸 */
@property (assign, nonatomic, readonly) CGRect commentTimeF;
/**  评论内容的尺寸 */
@property (assign, nonatomic, readonly) CGRect contentF;
/**  cell 的高度 */
@property (assign, nonatomic, readonly) CGFloat cellHeight;
@end
