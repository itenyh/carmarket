//
//  BKNetKit.h
//  iRally
//
//  Created by 蔡凌 on 13-9-4.
//  Copyright (c) 2013年 蔡凌. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SB_PREURL @"http://lmodel.gotoip4.com/"

typedef enum BKNetType_
{
    BKNet_NONE,
    BKNet_WWAN,
    BKNet_WIFI
} BKNetType;

@interface BKNetKit : NSObject

+ (BKNetType)getNowNetSituation;

+ (id)invokeTheApi:(NSString *)apiName withParam:(NSDictionary *)param requestMethod:(NSString *)method;
@end
