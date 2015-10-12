//
//  SBBuyCarVCInterface.h
//  carmarket
//
//  Created by itensb on 14-8-28.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBBaseInterface.h"

@interface SBBuyCarVCInterface : SBBaseInterface

+ (void)requestLowPriceActivities:(NSDictionary *)param pageSize:(int)pageSize pageIndex:(int)pageIndex isCache:(BOOL)is successBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestLowPriceActivityDetail:(NSString *)activityId successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestUsedCar:(NSString *)carModelId pageSize:(int)pageSize pageIndex:(int)pageIndex successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;
+ (void)requestUsedCarDetail:(NSString *)carModelId successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestDealerInfo:(NSString *)dealerId successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestDiscountCar:(NSString *)carModelId pageSize:(int)pageSize pageIndex:(int)pageIndex successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestPinxingCar:(NSString *)carModelId pageSize:(int)pageSize pageIndex:(int)pageIndex successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestPinxingCarDetail:(NSString *)pId successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;

@end
