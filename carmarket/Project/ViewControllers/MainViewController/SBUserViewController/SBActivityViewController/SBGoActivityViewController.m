//
//  SBGoActivityViewController.m
//  carmarket
//
//  Created by itensb on 14-8-19.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBGoActivityViewController.h"
#import "SBColoredBottomView.h"
#import "SBXLogViewController.h"

#import "SBActivityVCInterface.h"
#import "SBUserDataInterface.h"

#import "BKUpdateTableView.h"
#import "SBGoActivityTblCell.h"

#import <AMapSearchKit/AMapSearchAPI.h>

@interface SBGoActivityViewController () <BKUpdateTableViewDelegate, BKUpdateTableViewProcessingDelegate, UITableViewDataSource, AMapSearchDelegate, UIAlertViewDelegate>
{
    UILabel *title;
    UILabel *content;
    
    SBColoredBottomView *baomingBtn;
    SBColoredBottomView *quxiaoBtn;
    SBColoredBottomView *shanchuBtn;
    
    BKUpdateTableView *tbView;
    
    NSDictionary *info;
    
}
@end

@implementation SBGoActivityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"活动详情";
    
    info = [NSDictionary dictionary];
    
    [self createNaviCreateBtn:^(id sender) {[self startSearch];}];
    
    float bottomPanelHeight = 50;
    
    tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.cotentSize.height- 112 * PJSAH) style:UITableViewStylePlain updateType:BKUpdateTableViewTypeNoUpdate];
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.processingDelegate = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubviewInContentView:tbView];
    
    UIView *bottomPanel = [[UIView alloc] initWithFrame:CGRectMake(0, self.cotentSize.height - bottomPanelHeight, [ITUIKitHelper getAppWidth], bottomPanelHeight)];
    //    bottomPanel.backgroundColor = TEST_BGCOLOR;
    [self addSubviewInContentView:bottomPanel];
    
    baomingBtn = [[SBColoredBottomView alloc] initWithType:3 view:self.contentView];
    [baomingBtn.btn addTarget:self action:@selector(baomingClick:) forControlEvents:UIControlEventTouchUpInside];
    [baomingBtn setTitle:@"我要报名"];
    baomingBtn.hidden = YES;
    [self addSubviewInContentView:baomingBtn];
    
    quxiaoBtn = [[SBColoredBottomView alloc] initWithType:2 view:self.contentView];
    [quxiaoBtn.btn addTarget:self action:@selector(baomingClick:) forControlEvents:UIControlEventTouchUpInside];
    quxiaoBtn.hidden = YES;
    [quxiaoBtn setTitle:@"取消报名"];
    [self addSubviewInContentView:quxiaoBtn];
    
    shanchuBtn = [[SBColoredBottomView alloc] initWithType:3 view:self.contentView];
    [shanchuBtn.btn addTarget:self action:@selector(baomingClick:) forControlEvents:UIControlEventTouchUpInside];
    shanchuBtn.hidden = YES;
    [shanchuBtn setTitle:@"删除活动"];
    [self addSubviewInContentView:shanchuBtn];
    
    [self ini_data];
}

- (void)ini_data
{
    NSDictionary *_info = [[SBRequestParamBus instance] getParamWith:self key:@"info"];
    [SBActivityVCInterface requestActivityDetail:[SBUserDataInterface getUserId] actionId:[_info objectForKey:@"actionId"] successBlock:^(id successValue) {
        
        info = successValue;
        [tbView reloadData];
        
        NSString *isEnter = [successValue objectForKey:@"isEnter"];
        NSString *uid = [successValue objectForKey:@"userId"];
        
        //是自己发起的活动
        if (uid && [uid intValue] == [[SBUserDataInterface getUserId] integerValue]) {
            shanchuBtn.hidden = NO;
        }
        
        else {
            if (isEnter && [isEnter intValue] == 1) {
                baomingBtn.hidden = YES;
                quxiaoBtn.hidden = NO;
            }
            else {
                baomingBtn.hidden = NO;
                quxiaoBtn.hidden = YES;
            }
        }
        
    } andFailBlock:^(id failValue) {
        
    }];
}

