//
//  SBActivityVCInterface.h
//  carmarket
//
//  Created by Apple on 14-9-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBBaseInterface.h"

@interface SBActivityVCInterface : SBBaseInterface

+ (void)requestActivityList:(NSString *)userID time:(NSString *)time pageSize:(int)pageSize pageIndex:(int)pageIndex successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestCreateActivity:(NSDictionary *)param successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestActivityDetail:(NSString *)userID actionId:(NSString *)actionId successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestActivityCancel:(NSString *)userID actionId:(NSString *)actionId successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestDeleteActivity:(NSString *)userId actionId:(NSString *)actionId successBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestActivityApply:(NSString *)userID actionId:(NSString *)actionId successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestVersionCheckSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestPsModify:(NSString *)old new:(NSString *)new phone:(NSString *)phone uid:(NSString *)uid SuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;

@end
