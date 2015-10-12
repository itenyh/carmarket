//
//  SBUIUtils.m
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBUIFactory.h"
#import "PjArgMacro.h"
#import "UIImage+ITColorImage.h"

@implementation SBUIFactory

+ (UITextField *)getCusTextField:(NSString *)placeholder rect:(CGRect)rect
{
    UITextField *user = [[UITextField alloc] initWithFrame:rect];
    user.font = [UIFont systemFontOfSize:35 * PJSAH];
    user.textColor = [ITUIKitHelper color:@"ccccd2"];
    user.placeholder = placeholder;
    user.borderStyle = UITextBorderStyleRoundedRect;
    user.backgroundColor = [UIColor whiteColor];
    user.textColor = [ITUIKitHelper color:@"181818"];
    [user setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    return user;
}

+ (UIImage *)getUserHeadPlaceholderImg
{
    return [UIImage imageNamed:@"icon_defaulthead"];
}

+ (UIImage *)getPlaceHolderImg
{
    return [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(100, 100)];
}

+ (GBPathImageView *)getUserHeadView:(NSString *)url handler:(void (^)(id))handler
{
    GBPathImageView *head = [[GBPathImageView alloc] initWithFrame:CGRectMake(0, 0, 200 * PJSAH, 200 * PJSAH) image:nil pathType:GBPathImageViewTypeCircle pathColor:[UIColor grayColor] borderColor:[UIColor grayColor] pathWidth:3];
    head.image = [UIImage imageNamed:@"icon_defaulthead"];
    if (handler) [head addEventHandler:handler];
    
    return head;
}

+ (UIView *)getSeperateLineView:(float)y
{
    UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth], 0.5)]];
    [ITUIKitHelper pointSet:lineView piont:CGPointMake(0, y - 0.5)];
    return lineView;
}

+ (void)decorateWithLine:(UIView *)view width:(float)width type:(ITLineDecorateType)type
{
    [ITUIKitHelper decorateWithLine:view color:[ITUIKitHelper color:@"d6d6d6"] lineWidth:width type:type];
}

+ (UILabel *)getLowPriceView:(float)width point:(CGPoint)point superView:(UIView *)view
{
    UIView *low_icon = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_lowprice"]];
    
    UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, width, low_icon.frame.size.height)];
    [bottom addSubview:low_icon];
//    bottom.backgroundColor = TEST_BGCOLOR;
    
    UILabel *l = [ITUIKitHelper createLabel:@"" size:CGSizeMake(width - low_icon.frame.size.width - 14 * PJSAH, bottom.frame.size.height) font:[UIFont systemFontOfSize:28 * PJSAH] color:[ITUIKitHelper color:@"2ec200"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:low_icon margin:14 * PJSAH], 0) superViewFrame:bottom.frame];
    [bottom addSubview:l];
    
    [view addSubview:bottom];
    
    return l;
}

//实时导航白色底板
+ (UIView *)getDaoHangBottomPanel:(CGSize)size
{
//    UIImage *bgImg = [UIImage imageNamed:@"bg_daohangwhite"];
//    UIImage *strechBgImg = [bgImg resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeTile];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [view setBackgroundColor:[ITUIKitHelper color:247 blue:247 green:247 alpha:1]];
    return view;
    
}

//类似开始导航那样的红色btn
+ (UIButton *)getColoredRedBtn:(NSString *)title size:(CGSize)size
{
    UIImage *bgImg = [UIImage imageNamed:@"bg_pasubmit"];
    UIImage *strechBgImg = [bgImg resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeTile];
    
    UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [submit setBackgroundImage:strechBgImg forState:UIControlStateNormal];
    [submit setTitle:title forState:UIControlStateNormal];
    submit.titleLabel.font = [UIFont systemFontOfSize:40 * PJSAH];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return submit;
}

//红色圆角底板、同时也是btn
+ (UIButton *)getColoredRedPanel:(NSString *)title size:(CGSize)size color:(UIColor *)color font:(UIFont *)font
{
    return [SBUIFactory getColoredPanel:title size:size color:color font:font type:3];
}

//蓝色圆角底板、同时也是btn
+ (UIButton *)getColoredBluePanel:(NSString *)title size:(CGSize)size color:(UIColor *)color font:(UIFont *)font
{
    return [SBUIFactory getColoredPanel:title size:size color:color font:font type:2];
}

//绿色色圆角底板、同时也是btn
+ (UIButton *)getColoredGreenPanel:(NSString *)title size:(CGSize)size color:(UIColor *)color font:(UIFont *)font
{
    return [SBUIFactory getColoredPanel:title size:size color:color font:font type:1];
}

+(UIButton *)getColoredPanel:(NSString *)title size:(CGSize)size color:(UIColor *)color font:(UIFont *)font type:(int)type
{
    UIImage *bgImg;
    if (type == 1) bgImg = [UIImage imageNamed:@"bg_greenbottom"];
    if (type == 2) bgImg = [UIImage imageNamed:@"bg_bluebottom"];
    if (type == 3) bgImg = [UIImage imageNamed:@"bg_menuselect"];
    if (type == 4) bgImg = [UIImage imageNamed:@"bg_yellowbottom"];
    if (type == 5) bgImg = [UIImage imageNamed:@"bg_graybottom"];
    
    UIImage *strechBgImg = [bgImg resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeTile];
    
    UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [submit setBackgroundImage:strechBgImg forState:UIControlStateNormal];
    [submit setTitle:title forState:UIControlStateNormal];
    if (font) submit.titleLabel.font = font;
    if (color) [submit setTitleColor:color forState:UIControlStateNormal]; else [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return submit;
}

//得到所有cell的长度，左右留白值为默认值
+ (float)getCellLen
{
    return [ITUIKitHelper getAppWidth] - 2 * 13;
}

@end
