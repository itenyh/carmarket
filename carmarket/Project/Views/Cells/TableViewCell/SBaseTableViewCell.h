//
//  SBaseTableViewCell.h
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBUIFactory.h"
#import "ITUtils.h"

@interface SBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *info;

- (void)display:(NSDictionary *)info;
+ (float)getHeight:(NSDictionary *)info;
- (float)getMiddleYByHeight:(float)height;

@end
