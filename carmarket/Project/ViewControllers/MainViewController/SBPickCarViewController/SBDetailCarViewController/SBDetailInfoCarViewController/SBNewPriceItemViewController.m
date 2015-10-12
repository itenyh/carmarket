//
//  SBNewPriceItemViewController.m
//  carmarket
//
//  Created by itensb on 14-8-20.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBNewPriceItemViewController.h"
#import "BKUpdateTableView.h"

#import "SBDetailInfoNewPriceCarInfoTblCell.h"
#import "SBDetailInfoDealerInfoTblCell.h"
#import "SBDetailInfoOtherInfoTblCell.h"

#import "SBWebViewController.h"

#import "SBMapViewController.h"

@interface SBNewPriceItemViewController () <BKUpdateTableViewDelegate, BKUpdateTableViewProcessingDelegate, UITableViewDataSource>
{
    
}
@end

@implementation SBNewPriceItemViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *dealerDict = [[SBRequestParamBus instance] getParamWith:self key:@"dealerInfo"];
    self.title = [dealerDict objectForKey:@"dealerName"];
    
    BKUpdateTableView *tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.cotentSize.height) style:UITableViewStylePlain updateType:BKUpdateTableViewTypeNoUpdate];
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.processingDelegate = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubviewInContentView:tbView];
}

#pragma - mark tableDelegate
- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return [SBDetailInfoNewPriceCarInfoTblCell getHeight:nil];
    else if (indexPath.row == 1) return [SBDetailInfoDealerInfoTblCell getHeight:nil];
    else {
        NSDictionary *dealerDict = [[SBRequestParamBus instance] getParamWith:self key:@"dealerInfo"];
        return [SBDetailInfoOtherInfoTblCell getHeight:dealerDict];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == 0) {
        
        NSDictionary *carStyleDict = [[SBRequestParamBus instance] getParamWith:self key:@"carStyleInfo"];
        NSMutableDictionary *carInfo = [NSMutableDictionary dictionaryWithDictionary:carStyleDict];
        
        NSDictionary *carModelDict = [[SBRequestParamBus instance] getParamWith:self key:@"carModelInfo"];
        [carInfo setObject:carModelDict forKey:@"carModelInfo"];
        
        NSString *id2 = @"c1";
        SBDetailInfoNewPriceCarInfoTblCell *cell = [tableView dequeueReusableCellWithIdentifier:id2];
        if (!cell) cell = [[SBDetailInfoNewPriceCarInfoTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id2];
        [cell display:carInfo];
        return cell;
        
    }
    
    else if (indexPath.row == 1) {
        
        NSDictionary *dealerDict = [[SBRequestParamBus instance] getParamWith:self key:@"dealerInfo"];
        
        NSString *id2 = @"c2";
        SBDetailInfoDealerInfoTblCell *cell = [tableView dequeueReusableCellWithIdentifier:id2];
        if (!cell) cell = [[SBDetailInfoDealerInfoTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id2];
        [cell display:dealerDict];
        return cell;
        
    }
    
    else {
        
        NSDictionary *dealerDict = [[SBRequestParamBus instance] getParamWith:self key:@"dealerInfo"];
        
        NSString *id2 = @"c3";
        SBDetailInfoOtherInfoTblCell *cell = [tableView dequeueReusableCellWithIdentifier:id2];
        if (!cell) cell = [[SBDetailInfoOtherInfoTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id2];
        [cell display:dealerDict];
        return cell;
        
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma - mark 其他代理
- (void)SBDetailInfoDealerInfoTblCell_Button:(UIButton *)btn Cell:(SBaseTableViewCell *)cell
{
    NSDictionary *cellDict = cell.info;
    if(!cellDict) {
        [self showErrorMessageOnCenter:@"无相关数据"];
        return;
    }
    
    if (btn.tag == 0) {
        NSString *phoneNum = [cellDict objectForKey:@"dealerPhone"];
        if (phoneNum) [ITUtils dialPhoneNumber:phoneNum];
    }
    
    else {
        SBMapViewController *mpVC = [[SBMapViewController alloc] initWithNavi:YES leftBtnType:NDLeftBtnBack];
        mpVC.passedTitle = @"商家地图";
        [[SBRequestParamBus instance] setParamWith:mpVC key:@"dealerInfo" value:cellDict];
//        [self present_rootNaviController:mpVC animated:YES];
        [self push_rootNaviController:mpVC animated:YES];
    }
}

- (void)SBDetailInfoDealerInfoTblCell:(SBaseTableViewCell *)cell weburl:(NSString *)url
{
    SBWebViewController *vc = [[SBWebViewController alloc] initWithNavi:YES];
    vc.passedTitle = [cell.info objectForKey:@"dealerName"];
    vc.url = [NSURL URLWithString:url];
    [self push_rootNaviController:vc animated:YES];
    
}

@end
