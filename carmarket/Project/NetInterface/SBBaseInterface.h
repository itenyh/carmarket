//
//  SBBaseInterface.h
//  carmarket
//
//  Created by itensb on 14-8-11.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "ITBaseInterface.h"
#import "JSONKit.h"
#import "SBLoadingViewFactory.h"
#import "SBYapDBManager.h"

@interface SBBaseInterface : ITBaseInterface

+ (void)requestWithUrl:(NSString *)url pageSize:(int)pageSize pageIndex:(int)pageIndex param:(NSDictionary *)_param is:(BOOL)get successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestWithUrl:(NSString *)url domain:(NSString *)domain param:(NSDictionary *)param is:(BOOL)get andSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestWithUrl:(NSString *)url domain:(NSString *)domain pageNum:(int)pageNum pageIndex:(int)pageIndex param:(NSDictionary *)_param is:(BOOL)get successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestWithUrl:(NSString *)url param:(NSDictionary *)param is:(BOOL)get fullContext:(BOOL)fullContext andSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestWithUrl_HanHan:(NSString *)url param:(NSDictionary *)param is:(BOOL)get fullContext:(BOOL)fullContext andSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock;

//只缓存首页
+ (void)dataCashRequestWithKey:(NSString *)key col:(NSString *)col url:(NSString *)url pageSize:(int)pageSize pageIndex:(int)pageIndex successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock param:(NSDictionary *)param;

@end
