//
//  SBUserInfoLogOutTblCell.h
//  carmarket
//
//  Created by itensb on 14-8-20.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"

@interface SBColoredBtnTblCell : SBaseTableViewCell
{
    UIButton *logOut;
}

- (void)display:(NSDictionary *)info title:(NSString *)_title type:(int)colType;

@end
