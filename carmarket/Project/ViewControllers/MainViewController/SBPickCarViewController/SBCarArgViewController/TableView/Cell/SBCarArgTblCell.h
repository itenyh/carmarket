//
//  SBCarArgTblCell.h
//  carmarket
//
//  Created by itensb on 14-11-11.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"

@interface SBCarArgTblCell : SBaseTableViewCell
{
    UILabel *title;
    UILabel *c1;
}

- (void)displayWith:(NSString *)_title value:(NSString *)_value;

@end
