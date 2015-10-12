//
//  SBUserSettingBaseTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-20.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBUserSettingBaseTblCell.h"

@implementation SBUserSettingBaseTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        titile = [ITUIKitHelper createLabel:@"" font:[UIFont boldSystemFontOfSize:15] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(10, ([SBUserSettingBaseTblCell getHeight:nil] - [UIFont boldSystemFontOfSize:15].lineHeight) / 2.0) superViewFrame:self.frame];
        [self.contentView addSubview:titile];
        
        UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth], 0.5)]];
        [ITUIKitHelper pointSet:lineView piont:CGPointMake(0, [SBUserSettingBaseTblCell getHeight:nil] - 0.5)];
        [self addSubview:lineView];
    }
    
    return self;
}

- (void)displayWithTilte:(NSString *)_title
{
    titile.text = _title;
    [titile sizeWidthToFit];
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
}


+ (float)getHeight:(NSDictionary *)info
{
    return 50;
}


@end
