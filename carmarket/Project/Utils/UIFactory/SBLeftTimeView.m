//
//  SBLeftTimeView.m
//  carmarket
//
//  Created by itensb on 14-9-2.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBLeftTimeView.h"

@implementation SBLeftTimeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        low_icon = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_timer"]];
        [ITUIKitHelper pointSet:low_icon piont:CGPointMake(0, 0)];
        [self addSubview:low_icon];
        
        [ITUIKitHelper sizeSet:self size:low_icon.frame.size];
        
        l = [ITUIKitHelper createLabel:@"" size:CGSizeMake(0, low_icon.frame.size.height) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"2ec200"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:low_icon margin:10 * PJSAH], 0) superViewFrame:self.frame];
        [self addSubview:l];

        
    }
    
    return self;
}

- (void)setTime:(NSString *)time
{
    l.text = [NSString stringWithFormat:@"剩余%@天", time];
    float addedLength = l.frame.size.width;
    [l sizeWidthToFit];
    addedLength = l.frame.size.width - addedLength;
    [ITUIKitHelper pointSet:l piont:CGPointMake(l.frame.origin.x - addedLength, -1)];
    [ITUIKitHelper pointSet:low_icon piont:CGPointMake(low_icon.frame.origin.x - addedLength, -1)];
    [ITUIKitHelper sizeSet:self size:CGSizeMake(self.frame.size.width + addedLength, -1)];
}

@end
