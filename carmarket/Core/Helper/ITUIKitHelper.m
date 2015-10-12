//
//  ITUIHelper.m
//  91JJ3D
//
//  Created by apple on 14-5-20.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ITUIKitHelper.h"

@implementation ITUIKitHelper

#pragma mark - 关于UI生成
+ (UILabel *)createLabel:(NSString *)title size:(CGSize)size font:(UIFont *)font color:(UIColor *)color marginInsets:(ITMarginInsets)marginInsets point:(CGPoint)point superViewFrame:(CGRect)superFrame
{
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = title;
    titleLab.font = font;
    titleLab.textColor = color;
    titleLab.backgroundColor = [UIColor clearColor];
    
    if (size.height == -1) [ITUIKitHelper sizeSet:titleLab size:CGSizeMake(size.width, font.lineHeight)];
    else [ITUIKitHelper sizeSet:titleLab size:CGSizeMake(size.width, size.height)];
    
    [ITUIKitHelper locateWithMargin:marginInsets point:point view:titleLab superView:superFrame];
    
    return titleLab;
}

+ (UILabel *)createLabel:(NSString *)title font:(UIFont *)font color:(UIColor *)color marginInsets:(ITMarginInsets)marginInsets point:(CGPoint)point superViewFrame:(CGRect)superFrame
{
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = title;
    titleLab.font = font;
    titleLab.textColor = color;
    [titleLab sizeToFit];
    [ITUIKitHelper sizeSet:titleLab size:CGSizeMake(titleLab.frame.size.width, font.lineHeight)];
    titleLab.backgroundColor = [UIColor clearColor];
    [ITUIKitHelper locateWithMargin:marginInsets point:point view:titleLab superView:superFrame];
    
    return titleLab;
}

+ (UIView *)createIconWithUIImage:(UIImage *)img
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    view.backgroundColor = [UIColor colorWithPatternImage:img];
    return view;
}

+ (UIView *)createIconWithImage:(NSString *)img
{
    return [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:img]];
}

+ (UIView *)createUIViewWithImage:(NSString *)img marginInsets:(ITMarginInsets)marginInsets point:(CGPoint)point superViewFrame:(CGRect)superFrame
{
    UIImage *uiimg = [UIImage imageNamed:img];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, uiimg.size.width, uiimg.size.height)];
    [ITUIKitHelper locateWithMargin:marginInsets point:point view:view superView:superFrame];
    view.backgroundColor = [UIColor colorWithPatternImage:uiimg];
    return view;
}

+ (UIButton *)createButtonWithUIImage:(UIImage *)uiimg highlightImg:(UIImage *)pressImg isBackgroundImg:(BOOL)is
{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, uiimg.size.width, uiimg.size.height)];
    if(is) [btn setBackgroundImage:uiimg forState:UIControlStateNormal]; else [btn setImage:uiimg forState:UIControlStateNormal];
    if (pressImg != nil) {
        if (is) [btn setBackgroundImage:pressImg forState:UIControlStateHighlighted];
        else [btn setImage:pressImg forState:UIControlStateHighlighted];
    }
    return btn;
}

+ (UIButton *)createButtonWithImage:(NSString *)img highlightImg:(NSString *)himg isBackgroundImg:(BOOL)is
{
    UIImage *uiimg = [UIImage imageNamed:img];
    UIImage *pressImg;
    if (himg) pressImg = [UIImage imageNamed:himg];
    
    return [self createButtonWithUIImage:uiimg highlightImg:pressImg isBackgroundImg:is];
}

+ (UIButton *)createButtonWithUIImage:(UIImage *)img highlightImg:(UIImage *)himg point:(CGPoint)point isBackgroundImg:(BOOL)is
{
    UIButton *btn = [self createButtonWithUIImage:img highlightImg:himg isBackgroundImg:is];
    btn.frame = CGRectMake(point.x, point.y, btn.frame.size.width, btn.frame.size.height);
    return btn;
}

+ (UIButton *)createButtonWithImage:(NSString *)img highlightImg:(NSString *)himg point:(CGPoint)point isBackgroundImg:(BOOL)is
{
    UIButton *btn = [self createButtonWithImage:img highlightImg:himg isBackgroundImg:is];
    btn.frame = CGRectMake(point.x, point.y, btn.frame.size.width, btn.frame.size.height);
    return btn;
}

