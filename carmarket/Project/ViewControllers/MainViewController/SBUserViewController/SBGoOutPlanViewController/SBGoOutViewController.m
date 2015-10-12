//
//  SBGoOutViewController.m
//  carmarket
//
//  Created by Apple on 14-10-17.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBGoOutViewController.h"
#import "SBLocationPickViewController.h"
#import "SBGoOutPushSettingViewController.h"
#import "SBTrafficStateView.h"

#import "BKUpdateTableView.h"

#import "SBGoOutPlanTitle.h"
#import "SBGoOutPlanImportantTitleTblCell.h"
#import "SBGoOutPlanSwicherCell.h"

#import "SBDatePickerView.h"

@interface SBGoOutViewController () <BKUpdateTableViewDelegate, BKUpdateTableViewProcessingDelegate, UITableViewDataSource>
{
    NSDictionary *sInfo;
    NSDictionary *eInfo;
    NSDictionary *tbInfo;
    
    BOOL direction;
    
    BKUpdateTableView *tbView;
    
    SBDatePickerView *picker;
    
    MAMapView *sb_mapView;;
    
}
@end

@implementation SBGoOutViewController

- (id)initWithNavi:(BOOL)navi leftBtnType:(NDLeftBtnType)type dic:(NSDictionary *)dic
{
    self = [super initWithNavi:navi leftBtnType:type];
    
    if (self) {
        
        direction = 0;
        sInfo = [dic objectForKey:@"sInfo"];
        eInfo = [dic objectForKey:@"eInfo"];
        tbInfo = [NSMutableDictionary dictionary];
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"规划详情";
    
    [self createTextBtn:^(id sender) {
        
        NSDictionary *temp = sInfo;
        sInfo = eInfo;
        eInfo = temp;
        
        [self searchNaviDrive];
        
    } text:@"交换" isAdjusted:NO];
   
    [self start_mapView];
    
    tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, [ITUIKitHelper yMarTopView:[ITMapper instance].mapView margin:0], self.view.frame.size.width, self.cotentSize.height - [ITMapper instance].mapView.frame.size.height) style:UITableViewStylePlain updateType:BKUpdateTableViewTypeOnlyRefresh];
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.processingDelegate = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbView.pullUpdateDelegate = self;
    tbView.showsVerticalScrollIndicator = NO;
    tbView.bounces = NO;
    [self.contentView addSubview:tbView];
    
    [self searchNaviDrive];
}

- (void)start_mapView
{
    if (sb_mapView) {
        NSLog(@"712893471293847129834712384901718039471");
        [[ITMapper instance] clearMapView];
        [sb_mapView removeFromSuperview];
        sb_mapView = nil;
    }
    [ITMapper instance].mapView.frame = CGRectMake(0, 0, [ITUIKitHelper getAppWidth], 200);
    [ITMapper instance].mapView.showsCompass = NO;
    [self addSubviewInContentView:[ITMapper instance].mapView];
    SBTrafficStateView *tsv = [[SBTrafficStateView alloc] init];
    [ITUIKitHelper pointSet:tsv piont:CGPointMake([ITMapper instance].mapView.frame.size.width - tsv.frame.size.width - 5, [ITMapper instance].mapView.frame.size.height - tsv.frame.size.height - 5)];
    [[ITMapper instance].mapView addSubview:tsv];
    sb_mapView = [ITMapper instance].mapView;
}

#pragma - mark TableView代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        NSString *cid = @"id";
        SBGoOutPlanTitle *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBGoOutPlanTitle alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:[sInfo objectForKey:@"name"] content:[eInfo objectForKey:@"name"]];
        
        return cell;
    }
    
    else if(indexPath.row == 1) {
        
        NSString *cid = @"id1";
        SBGoOutPlanImportantTitleTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBGoOutPlanImportantTitleTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:@"路段全长" content:[tbInfo objectForKey:@"distance"]];
        
        return cell;
    }
    
    else if(indexPath.row == 2) {
        
        NSString *cid = @"id2";
        SBGoOutPlanImportantTitleTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBGoOutPlanImportantTitleTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        NSString *feiyong = [tbInfo objectForKey:@"taxicost"];
        if (!feiyong) feiyong = @"0元";
        else feiyong = [NSString stringWithFormat:@"%@%@", feiyong , @"元"];
        [cell display:@"打车费用" content:feiyong];
        return cell;
    }
    
    else if(indexPath.row == 3) {
        
        NSString *cid = @"id3";
        SBGoOutPlanImportantTitleTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBGoOutPlanImportantTitleTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:@"畅通路况下耗时" content:[tbInfo objectForKey:@"time"]];
        
        return cell;
        
    }
    
    else {
        
        NSString *cid = @"id4";
        SBGoOutPlanSwicherCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBGoOutPlanSwicherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];

        return cell;
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) return [SBGoOutPlanTitle getHeight:nil];
    else if(indexPath.row <= 2) return [SBGoOutPlanImportantTitleTblCell getHeight:nil];
    else if(indexPath.row == 3) return [SBGoOutPlanImportantTitleTblCell getHeight:nil] + 10;
    else {
        return [SBGoOutPlanSwicherCell getHeight:nil] + 30;
//        if(tbView.tag == 0) return [SBGoOutPlanSwicherCell getHeight:nil] + 30;
//        return [SBGoOutPlanSwicherCell getHeight:nil] + 100;
    }
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) [self present_rootNaviController:[[SBGoOutPushSettingViewController alloc] initWithNavi:YES leftBtnType:NDLeftBtnClose] animated:YES];
}


