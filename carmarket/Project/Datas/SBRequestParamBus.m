//
//  SBRequestBus.m
//  carmarket
//
//  Created by itensb on 14-8-27.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//
//  用于在Controller之间传递数据

#import "SBRequestParamBus.h"
#import "UtilsMacro.h"

@implementation SBRequestParamBus
@synthesize dict;

SYNTHESIZE_SINGLETON_FOR_CLASS_WITHOUTINIT(SBRequestParamBus);

+ (SBRequestParamBus *)instance
{
    @synchronized(self)
    {
        if (sharedSBRequestParamBus == nil)
        {
            sharedSBRequestParamBus = [SBRequestParamBus new];
            sharedSBRequestParamBus.dict = [NSMutableDictionary dictionary];
            
        }
    }
    return sharedSBRequestParamBus;
}

- (void)setParamWith:(id)object key:(NSString *)key value:(id)value
{
    NSString *obj_key = NSStringFromClass([object class]);
    
    NSMutableDictionary *obj_dict = [self.dict objectForKey:obj_key];
    if (obj_dict == nil) {
        NSMutableDictionary *new_dict = [NSMutableDictionary dictionaryWithObject:value forKey:key];
        [self.dict setObject:new_dict forKey:obj_key];
    }
    else {
        [obj_dict setObject:value forKey:key];
    }
}

- (id)getParamWith:(id)object key:(NSString *)key
{
    NSString *obj_key = NSStringFromClass([object class]);
    
    NSMutableDictionary *obj_dict = [self.dict objectForKey:obj_key];
    
    if (!obj_dict) return nil;
    
    return [obj_dict objectForKey:key];
}

- (void)removeParam4Obj:(id)object
{
//    NSLog(@"%@", self.dict);
    
    NSString *obj_key = NSStringFromClass([object class]);
    
    if (obj_key) {
        [self.dict removeObjectForKey:obj_key];
    }
    
//    NSLog(@"%@", self.dict);
}

@end
