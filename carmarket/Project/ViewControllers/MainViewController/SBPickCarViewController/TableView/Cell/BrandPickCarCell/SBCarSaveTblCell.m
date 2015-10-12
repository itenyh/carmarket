//
//  SBCarSaveTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-7.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCarSaveTblCell.h"

@implementation SBCarSaveTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIView *view = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_xuanchesave"]];
        [ITUIKitHelper pointSet:view piont:CGPointMake(63 * PJSAH, ([SBCarSaveTblCell getHeight:nil] - view.frame.size.height) / 2.0)];
        [self.contentView addSubview:view];
        
        UILabel *lab = [ITUIKitHelper createLabel:@"车型收藏" size:CGSizeMake(-1, [SBCarSaveTblCell getHeight:nil]) font:[UIFont systemFontOfSize:(40 * PJSAH)] color:[ITUIKitHelper color:@"070707"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:view margin:61 * PJSAH], 2) superViewFrame:self.contentView.frame];
        [lab sizeWidthToFit];
        [self.contentView addSubview:lab];
        
        UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth], 0.5)]];
        [ITUIKitHelper pointSet:lineView piont:CGPointMake(0, 0)];
        [self.contentView addSubview:lineView];
        
        UIView *lineView1 = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth], 0.5)]];
        [ITUIKitHelper pointSet:lineView1 piont:CGPointMake(0, [SBCarSaveTblCell getHeight:nil] + 0.5)];
        [self.contentView addSubview:lineView1];
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
}

+ (float)getHeight:(NSDictionary *)info
{
    return 99 * PJSAH;
}


@end
