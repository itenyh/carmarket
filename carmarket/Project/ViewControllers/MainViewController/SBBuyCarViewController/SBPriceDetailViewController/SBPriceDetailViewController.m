//
//  SBPriceDetailViewController.m
//  carmarket
//
//  Created by Apple on 14-8-17.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBPriceDetailViewController.h"
#import "SBCarArgViewController.h"

@interface SBPriceDetailViewController () <BKUpdateTableViewDelegate, BKUpdateTableViewProcessingDelegate, UITableViewDataSource>
{
    BOOL showConcrete;
}
@end

@implementation SBPriceDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self setTitleWithImage:[UIImage imageNamed:@"icon_titlejiangjiaxiangqing"]];
    self.title = @"购车详情";
    
    infos = [NSMutableDictionary dictionary];
    showConcrete = YES;
    
    SBLowPriceBottomMenu *bottomMenu = [[SBLowPriceBottomMenu alloc] initWithFrame:CGRectMake(0, self.cotentSize.height - 115 * PJSAH, [ITUIKitHelper getAppWidth], 115 * PJSAH) type:0 title:@""];
    [self addSubviewInContentView:bottomMenu];
    
    tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.cotentSize.height - 115 * PJSAH) style:UITableViewStylePlain updateType:BKUpdateTableViewTypeNoUpdate];
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.processingDelegate = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubviewInContentView:tbView];
    
    [self request_data];
    
}

- (void)request_data
{
    NSDictionary *InfoDic = [[SBRequestParamBus instance] getParamWith:self key:@"info"];
    NSString *acId = [InfoDic objectForKey:@"cutpriceInfoId"];
    if (!acId) acId = [InfoDic objectForKey:@"oldCarId"];
    
    [SBBuyCarVCInterface requestLowPriceActivityDetail:acId successBlock:^(id successValue) {
        
        [infos setObject:successValue forKey:@"data"];
        [infos setObject:InfoDic forKey:@"oldData"];
        [tbView reloadData];
        
    } andFailBlock:^(id failValue) {
        
    }];
    
    [SBBuyCarVCInterface requestDealerInfo:[InfoDic objectForKey:@"dealerId"] successBlock:^(id successValue) {
        
        [infos setObject:successValue forKey:@"dealer"];
        [tbView reloadData];
        
    } andFailBlock:^(id failValue) {
        
    }];
}

#pragma - mark TableView代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        static NSString *cid = @"1id";
        SBLowPriceCarInfoTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBLowPriceCarInfoTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:infos];
        
        return cell;
    }
    
    else if (indexPath.section == 1) {
        
        static NSString *cid = @"2id";
        SBLowPriceConcreteTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBLowPriceConcreteTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        NSDictionary *data = [infos objectForKey:@"data"];
        if (data) [cell display:[[data objectForKey:@"carList"] objectAtIndex:indexPath.row] show:showConcrete];
        
        return cell;
    }
    
    else {
        
        if (indexPath.row == 0) {
            
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
        
//        if (indexPath.row == 0) {
//            
//            static NSString *cid = @"3id";
//            SBLowPriceStrechBtnTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
//            if (!cell) cell = [[SBLowPriceStrechBtnTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
//            [cell display:nil];
//            
//            return cell;
//        }
//        
//        else if(indexPath.row == 1) {
//            
//            static NSString *cid = @"4id";
//            SBLowPriceCarComTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
//            if (!cell) cell = [[SBLowPriceCarComTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
//            [cell display:infos];
//            
//            return cell;
//            
//        }
//        
//        else if(indexPath.row == 2) {
//            
//            static NSString *cid = @"5id";
//            SBLowPriceCarComNameTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
//            if (!cell) cell = [[SBLowPriceCarComNameTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
//            [cell display:infos];
//            
//            return cell;
//            
//        }
//            
//        else if(indexPath.row == 3) {
//            
//            static NSString *cid = @"6id";
//            SBLowPriceCarComAddTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
//            if (!cell) cell = [[SBLowPriceCarComAddTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
//            [cell display:infos];
//            
//            return cell;
//            
//        }
//    
//        else {
//            
//            static NSString *cid = @"7id";
//            SBLowPriceComTeleTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
//            if (!cell) cell = [[SBLowPriceComTeleTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
//            [cell display:infos];
//            
//            return cell;
//
//            
//        }
        
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) return 1;
    else if(section == 1) {
        NSDictionary *data = [infos objectForKey:@"data"];
        if (data) {
            NSArray *carList = [data objectForKey:@"carList"];
            if(carList) return carList.count; else return 0;
        }
        else return 0;
        
    }
    else return 2;
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) return [SBLowPriceCarInfoTblCell getHeight:[infos objectForKey:@"data"]];
    else if(indexPath.section == 1) return (showConcrete == YES ? [SBLowPriceConcreteTblCell getHeight:nil] : 0.001);
    else if(indexPath.section == 2 && indexPath.row == 0) return [SBDetailInfoDealerInfoTblCell getHeight:nil];
    else if(indexPath.section == 2 && indexPath.row == 1) return [SBDetailInfoOtherInfoTblCell getHeight:nil];
