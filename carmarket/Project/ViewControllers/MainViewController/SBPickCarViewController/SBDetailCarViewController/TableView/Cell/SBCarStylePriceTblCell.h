//
//  SBCarStylePriceTblCell.h
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"

@interface SBCarStylePriceTblCell : SBaseTableViewCell
{
    UILabel *title;
    UILabel *subTitle;
    UILabel *price;
    UILabel *subPrice;
    
    NSMutableArray *btns;
    
    UIView *bottom;
    
    CGFloat kCellHeightMax;
}
@end
