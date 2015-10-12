//
//  ITMapper.m
//  GaoDeTemple
//
//  Created by Apple on 14-7-24.
//  Copyright (c) 2014年 itenyhCom. All rights reserved.
//

#import "ITMapper.h"
#import "UtilsMacro.h"
#import "LineDashPolyline.h"
#import "ITImageAnnotation.h"

#import "MAPolyline+Extension.h"
#import "SBMAPolylineView.h"
#import "SBNaviViewController.h"

#include <math.h>

@implementation ITMapper
@synthesize locationManager;

SYNTHESIZE_SINGLETON_FOR_CLASS_WITHOUTINIT(ITMapper);

+ (ITMapper *)instance
{
    @synchronized(self)
    {
        if (sharedITMapper == nil)
        {
            sharedITMapper = [ITMapper new];
            sharedITMapper.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], [ITUIKitHelper getAppHeight])];
            sharedITMapper.mapView.delegate = sharedITMapper;
            sharedITMapper.naviManager = [[AMapNaviManager alloc] init];
            sharedITMapper.naviManager.delegate = sharedITMapper;
            sharedITMapper.iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
            sharedITMapper.iFlySpeechSynthesizer.delegate = sharedITMapper;
            
            sharedITMapper.naviMapView = sharedITMapper.mapView;
            
//            sharedITMapper.naviMapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], [ITUIKitHelper getAppHeight])];
//            sharedITMapper.naviMapView.delegate = sharedITMapper;
            
        }
    }
    return sharedITMapper;
}

- (void)recover
{
    sharedITMapper.mapView.delegate = nil;
}

- (void)getUserCurLocationWithResult:(MapCurLocationB)block
{
    curLocationB = block;
    
    locationManager =[[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager startUpdatingLocation];
    
    locationManager =[[CLLocationManager alloc] init];
    
    // fix ios8 location issue
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
#ifdef __IPHONE_8_0
//        if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
//        {
//            [locationManager performSelector:@selector(requestAlwaysAuthorization)];//用这个方法，plist中需要NSLocationAlwaysUsageDescription
//        }
        
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        {
            [locationManager performSelector:@selector(requestWhenInUseAuthorization)];//用这个方法，plist里要加字段NSLocationWhenInUseUsageDescription
        }
#endif
    }
    
    sharedITMapper.mapView.showsUserLocation = YES;
}

- (void)naviDriveRouteWithEndPoints:(float)longitude latitude:(float)latitude drivingStrategy:(AMapNaviDrivingStrategy)strategy response:(CalculateRouteSuccessB)response fail:(CalculateRouteFailB)fail finish:(NaviRouteFinishB)finish
{
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位服务未开启" message:@"请在设置中开启定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        fail(self.naviManager);
        return;
    }
    
    AMapNaviPoint *endNode = [AMapNaviPoint new];
    endNode.longitude = longitude;
    endNode.latitude = latitude;
    
    calculateRouteSuccessB = response;
    calculateRouteFailB = fail;
    naviRouteFinishB = finish;
    
    [self.naviManager calculateDriveRouteWithEndPoints:@[endNode] wayPoints:nil drivingStrategy:strategy];
}

- (void)calculateDriveRouteWithStartPoints:(NSArray *)startPoints
                                 endPoints:(NSArray *)endPoints
                                 wayPoints:(NSArray *)wayPoints
                           drivingStrategy:(AMapNaviDrivingStrategy)strategy response:(CalculateRouteSuccessB)response fail:(CalculateRouteFailB)fail
{
    calculateRouteSuccessB = response;
    calculateRouteFailB = fail;
    
    [self.naviManager calculateDriveRouteWithEndPoints:endPoints wayPoints:wayPoints drivingStrategy:strategy];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (locations.count > 0) {
        CLLocation *l = locations[0];
        MAUserLocation *loc = [MAUserLocation new];
        [loc setCoordinate:l.coordinate];
        
        curLocationB(loc, nil);

        //保证回调块只被执行一次
        curLocationB = ^(MAUserLocation *response, NSError *error){};
        [self.locationManager stopUpdatingLocation];
        
        NSLog(@"定位成功");
    }
}

#pragma - mark MapView Delegate
- (void)mapView:(MAMapView*)mapView didUpdateUserLocation:(MAUserLocation*)userLocation updatingLocation:(BOOL)updatingLocation
{
    @synchronized(sharedITMapper) {

        curLocationB(userLocation, nil);
        
        //保证回调块只被执行一次
        curLocationB = ^(MAUserLocation *response, NSError *error){};
        sharedITMapper.mapView.showsUserLocation = NO;
        
        NSLog(@"定位成功");
        
    }

}

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    curLocationB(nil, nil);
    NSLog(@" 定位失败 ！");
}

#pragma - mark 导航模块
- (void)AMapNaviManager:(AMapNaviManager *)naviManager didPresentNaviViewController:(UIViewController *)naviViewController
{
    [self.naviManager startGPSNavi];
}

- (void)AMapNaviManagerOnCalculateRouteSuccess:(AMapNaviManager *)naviManager
{
    SBNaviViewController *_naviViewController = [[SBNaviViewController alloc] initWithMapView:sharedITMapper.naviMapView delegate:sharedITMapper];
    [sharedITMapper.naviManager presentNaviViewController:_naviViewController animated:YES];
    calculateRouteSuccessB(naviManager);
}

- (void)AMapNaviManager:(AMapNaviManager *)naviManager onCalculateRouteFailure:(NSError *)error
{
    [self clearMapView];
    calculateRouteFailB(naviManager);
}

