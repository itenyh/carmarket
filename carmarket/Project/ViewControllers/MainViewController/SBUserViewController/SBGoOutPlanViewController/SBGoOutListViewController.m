//
//  SBGoOutListViewController.m
//  carmarket
//
//  Created by itensb on 14-10-21.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBGoOutListViewController.h"
#import "SBGoOutViewController.h"
#import "SBLocationPickViewController.h"

#import "SBGoOutCreateTblCell.h"
#import "SBGoOutPlanTblCell.h"

#import "SBYapDBManager.h"

@interface SBGoOutListViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>
{
    NSDictionary *startInfo;
    NSDictionary *endInfo;
    
    UITableView *tbView;
    
    NSMutableArray *plans;
    
    BOOL isAdding;
    
}
@end

@implementation SBGoOutListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的规划";

    isAdding = NO;
    plans = [self getPlans];
    
    [ITMapper instance].mapView.frame = CGRectMake(0, 0, [ITUIKitHelper getAppWidth] - 21 * PJSA, 80);
    
    [self createTextBtn:^(UIButton *btn) {
        
        tbView.editing = tbView.editing ? NO : YES;
        if (tbView.editing) [btn setTitleColor:[ITUIKitHelper color:@"ffffff" alpha:0.5] forState:UIControlStateNormal];
        else [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    } text:@"编辑" isAdjusted:YES];
    
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], self.cotentSize.height) style:UITableViewStylePlain];
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubviewInContentView:tbView];
    tbView.backgroundColor = [UIColor clearColor];
    tbView.delegate = self;
    tbView.dataSource = self;
    
    MLNavigationController *navi = (MLNavigationController *)self.navigationController;
    navi.panGestureLock = YES;
    
//    for (int i = 0; i < 1; i++) [self createTrafficImg:plans[i] index:i];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    MLNavigationController *navi = (MLNavigationController *)self.navigationController;
    navi.panGestureLock = NO;
}

- (void)secondLoc
{
    [self push_rootNaviController:[[SBLocationPickViewController alloc] initWithNavi:YES handler:^(NSDictionary *info) {
        
        endInfo = info;
        
        [self insertPlan:startInfo eInfo:endInfo];
        
        plans = [self getPlans];
        
        [tbView reloadData];
        
    } leftBtnType:NDLeftBtnBack navTitle:@"设置另一个端点"] animated:YES];
}


#pragma - mark tabelView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        static NSString *cid = @"id";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        cell.textLabel.text = @"+ 开始规划";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
        
    }
    
    else {
        
        static NSString *cid = @"id1";
        SBGoOutPlanTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBGoOutPlanTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:plans[indexPath.row - 1]];

        return cell;
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) return 50;
    else return [SBGoOutPlanTblCell getHeight:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return plans.count + 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) {
        
        [self push_rootNaviController:[[SBLocationPickViewController alloc] initWithNavi:YES handler:^(NSDictionary *info) {
            
            startInfo = info;
            
            [self performSelector:@selector(secondLoc) withObject:nil afterDelay:1];
            
            
        } leftBtnType:NDLeftBtnBack navTitle:@"设置端点"] animated:YES];
        
    }
    
    else {
        
        NSDictionary *dic = [plans objectAtIndex:indexPath.row - 1];
        
        SBGoOutViewController *goVC = [[SBGoOutViewController alloc] initWithNavi:YES leftBtnType:NDLeftBtnBack dic:dic];
        
        [self push_rootNaviController:goVC animated:YES];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO]; 
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row != 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        plans = [self deletePlanAtIndex:indexPath.row - 1];
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

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    MLNavigationController *navi = (MLNavigationController *)self.navigationController;
    navi.canDragBack = NO;
}
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    MLNavigationController *navi = (MLNavigationController *)self.navigationController;
    navi.canDragBack = YES;
}

#pragma - mark 活动数据处理
- (NSMutableArray *)deletePlanAtIndex:(int)index
{
    NSMutableArray *datas = [plans mutableCopy];
    [datas removeObjectAtIndex:index];
    [[SBYapDBManager instance] insertDicDataSyn:datas key:GOOUT_PLAN_TB collection:GOOUT_PLAN_COL];
    
    return datas;
}

- (void)insertPlan:(NSDictionary *)sInfo eInfo:(NSDictionary *)eInfo
{
    NSMutableArray *datas = [[SBYapDBManager instance] getDicDataWithKeySyn:GOOUT_PLAN_TB collection:GOOUT_PLAN_COL];
    if (!datas) {
        datas = [NSMutableArray array];
        NSDictionary *newData = [NSDictionary dictionaryWithObjectsAndKeys:sInfo, @"sInfo", eInfo, @"eInfo", nil];
        [datas addObject:newData];
    }
    else {
        NSDictionary *newData = [NSDictionary dictionaryWithObjectsAndKeys:sInfo, @"sInfo", eInfo, @"eInfo", nil];
        [datas addObject:newData];
    }
    
    [[SBYapDBManager instance] insertDicDataSyn:datas key:GOOUT_PLAN_TB collection:GOOUT_PLAN_COL];
    
}

