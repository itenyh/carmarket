//
//  SBDetailCarTypeColCell.h
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBUpdateTableColCell.h"
#import "SBCarStyleDateTblCell.h"

@interface SBDetailCarTypeColCell : SBUpdateTableColCell <SBCarStyleDateTblCellDelegate>
{
    NSMutableDictionary *infoDic;
    
    NSMutableArray *dateType;
    NSMutableDictionary *pailiang;
    NSMutableDictionary *car;
    
    int dateIndex;
    
}

@end
