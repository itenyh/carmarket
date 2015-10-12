//
//  SBActivityVCInterface.m
//  carmarket
//
//  Created by Apple on 14-9-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBActivityVCInterface.h"

@implementation SBActivityVCInterface

+ (void)requestActivityCancel:(NSString *)userID actionId:(NSString *)actionId successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (userID) [param setObject:userID forKey:@"userId"];
    if (actionId) [param setObject:actionId forKey:@"actionId"];
    
    [SBBaseInterface requestWithUrl:@"action/cancel" param:param is:NO fullContext:YES andSuccessBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestActivityApply:(NSString *)userID actionId:(NSString *)actionId successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (userID) [param setObject:userID forKey:@"userId"];
    if (actionId) [param setObject:actionId forKey:@"actionId"];
    
    [SBBaseInterface requestWithUrl:@"action/apply" param:param is:NO fullContext:YES andSuccessBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestActivityDetail:(NSString *)userID actionId:(NSString *)actionId successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (userID) [param setObject:userID forKey:@"userId"];
    if (actionId) [param setObject:actionId forKey:@"actionId"];
    
    [SBBaseInterface requestWithUrl:@"action/actionDetail" param:param is:NO fullContext:NO andSuccessBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestActivityList:(NSString *)userID time:(NSString *)time pageSize:(int)pageSize pageIndex:(int)pageIndex successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (userID) [param setObject:userID forKey:@"userId"];
    if (time) [param setObject:time forKey:@"time"];
    if (pageSize > 0) [param setObject:[NSString stringWithFormat:@"%d", pageSize] forKey:@"pageSize"];
    if (pageIndex > 0) [param setObject:[NSString stringWithFormat:@"%d", pageIndex] forKey:@"page"];
    
    [SBBaseInterface requestWithUrl:@"action/findlist" param:param is:NO andSuccessBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestCreateActivity:(NSDictionary *)param successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock
{
    NSString *urlEncodedString = @"";
    
    if (param) {
 
        NSString *jsonString = [param JSONString];
        urlEncodedString = [ITUtils urlencode:jsonString];

    }

    [SBBaseInterface requestWithUrl:[NSString stringWithFormat:@"action/add?paramJson=%@", urlEncodedString] param:nil is:NO fullContext:YES andSuccessBlock:successBlock andFailBlock:failBlock];

}

+ (void)requestDeleteActivity:(NSString *)userId actionId:(NSString *)actionId successBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (userId) [param setObject:userId forKey:@"userId"];
    if (actionId) [param setObject:actionId forKey:@"actionId"];
    
    [SBBaseInterface requestWithUrl:@"action/cancelAction" param:param is:NO fullContext:YES andSuccessBlock:successBlock andFailBlock:failBlock];
}

//版本检测
+ (void)requestVersionCheckSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    [SBBaseInterface requestWithUrl:@"version/check" param:nil is:NO fullContext:YES andSuccessBlock:successBlock andFailBlock:failBlock];
}

//修改密码
+ (void)requestPsModify:(NSString *)old new:(NSString *)new phone:(NSString *)phone uid:(NSString *)uid SuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:phone, @"phone", [ITUtils md5HexDigest:old], @"oldPwd", [ITUtils md5HexDigest:new], @"newPwd", uid, @"userId", nil];
    
    [SBBaseInterface requestWithUrl:@"user/modifypwd" param:param is:NO fullContext:YES andSuccessBlock:successBlock andFailBlock:failBlock];
}

@end
