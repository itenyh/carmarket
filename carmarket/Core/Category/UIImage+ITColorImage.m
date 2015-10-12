//
//  UIImage+ITColorImage.m
//  91JJ3D
//
//  Created by apple on 14-5-30.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "UIImage+ITColorImage.h"

@implementation UIImage (ITColorImage)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, (CGRect){.size = size});
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [UIImage imageWithColor:color size:CGSizeMake(1, 1)];
}

@end
