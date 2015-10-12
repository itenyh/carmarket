//
//  BKUserDefautTool.h
//  BeikrOA
//
//  Created by itenyh on 13-12-8.
//  Copyright (c) 2013年 Beikr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKUserDefautTool : NSObject

+ (BKUserDefautTool *)instance;

- (void)setWithKey:(NSString *)key value:(id)value uid:(NSString *)uid;
- (void)setWithDictionary:(NSDictionary *)dic uid:(NSString *)uid;
- (id)getValueWith:(NSString *)key uid:(NSString *)uid;
- (NSMutableDictionary *)getDicForUserWith:(NSString *)uid;
- (void)clearUser:(NSString *)uid;

@end
