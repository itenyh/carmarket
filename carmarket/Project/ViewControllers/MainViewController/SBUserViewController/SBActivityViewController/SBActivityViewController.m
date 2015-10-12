//
//  SBActivityViewController.m
//  carmarket
//
//  Created by itensb on 14-8-18.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBActivityViewController.h"
#import "BKUpdateTableView.h"

#import "SBActivityTblCell.h"
#import "SBCreateActivityViewController.h"
#import "SBXLogViewController.h"
#import "SBMapActivityViewController.h"

#import "SBGoActivityViewController.h"

#import "SBActivityVCInterface.h"
#import "SBPickCarVCInterface.h"
#import "SBUserDataInterface.h"

@interface SBActivityViewController () <BKUpdateTableViewDelegate, BKUpdateTableViewProcessingDelegate, UITableViewDataSource>
{
    NSMutableArray *datas;
    BKUpdateTableView *tbView;
}
@end

@implementation SBActivityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    datas = [NSMutableArray array];
    
    [self setTitleWithImage:[UIImage imageNamed:@"icon_titlehuodong"]];
    
    [self createActivityCreateBtn:^(id sender) {
        if (![SBUserDataInterface isLogging]) [self push_rootNaviController:[[SBXLogViewController alloc] initWithNavi:YES handler:^(NSDictionary *info) {
            
            [self performSelector:@selector(delayPushCreateViewController) withObject:nil afterDelay:1];
            
        } leftBtnType:NDLeftBtnBack] animated:YES];
        
        else [self push_rootNaviController:[[SBCreateActivityViewController alloc] initWithNavi:YES] animated:YES];
    }];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"全部", @"本周", @"下周", @"下月", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake((self.view.frame.size.width - 300) / 2, 10, 300, 30.0);
    segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    segmentedControl.tintColor = [UIColor redColor];
//    [self addSubviewInContentView:segmentedControl];
    
//    BKUpdateTableView *tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, [ITUIKitHelper yMarTopView:segmentedControl margin:10], self.view.frame.size.width, self.cotentSize.height - [ITUIKitHelper yMarTopView:segmentedControl margin:10]) style:UITableViewStylePlain updateType:BKUpdateTableViewTypeNoUpdate];
    tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.cotentSize.height) style:UITableViewStylePlain updateType:BKUpdateTableViewTypePlain tip:nil];
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.processingDelegate = self;
    tbView.pullUpdateDelegate = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubviewInContentView:tbView];
    
    
}

- (void)delayPushCreateViewController
{
    [self push_rootNaviController:[[SBCreateActivityViewController alloc] initWithNavi:YES] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestActivityData:nil];
}

#pragma - mark TableView代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cid = @"id";
    SBActivityTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
    if (!cell) cell = [[SBActivityTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
    [cell display:[datas objectAtIndex:indexPath.row]];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datas.count;
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SBActivityTblCell getHeight:nil];
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBGoActivityViewController *act = [[SBGoActivityViewController alloc] initWithNavi:YES];
    [[SBRequestParamBus instance] setParamWith:act key:@"info" value:[datas objectAtIndex:indexPath.row]];
    [self push_rootNaviController:act animated:YES];
}

- (void)pullBKUpdateTableViewDidTriggerLoadMore:(BKUpdateTableView *)updateTableView
{
    [self requestMoreActivityData:^{ updateTableView.pullTableIsLoadingMore = NO; }];
}

- (void)pullBKUpdateTableViewDidTriggerRefresh:(BKUpdateTableView *)updateTableView
{
    [self requestActivityData:^{ updateTableView.pullTableIsRefreshing = NO; }];
}

- (void)requestActivityData:(void (^)(void))handler
{
    if (!handler) {handler = ^{};}
    
    [SBActivityVCInterface requestActivityList:[SBUserDataInterface getUserId] time:nil pageSize:DEFAULT_PAGESIZE pageIndex:0 successBlock:^(id successValue) {
        
        datas = successValue;
        [tbView reloadData];
        tbView.pageIndex = 1;
        handler();
        
    } andFailBlock:^(id failValue) {
        handler();
    }];
}

- (void)requestMoreActivityData:(void (^)(void))handler
{
    [SBActivityVCInterface requestActivityList:[SBUserDataInterface getUserId] time:nil pageSize:DEFAULT_PAGESIZE pageIndex:++tbView.pageIndex successBlock:^(id successValue) {
        
        if(successValue && [successValue isKindOfClass:[NSArray class]]) [datas addObjectsFromArray:successValue];
        [tbView reloadData];
        handler();
        
    } andFailBlock:^(id failValue) {
        handler();
    }];
}


@end
