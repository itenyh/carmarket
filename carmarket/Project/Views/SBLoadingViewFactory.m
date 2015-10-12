//
//  SBLoadingViewFactory.m
//  carmarket
//
//  Created by Apple on 14-9-16.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBLoadingViewFactory.h"

@implementation SBLoadingViewFactory


- (void)showInView:(UIView *)view
{
    if (loadingview == nil){
        loadingview = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:loadingview];
        loadingview.labelText = @"加载中";
        loadingview.animationType = MBProgressHUDAnimationFade;
        loadingview.mode = MBProgressHUDModeIndeterminate;
        loadingview.removeFromSuperViewOnHide = YES;
        [loadingview show:YES];
    }
}

- (void)stopView
{
    [loadingview hide:YES];
    if(loadingview){
        [loadingview removeFromSuperViewOnHide];
        loadingview = nil;
    }
}

@end
