//
//  SBGoOutPlanSwicherCell.h
//  carmarket
//
//  Created by itensb on 14-11-17.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"

@interface SBGoOutPlanSwicherCell : SBaseTableViewCell
{
    UISwitch *sw;
}

- (void)display:(NSString *)time isOn:(BOOL)is;

@end
