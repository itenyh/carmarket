//
//  NSString+URL.m
//  carmarket
//
//  Created by itensb on 14-9-1.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

//+ (NSString *)urlencode {
//    NSMutableString *output = [NSMutableString string];
//    const unsigned char *source = (const unsigned char *)[self UTF8String];
//    int sourceLen = strlen((const char *)source);
//    for (int i = 0; i < sourceLen; ++i) {
//        const unsigned char thisChar = source[i];
//        if (thisChar == ' '){
//            [output appendString:@"+"];
//        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
//                   (thisChar >= 'a' && thisChar <= 'z') ||
//                   (thisChar >= 'A' && thisChar <= 'Z') ||
//                   (thisChar >= '0' && thisChar <= '9')) {
//            [output appendFormat:@"%c", thisChar];
//        } else {
//            [output appendFormat:@"%%%02X", thisChar];
//        }
//    }
//    return output;
//}

@end
