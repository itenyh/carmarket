//
//  SBUIUtils.h
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBPathImageView.h"

@interface SBUIFactory : NSObject

+ (UITextField *)getCusTextField:(NSString *)placeholder rect:(CGRect)rect;
+ (UIImage *)getUserHeadPlaceholderImg;
+ (UIImage *)getPlaceHolderImg;

+ (GBPathImageView *)getUserHeadView:(NSString *)url handler:(void (^)(id sender))handler;

+ (UIView *)getSeperateLineView:(float)y;

+ (UILabel *)getLowPriceView:(float)width point:(CGPoint)point superView:(UIView *)view;

+ (void)decorateWithLine:(UIView *)view width:(float)width type:(ITLineDecorateType)type;

+ (UIView *)getDaoHangBottomPanel:(CGSize)size;

+ (UIButton *)getColoredRedBtn:(NSString *)title size:(CGSize)size;

+ (UIButton *)getColoredRedPanel:(NSString *)title size:(CGSize)size color:(UIColor *)color font:(UIFont *)font;
+ (UIButton *)getColoredBluePanel:(NSString *)title size:(CGSize)size color:(UIColor *)color font:(UIFont *)font;
+ (UIButton *)getColoredGreenPanel:(NSString *)title size:(CGSize)size color:(UIColor *)color font:(UIFont *)font;
+ (UIButton *)getColoredPanel:(NSString *)title size:(CGSize)size color:(UIColor *)color font:(UIFont *)font type:(int)type;

+ (float)getCellLen;

@end
