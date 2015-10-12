//
//  ITSearcher.m
//  GaoDeTemple
//
//  Created by Apple on 14-7-24.
//  Copyright (c) 2014年 itenyhCom. All rights reserved.
//

#import "ITMapSearcher.h"
#import "UtilsMacro.h"

@implementation ITMapSearcher

SYNTHESIZE_SINGLETON_FOR_CLASS_WITHOUTINIT(ITMapSearcher);

+ (ITMapSearcher *)instance
{
    @synchronized(self)
    {
        if (sharedITMapSearcher == nil)
        {
            sharedITMapSearcher = [ITMapSearcher new];
            sharedITMapSearcher.searcher = [[AMapSearchAPI alloc] initWithSearchKey:@"40bab99a13ad99654f55bcd592ec9bfc" Delegate:sharedITMapSearcher];
        }
    }
    return sharedITMapSearcher;
}

- (void)clearSearch
{

}

- (void)GDSearchGeocodeWithKey:(NSString *)key adcode:(NSString *)adcode searchResult:(MapGeoSearchResultB)block
{
    geoSearchResultB = block;
    
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
    geo.address = key;
    
    if (adcode.length > 0) geo.city = @[adcode];
    
    [sharedITMapSearcher.searcher AMapGeocodeSearch:geo];
}

- (void)GDSearchTipsWithKey:(NSString *)key searchResult:(MapTipsSearchResultB)block
{
    tipsSearchResultB = block;
    
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.keywords = key;
    [sharedITMapSearcher.searcher AMapInputTipsSearch:tips];
}

/* 驾车导航搜索. */
- (void)searchNaviDrive:(CLLocationCoordinate2D)start end:(CLLocationCoordinate2D)end searchResult:(MapRouteDriveSearchResultB)block
{
    
    routeDriveSearchResultB = block;

    AMapNavigationSearchRequest *navi = [[AMapNavigationSearchRequest alloc] init];
    navi.searchType       = AMapSearchType_NaviDrive;
    navi.requireExtension = YES;
    
    /* 出发点. */
    navi.origin = [AMapGeoPoint locationWithLatitude:start.latitude
                                           longitude:start.longitude];
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:end.latitude
                                                longitude:end.longitude];
    
    [sharedITMapSearcher.searcher AMapNavigationSearch:navi];
}

#pragma -mark search delegate
#pragma mark - AMapSearchDelegate
/* 导航搜索回调. */
- (void)onNavigationSearchDone:(AMapNavigationSearchRequest *)request
                      response:(AMapNavigationSearchResponse *)response
{
    routeDriveSearchResultB(response);
}

/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    tipsSearchResultB(response);
}

/* 地理编码回调.*/
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    geoSearchResultB(response);
}


@end
