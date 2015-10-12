//
//  ITBaseInterface.m
//  CoacoapodsDemo
//
//  Created by Apple on 14-7-22.
//  Copyright (c) 2014年 itenyhCom. All rights reserved.
//

#import "ITBaseInterface.h"
#import "BKNetKit.h"
#import "AppMacro.h"

#import "BKAlertView.h"

@implementation ITBaseInterface

+ (void)getDepartmentRelativeUserWith:(id)param andSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    [ITBaseInterface requestWithUrl:@"http://m.weather.com.cn/data/101110101.html" param:param is:YES andSuccessBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestWithUrl:(NSString *)url param:(NSDictionary *)param is:(BOOL)get fullContext:(BOOL)fullContext andSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
 
    dispatch_async(gAsynQueueT, ^{
        
        NSString *method; if (get) method = @"GET"; else method = @"POST";
        
        id retValue = [BKNetKit invokeTheApi:url withParam:param requestMethod:method];
        
        if([[retValue objectForKey:@"error_code"] intValue] != 100)
        {
            
            dispatch_async(gMainQueueT, ^{
                if (![BKAlertView isExisting])
                    [BKAlertView showErrorMsg:@"网络异常" inview:[SBUtil getAppDelegate].rootNavi.view offsetY:([ITUIKitHelper getAppHeight] - TankHeight) / 2];
                
                
                failBlock(retValue);
                NSLog(@"retValue : %@", [retValue objectForKey:@"error_description"]);
            });
        }
        
        else {
            dispatch_async(gMainQueueT, ^{
                if (fullContext) successBlock(retValue);
                else {
                    id val = [retValue objectForKey:@"data"];
                    successBlock(val);
                }
                
            });
        }
        
    });

}

+ (void)requestWithUrl:(NSString *)url param:(NSDictionary *)param is:(BOOL)get andSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    [ITBaseInterface requestWithUrl:url param:param is:get fullContext:NO andSuccessBlock:successBlock andFailBlock:failBlock];
}

+ (void)requestVersionCheckWithAppId:(NSString *)app_id andSuccessBlock:(void (^)(id successValue))successBlock andFailBlock:(void (^)(id failValue))failBlock
{
    [ITBaseInterface requestWithUrl:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", app_id] param:nil is:NO fullContext:YES andSuccessBlock:^(id successValue) {
        
        NSArray *array = [successValue objectForKey:@"results"];
        
        if (array && array.count > 0) {
            
            NSDictionary *dict = array[0];
            
            if (dict) {
                
                NSString *storeVersion = [dict objectForKey:@"version"];
                
                if (storeVersion) {
                    
                    int result = [ITUtils compareVersions:storeVersion version2:IT_APP_VERSION];

                    //有更新
                    if (result == 1) successBlock([[NSString alloc] initWithString:storeVersion]);
                    
                }
            
                
            }

            
        }
        
        
        
        
    } andFailBlock:^(id failValue) {
        
    }];
}


@end
