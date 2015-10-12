//
//  ITDBManager.h
//  CoacoapodsDemo
//
//  Created by Apple on 14-7-27.
//  Copyright (c) 2014年 itenyhCom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface ITDBManager : NSObject

+ (ITDBManager *)instance;
+ (NSString*)getTheDbQueuePath;

- (void)initTheDb;

@end
