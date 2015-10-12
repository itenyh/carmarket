//
//  SBCarCompareViewController.m
//  carmarket
//
//  Created by itensb on 14-11-3.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCarCompareViewController.h"
#import "SBCarsViewController.h"

#import "SBCompareDetailViewController.h"
#import "SBaseTableViewCell.h"
#import "SBLowPriceBottomMenu.h"

@interface SBCarCompareViewController () <UITableViewDataSource, UITableViewDelegate, SBCarsViewControllerDelegate>
{
    UITableView *tbView;
    NSArray *datas;
}
@end

@implementation SBCarCompareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"车型对比";
    
    SBLowPriceBottomMenu *bottomMenu = [[SBLowPriceBottomMenu alloc] initWithFrame:CGRectMake(0, self.cotentSize.height - 115 * PJSAH, [ITUIKitHelper getAppWidth], 115 * PJSAH) type:2 title:@"共选3个车辆，点击开始对比"];
    [self addSubviewInContentView:bottomMenu];
    
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], self.cotentSize.height - bottomMenu.frame.size.height) style:UITableViewStylePlain];
    [self addSubviewInContentView:tbView];
    tbView.delegate = self;
    tbView.dataSource = self;
    
    datas = [NSArray arrayWithObjects:@"奥迪", @"奥拓", @"奥特曼", nil];
    
}

#pragma - mark tabelView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        static NSString *cid = @"id";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        cell.textLabel.text = @"+添加车款";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
    
    else {
        static NSString *cid1 = @"id1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cid1];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid1];
            cell.tag = 0;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = datas[indexPath.row - 1];
        cell.textLabel.textColor = cell.tag == 0 ? [UIColor blackColor] : [UIColor redColor];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datas.count + 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        SBCarsViewController *cv = [[SBCarsViewController alloc] initWithNavi:YES leftBtnType:NDLeftBtnClose];
        cv.delegate = self;
        [self present_rootNaviController:cv animated:YES];
    }
    else {
        UITableViewCell *selectCell = [tableView cellForRowAtIndexPath:indexPath];
        if (selectCell.tag == 0) {
            selectCell.textLabel.textColor = [UIColor redColor];
            selectCell.tag = 1;
        }
        else {
            selectCell.textLabel.textColor = [UIColor blackColor];
            selectCell.tag = 0;
        }
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
//        plans = [self deletePlanAtIndex:indexPath.row];
        // Delete the row from the data source.
        [tbView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

//单元格返回的编辑风格，包括删除 添加 和 默认  和不可编辑三种风格
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

#pragma - mark CarsViewDelegate
- (void)sBCarsViewControllerCarStyleClick:(SBCarsViewController *)vc cell:(SBaseTableViewCell *)cell
{
//    SBDetailCarViewController *detailCon = [[SBDetailCarViewController alloc] initWithNavi:YES];
//    [[SBRequestParamBus instance] setParamWith:detailCon key:@"brandId" value:vc.pcView.brandListView.brandId];
//    [[SBRequestParamBus instance] setParamWith:detailCon key:@"carInfo" value:cell.info];
//    [vc push_rootNaviController:detailCon animated:YES];
}

#pragma - mark 代理函数
- (void)SBLowPriceBottomMenu_Button:(UIButton *)b
{
    SBCompareDetailViewController *detailCon = [[SBCompareDetailViewController alloc] initWithNavi:YES leftBtnType:NDLeftBtnClose];
    [self present_rootNaviController:detailCon animated:YES];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

@end
