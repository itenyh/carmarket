//
//  SBMapActivityViewController.h
//  carmarket
//
//  Created by itensb on 14-8-19.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBBaseViewController.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface SBMapActivityViewController : SBBaseViewController

@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) NSMutableArray *annotations;
@property (nonatomic, strong) NSMutableDictionary *info;

/* 起始点经纬度. */
@property (nonatomic) CLLocationCoordinate2D startCoordinate;
/* 终点经纬度. */
@property (nonatomic) CLLocationCoordinate2D destinationCoordinate;

@end
