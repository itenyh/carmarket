//
//  SBUserInfoLogOutTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-20.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBColoredBtnTblCell.h"

@implementation SBColoredBtnTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info title:(NSString *)_title type:(int)colType
{
    if (!logOut) {
        
        logOut = [SBUIFactory getColoredPanel:_title size:CGSizeMake(([ITUIKitHelper getAppWidth] - 27 * PJSA), 87 * PJSAH) color:nil font:[UIFont systemFontOfSize:35 * PJSAH] type:colType];
        [ITUIKitHelper pointSet:logOut piont:CGPointMake(27 * PJSAH, 0)];
        [self.contentView addSubview:logOut];
        
        [logOut bk_addEventHandler:^(id sender) {
            RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBUserInfoLogOutTblCell_LogOut:) withObject:self]);
        } forControlEvents:UIControlEventTouchUpInside];
        
    }
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
}


+ (float)getHeight:(NSDictionary *)info
{
    return 87 * PJSAH + 30;
}


@end
