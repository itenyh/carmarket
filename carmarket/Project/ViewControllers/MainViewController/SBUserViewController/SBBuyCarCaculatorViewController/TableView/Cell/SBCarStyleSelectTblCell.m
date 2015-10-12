//
//  SBCarStyleSelectTblCell.m
//  carmarket
//
//  Created by itensb on 14-11-5.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCarStyleSelectTblCell.h"

@implementation SBCarStyleSelectTblCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.textLabel.text = @"请选择车型";
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    return self;
}

+ (float)getHeight:(NSDictionary *)info
{
    return 50;
}

@end
