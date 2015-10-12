//
//  SBCondtionNormalTblCell.m
//  carmarket
//
//  Created by Apple on 14-8-30.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCondtionNormalTblCell.h"

@implementation SBCondtionNormalTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [ITUIKitHelper color:252 blue:252 green:252 alpha:1];
    
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake(150, [SBCondtionNormalTblCell getHeight:nil]) font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"757575"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(60 * PJSAH, 0) superViewFrame:self.frame];
        [self.contentView addSubview:title];
     
        UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth], 0.5)]];
        [ITUIKitHelper pointSet:lineView piont:CGPointMake(0, [SBCondtionNormalTblCell getHeight:nil] - 0.5)];
        [self addSubview:lineView];
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    title.text = [info objectForKey:@"title"];
    
    if ([[info objectForKey:@"selected"] isEqualToString:@"1"]) title.textColor = [ITUIKitHelper color:@"c30114"];
    else title.textColor = [ITUIKitHelper color:@"757575"];

}

+ (float)getHeight:(NSDictionary *)info
{
    return 50;
}

@end
