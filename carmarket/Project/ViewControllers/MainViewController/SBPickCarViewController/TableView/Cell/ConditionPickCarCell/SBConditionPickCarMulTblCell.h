//
//  SBConditionPickCarMulTblCell.h
//  carmarket
//
//  Created by Apple on 14-8-23.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"
#import "SBConditionItemsPanel.h"

@class SBConditionPickCarMulTblCell;
@protocol SBConditionPickCarMulTblCellDelegate <NSObject>
- (void)SBConditionPickCarMulTblCell:(SBConditionPickCarMulTblCell *)view panel:(SBConditionItemsPanel *)panel selectedDatas:(NSArray *)datas;

@end

@interface SBConditionPickCarMulTblCell : SBaseTableViewCell <SBConditionItemsPanelDelegate>
{
    SBConditionItemsPanel *panel;
    
    UILabel *left;
    UILabel *number;
    UILabel *right;
    
    UIView *lineView;
}

@property (nonatomic, weak) id<SBConditionPickCarMulTblCellDelegate> delegate;

@end
