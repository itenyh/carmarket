//
//  SBPlainItemTblCell.h
//  carmarket
//
//  Created by itensb on 14-11-5.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBBaseBuyCarTblCell.h"

@interface SBPlainItemTblCell : SBBaseBuyCarTblCell
{
    UILabel *price;
}

- (void)displayWithTitle:(NSString *)_title price:(NSString *)price type:(int)type;

@end
