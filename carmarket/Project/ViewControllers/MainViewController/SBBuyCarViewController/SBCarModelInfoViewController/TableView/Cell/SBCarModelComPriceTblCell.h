//
//  SBCarModelComPriceTblCell.h
//  carmarket
//
//  Created by itensb on 14-9-4.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"

@interface SBCarModelComPriceTblCell : SBaseTableViewCell
{
    UILabel *s4Title;
    UILabel *price;
    UILabel *dianhua;
}

@property (nonatomic, strong) UILabel *dianhua;

@end
