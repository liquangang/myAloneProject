//
//  UpDateSql.h
//  M-Cut
//
//  Created by Crab00 on 15/10/24.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpDateSql : NSObject
{
    NSString* ver;
    NSString* dbPath;
}
+(NSString*)getAPPVersion;
-(void)UpDateSqlite;
@end