- (NSMutableArray *)getPlans
{
    NSMutableArray *datas = [[SBYapDBManager instance] getDicDataWithKeySyn:GOOUT_PLAN_TB collection:GOOUT_PLAN_COL];
    
    return datas;
}

- (NSString *)cellStr:(int)row
{
    NSDictionary *dic = [plans objectAtIndex:row];
    NSString *s = [[dic objectForKey:@"sInfo"] objectForKey:@"name"];
    NSString *e = [[dic objectForKey:@"eInfo"] objectForKey:@"name"];
    NSString *result = [NSString stringWithFormat:@"%@ —— %@", s, e];
    
    return result;
}

#pragma - mark 地图模块
- (void)createTrafficImg:(NSDictionary *)plan index:(int)index
{
    [[ITMapper instance] clearAddedViews];
    [ITMapper instance].mapView.showTraffic = NO;
    
    NSDictionary *sInfo = [plan objectForKey:@"sInfo"];
    NSDictionary *eInfo = [plan objectForKey:@"eInfo"];
    
    CLLocationCoordinate2D startCoordinate = CLLocationCoordinate2DMake([[sInfo objectForKey:@"latitude"] floatValue], [[sInfo objectForKey:@"longitude"] floatValue]);
    CLLocationCoordinate2D destinationCoordinate  = CLLocationCoordinate2DMake([[eInfo objectForKey:@"latitude"] floatValue], [[eInfo objectForKey:@"longitude"] floatValue]);
    
    [[ITMapSearcher instance] searchNaviDrive:startCoordinate end:destinationCoordinate searchResult:^(AMapNavigationSearchResponse *response) {
        
        AMapPath *path = response.route.paths[0];
        NSArray *polylines = [CommonUtility polylinesForPath:path];
        
        [[ITMapper instance].mapView addOverlays:polylines];
        
        [self addDriveAnnotation:sInfo eInfo:eInfo];
        
        /* 缩放地图使其适应polylines的展示. */
        MAMapRect rect = [CommonUtility mapRectForOverlays:polylines];
        [ITMapper instance].mapView.visibleMapRect = rect;
        
//        NSLog(@"rect : %@", NSStringFromCGRect([ITMapper instance].mapView.frame));
//        UIImage *tImg = [[ITMapper instance].mapView takeSnapshotInRect:CGRectMake(0, 0, 300, 80)];
//
//        NSDictionary *dict = [plans objectAtIndex:index];
//        NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithDictionary:dict];
//        [newDict setObject:tImg forKey:@"map"];
//        [plans replaceObjectAtIndex:index withObject:newDict];
//        [tbView reloadData];
        
        [self performSelector:@selector(test:) withObject:[NSNumber numberWithInt:index] afterDelay:3];
        
    }];
}

- (void)test:(NSNumber *)num
{
    UIImage *tImg = [[ITMapper instance].mapView takeSnapshotInRect:CGRectMake(0, 0, 300, 80)];
    
    NSDictionary *dict = [plans objectAtIndex:[num integerValue]];
    NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [newDict setObject:tImg forKey:@"map"];
    [plans replaceObjectAtIndex:0 withObject:newDict];
    [tbView reloadData];
}

- (void)addDriveAnnotation:(NSDictionary *)sInfo eInfo:(NSDictionary *)eInfo
{
    CLLocationCoordinate2D startCoordinate = CLLocationCoordinate2DMake([[sInfo objectForKey:@"latitude"] floatValue], [[sInfo objectForKey:@"longitude"] floatValue]);
    CLLocationCoordinate2D destinationCoordinate  = CLLocationCoordinate2DMake([[eInfo objectForKey:@"latitude"] floatValue], [[eInfo objectForKey:@"longitude"] floatValue]);
    
    ITImageAnnotation *startAnnotation = [[ITImageAnnotation alloc] initWithType:ITPointAnnotationStart];
    startAnnotation.coordinate = startCoordinate;
    startAnnotation.title      = [sInfo objectForKey:@"name"];
    
    ITImageAnnotation *destinationAnnotation = [[ITImageAnnotation alloc] initWithType:ITPointAnnotationEnd];
    destinationAnnotation.coordinate = destinationCoordinate;
    destinationAnnotation.title      =  [eInfo objectForKey:@"name"];
    
    [[ITMapper instance].mapView addAnnotation:startAnnotation];
    [[ITMapper instance].mapView addAnnotation:destinationAnnotation];
}

- (void)clearViewController
{
    [super clearViewController];
    
    [[ITMapper instance] clearMapView];
}

@end
