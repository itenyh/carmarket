//
//  SBPinXingViewController.m
//  carmarket
//
//  Created by itensb on 14-11-20.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBPinXingViewController.h"

#import "SBPinXingLowPriceCarInfoTblCell.h"

@interface SBPinXingViewController ()

@end

@implementation SBPinXingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)request_data
{
    NSDictionary *InfoDic = [[SBRequestParamBus instance] getParamWith:self key:@"info"];
    
    [SBBuyCarVCInterface requestPinxingCarDetail:[InfoDic objectForKey:@"pid"] successBlock:^(id successValue) {
        
//        [infos setObject:successValue forKey:@"data"];
        [infos setObject:InfoDic forKey:@"oldData"];
        
        NSDictionary *dealerDic = [successValue objectForKey:@"dealer"];
        NSDictionary *parallercarDic = [successValue objectForKey:@"parallercar"];
        
        if(dealerDic) [infos setObject:dealerDic forKey:@"dealer"];
        if(parallercarDic) [infos setObject:parallercarDic forKey:@"data"];
        
        [tbView reloadData];
        
    } andFailBlock:^(id failValue) {
        
    }];
}

#pragma - mark TableView代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        NSString *cid = @"1id";
        SBPinXingLowPriceCarInfoTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBPinXingLowPriceCarInfoTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:infos];
        return cell;
        
    }
    
    else if (indexPath.row == 1) {
        
        NSString *id2 = @"c2";
        SBDetailInfoDealerInfoTblCell *cell = [tableView dequeueReusableCellWithIdentifier:id2];
        if (!cell) cell = [[SBDetailInfoDealerInfoTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id2];
        [cell display:[infos objectForKey:@"dealer"]];
        return cell;
        
    }
    
    else {
        
        NSString *id2 = @"c3";
        SBDetailInfoOtherInfoTblCell *cell = [tableView dequeueReusableCellWithIdentifier:id2];
        if (!cell) cell = [[SBDetailInfoOtherInfoTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id2];
        [cell display:[infos objectForKey:@"dealer"]];
        return cell;
        
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return [SBPinXingLowPriceCarInfoTblCell getHeight:[infos objectForKey:@"data"]];
    else if (indexPath.row == 1) return [SBDetailInfoDealerInfoTblCell getHeight:nil];
    else {
        NSDictionary *dealerDict = [[SBRequestParamBus instance] getParamWith:self key:@"dealerInfo"];
        return [SBDetailInfoOtherInfoTblCell getHeight:dealerDict];
    }
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
