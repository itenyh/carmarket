//
//  SBHeadNewsTblCell.h
//  carmarket
//
//  Created by itensb on 14-8-7.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"
#import "CycleScrollView.h"

@interface SBHeadNewsAdTblCell : SBaseTableViewCell

@property (nonatomic, strong) NSArray *adDatas;
@property (nonatomic, strong) CycleScrollView *mainScorllView;

- (void)displayWithDatas:(NSArray *)datas;

@end
