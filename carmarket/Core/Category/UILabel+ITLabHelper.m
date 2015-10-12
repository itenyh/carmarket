//
//  UILabel+ITLabHelper.m
//  carmarket
//
//  Created by itensb on 14-8-12.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "UILabel+ITLabHelper.h"

@implementation UILabel (ITLabHelper)

- (void)setTextFitWidth:(NSString *)text
{
    self.text = text;
    [self sizeWidthToFit];
}

- (void)sizeWidthToFit
{
    float oldHeight = self.frame.size.height;
    [self sizeToFit];
    
    CGRect rect = self.frame;
    rect.size.height = oldHeight;
    self.frame = rect;
}

@end
