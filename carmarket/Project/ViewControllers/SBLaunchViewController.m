//
//  SBLaunchViewController.m
//  carmarket
//
//  Created by Apple on 14-9-18.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define start_y (IS_UP7 ? -20 : 0)

#import "SBLaunchViewController.h"
#import "SBTabBarController.h"

#import "ITBaseInterface.h"
#import "BKUserDefautTool.h"
#import "SBAVOSTools.h"

@interface SBLaunchViewController ()<UIAlertViewDelegate>
{
    UIImageView *welcome;
    
}
@end

@implementation SBLaunchViewController
@synthesize store_version;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    self.contentView.backgroundColor = [UIColor blackColor];
    [self version_check];
    
    //调试模式请设为NO
    [self welcomeIn:YES];
    
}

- (void)version_check
{
    [ITBaseInterface requestVersionCheckWithAppId:APP_ID andSuccessBlock:^(id successValue) {
        
        store_version = successValue;
        
//        NSLog(@"store_vsersion : %@", store_version);
        
        if([self update_needed:store_version]) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"更新提示" message:@"有新版本咯，快去AppStore下载吧~" delegate:self cancelButtonTitle:@"下次吧" otherButtonTitles:@"不再提醒该版本", @"现在就去", nil];
            alertView.delegate = self;
            [alertView show];
            
        }
        
    } andFailBlock:^(id failValue) {
        
    }];
}

- (void)welcomeIn:(BOOL)is
{
    if (!is) {
        
        SBTabBarController *tab = [[SBTabBarController alloc] initWithNavi:NO];
        tab.isPopable = NO;
        [self push_rootNaviController:tab animated:NO];
        
    }
    
    else {
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];

        [self welcome_page_block:^(id value) {
            [self intro_page_block:^(id value) {
                [self ads_page:^(id value) {
                    [self toMainView];
                }];
            }];
        }];
        
    }
}

#pragma - mark welcome 流程函数
- (void)welcome_page_block:(void (^)(id value))finish_b
{
    welcome = [[UIImageView alloc] initWithFrame:CGRectMake(0, start_y, [ITUIKitHelper getAppWidth], [ITUIKitHelper getAppHeight])];
    welcome.image = [UIImage imageNamed:@"welcome"];
    [self addSubviewInContentView:welcome];
    
    [self performSelector:@selector(delay_welcome_page_block:) withObject:finish_b afterDelay:3];
}

- (void)intro_page_block:(void (^)(id value))finish_b
{
    BOOL is_intro_needed = [self intro_needed:IT_APP_VERSION];
    
    if (is_intro_needed) {
        
        [self init_intro_scrollView_block:finish_b];
        
    }
    
    else finish_b(nil);
}

- (void)ads_page:(void (^)(id value))finish_b
{
    if([[SBAVOSTools instance] is_ads_ready]) {
        
        NSMutableDictionary *imgsDatas = [[SBAVOSTools instance] get_ad_images];
        NSMutableArray *keys = [NSMutableArray arrayWithArray:[imgsDatas allKeys]];

//        NSLog(@"%@", keys);
        
        [keys sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            NSArray *a1 = [obj1 componentsSeparatedByString: @"."];
            NSArray *a2 = [obj2 componentsSeparatedByString: @"."];
            
            if (a1 && a2 && a1.count > 0 && a2.count > 0) {
                if ([a1[0] integerValue] > [a2[0] integerValue]) return NSOrderedDescending;
                else return NSOrderedAscending;
            }
            
            else return NSOrderedSame;
        }];
        
//        NSLog(@"%@", keys);
        
        NSMutableArray *imgs = [NSMutableArray array];
        for (NSString *key in keys) [imgs addObject:[imgsDatas objectForKey:key]];
        [self init_ad_scrollView_block:finish_b datas:imgs];
        
    }
    
    else finish_b(nil);
}

- (void)toMainView
{
    SBTabBarController *tab = [[SBTabBarController alloc] initWithNavi:NO];
    tab.isPopable = NO;
    [self push_rootNaviController:tab animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
}

#pragma - mark 辅助函数

- (void)delay_welcome_page_block:(void (^)(id value))finish_b
{
    finish_b(nil);
    
    [UIView animateWithDuration:0.3 animations:^{
        welcome.alpha = 0;
    } completion:^(BOOL finished) {
    }];
}

- (BOOL)update_needed:(NSString *)_store_version
{
    
    NSMutableArray *version_arr = [[BKUserDefautTool instance] getValueWith:@"update_version" uid:GLOBAL_USER];

    if (!version_arr || version_arr.count == 0) return YES;
    
    else {
        
        BOOL is_need = YES;
        
        for (NSString *v in version_arr) {
            
            if ([ITUtils compareVersions:v version2:_store_version] == 0) {
                is_need = NO;
                break;
            }
            
        }
        
        return is_need;
        
    }

}

- (BOOL)intro_needed:(NSString *)cur_version
{
    NSMutableArray *intro_arr = [[BKUserDefautTool instance] getValueWith:@"intro_version" uid:GLOBAL_USER];
    
    if (!intro_arr || intro_arr.count == 0) {
        
        intro_arr = [NSMutableArray arrayWithObject:cur_version];
        [[BKUserDefautTool instance] setWithKey:@"intro_version" value:intro_arr uid:GLOBAL_USER];
        
        return YES;
    
    }
    
    else {
        
        BOOL is_need = YES;
        
        for (NSString *v in intro_arr) {
            
            //如果已经存储过，就不intro了
            if ([ITUtils compareVersions:v version2:cur_version] == 0) {
                is_need = NO;
                break;
            }
            
        }
        
        if (is_need) {
            
            //userdefault需要新建array
            NSMutableArray *new_intro_arr = [NSMutableArray arrayWithArray:intro_arr];

            [new_intro_arr addObject:cur_version];
            [[BKUserDefautTool instance] setWithKey:@"intro_version" value:new_intro_arr uid:GLOBAL_USER];
            
        }
        
        return is_need;
        
    }
}

- (void)init_intro_scrollView_block:(void (^)(id value))finish_b
{

    UIScrollView *intro_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, start_y, [ITUIKitHelper getAppWidth], [ITUIKitHelper getAppHeight])];
    intro_scroll.pagingEnabled = YES;
    intro_scroll.bounces = NO;
    [intro_scroll bk_whenTapped:^{
        if (intro_scroll.contentOffset.x == 2 * intro_scroll.frame.size.width) {
            
            intro_scroll.scrollEnabled = NO;
            finish_b(nil);
            
        }
    }];
    
    [self addSubviewInContentView:intro_scroll];
    
    for (int i = 1; i <= 3; i++) {
        NSString *pic_name = [NSString stringWithFormat:@"bg_intro%d", i];
        UIImageView *image_view = [[UIImageView alloc] initWithFrame:CGRectMake((i - 1) * intro_scroll.frame.size.width, 0, intro_scroll.frame.size.width, intro_scroll.frame.size.height)];
        image_view.image = [UIImage imageNamed:pic_name];
        [intro_scroll addSubview:image_view];
        
        intro_scroll.contentSize = CGSizeMake(intro_scroll.frame.size.width * i, intro_scroll.frame.size.height);
    }
}

