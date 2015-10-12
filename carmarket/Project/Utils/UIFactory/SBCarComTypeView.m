//
//  SBCarComTypeView.m
//  carmarket
//
//  Created by itensb on 14-11-7.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCarComTypeView.h"

@implementation SBCarComTypeView

- (id)initWithFrame:(CGRect)frame type:(int)_type
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [ITUIKitHelper sizeSet:self size:CGSizeMake(50 * PJSAH, 32 * PJSAH)];
        type = _type;
    }
    
    return self;
}

- (void)setComTitle:(NSString *)title
{
    if (type == 1) {
        if ([title rangeOfString:@"4S"].length != 0) {
            [self createIconWithType:2];
            [icon setTitle:@"4S" forState:UIControlStateNormal];
        }
        else if([title rangeOfString:@"综合"].length != 0) {
            [self createIconWithType:2];
            [icon setTitle:@"综合" forState:UIControlStateNormal];
        }
        else {
            [icon setTitle:title forState:UIControlStateNormal];
        }
    }
    
    else {
        if ([title rangeOfString:@"4S"].length != 0) {
            [self createIconWithType:0];
            [icon setTitle:@"4S" forState:UIControlStateNormal];
        }
        else if([title rangeOfString:@"综合"].length != 0) {
            [self createIconWithType:1];
            [icon setTitle:@"综合" forState:UIControlStateNormal];
        }
        else {
            [icon setTitle:title forState:UIControlStateNormal];
        }
    }
    
}

- (void)createIconWithType:(int)_type
{
    if (icon) {
        [icon removeFromSuperview];
        icon = nil;
    }
    
    icon = [SBUIFactory getColoredRedPanel:@"" size:CGSizeMake(50 * PJSAH, 32 * PJSAH) color:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:24 * PJSAH]];
    
    if (_type == 0) {
        icon = [SBUIFactory getColoredRedPanel:@"" size:CGSizeMake(50 * PJSAH, 32 * PJSAH) color:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:24 * PJSAH]];
    }
    
    else if (_type == 1) {
        icon = [SBUIFactory getColoredBluePanel:@"" size:CGSizeMake(50 * PJSAH, 32 * PJSAH) color:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:24 * PJSAH]];
    }
    
    else if (_type == 2) {
        icon = [SBUIFactory getColoredPanel:@"" size:CGSizeMake(50 * PJSAH, 32 * PJSAH) color:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:24 * PJSAH] type:5];
    }
    
    icon.userInteractionEnabled = NO;
    [self addSubview:icon];

}

@end
