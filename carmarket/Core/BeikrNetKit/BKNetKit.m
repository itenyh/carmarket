//
//  BKNetKit.m
//  iRally
//
//  Created by 蔡凌 on 13-9-4.
//  Copyright (c) 2013年 蔡凌. All rights reserved.
//

#import "BKNetKit.h"
#import "Reachability.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
//#import "SBJson.h"
#import "JSONKit.h"

static long totalsize=0;
static int loopDepth = 0;

@implementation BKNetKit

+ (BKNetType)getNowNetSituation
{
    //获取当前网络状态
    BKNetType retValue;
    Reachability *t = [Reachability reachabilityWithHostname:@"www.apple.com"];
    switch ([t currentReachabilityStatus]) {
        case NotReachable:
            retValue = BKNet_NONE;    //没有网络
            break;
            
        case ReachableViaWWAN:
            retValue = BKNet_WWAN;    //WWAN网络
            break;
            
        case ReachableViaWiFi:
            retValue = BKNet_WIFI;    //WIFI网络
            break;
            
        default:
            retValue = BKNet_NONE;
            break;
    }
    return retValue;
}

+ (id)invokeTheApi:(NSString *)apiName withParam:(NSDictionary *)param requestMethod:(NSString *)method
{
    
//    NSLog(@"调用API接口 -> apiName: %@", apiName);
    
    ASIFormDataRequest *requstHttp  = [[ASIFormDataRequest alloc] init];
    [requstHttp setRequestMethod:method];
	[requstHttp setAllowCompressedResponse:YES];
	[requstHttp setStringEncoding:NSUTF8StringEncoding];
    [requstHttp setUseSessionPersistence:YES];
    [requstHttp setUseCookiePersistence:YES];
    [requstHttp setTimeOutSeconds:NETREQUEST_TIMEOUT];
    
    [requstHttp setPostFormat:ASIURLEncodedPostFormat];
    
//    requstHttp.numberOfTimesToRetryOnTimeout = 4;

    NSMutableString *url = [NSMutableString stringWithFormat:@"%@", apiName];
    
    //加入头部
    NSDictionary *headParams = [param objectForKey:@"head"];
    if (headParams) {
        for(NSString *subKey in headParams)
        {
            NSString *p = [headParams objectForKey:subKey];
            [requstHttp addRequestHeader:subKey value:p];
            
        }
    }
    
    //自定义参数录入
    if (param) {
        
        if ([requstHttp.requestMethod isEqualToString:@"GET"]) {
            
            int index = 0;
            NSArray *paramKeys = [param allKeys];
            if (paramKeys != nil) {
                for(NSString *subKey in paramKeys)
                {
                    if ([subKey isEqualToString:@"head"]) continue;
                    
                    if (index == 0) {
                        [url appendFormat:@"?%@=%@", subKey, [param objectForKey:subKey]];
                    }
                    
                    else {
                        [url appendFormat:@"&%@=%@", subKey, [param objectForKey:subKey]];
                    }
                    
                    index++;
                }
            }
            
        }
        
        //POST
        else {
            
            NSArray *paramKeys = [param allKeys];
            BOOL isJsonPost = NO;
            for (NSString *str in paramKeys) {
                if ([str isEqualToString:@"jsonPost"]) {isJsonPost = YES; break;}
            }
            
            if (paramKeys != nil && !isJsonPost) {
                
                for(NSString *subKey in paramKeys)
                {
                    if ([subKey isEqualToString:@"head"]) continue;
                    
                    NSString *p = [param objectForKey:subKey];
                    [requstHttp addPostValue:p forKey:subKey];
                }
            }
            
            else if(paramKeys != nil && isJsonPost) {
                
                NSMutableData *postDatas = nil;
                NSMutableDictionary *mulDic = [NSMutableDictionary dictionaryWithDictionary:param];
                if ([NSJSONSerialization isValidJSONObject:mulDic]) {
                    
                    postDatas = [NSMutableData dataWithData:[NSJSONSerialization dataWithJSONObject:mulDic options:NSJSONWritingPrettyPrinted error:nil]];
                    NSString *str = [[NSString alloc] initWithData:postDatas encoding:NSUTF8StringEncoding];
                    postDatas = [NSMutableData dataWithBytes:[str UTF8String] length:[str length]];
                    [requstHttp setPostBody:postDatas];
                }
                
            }
            
        }
        
        
        
    }
    
    //开始发送请求
    requstHttp.url = [NSURL URLWithString:url];
    [requstHttp buildRequestHeaders];
    [requstHttp startSynchronous];
    
    if([requstHttp error])
    {
        NSLog(@"%@", [requstHttp error]);
        return [BKNetKit returnError:901 errStr:@"request_failed" errDesc:@"网络连接异常"];
    }
    
    @try {
        
		if ([requstHttp isResponseCompressed]) totalsize += [[requstHttp rawResponseData] length];
        else totalsize += [[requstHttp responseData] length];
//        NSLog(@"%@", [requstHttp responseString]);
		if ([requstHttp responseString] == nil || [[requstHttp responseString] length] == 0) {
            return [BKNetKit returnError:902 errStr:@"request_failed" errDesc:@"返回数据异常"];
        }
        
        id retDic = [BKNetKit jsonValueFromStr:[requstHttp responseString]];
		
        if(retDic != nil && [retDic isKindOfClass:[NSDictionary class]]) {
            
            if ([retDic objectForKey:@"error_code"] == nil) {
                //无error_code也作为正确值
                NSMutableDictionary *resutlDic = [NSMutableDictionary dictionaryWithDictionary:retDic];
                [resutlDic setObject:[NSNumber numberWithInt:100] forKey:@"error_code"];
                return resutlDic;
            }
            
            if([[retDic objectForKey:@"error_code"] intValue] == 106) {
                return [BKNetKit returnError:903 errStr:@"invalid_json" errDesc:@"其他异常"];
            }
            
            else if([[retDic objectForKey:@"error_code"] intValue] == 100) {
                //正确返回
                return retDic;
    
            }
            
        }
        
        else {
            return [BKNetKit returnError:902 errStr:@"request_failed" errDesc:@"返回数据异常"];
			loopDepth = 0;
		}
        
    }
    
    @catch (NSException *exception) {
        return [BKNetKit returnError:904 errStr:@"invalid_json" errDesc:@"exception异常"];
    }
    
    return nil;
}

#pragma -mark 私有函数
+ (NSDictionary *)returnError:(NSInteger)code errStr:(NSString *)errStr errDesc:(NSString *)errDesc {
	return [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", code], @"error_code", errStr, @"error", errDesc, @"error_description", nil];
}

+ (id)jsonValueFromStr:(NSString *)targetStr
{
//    SBJsonParser *jsPar = [[SBJsonParser alloc] init];
//    return [jsPar objectWithString:targetStr];
    return [targetStr mutableObjectFromJSONString];
}

@end
