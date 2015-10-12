//
//  SBPickCarVCInterface.h
//  carmarket
//
//  Created by itensb on 14-8-25.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBBaseInterface.h"

@interface SBPickCarVCInterface : SBBaseInterface

+ (void)requestHotBrandCarSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;
+ (void)requestAllBrandCarSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;
+ (void)requestBrandCarModelWithBrandId:(NSString *)brandId SuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;
+ (void)requestBrandCarSearchWithKeyword:(NSString *)key SuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;
+ (void)requestCarModelWith:(NSString *)brandID model:(NSString *)model SuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;
+ (void)requestCarOilCostWith:(NSString *)brandID model:(NSString *)model SuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;
+ (void)requestConditionedCar:(NSDictionary *)conditions successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock params:(NSString *)param, ... NS_REQUIRES_NIL_TERMINATION;
+ (void)requestAttributeCarStyle:(NSString *)brandID model:(NSString *)model styleId:(NSString *)styleId SuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;
+ (void)requestAttributeCarStyle:(NSString *)styleId SuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;
+ (void)requestVenderCarStyle:(NSString *)brandID model:(NSString *)model styleId:(NSString *)styleId SuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;
@end
