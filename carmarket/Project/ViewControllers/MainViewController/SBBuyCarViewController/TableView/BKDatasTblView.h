//
//  SBLowPriceTblView.h
//  carmarket
//
//  Created by itensb on 14-11-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "BKUpdateTableView.h"

@interface BKDatasTblView : BKUpdateTableView

- (id)initWithFrame:(CGRect)frame updateType:(BKUpdateTableViewType)updateType cellClass:(Class)_class;
- (void)reloadWithData:(id)_data;
- (BOOL)isEmpty;

@end
