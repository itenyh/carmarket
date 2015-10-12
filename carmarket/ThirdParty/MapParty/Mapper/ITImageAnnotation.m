//
//  ITPointAnnotation.m
//  GaoDeTemple
//
//  Created by Apple on 14-7-27.
//  Copyright (c) 2014年 itenyhCom. All rights reserved.
//

#import "ITImageAnnotation.h"

@implementation ITImageAnnotation
@synthesize anootationType;

- (id)init
{
    self = [super init];
    
    if (self) {
        
        anootationType = ITPointAnnotationOtherCar;
        
    }
    
    return self;
}

- (id)initWithType:(ITPointAnnotationType)aType
{
    self = [super init];
    
    if (self) {
        
        anootationType = aType;
        
    }
    
    return self;
}

@end
