//
//  ITSearcher.h
//  GaoDeTemple
//
//  Created by Apple on 14-7-24.
//  Copyright (c) 2014年 itenyhCom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^MapTipsSearchResultB)(id response);
typedef void (^MapGeoSearchResultB)(id response);
typedef void (^MapRouteDriveSearchResultB)(AMapNavigationSearchResponse *response);

@interface ITMapSearcher : NSObject <AMapSearchDelegate>
{
    MapTipsSearchResultB tipsSearchResultB;
    MapGeoSearchResultB geoSearchResultB;
    MapRouteDriveSearchResultB routeDriveSearchResultB;
}

@property (nonatomic, strong) AMapSearchAPI *searcher;

+ (ITMapSearcher *)instance;

- (void)GDSearchTipsWithKey:(NSString *)key searchResult:(MapTipsSearchResultB)block;
- (void)GDSearchGeocodeWithKey:(NSString *)key adcode:(NSString *)adcode searchResult:(MapGeoSearchResultB)block;
- (void)searchNaviDrive:(CLLocationCoordinate2D)start end:(CLLocationCoordinate2D)end searchResult:(MapRouteDriveSearchResultB)block;

- (void)clearSearch;

@end
