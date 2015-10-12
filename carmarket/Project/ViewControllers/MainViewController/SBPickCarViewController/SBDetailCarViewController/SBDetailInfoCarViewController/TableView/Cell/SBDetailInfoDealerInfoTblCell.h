//
//  SBDetailInfoDealerInfoTblCell.h
//  carmarket
//
//  Created by itensb on 14-11-10.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"
#import "SBCarComTypeView.h"

@interface SBDetailInfoDealerInfoTblCell : SBaseTableViewCell
{
    SBCarComTypeView *comIcon;
    UILabel *title;
    
    UILabel *name;
    UILabel *phone;
    UIButton *web;
    UILabel *add;
    
    UILabel *qq;
    UILabel *weixin;
    
    NSString *weburl;
}
@end
