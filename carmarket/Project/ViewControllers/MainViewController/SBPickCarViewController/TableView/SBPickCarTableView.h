//
//  SBPickCarTableView.h
//  carmarket
//
//  Created by itensb on 14-8-5.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "BKUpdateTableView.h"

@interface SBPickCarTableView : BKUpdateTableView

@property (nonatomic, copy) NSMutableArray *data;
@property (nonatomic, copy) NSDictionary *hotdata;
@property (nonatomic, weak) UIViewController *targetVC;

@end
