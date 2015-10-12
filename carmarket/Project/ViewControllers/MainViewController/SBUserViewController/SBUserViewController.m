//
//  SBUserViewController.m
//  carmarket
//
//  Created by itensb on 14-8-15.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBUserViewController.h"
#import "BKUpdateTableView.h"

#import "SBUserInfoSectionView.h"
#import "SBUserMenuPanelTblCell.h"

#import "SBActivityViewController.h"
#import "SBUserBrowseHistoryViewController.h"
#import "SBUserSettingViewController.h"
#import "SBUserInfoViewController.h"

#import "SBUserDataInterface.h"

#import "SBPickCarVCInterface.h"
#import "SBActivityVCinterface.h"

#import "SBPunishViewController.h"
#import "SBGoOutViewController.h"
#import "SBGoOutListViewController.h"
#import "SBFastNaviListViewController.h"
#import "SBXLogViewController.h"
#import "SBCarCompareViewController.h"
#import "SBBuyCarCaculatorViewController.h"

#import "SBLocationPickViewController.h"

#import "UIImage+ITColorImage.h"

@interface SBUserViewController () <UITableViewDataSource, BKUpdateTableViewDelegate, BKUpdateTableViewProcessingDelegate>
{
    BKUpdateTableView *tbView;
}
@end

@implementation SBUserViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [tbView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitleWithImage:[UIImage imageNamed:@"icon_titlewode"]];
 
    tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.cotentSize.height - TABBAR_HEIGHT) style:UITableViewStylePlain updateType:BKUpdateTableViewTypeNoUpdate];
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.processingDelegate = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbView.bounces = NO;
    tbView.showsVerticalScrollIndicator = NO;
    [self addSubviewInContentView:tbView];
    
    [ITBaseInterface requestVersionCheckWithAppId:APP_ID andSuccessBlock:^(id successValue) {
        
        [self createNewVersionCreateBtn:^(id sender) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_STORE_ADD]];
        }];
        
    } andFailBlock:^(id failValue) {
        
    }];
    
//    [self createSettingBtn:^(id sender) {
//        [self push_rootNaviController:[[SBUserSettingViewController alloc] initWithNavi:YES] animated:YES];
//    }];
 
}

#pragma - mark TableView代理
- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return [SBUserInfoSectionView getHeight:nil];
    else return 0.1;
}

- (UIView *)BKUpdateTableView:(BKUpdateTableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        SBUserInfoSectionView *view = [SBUserInfoSectionView new];
        [view displayWithInfo:[SBUserDataInterface getInfo]];
        return view;
    }

    else return nil;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cid = @"3id";
    SBUserMenuPanelTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
    if (!cell) cell = [[SBUserMenuPanelTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
    [cell display:nil];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 0;
    else return 1;
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return 0;
    else return [SBUserMenuPanelTblCell getHeight:nil];
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma - mark 代理函数
- (void)SBUserMenuPanelTblCell_Button:(UIButton *)b
{
    switch (b.tag) {
        case 0:
            [self push_rootNaviController:[[SBActivityViewController alloc] initWithNavi:YES] animated:YES];
            break;
        case 1:
            [self push_rootNaviController:[[SBPunishViewController alloc] initWithNavi:YES] animated:YES];
            break;
        case 2:
            [self push_rootNaviController:[[SBGoOutListViewController alloc] initWithNavi:YES] animated:YES];
            break;
        case 3:
            [self push_rootNaviController:[[SBFastNaviListViewController alloc] initWithNavi:YES] animated:YES];
            break;
        case 4:
            [self push_rootNaviController:[[SBBuyCarCaculatorViewController alloc] initWithNavi:YES] animated:YES];
            break;
        case 5:
            [self push_rootNaviController:[[SBCarCompareViewController alloc] initWithNavi:YES] animated:YES];
            break;
        default:
            break;
    }
}

- (void)SBUserInfoSectionView_head:(id)sender
{
    if (![SBUserDataInterface isLogging]) [self push_rootNaviController:[[SBXLogViewController alloc] initWithNavi:YES leftBtnType:NDLeftBtnBack] animated:YES];
    else [self push_rootNaviController:[[SBUserInfoViewController alloc] initWithNavi:YES] animated:YES];
}

- (void)SBUserInfoSectionView_log:(id)sender
{
    [self push_rootNaviController:[[SBXLogViewController alloc] initWithNavi:YES leftBtnType:NDLeftBtnBack] animated:YES];
}

@end
