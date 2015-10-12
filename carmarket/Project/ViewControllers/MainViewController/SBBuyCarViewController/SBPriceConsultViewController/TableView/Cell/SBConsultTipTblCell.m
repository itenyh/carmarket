//
//  SBConsultTipTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-14.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBConsultTipTblCell.h"

@implementation SBConsultTipTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIView *icon = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_priceask"]];
        [ITUIKitHelper pointSet:icon piont:CGPointMake(61 * PJSAH, 41 * PJSAH)];
        [self.contentView addSubview:icon];
        
        UILabel *lab = [ITUIKitHelper createLabel:@"提交信息" font:[UIFont systemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"3f3f3f"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:icon margin:46 * PJSAH], 46 * PJSAH) superViewFrame:self.contentView.frame];
        [self.contentView addSubview:lab];
        
        UILabel *subLab = [ITUIKitHelper createLabel:@"稍后将获得最低价详情" font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"707070"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:icon margin:46 * PJSAH], [ITUIKitHelper yMarTopView:lab margin:10]) superViewFrame:self.contentView.frame];
        [self.contentView addSubview:subLab];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
}

+ (float)getHeight:(NSDictionary *)info
{
    return 202 * PJSAH;
}

@end
