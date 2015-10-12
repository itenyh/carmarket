//
//  SBYapDBManager.h
//  carmarket
//
//  Created by Apple on 14-9-8.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GOOUT_PLAN_COL @"goout_plan_col"
#define GOOUT_PLAN_TB @"goout_plan_tb"

#define FASTNAVI_COL @"fastnavi_col"
#define FASTNAVI_TB @"fastnavi_tb"

@interface SBYapDBManager : NSObject

+ (SBYapDBManager *)instance;

- (void)insertDicData:(id)dic key:(NSString *)key collection:(NSString *)col  dataSuccessB:(void (^)(id dicData))dataSuccessB;
- (void)insertDicDataSyn:(id)dic key:(NSString *)key collection:(NSString *)col;

- (void)getDicDataWithKey:(NSString *)key collection:(NSString *)col  dataSuccessB:(void (^)(id dicData))dataSuccessB;
- (id)getDicDataWithKeySyn:(NSString *)key collection:(NSString *)col;

- (void)removeObj4Key:(NSString *)key col:(NSString *)col;
- (void)randomRemoveItemsInCollection:(NSString *)col upLimited:(int)up;

@end
