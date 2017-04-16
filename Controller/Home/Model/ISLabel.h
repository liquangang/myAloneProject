//
//  ISLabel.h
//  M-Cut
//
//  Created by 李亚飞 on 15/11/26.
//  Copyright © 2015年 Crab movier. All rights reserved.
//  2015-12-1 新增 szDescribe 字段, 没有在本地数据的 plist 文件中新增字段, 字典转模型的方法中也没有添加

#import <Foundation/Foundation.h>

#pragma mark --------------  label模型
@interface ISLabel : NSObject <NSCoding>
/**  标签 ID */
@property (strong, nonatomic) NSNumber * nLabelID;
/**  标签名称 */
@property (copy, nonatomic) NSString * szLabelName;
/**  父标签 ID */
@property (strong, nonatomic) NSNumber * nParentID;
/**  二级 标签 缩略图 */
@property (copy, nonatomic) NSString * szThumbnail;
/**  1 普通带banner页面 2.活动页面 3.定制页面 */
@property (strong, nonatomic) NSNumber * nType;


/**  二级标签访问次数 */
@property (strong, nonatomic) NSNumber * nVideoNum;
/**  标签描述 */
@property (copy, nonatomic) NSString * szDescribe;


+ (instancetype)labelWithDict:(NSDictionary *)dict;
@end


#pragma mark -------------- banner模型
@interface ISBanner : NSObject
/**  banner ID */
@property (strong, nonatomic) NSNumber *nID;
/**  banner 缩略图地址 */
@property (copy, nonatomic) NSString *szThumbnail;
/**  banner 类型  
 *   1.个人页（npara1 个人id） 2.活动 （labelid）VDCBannerInfo
 *   ntype = 1 -----> npara1 表示个人页id
 *   ntype = 2 -----> npara1 表示个labelid
 *   ntype = 3 -----> npara3 表示网站url
 */
@property (strong, nonatomic) NSNumber *nType;
/**   */
@property (strong, nonatomic) NSNumber *nPara1;
/**   */
@property (strong, nonatomic) NSNumber *nPara2;
/**   */
@property (copy, nonatomic) NSString *szPara3;
/**   */
@property (strong, nonatomic) NSNumber *nLabelID;
@end


