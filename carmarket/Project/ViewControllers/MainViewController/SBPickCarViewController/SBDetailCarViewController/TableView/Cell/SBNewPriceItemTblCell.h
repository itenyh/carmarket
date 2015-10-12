//
//  SBNewPriceItemTblCell.h
//  carmarket
//
//  Created by itensb on 14-8-11.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"
#import "SBCarComTypeView.h"

@interface SBNewPriceItemTblCell : SBaseTableViewCell
{
    SBCarComTypeView *comIcon;
    UILabel *title;
    UILabel *price;
    UILabel *add;
    
    UIButton *teleBtn;
    
    UIView *bottom;
}
@end
