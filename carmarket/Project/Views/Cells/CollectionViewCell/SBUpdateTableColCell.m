//
//  SBUpdateTableColCell.m
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBUpdateTableColCell.h"

@implementation SBUpdateTableColCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    
    return self;
}

- (void)createView:(UITableViewStyle)tableStyle bkTableStyle:(BKUpdateTableViewType)type topInset:(float)inset
{
    if (tbView == nil) {
        
        tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, inset, self.frame.size.width, self.frame.size.height - inset) style:tableStyle updateType:type tip:nil];
        tbView.dataSource = self;
        tbView.backgroundColor = [UIColor clearColor];
        tbView.processingDelegate = self;
        tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tbView.scrollDelegate = self;
        tbView.pullUpdateDelegate = self;
        [self.contentView addSubview:tbView];
        
    }
}

- (void)createView:(UITableViewStyle)tableStyle bkTableStyle:(BKUpdateTableViewType)type
{
    [self createView:tableStyle bkTableStyle:type topInset:0];
}

- (void)createView:(UITableViewStyle)tableStyle
{
    [self createView:tableStyle frame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

- (void)createView:(UITableViewStyle)tableStyle frame:(CGRect)frame
{
    [self createView:tableStyle bkTableStyle:BKUpdateTableViewTypePlain];
    tbView.frame = frame;
}

- (BKUpdateTableView *)get_tbView
{
    return tbView;
}

- (void)display:(NSDictionary *)data
{
    
}

- (void)displayWithDatas:(NSArray *)datas
{
    
}

#pragma - mark 公共函数
- (void)autoRefeshTable
{
    [tbView automateRefresh];
}

- (void)refreshTable
{
    [tbView reloadData];
}

#pragma - mark TableView代理
- (void)pullBKUpdateTableViewDidTriggerLoadMore:(BKUpdateTableView *)updateTableView
{
    UIViewController *vc = [ITUtils viewControllerFor:self];
    
    if ([vc respondsToSelector:@selector(SBUpdateTableColCell_LoadMore:)])
        RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBUpdateTableColCell_LoadMore:) withObject:updateTableView]);
}

- (void)pullBKUpdateTableViewDidTriggerRefresh:(BKUpdateTableView *)updateTableView
{
    UIViewController *vc = [ITUtils viewControllerFor:self];
    
    if ([vc respondsToSelector:@selector(SBUpdateTableColCell_Refresh:)])
        RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBUpdateTableColCell_Refresh:) withObject:updateTableView]);
}

@end
