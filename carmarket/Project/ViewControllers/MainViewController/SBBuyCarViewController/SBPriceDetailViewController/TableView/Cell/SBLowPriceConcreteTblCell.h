//
//  SBLowPriceConcreteTblCell.h
//  carmarket
//
//  Created by Apple on 14-8-17.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"
#import "StrikeThroughLabel.h"
#import "SBLowPriceView.h"

@interface SBLowPriceConcreteTblCell : SBaseTableViewCell
{
    UILabel *title;
    UILabel *price;
    StrikeThroughLabel *delePrice;
    SBLowPriceView *lowprice;
    
    UIView *bottom;
}

- (void)display:(NSDictionary *)info show:(BOOL)is;

@end
