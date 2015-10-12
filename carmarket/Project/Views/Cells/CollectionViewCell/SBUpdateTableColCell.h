//
//  SBUpdateTableColCell.h
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKUpdateTableView.h"

@interface SBUpdateTableColCell : UICollectionViewCell <BKUpdateTableViewDelegate, BKUpdateTableViewProcessingDelegate, UITableViewDataSource, BKUpdateTableViewScrollDelegate, UIGestureRecognizerDelegate, BKUpdateTableViewDelegate>
{
    BKUpdateTableView *tbView;
}

- (void)createView:(UITableViewStyle)tableStyle frame:(CGRect)frame;
- (void)createView:(UITableViewStyle)tableStyle;
- (void)createView:(UITableViewStyle)tableStyle bkTableStyle:(BKUpdateTableViewType)type;
- (void)createView:(UITableViewStyle)tableStyle bkTableStyle:(BKUpdateTableViewType)type topInset:(float)inset;
- (void)display:(NSDictionary *)data;

- (void)displayWithDatas:(NSArray *)_datas;

- (void)autoRefeshTable;
- (void)refreshTable;
- (BKUpdateTableView *)get_tbView;

@end
