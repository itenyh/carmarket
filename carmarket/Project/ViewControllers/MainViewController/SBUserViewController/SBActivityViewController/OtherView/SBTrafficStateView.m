//
//  SBTrafficStateView.m
//  carmarket
//
//  Created by itensb on 14-8-29.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBTrafficStateView.h"

@implementation SBTrafficStateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 0, 0)];
    
    if (self) {
        
        UIImage *bgImg = [UIImage imageNamed:@"bg_daohangcolorpanel"];
        UIImage *strechBgImg = [bgImg resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15) resizingMode:UIImageResizingModeTile];
        
        UIButton *bottom = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150 * PJSAH, 150 * PJSAH)];
        [bottom setBackgroundImage:strechBgImg forState:UIControlStateNormal];
        bottom.userInteractionEnabled = NO;
        [self addSubview:bottom];
        
        [ITUIKitHelper sizeSet:self size:bottom.frame.size];
        
        float inset = 14;
        
        UIView *view = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_daohanggreen"]];
        [self addSubview:view];
        [ITUIKitHelper pointSet:view piont:CGPointMake(23 * PJSAH, 21 * PJSAH)];
        UILabel *l = [ITUIKitHelper createLabel:@"通畅" font:[UIFont systemFontOfSize:20 * PJSAH] color:[UIColor whiteColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:view margin:10], 20 * PJSAH - 2) superViewFrame:self.frame];
        [self addSubview:l];
        
        UIView *view1 = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_daohangyellow"]];
        [self addSubview:view1];
        [ITUIKitHelper pointSet:view1 piont:CGPointMake(23 * PJSAH, 21 * PJSAH + inset)];
        UILabel *l1 = [ITUIKitHelper createLabel:@"正常" font:[UIFont systemFontOfSize:20 * PJSAH] color:[UIColor whiteColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:view1 margin:10], 20 * PJSAH - 2 + inset) superViewFrame:self.frame];
        [self addSubview:l1];
        
        UIView *view2 = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_daohangred"]];
        [self addSubview:view2];
        [ITUIKitHelper pointSet:view2 piont:CGPointMake(23 * PJSAH, 21 * PJSAH + inset * 2)];
        UILabel *l2 = [ITUIKitHelper createLabel:@"拥堵" font:[UIFont systemFontOfSize:20 * PJSAH] color:[UIColor whiteColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:view2 margin:10], 20 * PJSAH - 2 + inset * 2) superViewFrame:self.frame];
        [self addSubview:l2];
        
        UIView *view3 = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_daohanggray"]];
        [self addSubview:view3];
        [ITUIKitHelper pointSet:view3 piont:CGPointMake(23 * PJSAH, 21 * PJSAH + inset * 3)];
        UILabel *l3 = [ITUIKitHelper createLabel:@"未知" font:[UIFont systemFontOfSize:20 * PJSAH] color:[UIColor whiteColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:view3 margin:10], 20 * PJSAH - 2 + inset * 3) superViewFrame:self.frame];
        [self addSubview:l3];
        
    }
    
    return self;
}


@end
