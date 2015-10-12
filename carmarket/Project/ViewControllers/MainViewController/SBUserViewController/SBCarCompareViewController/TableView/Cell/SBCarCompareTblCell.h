//
//  SBCarCompareTblCell.h
//  carmarket
//
//  Created by itensb on 14-11-4.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"

@interface SBCarCompareTblCell : SBaseTableViewCell
{
    UILabel *title;
    UIButton *c1;
    UIButton *c2;
}

- (void)displayWithTitle:(NSString *)_title p1:(NSString *)p1 p2:(NSString *)p2;

@end
