//
//  SBPickCarViewController.m
//  carmarket
//
//  Created by itensb on 14-8-5.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBPickCarViewController.h"
#import "SBPickCarTableView.h"
#import "SBSingleBrandlListView.h"
#import "SBDetailCarViewController.h"
#import "SBConditionCarView.h"
#import "SBCarSearchViewController.h"
#import "SBConditionItemsPanel.h"

#import "SBaseTableViewCell.h"

#import "SBPickCarVCInterface.h"
#import "SBConditionDataSource.h"
#import "SBCarsViewController.h"

#import "SBPickCarView.h"

@interface SBPickCarViewController () <BKUpdateTableViewScrollDelegate, BKUpdateTableViewDelegate, SBCarsViewControllerDelegate, SBCarsViewControllerDelegate>
{
    SBSingleBrandlListView *brandListView;
    SBPickCarTableView *tbView;
    SBConditionCarView *conditonMenuView;
}
@end

@implementation SBPickCarViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self setTitleWithImage:[UIImage imageNamed:@"icon_titlexuanche"]];
//    [self createSearchBtn:^(id sender) {
//        SBCarSearchViewController *searchCon = [[SBCarSearchViewController alloc] initWithNavi:YES naviType:SBNavCustomType];
//        [self push_rootNaviController:searchCon animated:YES];
//    }];
    
    NSArray *segmentedArray = [[NSArray alloc] initWithObjects:@"品牌选车", @"条件选车", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(([ITUIKitHelper getAppWidth] - 160 * PJSA) / 2 , 7 * PJSA, 160 * PJSA, 34 * PJSA);
    segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    segmentedControl.tintColor = [ITUIKitHelper color:@"c30114"];
    [self addSubviewInContentView:segmentedControl];
    
//    ---------- 品牌选车 ----------
    SBCarsViewController *carsVC = [[SBCarsViewController alloc] initWithNavi:NO leftBtnType:NDLeftBtnNone];
    carsVC.pcView.frame = CGRectMake(0, [ITUIKitHelper yMarTopView:segmentedControl margin:7 * PJSA], [ITUIKitHelper getAppWidth], self.cotentSize.height - TABBAR_HEIGHT - segmentedControl.frame.size.height - 7 * PJSA * 2);
    carsVC.delegate = self;
    [self addSubviewInContentView:carsVC.pcView];
    
//    ---------- 条件选车 ----------
    UIView *conditionBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, [ITUIKitHelper yMarTopView:segmentedControl margin:7 * PJSA], [ITUIKitHelper getAppWidth], self.cotentSize.height - TABBAR_HEIGHT - segmentedControl.frame.size.height - 7 * PJSA * 2)];
    conditionBottomView.hidden = YES;
    [self addSubviewInContentView:conditionBottomView];
    
    conditonMenuView = [[SBConditionCarView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], conditionBottomView.frame.size.height)];
    [conditionBottomView addSubview:conditonMenuView];
    
    [segmentedControl bk_addEventHandler:^(id sender) {
        int index = (int)segmentedControl.selectedSegmentIndex;
        if (index == 0) {
            conditionBottomView.hidden = YES;
            carsVC.pcView.hidden = NO;
        }
        else {
            conditionBottomView.hidden = NO;
            carsVC.pcView.hidden = YES;
        }
    } forControlEvents:UIControlEventValueChanged];

    
}

- (void)SBConditionMenuView_Request:(NSMutableDictionary *)params
{
    if (![params objectForKey:GENGDUO_KEY]) [params addEntriesFromDictionary:[SBConditionDataSource getGengDuoDefautParam]];
    
    [SBPickCarVCInterface requestConditionedCar:params successBlock:^(id successValue) {
        [conditonMenuView reloadDatas:successValue];
    } andFailBlock:^(id failValue) {
        
    } params:@"1", @"page", @"20", @"pagesize", nil];
    
}

- (void)SBConditionCarView_Cell:(SBaseTableViewCell *)cell
{
    SBDetailCarViewController *detailCon = [[SBDetailCarViewController alloc] initWithNavi:YES];
    [[SBRequestParamBus instance] setParamWith:detailCon key:@"brandId" value:[cell.info objectForKey:@"brandId"]];
    [[SBRequestParamBus instance] setParamWith:detailCon key:@"carInfo" value:cell.info];
    [self push_rootNaviController:detailCon animated:YES];
}

- (void)SBConditionCarView_TableLoadMore:(BKUpdateTableView *)table
{
    NSString *pageIndexStr = [NSString stringWithFormat:@"%d", conditonMenuView.pageIndex];

    [SBPickCarVCInterface requestConditionedCar:[conditonMenuView getNowParam] successBlock:^(id successValue) {
        [conditonMenuView reloadMoreDatas:successValue];
        table.pullTableIsLoadingMore = NO;
    } andFailBlock:^(id failValue) {
        table.pullTableIsLoadingMore = NO;
    } params:pageIndexStr, @"page", @"20", @"pagesize", nil];
    
}

- (void)sBCarsViewControllerTableIndex:(SBCarsViewController *)vc sectionTitle:(NSString *)sectionTitle
{
    [self showTblIndexMessageOnCenter:sectionTitle];
}

#pragma - mark CarsViewDelegate
- (void)sBCarsViewControllerCarStyleClick:(SBCarsViewController *)vc cell:(SBaseTableViewCell *)cell
{
    SBDetailCarViewController *detailCon = [[SBDetailCarViewController alloc] initWithNavi:YES];
    [[SBRequestParamBus instance] setParamWith:detailCon key:@"brandId" value:vc.pcView.brandListView.brandId];
    [[SBRequestParamBus instance] setParamWith:detailCon key:@"carInfo" value:cell.info];
    [self push_rootNaviController:detailCon animated:YES];
}

@end