- (void)init_ad_scrollView_block:(void (^)(id value))finish_b datas:(NSArray *)datas
{
    
    UIScrollView *intro_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, start_y, [ITUIKitHelper getAppWidth], [ITUIKitHelper getAppHeight])];
    intro_scroll.pagingEnabled = YES;
    intro_scroll.bounces = NO;
    intro_scroll.showsHorizontalScrollIndicator = NO;
    
    [self addSubviewInContentView:intro_scroll];
    
    for (int i = 0; i < datas.count; i++) {
        UIImageView *image_view = [[UIImageView alloc] initWithFrame:CGRectMake(i * intro_scroll.frame.size.width, 0, intro_scroll.frame.size.width, intro_scroll.frame.size.height)];
        image_view.image = [datas objectAtIndex:i];
        [intro_scroll addSubview:image_view];
        
        if (i == datas.count - 1) {
            
            //为最后一张图加上进入Button
            float height = 56;
            UIView *bgMask = [[UIView alloc] initWithFrame:CGRectMake(0, image_view.frame.size.height - height, [ITUIKitHelper getAppWidth], height)];
            bgMask.backgroundColor = [ITUIKitHelper color:196 blue:44 green:51 alpha:0.9];
            [image_view addSubview:bgMask];
            
            float left_inset = 20;
            UIView *arrow = [ITUIKitHelper createIconWithImage:@"icon_ad_arrow"];
            [ITUIKitHelper pointSet:arrow piont:CGPointMake((bgMask.frame.size.width - left_inset - arrow.frame.size.width), (bgMask.frame.size.height - arrow.frame.size.height) / 2)];
            [bgMask addSubview:arrow];
            
            UILabel *enter_l = [ITUIKitHelper createLabel:@"点击进入" size:CGSizeMake(0, bgMask.frame.size.height) font:[UIFont systemFontOfSize:17] color:[UIColor whiteColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointZero superViewFrame:image_view.frame];
            [enter_l sizeWidthToFit];
            [ITUIKitHelper pointSet:enter_l piont:CGPointMake(arrow.frame.origin.x - enter_l.frame.size.width - 5, 0)];
            enter_l.textAlignment = NSTextAlignmentCenter;
//            enter_l.backgroundColor = TEST_BGCOLOR;
            [bgMask addSubview:enter_l];
            
            UIButton *tap = [[UIButton alloc] initWithFrame:CGRectMake(enter_l.frame.origin.x, image_view.frame.size.height - enter_l.frame.size.height, enter_l.frame.size.width, enter_l.frame.size.height)];
//            tap.backgroundColor = TEST_BGCOLOR;
            [self.view addSubview:tap];
            [tap bk_addEventHandler:^(id sender) {
                finish_b(nil);
            } forControlEvents:UIControlEventTouchUpInside];
            
            UIView *icon = [ITUIKitHelper createIconWithImage:@"icon_ad_logo"];
            [ITUIKitHelper pointSet:icon piont:CGPointMake(10, (bgMask.frame.size.height - icon.frame.size.height) / 2)];
            [bgMask addSubview:icon];
            
        }
    }
    
    intro_scroll.contentSize = CGSizeMake(intro_scroll.frame.size.width * datas.count, intro_scroll.frame.size.height);
}

#pragma - mark AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }
    
    //点击不再提醒，那么就会把store上的版本存入，如果一直是这个版本就不会提醒了
    else if (buttonIndex == 1) {
        
        NSMutableArray *version_arr = [[BKUserDefautTool instance] getValueWith:@"update_version" uid:GLOBAL_USER];
        
        if (!version_arr) version_arr = [NSMutableArray array];
        version_arr = [NSMutableArray arrayWithArray:version_arr];
        [version_arr addObject:store_version];
        
        [[BKUserDefautTool instance] setWithKey:@"update_version" value:version_arr uid:GLOBAL_USER];
        
    }
    
    else [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_STORE_ADD]];
}

@end
