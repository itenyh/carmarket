//
//  SBCarNameTblCell.h
//  carmarket
//
//  Created by itensb on 14-8-8.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"

@interface SBCarNameTblCell : SBaseTableViewCell
{
    UIImageView *imgView;
    UILabel *lab;
    UILabel *price;
    
    int type;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(int)type;

- (void)display:(NSDictionary *)info imageDomainName:(NSString *)domain;

@end
