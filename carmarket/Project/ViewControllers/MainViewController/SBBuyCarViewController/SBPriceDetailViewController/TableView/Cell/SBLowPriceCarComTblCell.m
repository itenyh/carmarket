//
//  SBLowPriceCarComTblCell.m
//  carmarket
//
//  Created by Apple on 14-8-17.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBLowPriceCarComTblCell.h"

@implementation SBLowPriceCarComTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        title = [ITUIKitHelper createLabel:@"经销商信息"  font:[UIFont boldSystemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"0c0c0c"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(35 * PJSAH, 15 * PJSAH) superViewFrame:self.frame];
        [self.contentView addSubview:title];

    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
}

+ (float)getHeight:(NSDictionary *)info
{
    return 25 * PJSAH * 2 + 4;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
