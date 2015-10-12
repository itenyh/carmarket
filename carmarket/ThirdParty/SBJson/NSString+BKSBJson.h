//
//  NSString+BKSBJson.h
//  BKWeiyun
//  由于原SBJson中的JSONValue方式失去支持，所以自己添加一个扩展，以使后面方便使用
//  Created by Big_Krist on 13-1-9.
//  Copyright (c) 2013年 beikr developer 1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BKSBJson)
- (id)BKJSONValue;
@end


@interface NSObject (BKSBJson)

- (NSString *)BKJSONRepresentation;

@end