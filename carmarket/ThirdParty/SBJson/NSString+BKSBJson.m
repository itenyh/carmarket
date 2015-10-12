//
//  NSString+BKSBJson.m
//  BKWeiyun
//
//  Created by Big_Krist on 13-1-9.
//  Copyright (c) 2013年 beikr developer 1. All rights reserved.
//

#import "NSString+BKSBJson.h"
#import "SBJsonParser.h"
#import "SBJsonWriter.h"

@implementation NSString (BKSBJson)
- (id)BKJSONValue
{
    SBJsonParser *jsonPar = [[SBJsonParser alloc] init];
    id retValue = [jsonPar objectWithString:self];
    return retValue;
}
@end

@implementation NSObject (BKSBJson)
- (NSString *)BKJSONRepresentation
{
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *json = [writer stringWithObject:self];
    return json;
}
@end
