//
//  UpDateSql.m
//  M-Cut
//
//  Created by Crab00 on 15/10/24.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "UpDateSql.h"
#import <sqlite3.h>
extern sqlite3 *contactDB;

@implementation UpDateSql

-(id)init{
    if(self = [super init])
    {
        ver = [UpDateSql getAPPVersion];
        NSLog(@"APP Version = %@",ver);
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsDir = [dirPaths objectAtIndex:0];
        dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Movier.db"]];
    } 
    return self;
}


+(NSString*)getAPPVersion{
    NSDictionary *infoDictionary =[[NSBundle mainBundle]infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleVersion"];

    return version;
}

-(void)UpDateSqlwithVersion:(NSString*)nowversion{

    if ([nowversion compare:@"1.0.18"]==NSOrderedDescending) {
        [self sql1019];
    }
    if ([nowversion compare:@"1.0.26"]==NSOrderedDescending) {
        [self sql1026];
    }
    if ([nowversion compare:@"1.0.29"]==NSOrderedDescending) {
        [self sql1029];
    }
    //版本1.0.22 更新内容
    if ([nowversion isEqualToString:@"1.0.22"]) {
        [self sql1021_1022];
    }
}

-(void)UpDateSqlite
{
    [self UpDateSqlwithVersion:[UpDateSql getAPPVersion]];
    
}

- (void)sql1019 {
    
    const char *ccdbpath = [dbPath UTF8String];
    if(sqlite3_open(ccdbpath,&contactDB) !=SQLITE_OK){
        NSLog(@"创建/打开数据库失败");
    }else{
        char *errMsg;
        const char *sql = "ALTER TABLE VIDEO ADD visitcount INTEGER";
        if (sqlite3_exec(contactDB, sql, NULL, NULL, &errMsg)!=SQLITE_OK) {
            NSLog(@"更新素材表失败V1019，或已更新过\n");
        }sqlite3_close(contactDB);
    }
}

- (void)sql1026 {//1026->1029  数据缓存  Labels表需要新增字段
    
    const char *ccdbpath = [dbPath UTF8String];
    if(sqlite3_open(ccdbpath,&contactDB) !=SQLITE_OK){
        NSLog(@"创建/打开数据库失败");
    }else{
        char *errMsg;
        const char *sql = "ALTER TABLE LABELS ADD nType INTEGER;ALTER TABLE LABELS ADD nVideoNum INTEGER;ALTER TABLE LABELS ADD szThumbnail TEXT;ALTER TABLE LABELS ADD szDescribe TEXT";
        if (sqlite3_exec(contactDB, sql, NULL, NULL, &errMsg)!=SQLITE_OK) {
            NSLog(@"更新素材表失败V1026，或已更新过\n");
        }sqlite3_close(contactDB);
    }
}

-(void)sql1029{  //1029->1030  断点续传  oss sdk 更新
    const char *ccdbpath = [dbPath UTF8String];
    if(sqlite3_open(ccdbpath,&contactDB) !=SQLITE_OK){
        NSLog(@"创建/打开数据库失败");
    }else{
        char *errMsg;
        const char *sql = "ALTER TABLE MATERIAL ADD UploadID text";
        if (sqlite3_exec(contactDB, sql, NULL, NULL, &errMsg)!=SQLITE_OK) {
            NSLog(@"更新素材表失败V1029，或已更新过\n");
        }sqlite3_close(contactDB);
    }
}
-(void)sql1017{
    
    const char *ccdbpath = [dbPath UTF8String];
    if(sqlite3_open(ccdbpath,&contactDB) !=SQLITE_OK){
        NSLog(@"创建/打开数据库失败");
    }else{
        char *errMsg;
        const char *sql = "ALTER TABLE MATERIAL ADD duration FLOAT";
        if (sqlite3_exec(contactDB, sql, NULL, NULL, &errMsg)!=SQLITE_OK) {
            NSLog(@"更新素材表失败V1015\n");
        }sqlite3_close(contactDB);
    }
}

- (void)sql1021_1022{
    
    const char *ccdbpath = [dbPath UTF8String];
    if(sqlite3_open(ccdbpath,&contactDB) !=SQLITE_OK){
        NSLog(@"创建/打开数据库失败");
    }else{
        char *errMsg;
        const char *sql1 = "ALTER TABLE LABELS ADD TYPE INTEGER";
        if (sqlite3_exec(contactDB, sql1, NULL, NULL, &errMsg)!=SQLITE_OK) {
            NSLog(@"SQL1 从1021更新1022失败");
        }
        const char *sql2 = "ALTER TABLE LABELS ADD IMAGEURL TEXT";
        if (sqlite3_exec(contactDB, sql2, NULL, NULL, &errMsg)!=SQLITE_OK) {
            NSLog(@"SQL2 从1021更新1022失败");
        }
        sqlite3_close(contactDB);
    }
}

@end
