//
//  SBBuyCarViewController.m
//  carmarket
//
//  Created by itensb on 14-8-4.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBBuyCarViewController.h"
#import "BKUpdateTableView.h"
#import "SBLowPriceCarCell.h"

#import "SBPriceDetailViewController.h"
#import "SBPriceConsultViewController.h"
#import "SBCarModelInfoViewController.h"
#import "SBDiscountCarDetailViewController.h"
#import "SBBuyCarMenuView.h"

#import "SBBuyCarVCInterface.h"
#import "SBSecondHandCarInfoTblCell.h"
//#import "SBDiscountCarTblCell.h"
#import "SBSecondCarViewController.h"
#import "SBPinXingViewController.h"

#import "BKDatasTblView.h"

#import "SBPinXingCarTblCell.h"

@interface SBBuyCarViewController () <BKUpdateTableViewProcessingDelegate, BKUpdateTableViewDelegate>
{
    
    NSMutableDictionary *jiangjiaInfo;
    NSMutableDictionary *pinxingInfo;
    NSMutableDictionary *ershouInfo;
    
    int selectedIndex;
    
    BKDatasTblView *jiangJiaTbView;
    BKDatasTblView *pinxingCheTbView;
    BKDatasTblView *ershouCheTbView;
    BKDatasTblView *curTbView;
    
    SBBuyCarMenuView *menuView;
    UISegmentedControl *segmentedControl;
}

@end

@implementation SBBuyCarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    jiangjiaInfo = [NSMutableDictionary dictionary];
    pinxingInfo = [NSMutableDictionary dictionary];
    ershouInfo = [NSMutableDictionary dictionary];
    
    [self setTitleWithImage:[UIImage imageNamed:@"icon_titlemaiche"]];
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"新车优惠", @"平行进口车", @"二手车", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    float scWidth = 250 * PJSA;
    segmentedControl.frame = CGRectMake((self.view.frame.size.width - scWidth) / 2, 7 * PJSA, scWidth, 30.0);
    segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    segmentedControl.tintColor = [ITUIKitHelper color:@"c30114"];
    [segmentedControl addTarget:self action:@selector(segmentValueChange:) forControlEvents:UIControlEventValueChanged];
    selectedIndex = segmentedControl.selectedSegmentIndex;
    [self addSubviewInContentView:segmentedControl];
    
    menuView = [[SBBuyCarMenuView alloc] initWithFrame:CGRectMake(0, [ITUIKitHelper yMarTopView:segmentedControl margin:10], 0, 0)];
    //    [self addSubviewInContentView:menuView];
    
    jiangJiaTbView = [self createTbview:[SBLowPriceCarCell class]]; curTbView = jiangJiaTbView;
    pinxingCheTbView = [self createTbview:[SBPinXingCarTblCell class]]; pinxingCheTbView.hidden = YES;
    ershouCheTbView = [self createTbview:[SBSecondHandCarInfoTblCell class]]; ershouCheTbView.hidden = YES;
    
//    [self performSelector:@selector(segmentValueChange:) withObject:segmentedControl afterDelay:0.3];
    [self segmentValueChange:segmentedControl];
    
}

#pragma - mark TableView代理
- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (updateTableView == jiangJiaTbView) return [SBLowPriceCarCell getHeight:nil];
    else if (updateTableView == pinxingCheTbView) return [SBPinXingCarTblCell getHeight:nil];
    else return [SBSecondHandCarInfoTblCell getHeight:nil];
}


- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBaseTableViewCell *cell = (SBaseTableViewCell *)[updateTableView cellForRowAtIndexPath:indexPath];
    
    if (selectedIndex == 0)  {
        
        SBPriceDetailViewController *priceCon = [[SBPriceDetailViewController alloc] initWithNavi:YES];
        [[SBRequestParamBus instance] setParamWith:priceCon key:@"info" value:cell.info];
        [self push_rootNaviController:priceCon animated:YES];
        
    }
    
    else if (selectedIndex == 1) {
        
        SBPinXingViewController *priceCon = [[SBPinXingViewController alloc] initWithNavi:YES];
//        SBDiscountCarDetailViewController *priceCon = [[SBDiscountCarDetailViewController alloc] initWithNavi:YES];
        [[SBRequestParamBus instance] setParamWith:priceCon key:@"info" value:cell.info];
        [self push_rootNaviController:priceCon animated:YES];
        
        
    }
    
    else {
        
        SBSecondCarViewController *scVc = [[SBSecondCarViewController alloc] initWithNavi:YES];
        [[SBRequestParamBus instance] setParamWith:scVc key:@"info" value:cell.info];
        [self push_rootNaviController:scVc animated:YES];
        
    }
    
}

- (void)pullBKUpdateTableViewDidTriggerLoadMore:(BKUpdateTableView *)updateTableView
{
    [self requestMoreSelectedIndexData:^{
        updateTableView.pullTableIsLoadingMore = NO;
    }];
}

- (void)pullBKUpdateTableViewDidTriggerRefresh:(BKUpdateTableView *)updateTableView
{
    [self requestSelectedIndexData:^ {
        updateTableView.pullTableIsRefreshing = NO;
    }];
}

#pragma - mark 代理方法
- (void)SBCarStylePriceTblCell_Button:(UIButton *)btn Cell:(SBaseTableViewCell *)cell
{
    if (btn.tag == 0) [ITUtils dialPhoneNumber:btn.titleLabel.text];
    else [self push_rootNaviController:[[SBPriceConsultViewController alloc] initWithNavi:YES] animated:YES];
}

