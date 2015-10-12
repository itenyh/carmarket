//
//  ITUtils.h
//  carmarket
//
//  Created by itensb on 14-8-7.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITUtils : NSObject

+ (UIViewController *)viewControllerFor:(UIView *)v;
+ (void)dialPhoneNumber:(NSString *)aPhoneNumber;
+ (NSURL *)getNSURLWith:(NSString *)url;

+ (NSString *)date_fromInterval:(NSTimeInterval)_date format:(NSString *)format;
+ (NSString *)date_parse:(NSDate *)date format:(NSString *)format;
+ (NSDate *)date_fomat:(NSString *)date formte:(NSString *)format;

+ (NSString *)urlencode:(NSString *)param;
+ (NSString *)md5HexDigest:(NSString *)input;

+ (NSString *)num2chnDate:(int)num;
+ (NSString *)time_interval2date:(double)interval time_format:(NSString *)format;
+ (NSComparisonResult) compareVersions: (NSString*) version1 version2: (NSString*) version2;

@end
