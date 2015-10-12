//
//  SBBaseDataInterface.h
//  carmarket
//
//  Created by itensb on 14-8-27.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBUserDataInterface : NSObject

+ (void)setUserDataDict:(NSDictionary *)dict;
+ (NSDictionary *)getInfo;
+ (NSString *)getUserId;
+ (BOOL)isLogging;
+ (void)logOut;

@end
