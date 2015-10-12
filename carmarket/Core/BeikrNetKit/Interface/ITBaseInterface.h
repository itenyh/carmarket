//
//  ITBaseInterface.h
//  CoacoapodsDemo
//
//  Created by Apple on 14-7-22.
//  Copyright (c) 2014年 itenyhCom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITBaseInterface : NSObject

+ (void)getDepartmentRelativeUserWith:(id)param andSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestWithUrl:(NSString *)url param:(NSDictionary *)param is:(BOOL)get andSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestWithUrl:(NSString *)url param:(NSDictionary *)param is:(BOOL)get fullContext:(BOOL)fullContext andSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestVersionCheckWithAppId:(NSString *)app_id andSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;

@end
