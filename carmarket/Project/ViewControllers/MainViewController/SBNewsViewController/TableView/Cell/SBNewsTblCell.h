//
//  SBNewsTblCell.h
//  carmarket
//
//  Created by itensb on 14-8-13.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"

@interface SBNewsTblCell : SBaseTableViewCell
{
    UIButton *newsImgView;
    
    UILabel *title;
    UILabel *content;
    UILabel *time;
}
@end
