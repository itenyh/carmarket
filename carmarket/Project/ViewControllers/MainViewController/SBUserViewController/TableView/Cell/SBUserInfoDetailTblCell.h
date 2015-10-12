//
//  SBUserInfoDetailTblCell.h
//  carmarket
//
//  Created by itensb on 14-8-20.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"

@interface SBUserInfoDetailTblCell : SBaseTableViewCell
{
    UILabel *name;
    GBPathImageView *head;
    
    UILabel *chebi;           UILabel *chebiL;
    UILabel *jifen;           UILabel *jifenL;
    UILabel *guanzhu;         UILabel *guanzhuL;
    UILabel *fensi;           UILabel *fensiL;
    
    UIImageView *jifenBg;
    
}
@end