//    else if(indexPath.section == 2 && indexPath.row == 0) return [SBLowPriceStrechBtnTblCell getHeight:nil];
//    else if(indexPath.section == 2 && indexPath.row == 1) return [SBLowPriceCarComTblCell getHeight:nil];
//    else if(indexPath.section == 2 && indexPath.row == 2) return [SBLowPriceCarComNameTblCell getHeight:nil];
//    else if(indexPath.section == 2 && indexPath.row == 3) return [SBLowPriceCarComAddTblCell getHeight:nil];
//    else if(indexPath.section == 2 && indexPath.row == 4) return [SBLowPriceComTeleTblCell getHeight:nil];
    else return 0;
    
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma - mark 代理函数
- (void)SBLowPriceConcreteTblCell_askPrice:(SBaseTableViewCell *)cell
{
    [self push_rootNaviController:[[SBPriceConsultViewController alloc] initWithNavi:YES] animated:YES];
//    NSLog(@"%@",NSStringFromClass([cell class]));
}

- (void)SBLowPriceStrechBtnTblCell_strechBtn:(SBaseTableViewCell *)cell
{
    showConcrete = (showConcrete == YES ? NO : YES);
    [tbView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationTop];
//    NSLog(@"%@",NSStringFromClass([cell class]));
}

- (void)SBLowPriceBottomMenu_Button:(UIButton *)b
{

    //参数配置
    if (b.tag == 0) {
        
        NSDictionary *InfoDic = [[SBRequestParamBus instance] getParamWith:self key:@"info"];
        NSString *carStyleId = [InfoDic objectForKey:@"carStyleId"];
        NSString *carId;
        NSDictionary *tempDic = [infos objectForKey:@"data"];
        if (tempDic) carId = [tempDic objectForKey:@"carId"];
        
        SBCarArgViewController *vc = [[SBCarArgViewController alloc] initWithNavi:YES leftBtnType:NDLeftBtnClose];
        [self present_rootNaviController:vc animated:YES];
        
        if(carStyleId) {

            [[SBRequestParamBus instance] setParamWith:vc key:@"carStyle" value:carStyleId];
            [vc requestNetWork];
            
        }
        
        else if(carId) {

            [[SBRequestParamBus instance] setParamWith:vc key:@"carStyle" value:carId];
            [vc requestNetWork];
            
        }
        
    }
    
    else if (b.tag == 1) {
        
        NSDictionary *InfoDic = [[SBRequestParamBus instance] getParamWith:self key:@"info"];
        NSString *phoneNum = [InfoDic objectForKey:@"dealerPhone"];
        if(phoneNum) [ITUtils dialPhoneNumber:phoneNum];
        
    }
    
    //询问底价
    else {
        
    }
}

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
