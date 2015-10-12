//
//  SBBuyCarCaculatorViewController.m
//  carmarket
//
//  Created by itensb on 14-11-5.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define SECTION_HEIGHT 30

#import "SBBuyCarCaculatorViewController.h"

#import "SBCarStyleSelectTblCell.h"
#import "SBPriceInputTblCell.h"
#import "SBPlainItemTblCell.h"

#import "SBCarsViewController.h"

@interface SBBuyCarCaculatorViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tbView;
}
@end

@implementation SBBuyCarCaculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"购车计算器";
    
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], self.cotentSize.height) style:UITableViewStylePlain];
    [self addSubviewInContentView:tbView];
    tbView.delegate = self;
    tbView.dataSource = self;
    
    
}

#pragma - mark tabelView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *cid1 = @"cid1";
            SBCarStyleSelectTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid1];
            if (!cell) {
                cell = [[SBCarStyleSelectTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid1];
            }
            return cell;
        }
        else {
            static NSString *cid2 = @"cid2";
            SBPriceInputTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid2];
            if (!cell) {
                cell = [[SBPriceInputTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid2];
            }
            return cell;
        }
    }
    
    else if (indexPath.section == 1) {
        static NSString *cid3 = @"cid3";
        SBPlainItemTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid3];
        if (!cell) {
            cell = [[SBPlainItemTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid3];
        }
        
        if (indexPath.row == 0) {[cell displayWithTitle:@"购置税:" price:@"4720" type:0];}
        else if (indexPath.row == 1) {[cell displayWithTitle:@"交强险:" price:@"950" type:1];}
        else if (indexPath.row == 2) {[cell displayWithTitle:@"车船使用税:" price:@"70" type:1];}
        else {[cell displayWithTitle:@"上牌费用:" price:@"500" type:0];}
        
        return cell;
    }
    
    else {
        return nil;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], SECTION_HEIGHT)];
    view.backgroundColor = [ITUIKitHelper color:@"faf4f6"];
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, [ITUIKitHelper getAppWidth] - 20, SECTION_HEIGHT)];
    l.font = [UIFont systemFontOfSize:30 * PJSAH];
    l.textColor = [ITUIKitHelper color:@"757575"];
    l.backgroundColor = [UIColor clearColor];
    [view addSubview:l];
    l.text = @"各项税费";
    [SBUIFactory decorateWithLine:view width:0.5 type:ITLineDecorateUpDown];
    
    UILabel *totalPrice = [ITUIKitHelper createLabel:@"6,230" size:CGSizeMake(130, SECTION_HEIGHT) font:l.font color:[ITUIKitHelper color:@"4b89d2"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper getAppWidth] - 130 - 10, 0) superViewFrame:view.frame];
    totalPrice.textAlignment= NSTextAlignmentRight;
    [view addSubview:totalPrice];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return 0;
    else return SECTION_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SBCarStyleSelectTblCell getHeight:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 2;
    else if(section == 1) return 4;
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBCarsViewController *cv = [[SBCarsViewController alloc] initWithNavi:YES leftBtnType:NDLeftBtnClose];
//    cv.delegate = self;
    [self present_rootNaviController:cv animated:YES];
}

@end
