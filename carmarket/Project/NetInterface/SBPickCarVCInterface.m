//
//  SBPickCarVCInterface.m
//  carmarket
//
//  Created by itensb on 14-8-25.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBPickCarVCInterface.h"
#import "ASIFormDataRequest.h"

#import "SBYapDBManager.h"

@implementation SBPickCarVCInterface

+ (void)requestHotBrandCarSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    [SBBaseInterface dataCashRequestWithKey:@"HotBrand" col:@"SBPickCar" url:@"car/brand/hot" pageSize:0 pageIndex:0 successBlock:successBlock andFailBlock:failBlock param:nil];
    
}

+ (void)requestAllBrandCarSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    SBLoadingViewFactory *loadingFactory = [SBLoadingViewFactory new];
    
    [SBBaseInterface dataCashRequestWithKey:@"AllBrand" col:@"SBPickCar" url:@"car/brand/all" pageSize:0 pageIndex:0 successBlock:^(id successValue) {
        
        [loadingFactory stopView];
        successBlock(successValue);
        
    } andFailBlock:^(id failValue) {
        
        [loadingFactory stopView];
        failBlock(failValue);
        
    } param:nil];
    
}

+ (void)requestBrandCarModelWithBrandId:(NSString *)brandId SuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    SBLoadingViewFactory *loadingFactory = [SBLoadingViewFactory new];
    
    [SBBaseInterface dataCashRequestWithKey:brandId col:@"BrandCarModel" url:[NSString stringWithFormat:@"car/brand/%@/model", brandId] pageSize:0 pageIndex:0 successBlock:^(id successValue) {
        
        [loadingFactory stopView];
        successBlock(successValue);
        
    } andFailBlock:^(id failValue) {
        
        [loadingFactory stopView];
        failBlock(failValue);
        
    } param:nil];
    
}

+ (void)requestBrandCarSearchWithKeyword:(NSString *)key SuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    key = [ITUtils urlencode:key];
    [SBBaseInterface requestWithUrl:[NSString stringWithFormat:@"car/brand/query/model/bykeyword?keyword=%@", key] param:nil is:NO andSuccessBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestCarModelWith:(NSString *)brandID model:(NSString *)model SuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    [SBBaseInterface requestWithUrl:[NSString stringWithFormat:@"car/brand/%@/model/%@/style", brandID, model] param:nil is:NO andSuccessBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestCarOilCostWith:(NSString *)brandID model:(NSString *)model SuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    [SBBaseInterface requestWithUrl:[NSString stringWithFormat:@"car/brand/%@/model/%@/oilwear", brandID, model] param:nil is:NO andSuccessBlock:successBlock andFailBlock:failBlock];
}

//根据条件选车
+ (void)requestConditionedCar:(NSDictionary *)conditions successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock params:(NSString *)param, ... NS_REQUIRES_NIL_TERMINATION
{
    va_list args;
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    NSString *oldObj;
    NSString *obj = param;
    int index = 0;
    
    va_start(args, param);
    while (obj != NULL) {
        oldObj = obj;
        obj = va_arg(args, NSString *);
        
        if (index++ % 2 == 0) {
            [result setObject:oldObj forKey:obj];
        }
    
    }
    va_end(args);
    
    SBLoadingViewFactory *loadingFactory = [SBLoadingViewFactory new];
    [loadingFactory showInView:[SBUtil getLoadingViewControllerView]];
    
    NSString *jsonString = [conditions JSONString];
    NSString *urlEncodedString = [ITUtils urlencode:jsonString];
    
    [SBBaseInterface requestWithUrl:[NSString stringWithFormat:@"car/brand/query/model?paramJson=%@", urlEncodedString] param:result is:NO andSuccessBlock:^(id successValue) {
        [loadingFactory stopView];
        successBlock(successValue);
    } andFailBlock:^(id failValue) {
        [loadingFactory stopView];
        failBlock(failValue);
    }];
    
}

//车款属性
+ (void)requestAttributeCarStyle:(NSString *)brandID model:(NSString *)model styleId:(NSString *)styleId SuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    [SBBaseInterface requestWithUrl:[NSString stringWithFormat:@"car/brand/%@/model/%@/style/%@/attr", brandID, model, styleId] param:nil is:NO andSuccessBlock:successBlock andFailBlock:failBlock];
}

//车款属性根据carstyleId
+ (void)requestAttributeCarStyle:(NSString *)styleId SuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    [SBBaseInterface requestWithUrl:[NSString stringWithFormat:@"/car/style/%@/attr",  styleId] param:nil is:NO andSuccessBlock:successBlock andFailBlock:failBlock];
}

//提供车款的商家
+ (void)requestVenderCarStyle:(NSString *)brandID model:(NSString *)model styleId:(NSString *)styleId SuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    [SBBaseInterface requestWithUrl:[NSString stringWithFormat:@"car/brand/%@/model/%@/style/%@/dealer", brandID, model, styleId] param:nil is:NO andSuccessBlock:successBlock andFailBlock:failBlock];
}

@end
