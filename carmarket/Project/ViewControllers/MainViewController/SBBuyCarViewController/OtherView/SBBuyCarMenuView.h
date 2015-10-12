//
//  SBBuyCarMenuView.h
//  carmarket
//
//  Created by itensb on 14-8-14.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBMenuBtn.h"

@interface SBBuyCarMenuView : UIView
{
    SBMenuBtn *carStyle;
    SBMenuBtn *place;
    SBMenuBtn *price;
    
    UIScrollView *scrollView;
    UIView *priceSelectView;
    
    NSMutableArray *allPriceItem;
    
    UIButton *removeBtn;
}
@end
