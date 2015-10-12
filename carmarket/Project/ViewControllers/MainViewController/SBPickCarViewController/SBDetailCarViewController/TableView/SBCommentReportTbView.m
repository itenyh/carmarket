//
//  SBCommentReportTbView.m
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCommentReportTbView.h"
#import "SBDetailCarInfoViewController.h"
#import "SBAppDelegate.h"
#import "SBCarCommentGoodOrBadTblCell.h"
#import "SBCarCommentPlainTextTblCell.h"

@implementation SBCommentReportTbView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
    }
    
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        static NSString *cid = @"c1";
        SBCarCommentGoodOrBadTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBCarCommentGoodOrBadTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:nil];
        
        return cell;
        
    }
    
    else {
        
        static NSString *cid = @"c2";
        SBCarCommentPlainTextTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBCarCommentPlainTextTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:nil];
        
        return cell;
        
    }
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 55 * PJSAH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return [SBCarCommentGoodOrBadTblCell getHeight:nil];
    else return [SBCarCommentPlainTextTblCell getHeight:nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], 55 * PJSAH)];
    view.backgroundColor = [ITUIKitHelper color:245 blue:245 green:245 alpha:1];
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, [ITUIKitHelper getAppWidth] - 20, 55 * PJSAH)];
    l.font = [UIFont systemFontOfSize:30 * PJSAH];
    l.textColor = [ITUIKitHelper color:@"5f5f5f"];
    [view addSubview:l];
    
    l.text = @"热门品牌";
    
    return view;
}

@end
