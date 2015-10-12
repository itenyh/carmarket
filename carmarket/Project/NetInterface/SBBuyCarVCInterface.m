//
//  SBBuyCarVCInterface.m
//  carmarket
//
//  Created by itensb on 14-8-28.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBBuyCarVCInterface.h"

@implementation SBBuyCarVCInterface

+ (void)requestLowPriceActivities:(NSDictionary *)param pageSize:(int)pageSize pageIndex:(int)pageIndex isCache:(BOOL)is successBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    NSMutableDictionary *_param = [NSMutableDictionary dictionaryWithObject:@"2" forKey:@"orderType"];
    if (param) [_param addEntriesFromDictionary:param];

    if (is) [SBBaseInterface dataCashRequestWithKey:@"JiangJia" col:@"SBBuyCar" url:@"car/cutprice" pageSize:pageSize pageIndex:pageIndex successBlock:successBlock andFailBlock:failBlock param:_param];
    else [SBBaseInterface requestWithUrl:@"car/cutprice" pageSize:pageSize pageIndex:pageIndex param:_param is:NO successBlock:successBlock andFailBlock:failBlock];

}

+ (void)requestLowPriceActivityDetail:(NSString *)activityId successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock
{
    [SBBaseInterface requestWithUrl:[NSString stringWithFormat:@"car/cutprice/%@", activityId] param:nil is:NO andSuccessBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestUsedCar:(NSString *)carModelId pageSize:(int)pageSize pageIndex:(int)pageIndex successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (carModelId) [param setObject:carModelId forKey:@"carModelId"];
    
    [SBBaseInterface dataCashRequestWithKey:@"ErShou" col:@"SBBuyCar" url:@"usedcar" pageSize:pageSize pageIndex:pageIndex successBlock:successBlock andFailBlock:failBlock param:param];
}

+ (void)requestDealerInfo:(NSString *)dealerId successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock
{
    [SBBaseInterface requestWithUrl:[NSString stringWithFormat:@"dealer/%@", dealerId] param:nil is:NO andSuccessBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestUsedCarDetail:(NSString *)carModelId successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock
{
    [SBBaseInterface requestWithUrl:[NSString stringWithFormat:@"usedcar/%@", carModelId] param:nil is:NO andSuccessBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestDiscountCar:(NSString *)carModelId pageSize:(int)pageSize pageIndex:(int)pageIndex successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (carModelId) [param setObject:carModelId forKey:@"carModelId"];
    
    [SBBaseInterface dataCashRequestWithKey:@"YouHui" col:@"SBBuyCar" url:@"car/discount" pageSize:pageSize pageIndex:pageIndex successBlock:successBlock andFailBlock:failBlock param:param];
    
}

//平行进口车
+ (void)requestPinxingCar:(NSString *)carModelId pageSize:(int)pageSize pageIndex:(int)pageIndex successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (carModelId) [param setObject:carModelId forKey:@"carModelId"];
    
    [SBBaseInterface dataCashRequestWithKey:@"parallelCar" col:@"SBBuyCar" url:@"parallelcar" pageSize:pageSize pageIndex:pageIndex successBlock:successBlock andFailBlock:failBlock param:param];
    
}

+ (void)requestPinxingCarDetail:(NSString *)pId successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock
{
    [SBBaseInterface requestWithUrl:[NSString stringWithFormat:@"parallelcar/%@", pId] param:nil is:NO andSuccessBlock:successBlock andFailBlock:failBlock];
}

#pragma - mark 辅助函数


@end
