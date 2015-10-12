//
//  SBLoadingViewFactory.h
//  carmarket
//
//  Created by Apple on 14-9-16.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface SBLoadingViewFactory : NSObject
{
    MBProgressHUD *loadingview;
}

- (void)showInView:(UIView *)view;
- (void)stopView;

@end
