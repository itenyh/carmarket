//
//  SBLogRegisterVCInterface.m
//  carmarket
//
//  Created by Apple on 14-9-11.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBLogRegisterVCInterface.h"

@implementation SBLogRegisterVCInterface

+ (void)requestRegisterWith:(NSString *)phone successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (phone) [param setObject:phone forKey:@"userPhone"];
    
    [SBBaseInterface requestWithUrl:@"user/register" param:param is:NO fullContext:YES andSuccessBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestLogWithUser:(NSString *)user ps:(NSString *)ps successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (user) [param setObject:user forKey:@"phone"];
    if (ps) [param setObject:[ITUtils md5HexDigest:ps] forKey:@"password"];
    
    [SBBaseInterface requestWithUrl:@"user/login" param:param is:NO fullContext:YES andSuccessBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestForgetPs:(NSString *)phone successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (phone) [param setObject:phone forKey:@"phone"];
    
    [SBBaseInterface requestWithUrl:@"user/getpwd" param:param is:NO fullContext:YES andSuccessBlock:successBlock andFailBlock:failBlock];
}

//注册设备Token4推送
+ (void)requestTokenRegisterWith:(NSString *)token successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (token) [param setObject:token forKey:@"imei"];
    [param setObject:@"1" forKey:@"jsonPost"];
    
    [SBBaseInterface requestWithUrl_HanHan:@"api/devices/" param:param is:NO fullContext:YES andSuccessBlock:successBlock andFailBlock:failBlock];
}

//获取欢迎广告页面
+ (void)requestAd_picsSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    NSString *pre_fix = @"http://7u2gbt.com1.z0.glb.clouddn.com/ad_#.png";
    int up_num = 3; //最多三张图片
    
//    [ITBaseInterface requestWithUrl:<#(NSString *)#> param:<#(NSDictionary *)#> is:<#(BOOL)#> fullContext:<#(BOOL)#> andSuccessBlock:<#^(id successValue)successBlock#> andFailBlock:<#^(id failValue)failBlock#>]
    
    
}

@end
