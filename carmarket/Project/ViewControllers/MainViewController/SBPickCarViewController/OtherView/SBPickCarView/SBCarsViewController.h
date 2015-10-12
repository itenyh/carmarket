//
//  SBCarsViewController.h
//  carmarket
//
//  Created by itensb on 14-11-3.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBBaseViewController.h"
#import "SBPickCarView.h"

@class SBCarsViewController, SBaseTableViewCell;
@protocol SBCarsViewControllerDelegate <NSObject>

@optional
- (void)sBCarsViewControllerCarStyleClick:(SBCarsViewController *)vc cell:(SBaseTableViewCell *)cell;
- (void)sBCarsViewControllerTableIndex:(SBCarsViewController *)vc sectionTitle:(NSString *)sectionTitle;

@end

@interface SBCarsViewController : SBBaseViewController

@property (nonatomic, strong) SBPickCarView *pcView;
@property (nonatomic, weak) id<SBCarsViewControllerDelegate> delegate;

@end
