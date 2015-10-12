//
//  SBConditionCarView.h
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBConditionCarView : UIView

@property (nonatomic, assign) int pageIndex;

- (void)reloadDatas:(id)datas;
- (void)reloadMoreDatas:(id)_datas;
- (NSMutableDictionary *)getNowParam;

@end
