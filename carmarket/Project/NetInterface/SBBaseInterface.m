//
//  SBBaseInterface.m
//  carmarket
//
//  Created by itensb on 14-8-11.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBBaseInterface.h"

@implementation SBBaseInterface

+ (void)requestWithUrl_HanHan:(NSString *)url param:(NSDictionary *)param is:(BOOL)get fullContext:(BOOL)fullContext andSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    [SBBaseInterface requestWithUrl:url domain:HANHAN_API_DOMAIN param:param is:get fullContext:fullContext andSuccessBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestWithUrl:(NSString *)url param:(NSDictionary *)param is:(BOOL)get andSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    [SBBaseInterface requestWithUrl:url domain:API_DOMAIN param:param is:get andSuccessBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestWithUrl:(NSString *)url param:(NSDictionary *)param is:(BOOL)get fullContext:(BOOL)fullContext andSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    [SBBaseInterface requestWithUrl:url domain:API_DOMAIN param:param is:get fullContext:fullContext andSuccessBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestWithUrl:(NSString *)url domain:(NSString *)domain param:(NSDictionary *)param is:(BOOL)get fullContext:(BOOL)fullContext andSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    NSMutableDictionary *cusDict = [NSMutableDictionary dictionaryWithDictionary:param];
    
    NSMutableDictionary *headDict = [NSMutableDictionary dictionary];
    [headDict setObject:IT_UUID_APP forKey:@"uniqueness"];
    [headDict setObject:SB_APP_VERSION forKey:@"appversion"];
    [headDict setObject:IT_SYSTEM_VERSION forKey:@"systemversion"];
    [headDict setObject:IT_INTERFACE_VERSION forKey:@"interfaceversion"];
    [headDict setObject:IT_PHONE_MODEL forKey:@"model"];
    [cusDict setObject:headDict forKey:@"head"];
    
    [ITBaseInterface requestWithUrl:[NSString stringWithFormat:@"%@/%@", domain, url] param:cusDict is:get fullContext:fullContext andSuccessBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestWithUrl:(NSString *)url domain:(NSString *)domain param:(NSDictionary *)param is:(BOOL)get andSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    [self requestWithUrl:url domain:domain param:param is:get fullContext:NO andSuccessBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestWithUrl:(NSString *)url pageSize:(int)pageSize pageIndex:(int)pageIndex param:(NSDictionary *)_param is:(BOOL)get successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock
{
    [SBBaseInterface requestWithUrl:url domain:API_DOMAIN pageSize:pageSize pageIndex:pageIndex param:_param is:get successBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestWithUrl:(NSString *)url domain:(NSString *)domain pageSize:(int)pageSize pageIndex:(int)pageIndex param:(NSDictionary *)_param is:(BOOL)get successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:_param];
    if (pageSize > 0) [param setObject:[NSString stringWithFormat:@"%d", pageSize] forKey:@"pageSize"];
    if (pageIndex > 0) [param setObject:[NSString stringWithFormat:@"%d", pageIndex] forKey:@"pageIndex"];
    
//    NSLog(@"param : %@", param);
    
    [SBBaseInterface requestWithUrl:url domain:domain param:param is:NO andSuccessBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestWithUrl:(NSString *)url domain:(NSString *)domain pageNum:(int)pageNum pageIndex:(int)pageIndex param:(NSDictionary *)_param is:(BOOL)get successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:_param];
    if (pageNum > 0) [param setObject:[NSString stringWithFormat:@"%d", pageNum] forKey:@"pageNum"];
    if (pageIndex > 0) [param setObject:[NSString stringWithFormat:@"%d", pageIndex] forKey:@"pageIndex"];
    
//    NSLog(@"param : %@", param);
    
    [SBBaseInterface requestWithUrl:url domain:domain param:param is:NO andSuccessBlock:successBlock andFailBlock:failBlock];
}

#pragma - mark 缓存部分
+ (void)dataCashRequestWithKey:(NSString *)key col:(NSString *)col url:(NSString *)url pageSize:(int)pageSize pageIndex:(int)pageIndex successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock param:(NSDictionary *)param
{
    //只存首页数据
    if (pageIndex <= 1) {
        
        [[SBYapDBManager instance] getDicDataWithKey:key collection:col dataSuccessB:^(id dicData) {
            
            if (dicData) successBlock(dicData);
            
            [SBBaseInterface requestWithUrl:url pageSize:0 pageIndex:0 param:param is:NO successBlock:^(id successValue) {
                
                //对缓存的数据进行严格检测
                if([SBBaseInterface is_valied_data:successValue])
                    [[SBYapDBManager instance] insertDicData:successValue key:key collection:col dataSuccessB:successBlock];
                else NSLog(@"缓存数据不合格~~~");
                
            } andFailBlock:failBlock];
            
        }];
        
    }
    
    else [SBBaseInterface requestWithUrl:url pageSize:pageSize pageIndex:pageIndex param:param is:NO successBlock:successBlock andFailBlock:failBlock];
}

#pragma - mark 辅助函数
+ (BOOL)is_valied_data:(id)data
{
    if([data isKindOfClass:[NSDictionary class]] || [data isKindOfClass:[NSArray class]]) return YES;
    else return NO;
    
}

@end
