//
//  SBMapViewController.m
//  carmarket
//
//  Created by itensb on 14-11-21.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBMapViewController.h"
#import "ITMapper.h"
#import "ITMapSearcher.h"

@interface SBMapViewController ()

@end

@implementation SBMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNaviCreateBtn:^(id sender) {
        
        [self showLoading];
        NSDictionary *dealerInfo = [[SBRequestParamBus instance] getParamWith:self key:@"dealerInfo"];
        [[ITMapper instance] naviDriveRouteWithEndPoints:[[dealerInfo objectForKey:@"baiduMapLng"] floatValue] latitude:[[dealerInfo objectForKey:@"baiduMapLat"] floatValue] drivingStrategy:0 response:^(AMapNaviManager *naviManager) {
            [self stopLoading];
        } fail:^(AMapNaviManager *naviManager) {
            [self showErrorMessageOnCenter:@"导航加载失败"];
            [self stopLoading];
        } finish:^(AMapNaviManager *naviManager) {
            
        }];
        
    }];
    
    [ITMapper instance].mapView.frame = CGRectMake(0, 0, self.cotentSize.width, self.cotentSize.height);
    [self addSubviewInContentView:[ITMapper instance].mapView];
    
    [self addDealerAnnotation];
    
    [[ITMapper instance] getUserCurLocationWithResult:^(MAUserLocation *response, NSError *error) {
       
        CLLocationCoordinate2D startCoordinate = response.coordinate;
        
        ITImageAnnotation *startAnnotation = [[ITImageAnnotation alloc] initWithType:ITPointAnnotationSelf];
        startAnnotation.coordinate = startCoordinate;
        startAnnotation.title      = @"我的位置";
        
        [[ITMapper instance].mapView addAnnotation:startAnnotation];
        
        ITImageAnnotation *dealerAnnotation = [self addDealerAnnotation];
        
        MAMapRect rect = [CommonUtility minMapRectForAnnotations:[NSArray arrayWithObjects:dealerAnnotation, startAnnotation, nil]];
        [ITMapper instance].mapView.visibleMapRect = rect;
        
    }];
}

- (ITImageAnnotation *)addDealerAnnotation
{
    NSDictionary *dealerInfo = [[SBRequestParamBus instance] getParamWith:self key:@"dealerInfo"];
    CLLocationCoordinate2D startCoordinate = CLLocationCoordinate2DMake([[dealerInfo objectForKey:@"baiduMapLat"] floatValue], [[dealerInfo objectForKey:@"baiduMapLng"] floatValue]);

    ITImageAnnotation *startAnnotation = [[ITImageAnnotation alloc] initWithType:ITPointAnnotationCom];
    startAnnotation.coordinate = startCoordinate;
    startAnnotation.title      = [dealerInfo objectForKey:@"dealerName"];

    [[ITMapper instance].mapView addAnnotation:startAnnotation];
    
    return startAnnotation;
}

- (void)clearViewController
{
    [super clearViewController];
    
    [[ITMapper instance] clearMapView];
}

@end
