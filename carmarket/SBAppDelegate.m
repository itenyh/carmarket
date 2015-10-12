//
//  SBAppDelegate.m
//  carmarket
//
//  Created by itensb on 14-8-4.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBAppDelegate.h"

#import <AMapNaviKit/AMapNaviKit.h>

#import "SBLogRegisterVCInterface.h"
#import "BKUserDefautTool.h"

#import "SBLaunchViewController.h"
#import "SBNewsWebViewController.h"

#import "SBUtil.h"

#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlySetting.h"

#import "MobClick.h"
#import "SBUMSocialKit.h"

#import "SBAVOSTools.h"


@implementation SBAppDelegate
@synthesize rootNavi;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    
    SBLaunchViewController *launch = [[SBLaunchViewController alloc] initWithNavi:NO];
    rootNavi = [[MLNavigationController alloc] initWithRootViewController:launch];
    rootNavi.navigationBarHidden = YES;
    
    self.window.rootViewController = rootNavi;
    
    [MAMapServices sharedServices].apiKey = GAODE_MAP_KEY;
    [AMapNaviServices sharedServices].apiKey = GAODE_MAP_KEY;
    
    [self configIFlySpeech];
    
    [MobClick startWithAppkey:YOUMENG_APPKEY reportPolicy:BATCH   channelId:@"StartChannel"];
    [MobClick setAppVersion:IT_APP_VERSION];
    [[SBUMSocialKit instance] register_SBUMSocialKit];
    
    //注册云盘服务
    [[SBAVOSTools instance] register_SBAVOSTools];
    [[SBAVOSTools instance] start_loading_ads];
    
    //这里主要是针对iOS 8.0,相应的8.1,8.2等版本各程序员可自行发挥，如果苹果以后推出更高版本还不会使用这个注册方式就不得而知了……
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        #ifdef __IPHONE_8_0
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        #endif
    }  else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    
//    if(IS_UP8) [[UIApplication sharedApplication] registerForRemoteNotifications];
//
//    else [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    
    
    //判断程序是不是由推送服务完成的
    if (launchOptions) {
        
        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        [self performSelector:@selector(delay_noti_handle:) withObject:userInfo afterDelay:2];
        
    }
    
    return YES;
}

- (void)configIFlySpeech
{
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@,timeout=%@",@"543e2e54",@"20000"];
    
    [IFlySpeechUtility createUtility:initString];
    
    [IFlySetting setLogFile:LVL_NONE];
    [IFlySetting showLogcat:NO];
    
    // 设置语音合成的参数
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"35" forKey:[IFlySpeechConstant SPEED]];//合成的语速,取值范围 0~100
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"50" forKey:[IFlySpeechConstant VOLUME]];//合成的音量;取值范围 0~100
    
    // 发音人,默认为”xiaoyan”;可以设置的参数列表可参考个 性化发音人列表;
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"xiaoyan" forKey:[IFlySpeechConstant VOICE_NAME]];
    
    // 音频采样率,目前支持的采样率有 16000 和 8000;
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
    
    // 当你再不需要保存音频时，请在必要的地方加上这行。
    [[IFlySpeechSynthesizer sharedInstance] setParameter:nil forKey:[IFlySpeechConstant TTS_AUDIO_PATH]];
}

#pragma - mark 推送相关
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    NSString *tk = [[BKUserDefautTool instance] getValueWith:@"deviceToken" uid:GLOBAL_USER];
    
    if (!tk) {
        
        NSString *toke = [NSString stringWithFormat:@"%@", deviceToken];
        if (toke) {
            toke = [toke stringByReplacingOccurrencesOfString:@" " withString:@""];
            toke = [toke stringByReplacingOccurrencesOfString:@"<" withString:@""];
            toke = [toke stringByReplacingOccurrencesOfString:@">" withString:@""];
        }
        
        [SBLogRegisterVCInterface requestTokenRegisterWith:toke successBlock:^(id successValue) {
            
            [[BKUserDefautTool instance] setWithKey:@"deviceToken" value:toke uid:GLOBAL_USER];
            
        } andFailBlock:^(id failValue) {
            
        }];

    }
    
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
#endif

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"注册失败，无法获取设备ID, 具体错误: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    // 处理推送消息
    NSLog(@"收到推送消息:%@",userInfo);
    
    if([[UIApplication sharedApplication] applicationState] == UIApplicationStateInactive) {
        
        [SBUtil handle_push_data:userInfo];
        
    }
}

#pragma -mark 辅助函数
//为了防止推入的页面被tab覆盖，这是一个有缺陷的临时方案
- (void)delay_noti_handle:(NSDictionary *)userInfo
{
    [SBUtil handle_push_data:userInfo];
}

#pragma -mark 未用函数
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_ENTER_FORGROUND object:nil];
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

//回复，评论，刮刮卡，游戏
//会员卡，报名，调查问券
//？方式太单调
//二月滴票的规划 时间排列 抽奖 推广活动
//
//如何让更多的人都知道
//
//粉丝管理 吸粉以及转化是什么意思 为什么是3000的瓶颈 回复意思？


@end
