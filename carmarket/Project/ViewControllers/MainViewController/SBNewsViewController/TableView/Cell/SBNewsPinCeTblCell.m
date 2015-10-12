//
//  SBNewsPinCeTblCell.m
//  carmarket
//
//  Created by itensb on 14-9-4.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBNewsPinCeTblCell.h"

@implementation SBNewsPinCeTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
    
        img  = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, [SBNewsPinCeTblCell getHeight:nil] - 5 * 2)];
        [self.contentView addSubview:img];
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] - 10 * 2 - img.frame.size.width - 10, 40) font:[UIFont boldSystemFontOfSize:35 * PJSAH] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:img margin:28 * PJSAH], 21 * PJSAH) superViewFrame:self.frame];
//        title.backgroundColor = TEST_BGCOLOR;
        title.numberOfLines = 2;
        [self.contentView addSubview:title];
        
        time = [ITUIKitHelper createLabel:@"" size:CGSizeMake(200, -1) font:[UIFont boldSystemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"727272"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:img margin:28 * PJSAH], 10) superViewFrame:self.frame];
//        time.backgroundColor = TEST_BGCOLOR;
        [self.contentView addSubview:time];
        
        UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth], 0.5)]];
        [ITUIKitHelper pointSet:lineView piont:CGPointMake(0, [SBNewsPinCeTblCell getHeight:nil] - 0.5)];
        [self.contentView addSubview:lineView];
    
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
   
    [img sd_setImageWithURL:[SBUtil getNewsImgURLWith:info] placeholderImage:[SBUIFactory getPlaceHolderImg]];
    
    NSString *cellString = [info objectForKey:@"title"];
    title.text = cellString;
    
}

+ (float)getHeight:(NSDictionary *)info
{
    return 90;
}

@end
