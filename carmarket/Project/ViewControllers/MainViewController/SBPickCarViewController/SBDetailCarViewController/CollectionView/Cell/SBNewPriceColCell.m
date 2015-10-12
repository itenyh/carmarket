//
//  SBNewPriceColCell.m
//  carmarket
//
//  Created by itensb on 14-8-11.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBNewPriceColCell.h"
#import "SBNewPriceStaTblCell.h"
#import "SBNewPriceItemTblCell.h"

@implementation SBNewPriceColCell

- (void)initData
{
    datas = [NSMutableArray array];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initData];
        
    }
    
    return self;
}

- (void)displayWithDatas:(NSArray *)_datas
{
    [super displayWithDatas:_datas];
    
    datas = _datas;
    
    [tbView reloadData];
    
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0 && indexPath.section == 0) return [SBNewPriceStaTblCell getHeight:nil];
//    else return [SBNewPriceItemTblCell getHeight:nil];
    
    return [SBNewPriceItemTblCell getHeight:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0 && indexPath.section == 0) {
//        static NSString *id1 = @"staCell";
//        SBNewPriceStaTblCell *cell = [tableView dequeueReusableCellWithIdentifier:id1];
//        if (!cell) cell = [[SBNewPriceStaTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id1];
//        return cell;
//    }
//    
//    else {
        static NSString *id2 = @"priceCell";
        SBNewPriceItemTblCell *cell = [tableView dequeueReusableCellWithIdentifier:id2];
        if (!cell) cell = [[SBNewPriceItemTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id2];
        [cell display:datas[indexPath.row]];
        return cell;
//    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return 2;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0) return 1;
//    else return 5;
    return datas.count;
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBNewPriceColCell_SBNewPriceItemTblCell:) withObject:[updateTableView cellForRowAtIndexPath:indexPath]]);
    }
}

@end
