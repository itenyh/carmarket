//
//  SBPinCeColCell.m
//  carmarket
//
//  Created by itensb on 14-9-9.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBPinCeColCell.h"
#import "SBNewsTblCell.h"
#import "SBNewsPinCeTblCell.h"

@implementation SBPinCeColCell

- (void)initData
{
    newsData = [NSArray array];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initData];
        
    }
    
    return self;
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBHeadNewsColCell_Cell:) withObject:[updateTableView cellForRowAtIndexPath:indexPath]]);
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SBNewsTblCell getHeight:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *id1 = @"SBNewsPinCeTblCellId";
    SBNewsTblCell *cell = [tableView dequeueReusableCellWithIdentifier:id1];
    if (!cell) cell = [[SBNewsTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id1];
    [cell display:[newsData objectAtIndex:indexPath.row]];
    return cell;
    
}

- (void)displayWithDatas:(NSArray *)datas
{
    newsData = datas;
    [tbView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [newsData count];
}


@end
