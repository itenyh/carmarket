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
        [ITUIKitHelper pointSet:view piont:CGPointMake(63 * PJSAH, 28 * PJSAH)];
        [self.contentView addSubview:view];
        
        UILabel *lab = [ITUIKitHelper createLabel:@"车型收藏" font:[UIFont systemFontOfSize:(40 * PJSAH)] color:[ITUIKitHelper color:@"070707"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:view margin:61 * PJSAH],32 * PJSAH) superViewFrame:self.contentView.frame];
        [self.contentView addSubview:lab];
        
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
