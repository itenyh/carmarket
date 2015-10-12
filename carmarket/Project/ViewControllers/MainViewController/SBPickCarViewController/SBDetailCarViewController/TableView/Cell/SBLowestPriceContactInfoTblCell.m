//
//  SBLowestPriceContactInfoTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-15.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBLowestPriceContactInfoTblCell.h"

@implementation SBLowestPriceContactInfoTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createTextFieldView:@"车    款：" index:0];
        [self createTextFieldView:@"姓    名：" index:1];
        [self createTextFieldView:@"手    机：" index:2];
      
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
}

+ (float)getHeight:(NSDictionary *)info
{
    return 3 * 89 * PJSAH + 50 * PJSAH;
}


@end
