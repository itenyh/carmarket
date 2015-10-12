//
//  SBUserSettingSwitcherTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-20.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBUserSettingSwitcherTblCell.h"

@implementation SBUserSettingSwitcherTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UISwitch *swictch = [[UISwitch alloc] initWithFrame:CGRectMake([ITUIKitHelper getAppWidth] - 80, ([SBUserSettingBaseTblCell getHeight:nil] - 40) / 2.0, 80, 40)];
        [swictch setOnTintColor:[ITUIKitHelper color:@"c30114"]];
        
        [self.contentView addSubview:swictch];
        
    }
    
    return self;
}


@end
