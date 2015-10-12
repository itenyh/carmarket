//
//  SBCarArgBasicInfoCell.m
//  carmarket
//
//  Created by itensb on 14-8-13.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCarArgBasicInfoCell.h"

@implementation SBCarArgBasicInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        item = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] / 2.0, [SBCarArgBasicInfoCell getHeight:nil]) font:[UIFont boldSystemFontOfSize:10] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(0, 0) superViewFrame:self.frame];
        [self.contentView addSubview:item];
        
        content = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] / 2.0, [SBCarArgBasicInfoCell getHeight:nil]) font:[UIFont boldSystemFontOfSize:10] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:item margin:0], 0) superViewFrame:self.frame];
        [self.contentView addSubview:content];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    
    [super display:info];
    
    item.text = @"汽油";
    content.text = @"1.4L";
    
}

+ (float)getHeight:(NSDictionary *)info
{
    return 50;
}


@end
