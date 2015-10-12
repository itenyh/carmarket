//
//  SBGoOutPlanImportantTitleTblCell.h
//  carmarket
//
//  Created by itensb on 14-11-14.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"

@interface SBGoOutPlanImportantTitleTblCell : SBaseTableViewCell
{
    UILabel *ll;
    UILabel *rl;
}

- (void)display:(NSString *)title content:(NSString *)content;

@end
