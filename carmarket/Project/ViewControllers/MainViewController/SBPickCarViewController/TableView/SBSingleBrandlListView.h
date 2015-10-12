//
//  SBSingleBrandlListView.h
//  carmarket
//
//  Created by itensb on 14-8-5.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBSingleBrandlListView : UIView

- (void)show;
- (void)hide:(BOOL)animated;
- (void)clear;
- (void)reloadWithDatas:(NSArray *)_datas;

@property (nonatomic, copy) NSMutableDictionary *datas;
@property (nonatomic, strong) NSString *brandId;
@property (nonatomic, weak) UIViewController *targetVC;

@end
