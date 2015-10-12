//
//  ITDBManager.m
//  CoacoapodsDemo
//
//  Created by Apple on 14-7-27.
//  Copyright (c) 2014年 itenyhCom. All rights reserved.
//

#define dbName @"GlobalDb.db"

#import "ITDBManager.h"
#import "UtilsMacro.h"

@implementation ITDBManager

SYNTHESIZE_SINGLETON_FOR_CLASS(ITDBManager)

- (void)initTheDb
{
    NSString *dbPath = [ITDBManager getTheDbQueuePath];
    
    FMDatabaseQueue *dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];

    [dbQueue inDatabase:^(FMDatabase *db) {
        
        [db executeUpdate:@"create table if not exists [t_dir]([dir_id] TEXT PRIMARY KEY, [name] TEXT, [count] INTEGER, [create_time] INTEGER, [update_time] INTEGER)"];
        
    }];
}

+ (NSString*)getTheDbQueuePath
{
    //获取数据库路径
    NSArray *dicArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *basePath = [dicArray objectAtIndex:0];
    return [basePath stringByAppendingPathComponent:dbName];
}

@end
