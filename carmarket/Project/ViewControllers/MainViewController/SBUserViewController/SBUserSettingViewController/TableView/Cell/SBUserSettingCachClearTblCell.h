//
//  SBUserSettingCachClearTblCell.h
//  carmarket
//
//  Created by itensb on 14-8-20.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBUserSettingBaseTblCell.h"

@interface SBUserSettingCachClearTblCell : SBUserSettingBaseTblCell
{
    UILabel *cache;
    UIButton *clear;
}

- (void)displayWithTilte:(NSString *)_title cache:(NSString *)_cache;

@end
