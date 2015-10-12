//
//  SBLowPriceComTeleTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-18.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBLowPriceComTeleTblCell.h"

@implementation SBLowPriceComTeleTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIImage *s4IconImg = [UIImage imageNamed:@"UITabBarFavoritesTemplateSelected"];
        icon = [[UIView alloc] initWithFrame:CGRectMake(5, 0, s4IconImg.size.width, s4IconImg.size.height)];
        [icon setBackgroundColor:[UIColor colorWithPatternImage:s4IconImg]];
        [self.contentView addSubview:icon];
        
        name = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] - s4IconImg.size.width - 10, 0) font:[UIFont systemFontOfSize:12] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:icon margin:5], 0) superViewFrame:self.frame];
        name.numberOfLines = 0;
        name.backgroundColor = TEST_BGCOLOR;
        [self.contentView addSubview:name];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    NSString *nameStr = @"sdfjasdlfjsdal;f asdjfl sfjas;ld fjasd;lf jasd;lf jasd;flasjdfasdklfasdjf asdf ;alsk";
    CGSize maxSize = CGSizeMake(name.frame.size.width, 999);
    CGSize labelSize = [nameStr sizeWithFont:name.font
                           constrainedToSize: maxSize
                               lineBreakMode: NSLineBreakByTruncatingTail];
    [ITUIKitHelper sizeSet:name size:labelSize];
    name.text = nameStr;
    
    [ITUIKitHelper pointSet:icon piont:CGPointMake(-1, ([SBLowPriceComTeleTblCell getHeight:info] - icon.frame.size.height) / 2.0)];
}

+ (float)getHeight:(NSDictionary *)info
{
    NSString *nameStr = @"sdfjasdlfjsdal;f asdjfl sfjas;ld fjasd;lf jasd;lf jasd;flasjdfasdklfasdjf asdf ;alsk";
    CGSize maxSize = CGSizeMake(240, 999);
    CGSize labelSize = [nameStr sizeWithFont:[UIFont systemFontOfSize:12]
                           constrainedToSize: maxSize
                               lineBreakMode: NSLineBreakByTruncatingTail];
    
    return labelSize.height;
}


@end
