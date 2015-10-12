//
//  SBUtil.h
//  carmarket
//
//  Created by itensb on 14-8-26.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBAppDelegate.h"

@interface SBUtil : NSObject

+ (NSURL *)getUserHeadImgUrlWith:(NSDictionary *)dic;
+ (NSURL *)getBrandImgURLWith:(NSDictionary *)dic;
+ (NSURL *)getImgURLWith:(NSDictionary *)dic pre:(NSString *)preKey other:(NSString *)otherKey;
+ (NSURL *)getLowPriceActivityImgURLWith:(NSDictionary *)dic;
+ (NSURL *)getNewsImgURLWith:(NSDictionary *)dic;

+ (NSURL *)getNewsURLWith:(NSDictionary *)dic;

+ (SBAppDelegate *)getAppDelegate;

+ (UIView *)getLoadingViewControllerView;

+ (NSString *)getTimeWithTimeInterval:(NSDictionary *)dic key:(NSString *)key;

+ (NSString *)getOneWeiFloatStr:(NSString *)string;

+ (void)handle_push_data:(NSDictionary *)userInfo;
@end
