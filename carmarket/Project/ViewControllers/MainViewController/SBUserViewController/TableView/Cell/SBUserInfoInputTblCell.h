//
//  SBUserInfoInputTblCell.h
//  carmarket
//
//  Created by itensb on 14-8-20.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"

@interface SBUserInfoInputTblCell : SBaseTableViewCell
{
    UILabel *title;
    UITextField *tf;
}

- (void)display:(NSString *)info title:(NSString *)_title;
- (void)display:(NSString *)info title:(NSString *)_title isEditable:(BOOL)isE isSecury:(BOOL)isS placeholder:(NSString *)placeholder;
- (NSString *)getContent;

@end
