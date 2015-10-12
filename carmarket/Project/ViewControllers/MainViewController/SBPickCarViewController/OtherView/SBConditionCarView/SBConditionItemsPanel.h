//
//  SBConditionItemsPanel.h
//  carmarket
//
//  Created by Apple on 14-8-23.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBConditionBtn.h"

@class SBConditionItemsPanel;
@protocol SBConditionItemsPanelDelegate <NSObject>

- (void)SBConditionItemsPanel:(SBConditionItemsPanel *)panel selectedDatas:(NSArray *)datas;

@end

@interface SBConditionItemsPanel : UIView

@property (nonatomic ,strong) NSMutableArray *datas;
@property (nonatomic ,assign) float zuoyou;
@property (nonatomic ,assign) float shangxia;
@property (nonatomic ,assign) BOOL multiSelect;
@property (nonatomic ,readonly) NSMutableIndexSet *selecedSet;
@property (nonatomic ,readonly) NSMutableArray *selecedInfos;
@property (nonatomic ,readonly) NSMutableArray *btns;
@property (nonatomic ,weak) id<SBConditionItemsPanelDelegate> delegate;

+ (float)getHeight:(NSMutableArray *)a width:(float)width zuoyou:(float)zuoyou shangxia:(float)shangxia;
- (void)selectIndex:(int)index;
- (void)clearAll;

@end