- (void)naviStart:(UIButton *)sender
{
    [self showLoading];
    
    double x , y;
    NSDictionary *targetDic;
    
    if (sender.tag == 0) targetDic = sInfo;
    else targetDic = eInfo;
    
    y = [[targetDic objectForKey:@"latitude"] floatValue];
    x = [[targetDic objectForKey:@"longitude"] floatValue];
    
    [[ITMapper instance] naviDriveRouteWithEndPoints:x latitude:y drivingStrategy:0 response:^(AMapNaviManager *naviManager) {
        [self stopLoading];
    } fail:^(AMapNaviManager *naviManager) {
        [self showErrorMessageOnCenter:@"导航加载失败"];
        [self stopLoading];
    } finish:^(AMapNaviManager *naviManager) {
        
        [self start_mapView];
        [self searchNaviDrive];
        
    }];
}

/* 驾车导航搜索. */
- (void)showTraffic
{
    [[ITMapper instance] clearAddedViews];
    [ITMapper instance].mapView.showTraffic = YES;
}

- (void)searchNaviDrive
{
    direction = direction == 1 ? 0 :  1;
    
    [[ITMapper instance] clearAddedViews];
    [ITMapper instance].mapView.showTraffic = NO;
    
    CLLocationCoordinate2D startCoordinate = CLLocationCoordinate2DMake([[sInfo objectForKey:@"latitude"] floatValue], [[sInfo objectForKey:@"longitude"] floatValue]);
    CLLocationCoordinate2D destinationCoordinate  = CLLocationCoordinate2DMake([[eInfo objectForKey:@"latitude"] floatValue], [[eInfo objectForKey:@"longitude"] floatValue]);
    
    [self showLoading];
    
    [[ITMapSearcher instance] searchNaviDrive:startCoordinate end:destinationCoordinate searchResult:^(AMapNavigationSearchResponse *response) {
        
        AMapPath *path = response.route.paths[0];
        [tbInfo setValue:[NSString stringWithFormat:@"%d Km", path.distance / 1000] forKey:@"distance"];
        [tbInfo setValue:[NSString stringWithFormat:@"%d Min", path.duration / 60] forKey:@"time"];
        [tbInfo setValue:[NSString stringWithFormat:@"%.1f", response.route.taxiCost] forKey:@"taxicost"];

        NSArray *polylines = [CommonUtility polylinesForPath:path];
        
        [[ITMapper instance].mapView addOverlays:polylines];
        
        [self addDriveAnnotation];
        
        /* 缩放地图使其适应polylines的展示. */
//        float sizeFix = 3025;
        MAMapRect rect = [CommonUtility mapRectForOverlays:polylines];
//        MAMapRect rectFixed = MAMapRectMake(rect.origin.x - sizeFix / 2.0, rect.origin.y - sizeFix / 2.0, rect.size.width - sizeFix, rect.size.height - sizeFix);
        [ITMapper instance].mapView.visibleMapRect = rect;
        
        [tbView reloadData];
        
        [self stopLoading];
        
    }];
    
}

- (void)addDriveAnnotation
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
    
    [[[ITMapper instance].mapView subviews] bk_apply:^(id obj) {
       
        if ([obj isKindOfClass:[SBTrafficStateView class]]) {
            [obj removeFromSuperview];
            obj = nil;
        }
        
    }];
}

#pragma - mark 其他代理
- (void)SBGoOutPlanTitle_Cell:(SBaseTableViewCell *)cell Btn:(UIButton *)btn
{
    [self naviStart:btn];
}


@end
