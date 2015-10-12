//
//  SBSecondCarViewController.m
//  carmarket
//
//  Created by Apple on 14-9-23.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBSecondCarViewController.h"
#import "SBBuyCarVCInterface.h"

#import "BKUpdateTableView.h"

#import "SBSecondCarCarInfoTblCell.h"
#import "SBSecondCarMorePicTblCell.h"
#import "SBSecondCarOtherInfoTblCell.h"
#import "SBSecondCarComSayTblCell.h"

#import "SBLowPriceBottomMenu.h"
#import "SBCarArgViewController.h"

@interface SBSecondCarViewController () <BKUpdateTableViewDelegate, BKUpdateTableViewProcessingDelegate, UITableViewDataSource>
{
    BKUpdateTableView *tbView;
    
    NSMutableDictionary *infos;
}
@end

@implementation SBSecondCarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"二手车详情";
    
    infos = [NSMutableDictionary dictionary];
    
    tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.cotentSize.height - 115 * PJSAH) style:UITableViewStylePlain updateType:BKUpdateTableViewTypeNoUpdate];
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.processingDelegate = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubviewInContentView:tbView];
    
    SBLowPriceBottomMenu *bottomMenu = [[SBLowPriceBottomMenu alloc] initWithFrame:CGRectMake(0, self.cotentSize.height - 115 * PJSAH, [ITUIKitHelper getAppWidth], 115 * PJSAH) type:0 title:@"电话咨询"];
    [self addSubviewInContentView:bottomMenu];
    
    NSDictionary *InfoDic = [[SBRequestParamBus instance] getParamWith:self key:@"info"];
    NSString *oldCarId = [InfoDic objectForKey:@"oldCarId"];
    
    [SBBuyCarVCInterface requestUsedCarDetail:oldCarId successBlock:^(id successValue) {
       
        [infos setObject:successValue forKey:@"data"];
        [infos setObject:InfoDic forKey:@"oldData"];
        [tbView reloadData];
        
    } andFailBlock:^(id failValue) {
        
    }];
    
}

#pragma - mark TableView代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        NSString *cid = @"1id";
        SBSecondCarCarInfoTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBSecondCarCarInfoTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:infos];
        return cell;
        
    }
    
    else if(indexPath.row == 1) {
        
        NSString *cid = @"2id";
        SBSecondCarMorePicTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBSecondCarMorePicTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:infos];
        return cell;
        
    }
    
    else if(indexPath.row == 2) {
        
        NSString *cid = @"3id";
        SBSecondCarOtherInfoTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBSecondCarOtherInfoTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:infos];
        return cell;
        
    }
    
    else {
        
        NSString *cid = @"4id";
        SBSecondCarComSayTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBSecondCarComSayTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:infos];
        return cell;
        
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) return [SBSecondCarCarInfoTblCell getHeight:[infos objectForKey:@"data"]];
    else if(indexPath.row == 1) return [SBSecondCarMorePicTblCell getHeight:infos];
    else if(indexPath.row == 2) return [SBSecondCarOtherInfoTblCell getHeight:nil];
    else return [SBSecondCarComSayTblCell getHeight:infos];
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma - mark  其他代理
- (void)SBLowPriceBottomMenu_Button:(UIButton *)b
{
    //参数配置
    if (b.tag == 0) {
        
        NSDictionary *InfoDic = [[SBRequestParamBus instance] getParamWith:self key:@"info"];
        NSString *carStyleId = [InfoDic objectForKey:@"carStyleId"];
        if(carStyleId) {
            
            SBCarArgViewController *vc = [[SBCarArgViewController alloc] initWithNavi:YES leftBtnType:NDLeftBtnClose];
            [self present_rootNaviController:vc animated:YES];
        
            [[SBRequestParamBus instance] setParamWith:vc key:@"carStyle" value:carStyleId];
            [vc requestNetWork];
            
        }
        
    }
    
    else if (b.tag == 1) {
        
        NSDictionary *InfoDic = [[SBRequestParamBus instance] getParamWith:self key:@"info"];
        NSString *phoneNum = [InfoDic objectForKey:@"createPhone"];
        if(phoneNum) [ITUtils dialPhoneNumber:phoneNum];
        
    }
    
    //询问底价
    else {
        
    }

}

@end
