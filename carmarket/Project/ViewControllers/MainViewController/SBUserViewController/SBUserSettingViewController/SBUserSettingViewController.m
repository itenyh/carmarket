//
//  SBUserSettingViewController.m
//  carmarket
//
//  Created by itensb on 14-8-20.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBUserSettingViewController.h"
#import "BKUpdateTableView.h"

#import "SBUserSettingSwitcherTblCell.h"
#import "SBUserSettingCachClearTblCell.h"
#import "SBUserSettingArrayTblCell.h"

@interface SBUserSettingViewController () <UITableViewDataSource, BKUpdateTableViewDelegate, BKUpdateTableViewProcessingDelegate>
{
    BKUpdateTableView *tbView;
}
@end

@implementation SBUserSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitleWithImage:[UIImage imageNamed:@"icon_titleshezhi"]];
    
    tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.cotentSize.height) style:UITableViewStyleGrouped updateType:BKUpdateTableViewTypeNoUpdate];
    tbView.dataSource = self;
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
        
        if (indexPath.row == 0) {
            
            static NSString *cid = @"1id";
            SBUserSettingSwitcherTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
            if (!cell) cell = [[SBUserSettingSwitcherTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
            [cell displayWithTilte:@"夜间模式"];
            
            return cell;
        }
        
        else if (indexPath.row == 1) {
            
            static NSString *cid = @"2id";
            SBUserSettingSwitcherTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
            if (!cell) cell = [[SBUserSettingSwitcherTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
            [cell displayWithTilte:@"非wifi时浏览小尺寸图"];
            
            return cell;
            
        }
        
        else {
            
            static NSString *cid = @"3id";
            SBUserSettingCachClearTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
            if (!cell) cell = [[SBUserSettingCachClearTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
            [cell displayWithTilte:@"图片缓存" cache:@"123"];
            
            return cell;

            
        }
        
    }
    
    else {
        
        static NSString *cid = @"4id";
        SBUserSettingArrayTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBUserSettingArrayTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        if (indexPath.row == 0) [cell displayWithTilte:@"检查新版本"];
        if (indexPath.row == 1) [cell displayWithTilte:@"感觉不错，来个评分吧！"];
        if (indexPath.row == 2) [cell displayWithTilte:@"意见反馈"];
        if (indexPath.row == 3) [cell displayWithTilte:@"手机掌上车"];
        if (indexPath.row == 4) [cell displayWithTilte:@"关于"];
        
        return cell;
        
    }

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 3;
    else return 5;
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SBUserSettingBaseTblCell getHeight:nil];
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
