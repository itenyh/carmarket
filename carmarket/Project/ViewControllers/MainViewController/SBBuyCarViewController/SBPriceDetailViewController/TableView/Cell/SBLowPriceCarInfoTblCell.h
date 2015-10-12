//
//  SBLowPriceCarInfoTblCell.h
//  carmarket
//
//  Created by Apple on 14-8-17.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"
#import "StrikeThroughLabel.h"
#import "SBLowPriceView.h"
#import "SBLeftTimeView.h"
#import "SBCarComTypeView.h"

@interface SBLowPriceCarInfoTblCell : SBaseTableViewCell
{
    UILabel *title;
    SBCarComTypeView *s4Icon;
    UILabel *s4title;
    UIImageView *imgView;
    
    UILabel *price;
    StrikeThroughLabel *delePrice;
    SBLowPriceView *lowprice;
    UILabel *cuxiaotime;
    SBLeftTimeView *leftTime;
    
    UILabel *huodong;
    
    UILabel *xianjia;
    UILabel *yuanjia;
    UILabel *cuxiao;
}
@end
