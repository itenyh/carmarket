//
//  SBLogRegisterVCInterface.h
//  carmarket
//
//  Created by Apple on 14-9-11.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBBaseInterface.h"

@interface SBLogRegisterVCInterface : SBBaseInterface

+ (void)requestLogWithUser:(NSString *)user ps:(NSString *)ps successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestRegisterWith:(NSString *)phone successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestForgetPs:(NSString *)phone successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestTokenRegisterWith:(NSString *)token successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;

@end
