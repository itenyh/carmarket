//
//  SBConsultCarNameTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-14.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBConsultCarNameTblCell.h"

@implementation SBConsultCarNameTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        float labWidth = 300;
        
        lab = [ITUIKitHelper createLabel:@"" size:CGSizeMake(labWidth, -1) font:[UIFont boldSystemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"181818"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(([ITUIKitHelper getAppWidth] - labWidth) / 2, 40 * PJSAH) superViewFrame:self.contentView.frame];
        lab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lab];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    lab.text = @"杰德 1.8L 5AT 舒适型 （五座）";
}

+ (float)getHeight:(NSDictionary *)info
{
    return 115 * PJSAH;
}

@end
