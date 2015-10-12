//
//  ITUIHelper.h
//  91JJ3D
//
//  Created by apple on 14-5-20.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UILabel+ITLabHelper.h"

struct ITMarginInsets {
    float bottom;
    float right;
};
typedef struct ITMarginInsets ITMarginInsets;

typedef enum{
    ITLineDecorateUp,
    ITLineDecorateDown,
    ITLineDecorateLeft,
    ITLineDecorateRight,
    ITLineDecorateUpDown,
    ITLineDecorateLeftRight,
    ITLineDecorateAll,
    
    ITLineDecorateExceptDown,
    ITLineDecorateExceptRight
    
} ITLineDecorateType;

@interface ITUIKitHelper : NSObject

//快捷生成UI
+ (UIView *)createIconWithUIImage:(UIImage *)img;
+ (UIView *)createIconWithImage:(NSString *)img;

+ (UILabel *)createLabel:(NSString *)title font:(UIFont *)font color:(UIColor *)color marginInsets:(ITMarginInsets)marginInsets point:(CGPoint)point superViewFrame:(CGRect)superFrame;
+ (UILabel *)createLabel:(NSString *)title size:(CGSize)size font:(UIFont *)font color:(UIColor *)color marginInsets:(ITMarginInsets)marginInsets point:(CGPoint)point superViewFrame:(CGRect)superFrame;

+ (UIButton *)createButtonWithImage:(NSString *)img highlightImg:(NSString *)himg isBackgroundImg:(BOOL)is;
+ (UIButton *)createButtonWithImage:(NSString *)img highlightImg:(NSString *)himg point:(CGPoint)point isBackgroundImg:(BOOL)is;
+ (UIButton *)createButtonWithImage:(NSString *)img highlightImg:(NSString *)himg marginInsets:(ITMarginInsets)marginInsets point:(CGPoint)point isBackgroundImg:(BOOL)is superViewFrame:(CGRect)superFrame; //请置marginInsets的内容为-1如果不需要
+ (UIView *)createUIViewWithImage:(NSString *)img marginInsets:(ITMarginInsets)marginInsets point:(CGPoint)point superViewFrame:(CGRect)superFrame;

+ (UIButton *)createButtonWithUIImage:(UIImage *)img highlightImg:(UIImage *)himg marginInsets:(ITMarginInsets)marginInsets point:(CGPoint)point isBackgroundImg:(BOOL)is superViewFrame:(CGRect)superFrame;
+ (UIButton *)createButtonWithUIImage:(UIImage *)img highlightImg:(UIImage *)himg point:(CGPoint)point isBackgroundImg:(BOOL)is;
+ (UIButton *)createButtonWithUIImage:(UIImage *)uiimg highlightImg:(UIImage *)pressImg isBackgroundImg:(BOOL)is;

+ (ITMarginInsets)ITMarginInsetsMake:(float)bottom right:(float)right;

+ (float)xMarLeftView:(UIView *)leftView margin:(float)margin;
+ (float)yMarTopView:(UIView *)topView margin:(float)margin;
+ (ITMarginInsets)InvalideITMarginInsets;
+ (float)getHeightWithFont:(UIFont *)font;
+ (CGPoint)centerPoint:(UIView *)childView superView:(UIView *)superView;
+ (CGSize)setLabelWithConstrainedStringSize:(UILabel *)l text:(NSString *)text maxHeight:(float)height;
+ (void)locateWithMargin:(ITMarginInsets)marginInsets point:(CGPoint)point view:(UIView *)btn superView:(CGRect)superFrame;

+ (void)sizeLabelWithText:(NSString *)text label:(UILabel *)label;
+ (void)stretchViewFrame:(float)stretch view:(UIView *)view;
+ (void)pointSet:(UIView *)view piont:(CGPoint)point;
+ (void)sizeSet:(UIView *)view size:(CGSize)s;

//颜色
+(UIColor *)color:(float)red blue:(float)blue green:(float)green alpha:(float)alpha;
+(UIColor *)color:(NSString *)hex;
+(UIColor *)color:(NSString *)hex alpha:(float)alpha;

+ (float)getAppWidth;
+ (float)getAppHeight;

+ (void)decorateWithLine:(UIView *)view color:(UIColor *)color lineWidth:(float)lineWidth type:(ITLineDecorateType)type;
+ (void)removeLineViews:(UIView *)view;

@end