//请置marginInsets的内容为-1如果不需要
+ (UIButton *)createButtonWithUIImage:(UIImage *)img highlightImg:(UIImage *)himg marginInsets:(ITMarginInsets)marginInsets point:(CGPoint)point isBackgroundImg:(BOOL)is superViewFrame:(CGRect)superFrame
{
    //首先按bottom,right依次进行定位; 之后根据是否进行bottom，right定位，判断是否进行绝对定位
    UIButton *btn = [self createButtonWithUIImage:img highlightImg:himg isBackgroundImg:is];
    [ITUIKitHelper locateWithMargin:marginInsets point:point view:btn superView:superFrame];
    
    return btn;
}

+ (UIButton *)createButtonWithImage:(NSString *)img highlightImg:(NSString *)himg marginInsets:(ITMarginInsets)marginInsets point:(CGPoint)point isBackgroundImg:(BOOL)is superViewFrame:(CGRect)superFrame
{
    //首先按bottom,right依次进行定位; 之后根据是否进行bottom，right定位，判断是否进行绝对定位
    UIButton *btn = [self createButtonWithImage:img highlightImg:himg isBackgroundImg:is];
    [ITUIKitHelper locateWithMargin:marginInsets point:point view:btn superView:superFrame];
    
    return btn;
}

#pragma mark - 关于尺度计算
+ (void)pointSet:(UIView *)view piont:(CGPoint)point
{
    CGRect rect = view.frame;
    if (point.x != -1) rect.origin.x = point.x;
    if (point.y != -1) rect.origin.y = point.y;
    view.frame = rect;
}

+ (void)sizeSet:(UIView *)view size:(CGSize)s
{
    CGRect rect = view.frame;
    if (s.width != -1) rect.size.width = s.width;
    if (s.height != -1) rect.size.height = s.height;
    view.frame = rect;
}

+ (float)xMarLeftView:(UIView *)leftView margin:(float)margin
{
    return leftView.frame.size.width + leftView.frame.origin.x + margin;
}

+ (float)yMarTopView:(UIView *)topView margin:(float)margin
{
    return topView.frame.size.height + topView.frame.origin.y + margin;
}

+ (ITMarginInsets)InvalideITMarginInsets
{
    
    ITMarginInsets insets;
    insets.bottom = -1;
    insets.right = -1;
    return insets;
}

+ (ITMarginInsets)ITMarginInsetsMake:(float)bottom right:(float)right
{
    ITMarginInsets insets;
    insets.bottom = bottom;
    insets.right = right;
    return insets;
}

+ (CGPoint)centerPoint:(UIView *)childView superView:(UIView *)superView
{
    float x = (superView.frame.size.width - childView.frame.size.width) / 2.0;
    float y = (superView.frame.size.height - childView.frame.size.height) / 2.0;
    
    return CGPointMake(x, y);
}

+ (float)getHeightWithFont:(UIFont *)font
{
    NSString *text = @"测";
    return [text sizeWithFont:font].height;
}

+ (void)stretchViewFrame:(float)stretch view:(UIView *)view
{
    view.frame = CGRectMake(view.frame.origin.x - stretch / 2.0, view.frame.origin.y - stretch / 2.0, view.frame.size.width + stretch, view.frame.size.height + stretch);
}

+ (CGSize)setLabelWithConstrainedStringSize:(UILabel *)l text:(NSString *)text maxHeight:(float)height
{
    height = (height < 0 ? INT16_MAX : height);
    CGSize maxSize = CGSizeMake(l.frame.size.width, height);
    CGSize labelSize = [text sizeWithFont:l.font
                            constrainedToSize: maxSize
                                lineBreakMode: NSLineBreakByTruncatingTail];
    l.text = text;
    [ITUIKitHelper sizeSet:l size:CGSizeMake(-1, labelSize.height)];
    
    return labelSize;
}

+ (void)sizeLabelWithText:(NSString *)text label:(UILabel *)label
{
    NSString *addStr = text;
    CGSize maxSize = CGSizeMake(label.frame.size.width, 999);
    CGSize labelSize = [addStr sizeWithFont:label.font
                          constrainedToSize: maxSize
                              lineBreakMode: NSLineBreakByTruncatingTail];
    if(labelSize.width != 0) [ITUIKitHelper sizeSet:label size:labelSize];
    label.text = addStr;
}

