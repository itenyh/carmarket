//
//  BKUserDefautTool.m
//  BeikrOA
//
//  Created by itenyh on 13-12-8.
//  Copyright (c) 2013年 Beikr. All rights reserved.
//

#import "BKUserDefautTool.h"
#import "UtilsMacro.h"

@implementation BKUserDefautTool

SYNTHESIZE_SINGLETON_FOR_CLASS(BKUserDefautTool);

- (void)setWithKey:(NSString *)key value:(id)value uid:(NSString *)uid
{
    NSDictionary *newDic = [NSDictionary dictionaryWithObject:value forKey:key];
    [self setWithDictionary:newDic uid:uid];
}

- (void)setWithDictionary:(NSDictionary *)dic uid:(NSString *)uid
{
    NSMutableDictionary *userDic = [self getDicForUserWith:uid];
    NSMutableDictionary *replaceDic = [NSMutableDictionary dictionaryWithDictionary:userDic];
    
    for (NSString* key in [dic allKeys]) {
        [replaceDic setObject:[dic objectForKey:key] forKey:key];
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:replaceDic forKey:uid];
    [ud synchronize];
}

- (id)getValueWith:(NSString *)key uid:(NSString *)uid
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDic = [ud objectForKey:uid];
    
    return [userDic objectForKey:key];
}

- (NSMutableDictionary *)getDicForUserWith:(NSString *)uid
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDic = [ud objectForKey:uid];
    
    if (userDic == nil) {
        userDic = [[NSMutableDictionary alloc] init];
        [ud setObject:userDic forKey:uid];
    }
    
    return userDic;
}

- (void)clearUser:(NSString *)uid
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:uid];
    [ud synchronize];
}

#pragma -application functions


@end
