//
//  SBYapDBManager.m
//  carmarket
//
//  Created by Apple on 14-9-8.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "UtilsMacro.h"

#import "SBYapDBManager.h"
#import "ITDBManager.h"
#import "YapDatabase.h"

static YapDatabase *database;

@implementation SBYapDBManager

SYNTHESIZE_SINGLETON_FOR_CLASS(SBYapDBManager)

- (void)setupDatabase
{
	NSString *databasePath = [ITDBManager getTheDbQueuePath];
	
//	[[NSFileManager defaultManager] removeItemAtPath:databasePath error:NULL];
	
    if (database == nil) database = [[YapDatabase alloc] initWithPath:databasePath];
    
}

- (void)insertDicData:(id)dic key:(NSString *)key collection:(NSString *)col  dataSuccessB:(void (^)(id dicData))dataSuccessB
{
    
    if ([key isKindOfClass:[NSNumber class]]) {
        NSNumber *keyNum = (NSNumber *)key;
        key = [keyNum stringValue];
    }

    [[database newConnection] asyncReadWriteWithBlock:^(YapDatabaseReadWriteTransaction *transaction) {
        
        [transaction setObject:dic forKey:key inCollection:col];
        
    } completionBlock:^{
        
        dataSuccessB(dic);
        
    }];

}

- (void)insertDicDataSyn:(id)dic key:(NSString *)key collection:(NSString *)col
{
    if ([key isKindOfClass:[NSNumber class]]) {
        NSNumber *keyNum = (NSNumber *)key;
        key = [keyNum stringValue];
    }
    
    [[database newConnection] readWriteWithBlock:^(YapDatabaseReadWriteTransaction *transaction) {
        [transaction setObject:dic forKey:key inCollection:col];
    }];
}

- (void)getDicDataWithKey:(NSString *)key collection:(NSString *)col  dataSuccessB:(void (^)(id dicData))dataSuccessB
{
    
    if ([key isKindOfClass:[NSNumber class]]) {
        NSNumber *keyNum = (NSNumber *)key;
        key = [keyNum stringValue];
    }
    
    [[database newConnection] asyncReadWithBlock:^(YapDatabaseReadTransaction *transaction) {
        
        NSDictionary *data = [transaction objectForKey:key inCollection:col];
        
        dispatch_async(gMainQueueT, ^{
            dataSuccessB(data);
        });
        
    }];
    
}

- (id)getDicDataWithKeySyn:(NSString *)key collection:(NSString *)col
{
    
    if ([key isKindOfClass:[NSNumber class]]) {
        NSNumber *keyNum = (NSNumber *)key;
        key = [keyNum stringValue];
    }
    
    __block NSDictionary *result;
    
    [[database newConnection] readWithBlock:^(YapDatabaseReadTransaction *transaction) {
        result = [transaction objectForKey:key inCollection:col];
    }];
    
    return result;
    
}

- (void)removeObj4Key:(NSString *)key col:(NSString *)col
{
    [[database newConnection] readWriteWithBlock:^(YapDatabaseReadWriteTransaction *transaction) {
        
        [transaction removeObjectForKey:key inCollection:col];
        
    }];
}

//超过up的部分会随机 remove 多余的
- (void)randomRemoveItemsInCollection:(NSString *)col upLimited:(int)up
{
    
    [[database newConnection] readWriteWithBlock:^(YapDatabaseReadWriteTransaction *transaction) {
       
        NSArray *keys = [transaction allKeysInCollection:col];
        
        if (keys.count > up && up >= 0) {
            
            for (int i = 0;i < keys.count - up ;i++) {
                
                NSString *key = [keys objectAtIndex:i];
                [transaction removeObjectForKey:key inCollection:col];
                
            }
            
        }
        
//        NSLog(@"all keys : %d", [transaction allKeysInCollection:col].count);
        
    }];

}

- (void)setup
{
    [self setupDatabase];
}


@end
