//
//  SBUserSettingArrayTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-20.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBUserSettingArrayTblCell.h"

@implementation SBUserSettingArrayTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIView *arrIcon = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_wangjimimaarray"]];
        [self addSubview:arrIcon];
        [ITUIKitHelper pointSet:arrIcon piont:CGPointMake([ITUIKitHelper getAppWidth] - 27 * PJSAH - arrIcon.frame.size.width, [self getMiddleYByHeight:arrIcon.frame.size.height])];
        
    }
    
    return self;
    
}

@end
