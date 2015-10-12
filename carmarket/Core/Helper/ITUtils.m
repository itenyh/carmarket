//
//  ITUtils.m
//  carmarket
//
//  Created by itensb on 14-8-7.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "ITUtils.h"
#import <CommonCrypto/CommonDigest.h>

static UIWebView *phoneCallWebView;

@implementation ITUtils

+ (UIViewController *)viewControllerFor:(UIView *)v {
    
    id viewController = [v nextResponder];
    UIView *view = v;
    
    while (viewController && ![viewController isKindOfClass:[UIViewController class]]) {
        view = [view superview];
        viewController = [view nextResponder];
    }
    return viewController;
}

+ (void)dialPhoneNumber:(NSString *)aPhoneNumber
{
    if (!phoneCallWebView) {
        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", aPhoneNumber]];
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

+ (NSURL *)getNSURLWith:(NSString *)url
{
    return [NSURL URLWithString:url];
}

#pragma - mark 日期相关
+ (NSString *)date_fromInterval:(NSTimeInterval)_date format:(NSString *)format
{
    NSDate *date = [ITUtils date_from1970:_date];
    return [ITUtils date_parse:date format:format];
}

+ (NSString *)date_parse:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:format];
    NSString *currentTime = [timeFormatter stringFromDate:date];
    return currentTime;
}

+(NSDate *)date_from1970:(NSTimeInterval)interl{
    return [NSDate dateWithTimeIntervalSince1970:interl];
}

// 日期是标准格式 yyyy-MM-dd HH:mm:ss ZZZ
+(NSDate *)date_fomat:(NSString *)date formte:(NSString *)format{
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    timeFormatter.dateFormat = format;
    NSDate *adate = [timeFormatter dateFromString:date];
    return adate;
}

+ (BOOL)isToday:(NSDate *)date {
	NSDate *now = [NSDate date];
	NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    timeFormatter.dateFormat = @"yyyy-MM-dd";
	NSString *nowDateStr = [timeFormatter stringFromDate:now];
	NSString *dateStr = [timeFormatter stringFromDate:date];
	return [dateStr compare:nowDateStr] == NSOrderedSame;
}

#pragma - mark 网络相关
+ (NSString *)urlencode:(NSString *)param
{

    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[param UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

+ (NSString *)md5HexDigest:(NSString *)input

{
    const char *original_str = [input UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(original_str, strlen(original_str), result);
    
    NSMutableString *hash = [NSMutableString string];
    
    for (int i = 0; i < 16; i++)
        
        [hash appendFormat:@"%02X", result[i]];
    
    return [hash lowercaseString];
    
}

//中文数字词典
+ (NSString *)num2chnDate:(int)num
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"一", @"1", @"二", @"2", @"三", @"3", @"四", @"4", @"五", @"5", @"六", @"6", @"日", @"7", nil];
    
    return [dic objectForKey:[NSString stringWithFormat:@"%d", num]];
}

//只包含年月日，会显示今天和昨天
+ (NSString *)time_interval2date:(double)interval time_format:(NSString *)format
{
    if (interval == 0) return @"";
    
    int int_int = [[NSNumber numberWithDouble:interval] intValue];
    int now_int = [[NSNumber numberWithDouble:[[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]] intValue];
    
    int now_day_past = now_int / (60 * 60 * 24);
    int int_day_past = int_int / (60 * 60 * 24);
    
    if (now_day_past - int_day_past == 0) return @"今天";
    else if (now_day_past - int_day_past == 1) return @"昨天";
    else return [ITUtils date_fromInterval:interval format:format];

}

#pragma - mark 比较函数
+ (NSComparisonResult) compareVersions: (NSString*) version1 version2: (NSString*) version2 {
    NSComparisonResult result = NSOrderedSame;
    
    NSMutableArray* a = (NSMutableArray*) [version1 componentsSeparatedByString: @"."];
    NSMutableArray* b = (NSMutableArray*) [version2 componentsSeparatedByString: @"."];
    
    while (a.count < b.count) { [a addObject: @"0"]; }
    while (b.count < a.count) { [b addObject: @"0"]; }
    
    for (int i = 0; i < a.count; ++i) {
        if ([[a objectAtIndex: i] integerValue] < [[b objectAtIndex: i] integerValue]) {
            result = NSOrderedAscending;
            break;
        }
        else if ([[b objectAtIndex: i] integerValue] < [[a objectAtIndex: i] integerValue]) {
            result = NSOrderedDescending;
            break;
        }
    }
    
    return result;
}

@end
