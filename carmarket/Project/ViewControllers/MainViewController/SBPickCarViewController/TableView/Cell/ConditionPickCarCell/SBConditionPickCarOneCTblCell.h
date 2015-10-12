//
//  SBConditionPickCarOneCTblCell.h
//  carmarket
//
//  Created by Apple on 14-8-23.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"
#import "SBConditionBtn.h"
#import "SBConditionItemsPanel.h"

@class SBConditionPickCarOneCTblCell;
@protocol SBConditionPickCarOneCTblCellDelegate <NSObject>
- (void)SBConditionPickCarOneCTblCell:(SBConditionPickCarOneCTblCell *)view panel:(SBConditionItemsPanel *)panel selectedDatas:(NSArray *)datas;

@end

@interface SBConditionPickCarOneCTblCell : SBaseTableViewCell <SBConditionItemsPanelDelegate>
{
    SBConditionItemsPanel *panel;
    UILabel *l;
    UIView *lineView;
}

@property (nonatomic, weak) id<SBConditionPickCarOneCTblCellDelegate> delegate;

@end
