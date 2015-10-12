//
//  SBCarStyleDateTblCell.h
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"

@interface SBCarStyleDateTblCell : SBaseTableViewCell
{
    NSMutableArray *btns;
    UIScrollView *scrollView;
    
    int selectedIndex;
    
    
}
@end
