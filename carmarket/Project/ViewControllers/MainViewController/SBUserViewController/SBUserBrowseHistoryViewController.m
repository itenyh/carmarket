//
//  SBBrowseHistoryViewController.m
//  carmarket
//
//  Created by itensb on 14-8-20.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBUserBrowseHistoryViewController.h"
#import "SBCategoryColView.h"
#import "BKUpdateTableView.h"

@interface SBUserBrowseHistoryViewController () <SBCategoryColViewDelegate, BKUpdateTableViewProcessingDelegate, BKUpdateTableViewDelegate, UITableViewDataSource>
{
    SBCategoryColView *categoryView;
    BKUpdateTableView *tbView;
}
@end

@implementation SBUserBrowseHistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"浏览历史";
    
    categoryView = [SBCategoryColView new];
    categoryView.data = [NSArray arrayWithObjects:@"车款", @"车型", @"资讯", nil];
    categoryView.sbdelegate = self;
    [self addSubviewInContentView:categoryView];
    
    tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, [ITUIKitHelper yMarTopView:categoryView margin:0], self.view.frame.size.width, self.cotentSize.height - categoryView.frame.size.height) style:UITableViewStylePlain updateType:BKUpdateTableViewTypeNoUpdate];
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.processingDelegate = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubviewInContentView:tbView];
    
}

#pragma - mark TableView代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cid = @"3id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
//    [cell display:nil];
    
    return cell;
    
    return nil;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10;
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)sbCategoryColView:(SBCategoryColView *)view didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tbView reloadData];
}

@end
