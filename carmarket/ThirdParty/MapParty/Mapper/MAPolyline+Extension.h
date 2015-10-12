//
//  MAPolygon+Extension.h
//  carmarket
//
//  Created by Apple on 14-10-17.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface MAPolyline (Extension)

- (void)setMapStep:(AMapStep *)mapStep;
- (AMapStep *)mapStep;
    
@end
