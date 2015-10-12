//
//  SBPickCarView.h
//  carmarket
//
//  Created by itensb on 14-11-3.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBSingleBrandlListView.h"
#import "SBPickCarTableView.h"

@interface SBPickCarView : UIView

@property (nonatomic, strong) SBSingleBrandlListView *brandListView;
@property (nonatomic, strong) SBPickCarTableView *tbView;

- (void)setBrandListData:(NSArray *)data;
- (void)setHotBrandData:(NSDictionary *)dic;
- (void)setTargetVC:(UIViewController *)tc;

@end
