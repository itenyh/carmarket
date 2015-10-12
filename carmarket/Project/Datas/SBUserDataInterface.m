//
//  SBBaseDataInterface.m
//  carmarket
//
//  Created by itensb on 14-8-27.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBUserDataInterface.h"
#import "SBYapDBManager.h"

@implementation SBUserDataInterface

+ (void)setUserDataDict:(NSDictionary *)dict
{
    [[SBYapDBManager instance] insertDicDataSyn:dict key:@"info" collection:@"User"];
}

+ (NSString *)getUserId
{
    NSDictionary *dict = [[SBYapDBManager instance] getDicDataWithKeySyn:@"info" collection:@"User"];
    if(dict) return [NSString stringWithFormat:@"%d", [[dict objectForKey:@"userId"] integerValue]];
    else return nil;
}

+ (NSDictionary *)getInfo
{
    NSDictionary *dict = [[SBYapDBManager instance] getDicDataWithKeySyn:@"info" collection:@"User"];
    return dict;
}

+ (BOOL)isLogging
{
    NSDictionary *dict = [[SBYapDBManager instance] getDicDataWithKeySyn:@"info" collection:@"User"];
    return dict != nil;
}

+ (void)logOut
{
    [[SBYapDBManager instance] removeObj4Key:@"info" col:@"User"];
}


@end