- (void)SBLowPriceCarCell_Button:(UIButton *)btn Cell:(SBaseTableViewCell *)cell
{
    if (btn.tag == 0) [ITUtils dialPhoneNumber:btn.titleLabel.text];
    else [self push_rootNaviController:[[SBPriceConsultViewController alloc] initWithNavi:YES] animated:YES];
}

#pragma - mark 网络请求
- (void)segmentValueChange:(UISegmentedControl *)control
{

    selectedIndex = control.selectedSegmentIndex;
    [self showTableViewWithIndex];
//    if ([curTbView isEmpty]) [curTbView performSelector:@selector(automateRefresh) withObject:nil afterDelay:0.3];
    if ([curTbView isEmpty]) [self requestSelectedIndexData:nil];
}

- (void)requestSelectedIndexData:(void (^)(void))handler
{
    
    if (!handler) {handler = ^{};}
    
    if (selectedIndex == 0) {
        [SBBuyCarVCInterface requestLowPriceActivities:nil pageSize:0 pageIndex:0 isCache:YES successBlock:^(id successValue) {
            
            [self refreshDataSet:jiangjiaInfo value:successValue];
            [jiangJiaTbView reloadWithData:jiangjiaInfo];
            handler();
            
        } andFailBlock:^(id failValue) {
            
            handler();
            
        }];
    }
    
    else if (selectedIndex == 1) {
        
        [SBBuyCarVCInterface requestPinxingCar:nil pageSize:0 pageIndex:0 successBlock:^(id successValue) {
            
            [self refreshDataSet:pinxingInfo value:successValue];
            [pinxingCheTbView reloadWithData:pinxingInfo];
            handler();
            
        } andFailBlock:^(id failValue) {
            handler();
        }];
        
    }
    
    else if (selectedIndex == 2) {
        
        [SBBuyCarVCInterface requestUsedCar:nil pageSize:0 pageIndex:0 successBlock:^(id successValue) {
            
            [self refreshDataSet:ershouInfo value:successValue];
            [ershouCheTbView reloadWithData:ershouInfo];
            handler();
            
        } andFailBlock:^(id failValue) {
            
            handler();
            
        }];
        
    }
    
}

- (void)requestMoreSelectedIndexData:(void (^)(void))handler
{
    
    if (!handler) {handler = ^{};}
    
    if (selectedIndex == 0) {
        
        int curPage = [[jiangjiaInfo objectForKey:@"curPage"] integerValue];
        int requestPage = curPage + 1;
        
        [SBBuyCarVCInterface requestLowPriceActivities:nil pageSize:0 pageIndex:requestPage isCache:YES successBlock:^(id successValue) {
            
            [self refreshDataSet:jiangjiaInfo value:successValue page:requestPage];
            [jiangJiaTbView reloadWithData:jiangjiaInfo];
            handler();
            
        } andFailBlock:^(id failValue) {
            
            handler();
            
        }];
    }
    
    else if (selectedIndex == 2) {
        
        int curPage = [[pinxingInfo objectForKey:@"curPage"] integerValue];
        int requestPage = curPage + 1;
        
        [SBBuyCarVCInterface requestPinxingCar:nil pageSize:0 pageIndex:requestPage successBlock:^(id successValue) {
            
            [self refreshDataSet:pinxingInfo value:successValue];
            [pinxingCheTbView reloadWithData:pinxingInfo];
            handler();
            
        } andFailBlock:^(id failValue) {
            handler();
        }];
        
    }
    
    else if (selectedIndex == 1) {
        
        int curPage = [[ershouInfo objectForKey:@"curPage"] integerValue];
        int requestPage = curPage + 1;
        
        [SBBuyCarVCInterface requestUsedCar:nil pageSize:0 pageIndex:requestPage successBlock:^(id successValue) {
            
            [self refreshDataSet:ershouInfo value:successValue page:requestPage];
            [ershouCheTbView reloadWithData:ershouInfo];
            handler();
            
        } andFailBlock:^(id failValue) {
            
            handler();
            
        }];
        
    }
    
}

- (void)refreshDataSet:(NSMutableDictionary *)dic value:(id)value
{
    [dic setObject:[NSMutableArray arrayWithArray:value] forKey:@"data"];
    [dic setObject:[NSNumber numberWithInt:1] forKey:@"curPage"];
}

- (void)refreshDataSet:(NSMutableDictionary *)dic value:(id)value page:(int)page
{
    NSMutableArray *array = [dic objectForKey:@"data"];
    [array addObjectsFromArray:value];
    [dic setObject:[NSNumber numberWithInt:page] forKey:@"curPage"];
}

#pragma - mark 辅助函数
- (BKDatasTblView *)createTbview:(Class)class
{
    BKDatasTblView *tbView = [[BKDatasTblView alloc] initWithFrame:CGRectMake(0, [ITUIKitHelper yMarTopView:segmentedControl margin:7 * PJSA], self.view.frame.size.width, self.cotentSize.height - [ITUIKitHelper yMarTopView:segmentedControl margin:7 * PJSA] - TABBAR_HEIGHT) updateType:BKUpdateTableViewTypePlain cellClass:class];
    tbView.pullUpdateDelegate = self;
    tbView.processingDelegate = self;
    [self insertSubview:tbView belowContentSubview:menuView];
    return tbView;
}

- (void)showTableViewWithIndex
{
    jiangJiaTbView.hidden = YES;
    ershouCheTbView.hidden = YES;
    pinxingCheTbView.hidden = YES;
    
    if (selectedIndex == 0) {jiangJiaTbView.hidden = NO;curTbView = jiangJiaTbView;}
    else if (selectedIndex == 1) {pinxingCheTbView.hidden = NO;curTbView = pinxingCheTbView;}
    else {ershouCheTbView.hidden = NO;curTbView = ershouCheTbView;}
    
}

@end
