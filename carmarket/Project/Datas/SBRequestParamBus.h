//
//  SBRequestBus.h
//  carmarket
//
//  Created by itensb on 14-8-27.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBRequestParamBus : NSObject

@property(nonatomic, strong) NSMutableDictionary *dict;

+ (SBRequestParamBus *)instance;

- (void)setParamWith:(id)object key:(NSString *)key value:(id)value;
- (id)getParamWith:(id)object key:(NSString *)key;

- (void)removeParam4Obj:(id)object;

@end
