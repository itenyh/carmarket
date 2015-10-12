//
//  SBLocPickViewTblCell.m
//  carmarket
//
//  Created by itensb on 14-11-10.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBLocPickViewTblCell.h"

@implementation SBLocPickViewTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] - 15, -1) font:[UIFont systemFontOfSize:16] color:[ITUIKitHelper color:@"181818"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(10, 6) superViewFrame:self.frame];
        [self.contentView addSubview:title];
        
        subTitle = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] - 15, -1) font:[UIFont systemFontOfSize:12] color:[UIColor lightGrayColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(10, [ITUIKitHelper yMarTopView:title margin:1]) superViewFrame:self.frame];
        [self.contentView addSubview:subTitle];
        
        [SBUIFactory decorateWithLine:self width:0.5 type:ITLineDecorateDown];
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    title.text = [info objectForKey:@"name"];
    subTitle.text = [info objectForKey:@"district"];
    
}

+ (float)getHeight:(NSDictionary *)info
{
    return 18 * PJSA + [UIImage imageNamed:@"bg_huodongtime"].size.height;
}


@end
