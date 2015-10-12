//
//  SBCarVideoColCell.m
//  carmarket
//
//  Created by itensb on 14-8-25.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCarVideoColCell.h"

@implementation SBCarVideoColCell

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SBCarVideoTblCell getHeight:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *id1 = @"d1";
    SBCarVideoTblCell *cell = [tableView dequeueReusableCellWithIdentifier:id1];
    if (!cell) cell = [[SBCarVideoTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id1];
    [cell display:nil];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

@end
