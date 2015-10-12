//
//  ITMapper.h
//  GaoDeTemple
//
//  Created by Apple on 14-7-24.
//  Copyright (c) 2014年 itenyhCom. All rights reserved.
//

#import "CommonUtility.h"
#import "ITImageAnnotation.h"
#import "LineDashPolyline.h"

#import <Foundation/Foundation.h>
#import <AMapNaviKit/AMapNaviKit.h>

#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlySetting.h"

typedef void (^MapCurLocationB)(MAUserLocation *response, NSError *error);

typedef void (^CalculateRouteSuccessB)(AMapNaviManager *naviManager);
typedef void (^CalculateRouteFailB)(AMapNaviManager *naviManager);
typedef void (^NaviRouteFinishB)(AMapNaviManager *naviManager);

@interface ITMapper : NSObject <MAMapViewDelegate, AMapNaviManagerDelegate, CLLocationManagerDelegate, IFlySpeechSynthesizerDelegate, AMapNaviViewControllerDelegate>
{
    MapCurLocationB curLocationB;
    
    CalculateRouteSuccessB calculateRouteSuccessB;
    CalculateRouteFailB calculateRouteFailB;
    NaviRouteFinishB naviRouteFinishB;
    
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) MAMapView *naviMapView;
@property (nonatomic, strong) AMapNaviManager *naviManager;
@property (nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;

+ (ITMapper *)instance;

- (void)getUserCurLocationWithResult:(MapCurLocationB)block;

- (void)calculateDriveRouteWithStartPoints:(NSArray *)startPoints
                                 endPoints:(NSArray *)endPoints
                                 wayPoints:(NSArray *)wayPoints
                           drivingStrategy:(AMapNaviDrivingStrategy)strategy response:(CalculateRouteSuccessB)response fail:(CalculateRouteFailB)fail;
- (void)naviDriveRouteWithEndPoints:(float)longitude latitude:(float)latitude drivingStrategy:(AMapNaviDrivingStrategy)strategy response:(CalculateRouteSuccessB)response fail:(CalculateRouteFailB)fail finish:(NaviRouteFinishB)finish;

- (void)clearMapView;
- (void)clearAddedViews;

@end
