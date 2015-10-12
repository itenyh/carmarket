//
//  SBBaseBuyCarTblCell.m
//  carmarket
//
//  Created by itensb on 14-11-5.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBBaseBuyCarTblCell.h"

@implementation SBBaseBuyCarTblCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] / 2.0, [SBBaseBuyCarTblCell getHeight:nil]) font:[UIFont systemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"727272"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(30 * PJSAH, 0) superViewFrame:self.frame];
//        title.backgroundColor = TEST_BGCOLOR;
        [self.contentView addSubview:title];
        
        
    }
    
    return self;
}

@end
