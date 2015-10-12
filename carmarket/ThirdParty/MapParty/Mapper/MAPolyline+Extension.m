//
//  MAPolygon+Extension.m
//  carmarket
//
//  Created by Apple on 14-10-17.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "MAPolyline+Extension.h"
#import <objc/runtime.h>

@interface MAPolyline ()

@property (nonatomic, strong) AMapStep *mapStep;

@end

@implementation MAPolyline (Extension)

static char AMapStepKey;

- (void)setMapStep:(AMapStep *)mapStep {
    objc_setAssociatedObject(self, &AMapStepKey, mapStep, OBJC_ASSOCIATION_ASSIGN);
}

- (AMapStep *)mapStep {
    return objc_getAssociatedObject(self, &AMapStepKey);
}

@end
