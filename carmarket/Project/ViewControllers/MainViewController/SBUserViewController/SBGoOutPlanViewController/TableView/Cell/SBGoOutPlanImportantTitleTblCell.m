//
//  SBGoOutPlanImportantTitleTblCell.m
//  carmarket
//
//  Created by itensb on 14-11-14.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBGoOutPlanImportantTitleTblCell.h"

@implementation SBGoOutPlanImportantTitleTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.contentView.backgroundColor = [ITUIKitHelper color:@"ffffff" alpha:1];
    
        ll = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] / 2.0, -1) font:[UIFont systemFontOfSize:12] color:[ITUIKitHelper color:156 blue:164 green:161 alpha:1] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(5, 10) superViewFrame:self.contentView.frame];
        [self.contentView addSubview:ll];
        
        rl = [ITUIKitHelper createLabel:@"13 Km" size:CGSizeMake([ITUIKitHelper getAppWidth] - 2 * 6, -1) font:[UIFont boldSystemFontOfSize:33] color:[ITUIKitHelper color:85 blue:90 green:86 alpha:1] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(6, [ITUIKitHelper yMarTopView:ll margin:0]) superViewFrame:self.contentView.frame];
        [self.contentView addSubview:rl];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
}

- (void)display:(NSString *)title content:(NSString *)content
{
    ll.text = title;
    rl.text = content;
}

+ (float)getHeight:(NSDictionary *)info
{
    return 60;
}


@end
