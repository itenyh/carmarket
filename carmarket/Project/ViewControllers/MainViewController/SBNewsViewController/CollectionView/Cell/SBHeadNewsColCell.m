//
//  SBHeadNewsColView.m
//  carmarket
//
//  Created by itensb on 14-8-7.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBHeadNewsColCell.h"
#import "SBHeadNewsAdTblCell.h"
#import "SBNewsTblCell.h"

@implementation SBHeadNewsColCell

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
    if (indexPath.section == 0) return [SBHeadNewsAdTblCell getHeight:nil];
    else return [SBNewsTblCell getHeight:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *id1 = @"SBHeadNewsAdTblCellId";
        SBHeadNewsAdTblCell *cell = [tableView dequeueReusableCellWithIdentifier:id1];
        if (!cell) cell = [[SBHeadNewsAdTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id1];
        [cell displayWithDatas:newsData];
        return cell;
    }
    
    else {
        static NSString *id1 = @"SBHeadNewsTblCellId";
        SBNewsTblCell *cell = [tableView dequeueReusableCellWithIdentifier:id1];
        if (!cell) cell = [[SBNewsTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id1];
        if (newsData.count > indexPath.row + ADDATA_NUM)
            [cell display:[newsData objectAtIndex:indexPath.row + ADDATA_NUM]];
        return cell;
    }
    
}

- (void)displayWithDatas:(NSArray *)datas
{
    newsData = datas;
    [tbView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) return 1;
    else return [newsData count] - ADDATA_NUM;
}

@end
