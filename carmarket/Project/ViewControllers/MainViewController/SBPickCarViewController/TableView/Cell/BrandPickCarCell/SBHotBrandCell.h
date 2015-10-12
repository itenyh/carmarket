//
//  SBHotBrandCell.h
//  carmarket
//
//  Created by itensb on 14-8-5.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBaseTableViewCell.h"

@class SBHotBrandCell;
@protocol SBHotBrandCellDelegate <NSObject>

- (void)sBHotBrandCell:(SBHotBrandCell *)cell btn:(UIButton *)btn data:(NSDictionary *)data;

@end

@interface SBHotBrandCell : SBaseTableViewCell

@property (nonatomic, weak) id<SBHotBrandCellDelegate> delegate;

@end
