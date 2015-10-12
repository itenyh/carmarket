//
//  SBUtil.m
//  carmarket
//
//  Created by itensb on 14-8-26.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBUtil.h"
#import "SBTabBarController.h"
#import "SBWebViewController.h"
#import "SBNewsWebViewController.h"
#import "SBRequestParamBus.h"

@implementation SBUtil

+ (NSURL *)getUserHeadImgUrlWith:(NSDictionary *)dic
{
    return [NSURL URLWithString:[dic objectForKey:@"userAvatar"]];
}

+ (NSURL *)getNewsImgURLWith:(NSDictionary *)dic
{
    return [NSURL URLWithString:[dic objectForKey:@"titleMinImg"]];
}

+ (NSURL *)getLowPriceActivityImgURLWith:(NSDictionary *)dic
{
    return [SBUtil getImgURLWith:dic pre:@"imgDomainName" other:@"ImgAddress"];
}

+ (NSURL *)getBrandImgURLWith:(NSDictionary *)dic
{
    return [SBUtil getImgURLWith:dic pre:@"imgDomainName" other:@"brandIco"];
}


+ (NSURL *)getImgURLWith:(NSDictionary *)dic pre:(NSString *)preKey other:(NSString *)otherKey
{
    NSString *pre = [dic objectForKey:preKey];
    NSString *other = [dic objectForKey:otherKey];
    other = [other stringByReplacingOccurrencesOfString:@"{0}" withString:@"1"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", pre, other];

    return [NSURL URLWithString:url];
}

+ (NSURL *)getNewsURLWith:(NSDictionary *)dic
{
    NSString *newsId = [dic objectForKey:@"newsId"];
    NSURL *result;
    
    if (newsId) {
        
        NSString *newsUrlStr = [NSString stringWithFormat:@"%@/news/%@", API_NEWS_DOMAIN, newsId];
        result = [NSURL URLWithString:newsUrlStr];
        
    }
    
    return result;
}

+ (SBAppDelegate *)getAppDelegate
{
    return [UIApplication sharedApplication].delegate;
}

+ (UIView *)getLoadingViewControllerView
{
    UIViewController *vc = [[SBUtil getAppDelegate].rootNavi topViewController];
    SBTabBarController *tempTbVC = (SBTabBarController *)vc;
    UIViewController *selectedVC;
    
    if ([tempTbVC isKindOfClass:[SBTabBarController class]]) selectedVC = tempTbVC.tbController.selectedViewController;
    else return vc.view;
    
    if (selectedVC) return selectedVC.view;
    else return vc.view;
    
}

+ (NSString *)getTimeWithTimeInterval:(NSDictionary *)dic key:(NSString *)key
{
    NSString *format = @"yyyy年MM月dd日 ";
    NSString *sDate = [ITUtils date_fromInterval:[[dic objectForKey:key] doubleValue] / 1000 format:format];
    return sDate;
}

+ (NSString *)getOneWeiFloatStr:(NSString *)string
{
    float f = [string floatValue];
    return [NSString stringWithFormat:@"%.1f", f];
}

#pragma mark -推送数据处理
+ (void)handle_push_data:(NSDictionary *)userInfo
{
    MLNavigationController *rootNavi = [SBUtil getAppDelegate].rootNavi;
    
    if (!userInfo) return;
    
    NSDictionary *data = [userInfo objectForKey:@"data"];
    if (data) {
        
        NSString *type = [data objectForKey:@"type"];
        
        if(!type) return;
        
        else if([type isEqualToString:@"news"]) {
            
            NSString *typeId = [data objectForKey:@"newsid"];
            
            if (typeId && [typeId intValue] > 0) {
                
                NSDictionary *newDic = [NSDictionary dictionaryWithObject:typeId forKey:@"newsId"];
                SBNewsWebViewController *wvc = [[SBNewsWebViewController alloc] initWithNavi:YES];
                [[SBRequestParamBus instance] setParamWith:wvc key:@"news" value:newDic];
                [rootNavi pushViewController:wvc animated:YES];
                
            }
        }
        else if([type isEqualToString:@"free"]) {
            
            NSString *url = [data objectForKey:@"url"];
            
            if (url) {
                
                SBWebViewController *vc = [[SBWebViewController alloc] initWithNavi:YES];
                vc.url = [NSURL URLWithString:url];
                vc.passedTitle = [data objectForKey:@"title"];
                [rootNavi pushViewController:vc animated:YES];
                
            }
            
        }
        
    }
    
}


@end

//1  2  3
//大图小图、中图