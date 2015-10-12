//
//  SBDetailCarTypeColCell.m
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBDetailCarTypeColCell.h"
#import "SBDetailCarInfoTblCell.h"
#import "SBCarStylePriceTblCell.h"

@implementation SBDetailCarTypeColCell

- (void)initData
{
    infoDic = [NSMutableDictionary dictionary];
    dateType = [NSMutableArray array];
    pailiang = [NSMutableDictionary dictionary];
    car = [NSMutableDictionary dictionary];
    dateIndex = -1;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initData];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)data
{
    
    [self initData];
    
    infoDic = [data objectForKey:@"carData"];
    
    NSMutableArray *datas = [data objectForKey:@"carList"];
    for (NSDictionary *data in datas) {
        NSString *carYearType = [data objectForKey:@"carYearType"];
        
        if (carYearType) {
            
            NSMutableArray *cars = [car objectForKey:carYearType];
            if (!cars) {
                cars = [NSMutableArray array];
                [car setObject:cars forKey:carYearType];
                [dateType addObject:carYearType];
                [dateType sortWithOptions:NSSortStable usingComparator:^NSComparisonResult(id obj1, id obj2) {
                    if (obj1 < obj2) return YES; return NO;
                }];
            }
            [cars addObject:data];
            
        }
    }
    
    for (NSString *dateKey in dateType) {
        
        NSMutableDictionary *paiLiangDic = [NSMutableDictionary dictionary];
        NSMutableArray *paiLiangArr = [NSMutableArray array];
        
        for (NSDictionary *oneCar in [car objectForKey:dateKey]) {
            NSString *car_pailiang = [oneCar objectForKey:@"displacement"];
            
            if (car_pailiang) {
                
                NSMutableArray* paiLiangs = [paiLiangDic objectForKey:car_pailiang];
                if (!paiLiangs) {
                    paiLiangs = [NSMutableArray array];
                    [paiLiangDic setObject:paiLiangs forKey:car_pailiang];
                    [paiLiangArr addObject:car_pailiang];
                    [paiLiangArr sortWithOptions:NSSortStable usingComparator:^NSComparisonResult(id obj1, id obj2) {
                        if (obj1 < obj2) return YES; return NO;
                    }];
                    
                }
                [paiLiangs addObject:oneCar];
                
            }
        }
        
        [car setObject:paiLiangDic forKey:dateKey];
        [pailiang setObject:paiLiangArr forKey:dateKey];
        
    }
    
    dateIndex = 0;
    
    [tbView reloadData];
    
//    NSLog(@"pailiang : %@", pailiang);
//    NSLog(@"car : %@", car);
//    NSLog(@"datetype : %@", dateType);
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) return [SBDetailCarInfoTblCell getHeight:nil];
    else if (indexPath.row == 1 && indexPath.section == 0) return [SBCarStyleDateTblCell getHeight:nil];
    
    else {
//        NSLog(@"here : %@", indexPath);
        NSString *dateKey = [dateType objectAtIndex:dateIndex];
        NSMutableArray *pailiangs = [pailiang objectForKey:dateKey];
        NSString *_pailiang = [pailiangs objectAtIndex:indexPath.section - 1];
        NSMutableDictionary *pailiangDic = [car objectForKey:dateKey];
        NSMutableArray *cars = [pailiangDic objectForKey:_pailiang];
        NSDictionary *data = [cars objectAtIndex:indexPath.row];
        return [SBCarStylePriceTblCell getHeight:data];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        static NSString *id1 = @"detaiCarId";
        SBDetailCarInfoTblCell *cell = [tableView dequeueReusableCellWithIdentifier:id1];
        if (!cell) cell = [[SBDetailCarInfoTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id1];
        [cell display:infoDic];
        return cell;
    }
    
    else if (indexPath.row == 1 && indexPath.section == 0) {
        static NSString *id2 = @"carDateCarId";
        SBCarStyleDateTblCell *cell = [tableView dequeueReusableCellWithIdentifier:id2];
        cell.delegate = self;
        if (!cell) cell = [[SBCarStyleDateTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id2];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObject:dateType forKey:@"data"];
        [cell display:dic];
        return cell;
    }
    
    else {
        static NSString *id3 = @"priceCarId";
        SBCarStylePriceTblCell *cell = [tableView dequeueReusableCellWithIdentifier:id3];
        if (!cell) cell = [[SBCarStylePriceTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id3];
        
        NSString *dateKey = [dateType objectAtIndex:dateIndex];
        NSMutableArray *pailiangs = [pailiang objectForKey:dateKey];
        NSString *_pailiang = [pailiangs objectAtIndex:indexPath.section - 1];
        NSMutableDictionary *pailiangDic = [car objectForKey:dateKey];
        NSMutableArray *cars = [pailiangDic objectForKey:_pailiang];
        NSDictionary *data = [cars objectAtIndex:indexPath.row];
        [cell display:data];
        
        return cell;
    }
    
    
}

- (UIView *)BKUpdateTableView:(BKUpdateTableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], 57 * PJSAH)];
    view.backgroundColor = [ITUIKitHelper color:245 blue:245 green:245 alpha:1];
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(27 * PJSAH, 0, [ITUIKitHelper getAppWidth] - 27 * PJSAH, 57 * PJSAH)];
    l.backgroundColor = [UIColor clearColor];
    l.textColor = [ITUIKitHelper color:@"4f4f4f"];
    [view addSubview:l];
    
    [view addSubview:[SBUIFactory getSeperateLineView:0.5]];
    [view addSubview:[SBUIFactory getSeperateLineView:57 * PJSAH]];
    
    NSString *dateKey = [dateType objectAtIndex:dateIndex];
    NSMutableArray *pailiangs = [pailiang objectForKey:dateKey];
    float pl = [[pailiangs objectAtIndex:section - 1] floatValue];
    l.text = [NSString stringWithFormat:@"%.1fL", pl];
    
    return view;
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return 0.1;
    return 57 * PJSAH;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([pailiang allKeys].count > 0) {
        NSString *dateKey = [dateType objectAtIndex:dateIndex];
        NSMutableArray *pailiangs = [pailiang objectForKey:dateKey];
        return pailiangs.count + 1;
    }
    else return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 2;
    else {
        NSString *dateKey = [dateType objectAtIndex:dateIndex];
        NSMutableArray *pailiangs = [pailiang objectForKey:dateKey];
        NSMutableDictionary *pailiangDic = [car objectForKey:dateKey];
        NSMutableArray *cars = [pailiangDic objectForKey:[pailiangs objectAtIndex:section - 1]];
        return cars.count;
    }
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0) RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBDetailCarTypeColCell_Cell:) withObject:[updateTableView cellForRowAtIndexPath:indexPath]]);
}

#pragma - mark 代理
- (void)SBCarStyleDateTblCellBtnClick:(UIButton *)btn
{
    dateIndex = btn.tag;
    [tbView reloadData];
}


@end