- (void)AMapNaviManager:(AMapNaviManager *)naviManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [_iFlySpeechSynthesizer startSpeaking:soundString];//soundString为导航引导语
    });
}

#pragma mark - AManNaviViewController Delegate
- (void)AMapNaviViewControllerCloseButtonClicked:(AMapNaviViewController *)naviViewController
{

    [self clearMapView];
    naviRouteFinishB(self.naviManager);
    
    [[ITMapper instance].iFlySpeechSynthesizer stopSpeaking];
    [[ITMapper instance].naviManager stopNavi];
    [[ITMapper instance].naviManager dismissNaviViewControllerAnimated:YES];
}

- (void)AMapNaviViewControllerMoreButtonClicked:(AMapNaviViewController *)naviViewController
{
    [ITMapper instance].naviMapView.showTraffic = [ITMapper instance].mapView.showTraffic ? NO : YES;
}

- (void)AMapNaviViewControllerTrunIndicatorViewTapped:(AMapNaviViewController *)naviViewController
{
    [[ITMapper instance].naviManager readNaviInfoManual];
}

#pragma mark - iFlySpeechDelegate
- (void)onCompleted:(IFlySpeechError*) error
{
    NSLog(@"Speak Error:{%d:%@}", error.errorCode, error.errorDesc);
}

#pragma mark - Drawing
- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay
{
//    路况状态：0-未知；1-畅通；2-缓行；3-拥堵。
    
//    NSLog(@"add layer");
    
    if ([overlay isKindOfClass:[LineDashPolyline class]])
    {
        MAPolyline *pl = ((LineDashPolyline *)overlay).polyline;
        SBMAPolylineView *overlayView = [[SBMAPolylineView alloc] initWithPolyline:pl];
        
//        NSLog(@"@#$^&*( : %@", pl.mapStep.tmcs);
        
        overlayView.lineWidth    = 8;
        overlayView.strokeColor  = [self trafficColor:pl.mapStep.tmcs];
//        overlayView.lineDash     = YES;

        return overlayView;
    }
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolyline *pl = overlay;
        SBMAPolylineView *overlayView = [[SBMAPolylineView alloc] initWithPolyline:pl];
        
//        NSLog(@"@#$^&*( : %@", pl.mapStep.tmcs);
        
        overlayView.lineWidth    = 8;
        overlayView.strokeColor  = [self trafficColor:pl.mapStep.tmcs];
        
        return overlayView;
    }
    
    return nil;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[ITImageAnnotation class]])
    {
        ITImageAnnotation *newAnnotation = (ITImageAnnotation *)annotation;
        
        static NSString *pointReuseIndetifier = @"pointReuseId";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:newAnnotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout = YES;
    
        
        switch (newAnnotation.anootationType) {
            case ITPointAnnotationStart:
                annotationView.image = [UIImage imageNamed:@"startPoint"];
                break;
            case ITPointAnnotationEnd:
                annotationView.image = [UIImage imageNamed:@"endPoint"];
                break;
            case ITPointAnnotationSelfCar:
                annotationView.pinColor = MAPinAnnotationColorPurple;
                break;
            case ITPointAnnotationOtherCar:
                annotationView.pinColor = MAPinAnnotationColorRed;
                break;
            case ITPointAnnotationSelf:
                annotationView.image = [UIImage imageNamed:@"icon_myloc"];
                break;
            case ITPointAnnotationCom:
                annotationView.image = [UIImage imageNamed:@"icon_comloc"];
                break;
            default:
                break;
        }
        
        
        return annotationView;
    }
    
    return nil;
    
}

#pragma - mark Map清理
- (void)clearAddedViews
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView removeOverlays:self.mapView.overlays];
}

- (void)clearMapView
{
    self.mapView.frame = CGRectMake(0, 0, [ITUIKitHelper getAppWidth], [ITUIKitHelper getAppHeight]);
    
    self.mapView.showsCompass = YES;
    self.mapView.showsUserLocation = NO;
    self.mapView.showsScale = YES;
    
    sharedITMapper.mapView.delegate = sharedITMapper;
    sharedITMapper.naviManager.delegate = sharedITMapper;
    
    [self clearAddedViews];
}

#pragma - mark 辅助函数
- (UIColor *)trafficColor:(NSArray *)tmcs
{
    if (tmcs == nil || tmcs.count == 0) {
//        NSLog(@"灰色 nil 或者 无数据");
        return [ITUIKitHelper color:@"#DEDEDE"];
    }
    else {
        
        float count = 0.0;
        float statusSum = 0.0;
        
        for (AMapTMC *tmc in tmcs) {
            NSInteger status = tmc.status;
            if (status != 0) {
                statusSum += status;
                count++;
            }
        }
        
        if (count == 0)
        {
//            NSLog(@"灰色 全路段未知");
            return [ITUIKitHelper color:@"#DEDEDE"];
        }
        
        else {
            float resultf = statusSum / count;
            int result = round(resultf);
            
            switch (result) {
                
                case 1:
//                    NSLog(@"绿色 计算值 ： %f / %f = %f  %d", statusSum, count, statusSum / count, result);
                    return [UIColor greenColor];
                    break;
                  
                case 2:
//                    NSLog(@"黄色 计算值 ： %f / %f = %f  %d", statusSum, count, statusSum / count, result);
                    return [UIColor yellowColor];
                    break;
                    
                case 3:
//                    NSLog(@"红色 计算值 ： %f / %f = %f  %d", statusSum, count, statusSum / count, result);
                    return [UIColor redColor];
                    break;
                    
                default:
//                    NSLog(@"绿色 默认");
                    return [UIColor greenColor];
                    break;
            }
            
        }
        
    }
}

@end
