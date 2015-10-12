//
//  ITPointAnnotation.h
//  GaoDeTemple
//
//  Created by Apple on 14-7-27.
//  Copyright (c) 2014年 itenyhCom. All rights reserved.
//

typedef enum ITPointAnnotationType_ {
    
	ITPointAnnotationStart,
    ITPointAnnotationEnd,
    ITPointAnnotationOtherCar,
    ITPointAnnotationSelfCar,
    ITPointAnnotationSelf,
    ITPointAnnotationCom
    
} ITPointAnnotationType;

#import <AMapNaviKit/AMapNaviKit.h>

@interface ITImageAnnotation : MAPointAnnotation

@property (nonatomic, readonly, assign) ITPointAnnotationType anootationType;

- (id)initWithType:(ITPointAnnotationType)aType;

@end
