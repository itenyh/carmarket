//
//  SBLocPriceCarCell.h
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"
#import "StrikeThroughLabel.h"
#import "SBCarComTypeView.h"

@interface SBLowPriceCarCell : SBaseTableViewCell
{
    UIImageView *imgView;
    UIView *bottom;
    
    UIButton *teleBtn;
    
    UILabel *title;
    UILabel *price;
    UILabel *lowprice;
    SBCarComTypeView *s4Icon;
    UILabel *s4title;
    UILabel *localSell;
    StrikeThroughLabel *delePrice;
}
@end
