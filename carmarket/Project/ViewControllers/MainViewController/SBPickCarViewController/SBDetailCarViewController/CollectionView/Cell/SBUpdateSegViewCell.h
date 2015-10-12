//
//  SBUpdateSegViewCell.h
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBUpdateTableColCell.h"
#import "BKUpdateTableView.h"
#import "SBCommentReportSegView.h"
#import "SBCommentReportTbView.h"

@interface SBUpdateSegViewCell : SBUpdateTableColCell <BKUpdateTableViewProcessingDelegate, BKUpdateTableViewDelegate, UITableViewDataSource, SBCommentReportSegViewDelegate>
{
    SBCommentReportTbView *commentTbView;
}
- (void)createView:(UITableViewStyle)tableStyle;

@end
