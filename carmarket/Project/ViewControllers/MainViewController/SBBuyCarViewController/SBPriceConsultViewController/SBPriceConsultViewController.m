//
//  SBPriceConsultViewController.m
//  carmarket
//
//  Created by itensb on 14-8-14.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBPriceConsultViewController.h"
#import "BKUpdateTableView.h"

#import "SBConsultTipTblCell.h"
#import "SBConsultContactInfoTblCell.h"
#import "SBSubmitTblCell.h"

@interface SBPriceConsultViewController () <UITableViewDataSource, BKUpdateTableViewDelegate, BKUpdateTableViewProcessingDelegate>

@end

@implementation SBPriceConsultViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"询问底价";
    
    BKUpdateTableView *tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.cotentSize.height) style:UITableViewStylePlain updateType:BKUpdateTableViewTypeNoUpdate];
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.processingDelegate = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubviewInContentView:tbView];
}

#pragma - mark TableView代理
- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        static NSString *cid = @"1id";
        SBConsultTipTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBConsultTipTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:nil];
        
        return cell;
    }
    
    else if (indexPath.row == 1) {
        static NSString *cid = @"2id";
        SBConsultContactInfoTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBConsultContactInfoTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:nil];
        
        return cell;
    }
    
    else {
        static NSString *cid = @"3id";
        SBSubmitTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBSubmitTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:nil];
        
        return cell;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) return [SBConsultTipTblCell getHeight:nil];
    else if(indexPath.row == 1) return [SBConsultContactInfoTblCell getHeight:nil];
    return [SBSubmitTblCell getHeight:nil];
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
