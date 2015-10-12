//
//  SBCarNameTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-8.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBBrandNameTblCell.h"

@implementation SBBrandNameTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        // Initialization code
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(30 * PJSAH, [self getMiddleYByHeight:90 * PJSAH], 115 * PJSAH, 90 * PJSAH)];
        [self.contentView addSubview:imgView];
        
        lab = [ITUIKitHelper createLabel:@"" size:CGSizeMake(200, -1) font:[UIFont boldSystemFontOfSize:40 * PJSAH] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(171 * PJSAH, ([SBBrandNameTblCell getHeight:nil] - [UIFont boldSystemFontOfSize:40 * PJSAH].lineHeight) / 2) superViewFrame:self.contentView.frame];
        [self.contentView addSubview:lab];
        
        UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth], 0.5)]];
        [ITUIKitHelper pointSet:lineView piont:CGPointMake(0, 0)];
        [self.contentView addSubview:lineView];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    [imgView sd_setImageWithURL:[SBUtil getBrandImgURLWith:info] placeholderImage:[SBUIFactory getPlaceHolderImg]];
    lab.text = [info objectForKey:@"name"];
    
}

+ (float)getHeight:(NSDictionary *)info
{
    return 127 * PJSAH;
}

@end
