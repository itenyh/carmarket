//
//  SBFastNaviListViewController.m
//  carmarket
//
//  Created by itensb on 14-10-23.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBFastNaviListViewController.h"
#import "SBLocationPickViewController.h"
#import "SBYapDBManager.h"
#import "ITMapper.h"

#import "SBFastNaviHistoryTblCell.h"

@interface SBFastNaviListViewController () <UITableViewDataSource, UITableViewDelegate>
{
    
    UITableView *tbView;
    
    NSArray *plans;
    
}
@end

@implementation SBFastNaviListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的导航";
    
    plans = [self getPlans];
    
    [self createNaviCreateBtn:^(id sender) {
        
        [self push_rootNaviController:[[SBLocationPickViewController alloc] initWithNavi:YES handler:^(NSDictionary *info) {
            
            [self saveNaviLoc:info];
            plans = [self getPlans];
            [tbView reloadData];
            
            [self startNaviWithDic:info];
            
        } leftBtnType:NDLeftBtnBack navTitle:@"导航目的地"] animated:YES];
        
    }];
    
    [ITMapper instance].mapView.frame = CGRectMake(0, 0, [ITUIKitHelper getAppWidth], [ITUIKitHelper getAppHeight]);
    [ITMapper instance].mapView.showsCompass = NO;
    [ITMapper instance].mapView.showsScale = NO;
    [self addSubviewInContentView:[ITMapper instance].mapView];
    
    UIView *mask = [[UIView alloc] initWithFrame:[ITMapper instance].mapView.frame];
    mask.backgroundColor = [ITUIKitHelper color:@"000000" alpha:0.2];
    [self addSubviewInContentView:mask];
    
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], self.cotentSize.height) style:UITableViewStylePlain];
    [self addSubviewInContentView:tbView];
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma - mark tabelView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cid = @"id";
    SBFastNaviHistoryTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
    if (!cell) cell = [[SBFastNaviHistoryTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
    [cell display:[plans objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SBFastNaviHistoryTblCell getHeight:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return plans.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [plans objectAtIndex:indexPath.row];
    
    [self startNaviWithDic:dic];
}

- (void)startNaviWithDic:(NSDictionary *)dic
{
    double x , y;
    
    y = [[dic objectForKey:@"latitude"] floatValue];
    x = [[dic objectForKey:@"longitude"] floatValue];
    
    [self showLoading];
    
    [[ITMapper instance] naviDriveRouteWithEndPoints:x latitude:y drivingStrategy:0 response:^(AMapNaviManager *naviManager) {
        [self stopLoading];
    } fail:^(AMapNaviManager *naviManager) {
        [self showErrorMessageOnCenter:@"导航加载失败"];
        [self stopLoading];
    } finish:^(AMapNaviManager *naviManager) {
        
    }];
}

- (void)saveNaviLoc:(NSDictionary *)dic
{
    NSMutableArray *datas = [[SBYapDBManager instance] getDicDataWithKeySyn:FASTNAVI_TB collection:FASTNAVI_COL];
    if (!datas) {
        datas = [NSMutableArray array];
        [datas addObject:dic];
    }
    else {
        
        //排重
        BOOL isRepeated = NO;
        for (NSDictionary *data in datas) {
            if ([[data objectForKey:@"name"] isEqualToString:[dic objectForKey:@"name"]]) {
                isRepeated = YES;
                break;
            }
        }
        
        if(!isRepeated) [datas insertObject:dic atIndex:0];
    }
    
    [[SBYapDBManager instance] insertDicDataSyn:datas key:FASTNAVI_TB collection:FASTNAVI_COL];
}

- (NSArray *)getPlans
{
    NSMutableArray *datas = [[SBYapDBManager instance] getDicDataWithKeySyn:FASTNAVI_TB collection:FASTNAVI_COL];
    
    return datas;
}

- (NSString *)cellStr:(int)row
{
    NSDictionary *dic = [plans objectAtIndex:row];
    NSString *s = [dic objectForKey:@"name"];

    return s;
}

- (void)clearViewController
{
    [super clearViewController];
    
    [[ITMapper instance] clearMapView];
    
}

@end