#pragma - mark TableView代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cid = @"id";
    SBGoActivityTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
    if (!cell) cell = [[SBGoActivityTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
    [cell display:info];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SBGoActivityTblCell getHeight:info];
}


- (void)baomingClick:(id)sender
{
    NSDictionary *_info = [[SBRequestParamBus instance] getParamWith:self key:@"info"];
    
    //报名
    if (sender == baomingBtn.btn) {
        
        if (![SBUserDataInterface isLogging]) [self push_rootNaviController:[[SBXLogViewController alloc] initWithNavi:YES handler:^(NSDictionary *info) {
            
            [self ini_data];
            
        } leftBtnType:NDLeftBtnBack] animated:YES];
        
        else {
            
            [SBActivityVCInterface requestActivityApply:[SBUserDataInterface getUserId] actionId:[_info objectForKey:@"actionId"] successBlock:^(id successValue) {
                
                if ([[successValue objectForKey:@"state"] integerValue] == 1) {
                    baomingBtn.hidden = YES;
                    quxiaoBtn.hidden = NO;
                    [self showInfoMessageOnCenter:@"报名成功"];
                }
                
                else [self showErrorMessageOnCenter:[successValue objectForKey:@"message"]];
                
            } andFailBlock:^(id failValue) {
                
                [self showInfoMessageOnCenter:@"报名失败"];
                
            }];
            
        }
        
    }
    
    //删除活动
    else if (sender == shanchuBtn.btn) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认要删除此活动?" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.delegate = self;
        [alertView show];
    }
    
    //取消
    else {
        
        [SBActivityVCInterface requestActivityCancel:[SBUserDataInterface getUserId] actionId:[_info objectForKey:@"actionId"] successBlock:^(id successValue) {
            
            if ([[successValue objectForKey:@"state"] integerValue] == 1) {
                baomingBtn.hidden = NO;
                quxiaoBtn.hidden = YES;
                [self showInfoMessageOnCenter:@"取消成功"];
            }
            
            else [self showErrorMessageOnCenter:[successValue objectForKey:@"message"]];
            
        } andFailBlock:^(id failValue) {
            
            [self showErrorMessageOnCenter:@"取消失败"];
            
        }];
        
    }
}

#pragma - mark 导航部分
- (void)startSearch
{

    NSString *site_posStr = [info objectForKey:@"site_longitudeAndLatitude"]; //经纬
    NSArray *site_posStrs = [site_posStr componentsSeparatedByString:@","];
    if (site_posStrs.count == 2) {
        double x = [[site_posStrs objectAtIndex:0] doubleValue];
        double y = [[site_posStrs objectAtIndex:1] doubleValue];
        
        [self showLoading];
        
        [[ITMapper instance] naviDriveRouteWithEndPoints:x latitude:y drivingStrategy:0 response:^(AMapNaviManager *naviManager) {
            [self stopLoading];
        } fail:^(AMapNaviManager *naviManager) {
            [self showErrorMessageOnCenter:@"导航加载失败"];
            [self stopLoading];
        } finish:^(AMapNaviManager *naviManager) {
            
        }];
        
    }
    
}

#pragma - mark AlertView Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSDictionary *_info = [[SBRequestParamBus instance] getParamWith:self key:@"info"];
    
    if (buttonIndex == 1) {
        
        [SBActivityVCInterface requestDeleteActivity:[SBUserDataInterface getUserId] actionId:[_info objectForKey:@"actionId"] successBlock:^(id successValue) {
            
            if ([[successValue objectForKey:@"state"] integerValue] == 1) {
                [self showInfoMessageOnCenter:@"删除成功"];
                [self performSelector:@selector(popViewController) withObject:nil afterDelay:1];
            }
            
            else [self showErrorMessageOnCenter:[successValue objectForKey:@"message"]];
            
        } andFailBlock:^(id failValue) {
            
            [self showErrorMessageOnCenter:@"删除失败"];
            
        }];
        
    }
}

@end
