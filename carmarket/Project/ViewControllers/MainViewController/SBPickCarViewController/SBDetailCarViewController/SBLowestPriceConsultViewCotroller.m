//
//  SBLowestPriceConsultViewCotroller.m
//  carmarket
//
//  Created by itensb on 14-8-15.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBLowestPriceConsultViewCotroller.h"
#import "BKUpdateTableView.h"

#import "SBConsultCarNameTblCell.h"
#import "SBLowestPriceContactInfoTblCell.h"
#import "SBSubmitTblCell.h"
#import "SBLowestPriceComInfoTblCell.h"

#import "SBColoredBottomView.h"

@interface SBLowestPriceConsultViewCotroller () <UITableViewDataSource, BKUpdateTableViewDelegate, BKUpdateTableViewProcessingDelegate>
{
    
}
@end

@implementation SBLowestPriceConsultViewCotroller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"咨询最低价";
    
    SBColoredBottomView *bottomViewBtn = [[SBColoredBottomView alloc] initWithType:3 view:self.contentView];
    [bottomViewBtn setTitle:@"提交" handler:^(id sender) {
        [self showErrorMessageOnCenter:@"等待接口"];
    }];
    [self addSubviewInContentView:bottomViewBtn];
    
    BKUpdateTableView *tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.cotentSize.height - bottomViewBtn.frame.size.height) style:UITableViewStylePlain updateType:BKUpdateTableViewTypeNoUpdate];
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.processingDelegate = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubviewInContentView:tbView];
}

#pragma - mark TableView代理
- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)  return 0.1;
    else return 54 * PJSAH;
}


- (UIView *)BKUpdateTableView:(BKUpdateTableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) return nil;

    else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], 54 * PJSAH)];
        view.backgroundColor = [ITUIKitHelper color:@"ededed"];
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(27 * PJSAH, 0, 150, 54 * PJSAH)];
        l.textColor = [ITUIKitHelper color:@"828282"];
        l.font = [UIFont systemFontOfSize:30 * PJSAH];
        [view addSubview:l];
        l.backgroundColor = [UIColor clearColor];
        l.text = @"选择询价经销商";
        return view;
    }


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            static NSString *cid = @"1id";
            SBConsultCarNameTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
            if (!cell) cell = [[SBConsultCarNameTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
            [cell display:nil];
            
            return cell;
        }
        
        else {
            static NSString *cid = @"2id";
            SBLowestPriceContactInfoTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
            if (!cell) cell = [[SBLowestPriceContactInfoTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
            [cell display:nil];
            
            return cell;
        }
        
    }
    
    else {
        
        static NSString *cid = @"4id";
        SBLowestPriceComInfoTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBLowestPriceComInfoTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:nil];
        
        return cell;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 2;
    else return 5;
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) return [SBConsultCarNameTblCell getHeight:nil];
        else return [SBLowestPriceContactInfoTblCell getHeight:nil];
    }
    
    else return [SBLowestPriceComInfoTblCell getHeight:nil];

}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [updateTableView reloadData];
}


@end
