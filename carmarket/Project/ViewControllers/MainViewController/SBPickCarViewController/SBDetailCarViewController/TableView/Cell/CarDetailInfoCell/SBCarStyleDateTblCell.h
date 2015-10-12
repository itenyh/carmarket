//
//  SBCarStyleDateTblCell.h
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"

@protocol  SBCarStyleDateTblCellDelegate <NSObject>

- (void)SBCarStyleDateTblCellBtnClick:(UIButton *)btn;

@end

@interface SBCarStyleDateTblCell : SBaseTableViewCell
{
    NSMutableArray *btns;
    UIScrollView *scrollView;
    
    int selectedIndex;
}

@property (nonatomic, weak) id<SBCarStyleDateTblCellDelegate> delegate;

@end
