//
//  SBLowPriceView.m
//  carmarket
//
//  Created by itensb on 14-9-2.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBLowPriceView.h"

@implementation SBLowPriceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIView *low_icon = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_lowprice"]];
        
        bottom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, low_icon.frame.size.height)];
        [bottom addSubview:low_icon];
        [self addSubview:bottom];
        
        l = [ITUIKitHelper createLabel:@"" size:CGSizeMake(bottom.frame.size.width - low_icon.frame.size.width - 14 * PJSAH, bottom.frame.size.height) font:[UIFont systemFontOfSize:28 * PJSAH] color:[ITUIKitHelper color:@"2ec200"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:low_icon margin:14 * PJSAH], 0) superViewFrame:bottom.frame];
        [bottom addSubview:l];
        
        [ITUIKitHelper sizeSet:self size:bottom.frame.size];
        
    }
    
    return self;
}

- (void)setPrice:(NSString *)price
{
    l.text = price;
    float addedLength = l.frame.size.width;
    [l sizeWidthToFit];
    addedLength = l.frame.size.width - addedLength;
    
    [ITUIKitHelper sizeSet:bottom size:CGSizeMake(bottom.frame.size.width + addedLength, -1)];
    [ITUIKitHelper sizeSet:self size:bottom.frame.size];
}

@end
