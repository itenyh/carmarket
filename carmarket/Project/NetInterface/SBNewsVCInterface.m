//
//  SBNewsVCInterface.m
//  carmarket
//
//  Created by itensb on 14-9-9.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBNewsVCInterface.h"

#import "SBYapDBManager.h"

@implementation SBNewsVCInterface

+ (void)requestNewsTypeWithsuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{

    SBLoadingViewFactory *loadingFactory = [SBLoadingViewFactory new];
    
    [[SBYapDBManager instance] getDicDataWithKey:@"NewsType" collection:@"SBNews" dataSuccessB:^(id dicData) {
        
        if (dicData) successBlock(dicData);
        
        else [loadingFactory showInView:[SBUtil getLoadingViewControllerView]];
        
        [SBBaseInterface requestWithUrl:@"type" domain:API_NEWS_DOMAIN param:nil is:NO andSuccessBlock:^(id successValue) {
            
            [[SBYapDBManager instance] insertDicData:successValue key:@"NewsType" collection:@"SBNews" dataSuccessB:successBlock];
            [loadingFactory stopView];
            
        } andFailBlock:^(id failValue) {
           
            [loadingFactory stopView];
            failBlock(failValue);
            
        }];
        
    }];
}

+ (void)requestNewsWithTypeId:(NSString *)typeId pageNum:(int)pageNum pageIndex:(int)pageIndex successBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (typeId) [param setObject:typeId forKey:@"typeId"];
    
    //只存首页数据
    if (pageNum <= 1) {
        
        
        [[SBYapDBManager instance] getDicDataWithKey:typeId collection:@"SBNews" dataSuccessB:^(id dicData) {
            
            if (dicData) successBlock(dicData);
            
            [SBBaseInterface requestWithUrl:@"news" domain:API_NEWS_DOMAIN pageNum:pageNum pageIndex:-1 param:param is:NO successBlock:^(id successValue) {
                
                if (pageNum == 1) {
                    [[SBYapDBManager instance] insertDicData:successValue key:typeId collection:@"SBNews" dataSuccessB:successBlock];
                }
                else {
                    successBlock(successValue);
                }
                
            } andFailBlock:failBlock];
            
        }];
        
    }
    
    else {
        
        [SBBaseInterface requestWithUrl:@"news" domain:API_NEWS_DOMAIN pageNum:pageNum pageIndex:-1 param:param is:NO successBlock:successBlock andFailBlock:failBlock];
        
    }
    
}

+ (void)requestWithUrl:(NSString *)url domain:(NSString *)domain param:(NSDictionary *)param is:(BOOL)get andSuccessBlock:(void (^)(id))successBlock andFailBlock:(void (^)(id))failBlock
{
    
}

@end
