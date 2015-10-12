//
//  SBLowPriceColCell.m
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBLowPriceColCell.h"

@implementation SBLowPriceColCell

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

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SBLowPriceCarCell getHeight:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *id1 = @"lowPriceCarId";
    SBLowPriceCarCell *cell = [tableView dequeueReusableCellWithIdentifier:id1];
    if (!cell) cell = [[SBLowPriceCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id1];
    [cell display:[datas objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datas.count;
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBLowPriceColCell_Cell:) withObject:[updateTableView cellForRowAtIndexPath:indexPath]]);
}

- (void)display:(NSDictionary *)data
{
    
    datas = [data objectForKey:@"data"];
    
    if (!datas) [self initData];
    
    [tbView reloadData];
}


@end
