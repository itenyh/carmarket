//
//  UIImage+ITColorImage.h
//  91JJ3D
//
//  Created by apple on 14-5-30.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ITColorImage)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
