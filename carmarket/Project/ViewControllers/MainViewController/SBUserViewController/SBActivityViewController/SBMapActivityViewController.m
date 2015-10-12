//
//  SBMapActivityViewController.m
//  carmarket
//
//  Created by itensb on 14-8-19.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBMapActivityViewController.h"
#import "ITMapper.h"
#import "ITMapSearcher.h"
#import "SBTrafficStateView.h"
#import "SBColoredBottomView.h"

@interface SBMapActivityViewController ()
{
    SBTrafficStateView *trafficView;
}
@end

@implementation SBMapActivityViewController
@synthesize info, startCoordinate, destinationCoordinate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setTitleWithImage:[UIImage imageNamed:@"icon_titleshishidaohang"]];
    
    UIView *segBg = [SBUIFactory getDaoHangBottomPanel:CGSizeMake([ITUIKitHelper getAppWidth], 92 * PJSAH)];
    [SBUIFactory decorateWithLine:segBg width:0.5 type:ITLineDecorateDown];
    [self addSubviewInContentView:segBg];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"实时导航", @"路况信息", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake((self.view.frame.size.width - 150) / 2, 12 * PJSAH, 150.0, 30.0);
    segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    segmentedControl.tintColor = [ITUIKitHelper color:@"c30114"];

    [ITMapper instance].mapView.frame = CGRectMake(0, [ITUIKitHelper yMarTopView:segBg margin:0], [ITUIKitHelper getAppWidth], self.cotentSize.height - [ITUIKitHelper yMarTopView:segBg margin:0]);
    [self addSubviewInContentView:[ITMapper instance].mapView];
    
    SBColoredBottomView *bottomViewBtn = [[SBColoredBottomView alloc] initWithType:3 view:self.contentView];
    [bottomViewBtn setTitle:@"开始导航" handler:^(id sender) {}];
    [self addSubviewInContentView:bottomViewBtn];
    
    trafficView = [[SBTrafficStateView alloc] initWithFrame:CGRectMake(20 * PJSAH, self.cotentSize.height - 20 * PJSAH - 119 * PJSAH, 0, 0)];
    trafficView.hidden = YES;
    [self addSubviewInContentView:trafficView];
    
    [segmentedControl bk_addEventHandler:^(UISegmentedControl *sender) {
        [ITMapper instance].mapView.showTraffic = (sender.selectedSegmentIndex == 0 ? NO : YES);
        bottomViewBtn.hidden = (sender.selectedSegmentIndex == 0 ? NO : YES);
        trafficView.hidden = (sender.selectedSegmentIndex == 0 ? YES : NO);
    } forControlEvents:UIControlEventValueChanged];
    [segBg addSubview:segmentedControl];
//
//    [self addOtherCars];
//    
//    UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(0, 568 - 20, 120, 20)];
//    [b setBackgroundColor:[UIColor redColor]];
//    [b setTitle:@"点击启动导航" forState:UIControlStateNormal];
//    
//    [b addTarget:self action:@selector(startNavi) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:b];
//    
//    [self initTrafficBar];
//    
    [self searchNaviDrive];
    
}



/* 驾车导航搜索. */
- (void)searchNaviDrive
{
    
    AMapGeoPoint *end = [info objectForKey:@"des"];
    AMapGeoPoint *start = [info objectForKey:@"start"];
    
    if (end && start) {
        
        startCoordinate        = CLLocationCoordinate2DMake(start.latitude, start.longitude);
        destinationCoordinate  = CLLocationCoordinate2DMake(end.latitude, end.longitude);
        
        [[ITMapSearcher instance] searchNaviDrive:self.startCoordinate end:self.destinationCoordinate searchResult:^(AMapNavigationSearchResponse *response) {
            
            NSArray *polylines = [CommonUtility polylinesForPath:response.route.paths[0]];
            
            [[ITMapper instance].mapView addOverlays:polylines];
            
            [self addDriveAnnotation];
            
            /* 缩放地图使其适应polylines的展示. */
            [ITMapper instance].mapView.visibleMapRect = [CommonUtility mapRectForOverlays:polylines];
            
        }];
        
    }
    
    
}

- (void)addDriveAnnotation
{
    ITImageAnnotation *startAnnotation = [[ITImageAnnotation alloc] initWithType:ITPointAnnotationSelfCar];
    startAnnotation.coordinate = self.startCoordinate;
    startAnnotation.title      = @"起点";
    startAnnotation.subtitle   = [NSString stringWithFormat:@"{%f, %f}", self.startCoordinate.latitude, self.startCoordinate.longitude];
    
    ITImageAnnotation *destinationAnnotation = [[ITImageAnnotation alloc] initWithType:ITPointAnnotationEnd];
    destinationAnnotation.coordinate = self.destinationCoordinate;
    destinationAnnotation.title      = @"终点";
    destinationAnnotation.subtitle   = [NSString stringWithFormat:@"{%f, %f}", self.destinationCoordinate.latitude, self.destinationCoordinate.longitude];
    
    [[ITMapper instance].mapView addAnnotation:startAnnotation];
    [[ITMapper instance].mapView addAnnotation:destinationAnnotation];
}

- (void)clearViewController
{
    [super clearViewController];
    
    NSLog(@"Map 清理");
    
    [[ITMapper instance] clearMapView];
}

@end
