//
//  SBUserInfoViewController.m
//  carmarket
//
//  Created by itensb on 14-8-20.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBUserInfoViewController.h"
#import "BKUpdateTableView.h"

#import "SBColoredBtnTblCell.h"
#import "SBUserInfoInputTblCell.h"
#import "SBUserInfoDetailTblCell.h"

#import "SBUserDataInterface.h"
#import "SBUserSettingArrayTblCell.h"
#import "SBPsModifyViewController.h"

@interface SBUserInfoViewController () <BKUpdateTableViewDelegate, BKUpdateTableViewProcessingDelegate, UITableViewDataSource>
{
    BKUpdateTableView *tbView;
}
@end

@implementation SBUserInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的资料";
    
    tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.cotentSize.height) style:UITableViewStyleGrouped updateType:BKUpdateTableViewTypeNoUpdate];
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.processingDelegate = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubviewInContentView:tbView];
    
}

#pragma - mark TableView代理
- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        NSDictionary *info = [SBUserDataInterface getInfo];
        
        NSString *cid = @"1id";
        SBUserInfoDetailTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBUserInfoDetailTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:info];
        
        return cell;
        
    }
    
    else if (indexPath.section == 1) {
        
        NSDictionary *info = [SBUserDataInterface getInfo];
        
        NSString *cid = @"2id";
        SBUserInfoInputTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBUserInfoInputTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        if (indexPath.row == 0) [cell display:[info objectForKey:@"userGrade"] title:@"等  级"];
        if (indexPath.row == 1) [cell display:[info objectForKey:@"email"] title:@"Email"];
        if (indexPath.row == 2) [cell display:[info objectForKey:@"userPhone"] title:@"电  话"];
        
        return cell;
        
    }
    
    else if (indexPath.section == 2) {
        
        NSString *cid = @"3id";
        SBUserSettingArrayTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBUserSettingArrayTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell displayWithTilte:@"修改密码"];
        
        return cell;
    }
    
    else {
        
        NSString *cid = @"4id";
        SBColoredBtnTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBColoredBtnTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:nil title:@"注销" type:3];
        return cell;
        
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 1;
    else if (section == 1) return 3;
    else if (section == 2) return 1;
    else return ([SBUserDataInterface isLogging] ? 1 : 0);
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return [SBUserInfoDetailTblCell getHeight:nil];
    else if (indexPath.section == 1) return [SBUserInfoInputTblCell getHeight:nil];
    else if (indexPath.section == 2) return [SBUserSettingArrayTblCell getHeight:nil];
    else return [SBColoredBtnTblCell getHeight:nil];
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        
        SBPsModifyViewController *vc = [[SBPsModifyViewController alloc] initWithNavi:YES];
        [self push_rootNaviController:vc animated:YES];
        
    }
}

#pragma - mark 其他代理
- (void)SBUserInfoLogOutTblCell_LogOut:(SBaseTableViewCell *)cell
{
    [SBUserDataInterface logOut];
    [self showInfoMessageOnCenter:@"注销成功"];
    [self performSelector:@selector(popViewController) withObject:nil afterDelay:1];
}


@end