+ (void)locateWithMargin:(ITMarginInsets)marginInsets point:(CGPoint)point view:(UIView *)btn superView:(CGRect)superFrame
{
    if (marginInsets.bottom >= 0) btn.frame = CGRectMake(btn.frame.origin.x, superFrame.size.height - marginInsets.bottom - btn.frame.size.height, btn.frame.size.width, btn.frame.size.height);
    if (marginInsets.right >= 0) btn.frame = CGRectMake(superFrame.size.width - marginInsets.right - btn.frame.size.width, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height);
    
    if (marginInsets.bottom < 0) {
        btn.frame = CGRectMake(btn.frame.origin.x, point.y, btn.frame.size.width, btn.frame.size.height);
    }
    
    if (marginInsets.right < 0) {
        btn.frame = CGRectMake(point.x, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height);
    }
}

#pragma -mark 颜色相关
+(UIColor *)color:(float)red blue:(float)blue green:(float)green alpha:(float)alpha{
    
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

+(UIColor *)color:(NSString *)hex{
    return [ITUIKitHelper color:hex alpha:1.0];
}

+(UIColor *)color:(NSString *)hex alpha:(float)alpha{
    if ([hex characterAtIndex:0]=='#') {
        hex = [hex substringFromIndex:1];
    }
    NSString *rs = [hex substringWithRange:NSMakeRange(0, 2)];
    long r = strtol([rs UTF8String],NULL, 16);
    NSString *gs = [hex substringWithRange:NSMakeRange(2, 2)];
    long g = strtol([gs UTF8String],NULL, 16);
    NSString *bs = [hex substringWithRange:NSMakeRange(4, 2)];
    long b = strtol([bs UTF8String],NULL, 16);
    return [ITUIKitHelper color:r*(1.0) blue:b*(1.0) green:g*(1.0) alpha:alpha];
}

#pragma -mark app全局函数
+ (float)getAppWidth
{
    CGRect appFrame = [[UIScreen mainScreen] bounds];
    float appWidth = appFrame.size.width;
    return appWidth;
}

+ (float)getAppHeight
{
    CGRect appFrame = [[UIScreen mainScreen] bounds];
    float appHeight = appFrame.size.height;
    return appHeight;
}

#pragma - mark 边线装饰
+ (void)decorateWithLine:(UIView *)view color:(UIColor *)color lineWidth:(float)lineWidth type:(ITLineDecorateType)type
{
    UIView *up = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:color size:CGSizeMake(view.frame.size.width, lineWidth)]]; up.tag = 153983;
    UIView *down = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:color size:CGSizeMake(view.frame.size.width, lineWidth)]]; down.tag = 153983;
    UIView *left = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:color size:CGSizeMake(lineWidth, view.frame.size.height)]]; left.tag = 153983;
    UIView *right = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:color size:CGSizeMake(lineWidth, view.frame.size.height)]]; right.tag = 153983;
    [ITUIKitHelper pointSet:up piont:CGPointMake(0, 0)];
    [ITUIKitHelper pointSet:down piont:CGPointMake(0, view.frame.size.height - lineWidth)];
    [ITUIKitHelper pointSet:left piont:CGPointMake(0, 0)];
    [ITUIKitHelper pointSet:right piont:CGPointMake(view.frame.size.width - lineWidth, 0)];
    switch (type) {
        case ITLineDecorateAll:
        {
            [view addSubview:up];[view addSubview:down];[view addSubview:left];[view addSubview:right];break;
        }
        case ITLineDecorateLeft:[view addSubview:left];break;
        
        case ITLineDecorateRight:[view addSubview:right];break;
    
        case ITLineDecorateUp:[view addSubview:up];break;
        
        case ITLineDecorateDown:[view addSubview:down];break;
        
        case ITLineDecorateUpDown:
        {
            [view addSubview:up];[view addSubview:down];break;
        }
        case ITLineDecorateLeftRight:
        {
            [view addSubview:left];[view addSubview:right];break;
        }
        case ITLineDecorateExceptDown:
        {
            [view addSubview:left];[view addSubview:right];[view addSubview:up];break;
        }
        case ITLineDecorateExceptRight:
        {
            [view addSubview:left];[view addSubview:down];[view addSubview:up];break;
        }
        default:
            break;
    }

}

+ (void)removeLineViews:(UIView *)view
{
    for (UIView *line in view.subviews) {
        if (line.tag == 153983) {
            [line removeFromSuperview];
        }
    }
}

//+ (UIImage *)getColoredImg

@end
