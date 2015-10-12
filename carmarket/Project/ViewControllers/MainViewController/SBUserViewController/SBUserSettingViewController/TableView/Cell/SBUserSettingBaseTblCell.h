//
//  SBUserSettingBaseTblCell.h
//  carmarket
//
//  Created by itensb on 14-8-20.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"

@interface SBUserSettingBaseTblCell : SBaseTableViewCell
{
    UILabel *titile;
}

- (void)displayWithTilte:(NSString *)_title;

@end
