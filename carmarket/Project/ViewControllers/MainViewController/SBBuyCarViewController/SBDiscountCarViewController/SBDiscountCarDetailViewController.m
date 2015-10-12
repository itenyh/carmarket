//
//  SBDiscountCarDetailViewController.m
//  carmarket
//
//  Created by itensb on 14-11-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBDiscountCarDetailViewController.h"
#import "BKUpdateTableView.h"
#import "SBDiscountDetailTblCell.h"
#import "SBLowPriceBottomMenu.h"

@interface SBDiscountCarDetailViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tbView;
    NSDictionary *info;
}
@end

@implementation SBDiscountCarDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"优惠详情";
    
    SBLowPriceBottomMenu *bottomMenu = [[SBLowPriceBottomMenu alloc] initWithFrame:CGRectMake(0, self.cotentSize.height - 115 * PJSAH, [ITUIKitHelper getAppWidth], 115 * PJSAH) type:3 title:@"立即支付"];
    [self addSubviewInContentView:bottomMenu];
    
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.cotentSize.height - bottomMenu.frame.size.height)];
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.delegate = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubviewInContentView:tbView];
    
    info = [[SBRequestParamBus instance] getParamWith:self key:@"info"];
    
}

#pragma - mark TableView代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *id1 = @"d1";
    SBDiscountDetailTblCell *cell = [tableView dequeueReusableCellWithIdentifier:id1];
    if (!cell) cell = [[SBDiscountDetailTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id1];
    [cell display:info];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SBDiscountDetailTblCell getHeight:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma - mark 代理函数
- (void)SBLowPriceBottomMenu_Button:(UIButton *)b
{
    
}

@end
