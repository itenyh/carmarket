//
//  SBCarModelInfoViewController.m
//  carmarket
//
//  Created by itensb on 14-9-4.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCarModelInfoViewController.h"
#import "BKUpdateTableView.h"

#import "SBCarModelInfoTblCell.h"
#import "SBCarModelComPriceTblCell.h"

#import "SBYuFuViewController.h"

#import "SBBuyCarVCInterface.h"

@interface SBCarModelInfoViewController () <BKUpdateTableViewDelegate, BKUpdateTableViewProcessingDelegate, UITableViewDataSource>
{
    NSDictionary *info;
}

@end

@implementation SBCarModelInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"车型信息";
    
    info = [NSDictionary dictionary];
    
    BKUpdateTableView *tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.cotentSize.height) style:UITableViewStylePlain updateType:BKUpdateTableViewTypeNoUpdate];
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.processingDelegate = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubviewInContentView:tbView];
    
    NSDictionary *InfoDic = [[SBRequestParamBus instance] getParamWith:self key:@"info"];
    NSString *carId = [InfoDic objectForKey:@"oldCarId"];
    
    [SBBuyCarVCInterface requestUsedCarDetail:carId successBlock:^(id successValue) {
        
        NSLog(@"successValue : %@", successValue);
        info = successValue;
        [tbView reloadData];
        
    } andFailBlock:^(id failValue) {
        
    }];
    
}

#pragma - mark TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        static NSString *cid = @"1id";
        SBCarModelInfoTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBCarModelInfoTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:nil];
        
        return cell;
    }
    
    else {
        static NSString *cid = @"2id";
        SBCarModelComPriceTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBCarModelComPriceTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:nil];
        
        return cell;
    }
    
    return nil;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 1;
    else return 1;
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return [SBCarModelInfoTblCell getHeight:nil];
    else return [SBCarModelComPriceTblCell getHeight:nil];
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma - mark 代理函数
- (void)SBCarModelComPriceTblCell_askPrice:(SBCarModelComPriceTblCell *)cell Btn:(UIButton *)btn
{
    //预付
    if (btn.tag == 0) {
        SBYuFuViewController *yufu = [[SBYuFuViewController alloc] initWithNavi:YES];
        [self push_rootNaviController:yufu animated:YES];
    }
    
    //联系
    else {
        [ITUtils dialPhoneNumber:cell.dianhua.text];
    }
}


@end
